using Npgsql;
using NpgsqlTypes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Windows;
using System.Windows.Controls;

namespace SystemManager
{
    /// <summary>
    /// Логика взаимодействия для EditWindow.xaml
    /// </summary>
    public partial class EditWindow : Window
    {
        private string tableName;
        private DataRowView row;
        private string connectionString;
        private Dictionary<string, Control> inputControls = new Dictionary<string, Control>();
        public EditWindow(string tableName, DataRowView row, string connectionString)
        {
            InitializeComponent();
            this.tableName = tableName;
            this.row = row;
            this.connectionString = connectionString;
            this.Title = (row == null) ? $"Add New {tableName}" : $"Edit {tableName}";
            LoadFields();
        }
        private void LoadFields()
        {
            try
            {
                using (var conn = new NpgsqlConnection(connectionString))
                {
                    conn.Open();
                    var cmd = new NpgsqlCommand($"SELECT * FROM {tableName} LIMIT 0", conn);
                    using (var reader = cmd.ExecuteReader())
                    {
                        var schema = reader.GetSchemaTable();

                        foreach (DataRow schemaRow in schema.Rows)
                        {
                            string columnName = schemaRow["ColumnName"].ToString();
                            Type dataType = (Type)schemaRow["DataType"];
                            bool isIdentity = Convert.ToBoolean(schemaRow["IsIdentity"]);
                            bool isAutoIncrement = Convert.ToBoolean(schemaRow["IsAutoIncrement"]);
                            bool isReadOnly = isIdentity || isAutoIncrement;

                            // Skip identity/auto-increment columns for new records
                            if (row == null && isReadOnly)
                                continue;

                            var label = new Label { Content = columnName };
                            FieldsPanel.Children.Add(label);

                            Control inputControl;
                            if (dataType == typeof(bool))
                            {
                                inputControl = new CheckBox { IsEnabled = !isReadOnly };
                            }
                            else if (dataType == typeof(DateTime))
                            {
                                inputControl = new DatePicker { IsEnabled = !isReadOnly };
                            }
                            else
                            {
                                inputControl = new TextBox { IsReadOnly = isReadOnly };
                            }

                            // Set value if editing existing row
                            if (row != null && row.Row.Table.Columns.Contains(columnName))
                            {
                                if (inputControl is CheckBox checkBox)
                                {
                                    checkBox.IsChecked = Convert.ToBoolean(row[columnName]);
                                }
                                else if (inputControl is DatePicker datePicker)
                                {
                                    datePicker.SelectedDate = row[columnName] != DBNull.Value ? (DateTime?)row[columnName] : null;
                                }
                                else if (inputControl is TextBox textBox)
                                {
                                    textBox.Text = row[columnName]?.ToString();
                                }
                            }

                            FieldsPanel.Children.Add(inputControl);
                            inputControls.Add(columnName, inputControl);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error loading fields: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
            }
        }

        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string primaryKeyColumn = GetPrimaryKeyColumn();
                bool isNewRecord = row == null;

                using (var conn = new NpgsqlConnection(connectionString))
                {
                    conn.Open();

                    if (isNewRecord)
                    {
                        InsertNewRecord(conn);
                    }
                    else
                    {
                        UpdateExistingRecord(conn, primaryKeyColumn);
                    }
                }

                DialogResult = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error saving record: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void InsertNewRecord(NpgsqlConnection conn)
        {
            var columns = new List<string>();
            var values = new List<string>();
            var parameters = new List<NpgsqlParameter>();

            // Получаем информацию о типах столбцов
            var columnTypes = GetColumnTypes(conn);

            foreach (var kvp in inputControls)
            {
                string columnName = kvp.Key;
                Control control = kvp.Value;

                columns.Add(columnName);

                object value = GetControlValue(control, columnTypes[columnName]);
                if (value == null)
                {
                    values.Add("NULL");
                }
                else
                {
                    string paramName = $"@{columnName}";
                    values.Add(paramName);
                    parameters.Add(new NpgsqlParameter(paramName, value));
                }
            }

            string query = $"INSERT INTO {tableName} ({string.Join(", ", columns)}) VALUES ({string.Join(", ", values)})";
            var cmd = new NpgsqlCommand(query, conn);
            cmd.Parameters.AddRange(parameters.ToArray());
            cmd.ExecuteNonQuery();
        }

        private Dictionary<string, Type> GetColumnTypes(NpgsqlConnection conn)
        {
            var columnTypes = new Dictionary<string, Type>();

            var cmd = new NpgsqlCommand($"SELECT * FROM {tableName} LIMIT 0", conn);
            using (var reader = cmd.ExecuteReader())
            {
                var schema = reader.GetSchemaTable();

                foreach (DataRow schemaRow in schema.Rows)
                {
                    string columnName = schemaRow["ColumnName"].ToString();
                    Type dataType = (Type)schemaRow["DataType"];
                    columnTypes.Add(columnName, dataType);
                }
            }

            return columnTypes;
        }

        private void UpdateExistingRecord(NpgsqlConnection conn, string primaryKeyColumn)
        {
            var setClauses = new List<string>();
            var parameters = new List<NpgsqlParameter>();

            var columnTypes = GetColumnTypes(conn);

            foreach (var kvp in inputControls)
            {
                string columnName = kvp.Key;
                Control control = kvp.Value;

                object value = GetControlValue(control, columnTypes[columnName]);

                if (value == DBNull.Value)
                {
                    setClauses.Add($"{columnName} = NULL");
                }
                else
                {
                    string paramName = $"@{columnName}";
                    setClauses.Add($"{columnName} = {paramName}");

                    // Указываем точный тип параметра
                    if (columnTypes[columnName] == typeof(int))
                    {
                        parameters.Add(new NpgsqlParameter(paramName, NpgsqlDbType.Integer) { Value = value });
                    }
                    else if (columnTypes[columnName] == typeof(decimal))
                    {
                        parameters.Add(new NpgsqlParameter(paramName, NpgsqlDbType.Numeric) { Value = value });
                    }
                    else
                    {
                        parameters.Add(new NpgsqlParameter(paramName, value));
                    }
                }
            }

            // Обработка первичного ключа
            string primaryKeyValue = row[primaryKeyColumn].ToString();
            var pkParam = new NpgsqlParameter("@pk", NpgsqlDbType.Integer)
            {
                Value = Convert.ToInt32(primaryKeyValue)
            };
            parameters.Add(pkParam);

            string query = $"UPDATE {tableName} SET {string.Join(", ", setClauses)} WHERE {primaryKeyColumn} = @pk";
            var cmd = new NpgsqlCommand(query, conn);
            cmd.Parameters.AddRange(parameters.ToArray());
            cmd.ExecuteNonQuery();
        }

        private object GetControlValue(Control control, Type targetType)
        {
            if (control is CheckBox checkBox)
            {
                return checkBox.IsChecked;
            }
            else if (control is DatePicker datePicker)
            {
                return datePicker.SelectedDate;
            }
            else if (control is TextBox textBox)
            {
                string textValue = textBox.Text;

                if (string.IsNullOrEmpty(textValue))
                {
                    return null;
                }

                // Преобразование для целочисленных полей
                if (targetType == typeof(int) || targetType == typeof(int?))
                {
                    if (int.TryParse(textValue, out int intValue))
                    {
                        return intValue;
                    }
                    throw new FormatException($"Значение '{textValue}' не может быть преобразовано в целое число");
                }

                // Преобразование для decimal полей
                if (targetType == typeof(decimal) || targetType == typeof(decimal?))
                {
                    if (decimal.TryParse(textValue, out decimal decimalValue))
                    {
                        return decimalValue;
                    }
                    throw new FormatException($"Значение '{textValue}' не может быть преобразовано в число с плавающей точкой");
                }

                // Для всех остальных типов возвращаем как строку
                return textValue;
            }

            return null;
        }

        private string GetPrimaryKeyColumn()
        {
            switch (tableName)
            {
                case "users": return "user_id";
                case "roles": return "role_id";
                case "user_roles": return "user_role_id";
                case "event_categories": return "category_id";
                case "locations": return "location_id";
                case "events": return "event_id";
                case "speakers": return "speaker_id";
                case "sessions": return "session_id";
                case "participants": return "participant_id";
                case "ticket_types": return "ticket_type_id";
                case "orders": return "order_id";
                case "tickets": return "ticket_id";
                case "promo_codes": return "promo_code_id";
                case "sponsors": return "sponsor_id";
                case "event_sponsors": return "event_sponsor_id";
                case "volunteers": return "volunteer_id";
                case "volunteer_tasks": return "task_id";
                case "volunteer_assignments": return "assignment_id";
                case "notifications": return "notification_id";
                case "notification_templates": return "template_id";
                case "streams": return "stream_id";
                case "attendance": return "attendance_id";
                case "feedback": return "feedback_id";
                case "reports": return "report_id";
                case "system_settings": return "setting_id";
                default: throw new Exception("Unknown table");
            }
        }

        private void CancelButton_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = false;
            Close();
        }
    }
}
