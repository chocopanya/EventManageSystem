using System.Data;
using System.IO;
using Newtonsoft.Json;

public class JsonService
{
    public void ExportToJson(DataTable dataTable, string filePath)
    {
        var json = JsonConvert.SerializeObject(dataTable, Formatting.Indented);
        File.WriteAllText(filePath, json);
    }

    public DataTable ImportFromJson(string filePath)
    {
        var json = File.ReadAllText(filePath);
        return JsonConvert.DeserializeObject<DataTable>(json);
    }
}