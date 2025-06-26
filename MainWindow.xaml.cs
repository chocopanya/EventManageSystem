using Newtonsoft.Json;
using Npgsql;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace SystemManager
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private string connectionString = "Host=localhost;Database=eventmanager_backup;Username=postgres;Password=sa";
        private string currentTable = "";
        private JsonService jsonService = new JsonService();
        public MainWindow()
        {
            InitializeComponent();
            LoadTableList();
        }
        private void LoadTableList()
        {
            List<string> tables = new List<string>
            {
                "users", "roles", "user_roles",
                "event_categories", "locations", "events", "speakers", "sessions",
                "participants", "ticket_types", "orders", "tickets", "promo_codes",
                "sponsors", "event_sponsors",
                "volunteers", "volunteer_tasks", "volunteer_assignments",
                "notifications", "notification_templates",
                "streams",
                "attendance", "feedback", "reports",
                "system_settings"
            };

            TablesListBox.ItemsSource = tables;
        }

        private void TablesListBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (TablesListBox.SelectedItem != null)
            {
                currentTable = TablesListBox.SelectedItem.ToString();
                LoadTableData(currentTable);
            }
        }

        private void LoadTableData(string tableName)
        {
            try
            {
                using (var conn = new NpgsqlConnection(connectionString))
                {
                    conn.Open();
                    var cmd = new NpgsqlCommand($"SELECT * FROM {tableName}", conn);
                    var adapter = new NpgsqlDataAdapter(cmd);
                    var dataTable = new DataTable();
                    adapter.Fill(dataTable);

                    DataGridView.ItemsSource = dataTable.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Error loading table {tableName}: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(currentTable))
            {
                MessageBox.Show("Please select a table first.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var editWindow = new EditWindow(currentTable, null, connectionString);
            if (editWindow.ShowDialog() == true)
            {
                LoadTableData(currentTable);
            }
        }

        private void EditButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataGridView.SelectedItem == null)
            {
                MessageBox.Show("Please select a row to edit.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var selectedRow = (DataRowView)DataGridView.SelectedItem;
            var editWindow = new EditWindow(currentTable, selectedRow, connectionString);
            if (editWindow.ShowDialog() == true)
            {
                LoadTableData(currentTable);
            }
        }

        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (DataGridView.SelectedItem == null)
            {
                MessageBox.Show("Please select a row to delete.", "Error", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var selectedRow = (DataRowView)DataGridView.SelectedItem;
            var result = MessageBox.Show("Are you sure you want to delete this record?", "Confirm Delete",
                MessageBoxButton.YesNo, MessageBoxImage.Question);

            if (result == MessageBoxResult.Yes)
            {
                try
                {
                    string primaryKeyColumn = GetPrimaryKeyColumn(currentTable);
                    if (string.IsNullOrEmpty(primaryKeyColumn))
                    {
                        MessageBox.Show("Could not determine primary key for this table.", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                        return;
                    }

                    using (var conn = new NpgsqlConnection(connectionString))
                    {
                        conn.Open();
                        var cmd = new NpgsqlCommand($"DELETE FROM {currentTable} WHERE {primaryKeyColumn} = @id", conn);
                        cmd.Parameters.AddWithValue("@id", selectedRow[primaryKeyColumn]);
                        cmd.ExecuteNonQuery();
                    }

                    LoadTableData(currentTable);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Error deleting record: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private void RefreshButton_Click(object sender, RoutedEventArgs e)
        {
            if (!string.IsNullOrEmpty(currentTable))
            {
                LoadTableData(currentTable);
            }
        }

        private string GetPrimaryKeyColumn(string tableName)
        {
            // For simplicity, we'll use a mapping of known primary keys
            // In a real application, you would query the database metadata
            var primaryKeys = new Dictionary<string, string>
            {
                {"users", "user_id"},
                {"roles", "role_id"},
                {"user_roles", "user_role_id"},
                {"event_categories", "category_id"},
                {"locations", "location_id"},
                {"events", "event_id"},
                {"speakers", "speaker_id"},
                {"sessions", "session_id"},
                {"participants", "participant_id"},
                {"ticket_types", "ticket_type_id"},
                {"orders", "order_id"},
                {"tickets", "ticket_id"},
                {"promo_codes", "promo_code_id"},
                {"sponsors", "sponsor_id"},
                {"event_sponsors", "event_sponsor_id"},
                {"volunteers", "volunteer_id"},
                {"volunteer_tasks", "task_id"},
                {"volunteer_assignments", "assignment_id"},
                {"notifications", "notification_id"},
                {"notification_templates", "template_id"},
                {"streams", "stream_id"},
                {"attendance", "attendance_id"},
                {"feedback", "feedback_id"},
                {"reports", "report_id"},
                {"system_settings", "setting_id"}
            };

            return primaryKeys.TryGetValue(tableName, out var pk) ? pk : null;
        }
        private async void ExportEventsToJson_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var dataService = new EventDataService("Host=localhost;Database=your_db;Username=your_user;Password=your_password");
                var exportService = new JsonExportService();

                var users = await Task.Run(() => dataService.GetUsersWithEventsData());
                string filePath = "users_events_export.json";

                exportService.ExportToJson(users, filePath);

                MessageBox.Show($"Данные успешно экспортированы в {filePath}",
                    "Экспорт завершен", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при экспорте данных: {ex.Message}",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ImportFromJsonButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string filePath = "app.json";

                // Импортируем данные из JSON
                DataTable importedData = jsonService.ImportFromJson(filePath);

                // Здесь можно использовать импортированные данные, например:
                // dataGrid.ItemsSource = importedData.DefaultView;

                MessageBox.Show($"Успешно импортировано {importedData.Rows.Count} записей", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при импорте данных: {ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
