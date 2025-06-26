using System;
using System.Collections.Generic;
using System.IO; // Добавляем для работы с File
using System.Linq; // Добавляем для метода ToList()
using Npgsql;
using Newtonsoft.Json;

public class EventDataService
{
    private readonly string _connectionString;

    public EventDataService(string connectionString)
    {
        _connectionString = connectionString;
    }

    public List<UserExportModel> GetUsersWithEventsData()
    {
        var users = new List<UserExportModel>();

        using (var conn = new NpgsqlConnection(_connectionString))
        {
            conn.Open();

            // Получаем основных пользователей
            using (var cmd = new NpgsqlCommand(
                @"SELECT user_id, email, first_name, last_name 
                  FROM users 
                  WHERE is_active = true", conn))
            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    var user = new UserExportModel
                    {
                        UserId = reader.GetInt32(0),
                        email = reader.GetString(1),
                        first_name = reader.GetString(2),
                        last_name = reader.GetString(3)
                    };
                    users.Add(user);
                }
            }

            // Для каждого пользователя получаем связанные данные
            foreach (var user in users)
            {
                user.events = GetUserEvents(conn, user.UserId);
                user.speakers = GetEventSpeakers(conn, user.UserId);
                user.participants = GetEventParticipants(conn, user.UserId);
            }
        }

        return users;
    }

    private List<UserEvent> GetUserEvents(NpgsqlConnection conn, int userId)
    {
        var events = new List<UserEvent>();

        string query = @"SELECT e.event_id, e.title, e.created_at, e.location_id, 
                        array_agg(ec.category_id) as category_ids
                        FROM events e
                        LEFT JOIN event_categories ec ON e.category_id = ec.category_id
                        WHERE e.created_by = @userId
                        GROUP BY e.event_id, e.title, e.created_at, e.location_id";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@userId", userId);
            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    // Исправленное преобразование массива в список
                    var categoryIds = reader.IsDBNull(4) ?
                        new List<int>() :
                        ((int[])reader.GetValue(4)).ToList();

                    events.Add(new UserEvent
                    {
                        event_id = reader.GetInt32(0),
                        title = reader.GetString(1),
                        created_at = reader.GetDateTime(2),
                        location_id = reader.GetInt32(3),
                        category_id = categoryIds
                    });
                }
            }
        }

        return events;
    }

    private List<EventSpeaker> GetEventSpeakers(NpgsqlConnection conn, int userId)
    {
        var speakers = new List<EventSpeaker>();

        string query = @"SELECT DISTINCT s.speaker_id, s.first_name, s.last_name
                        FROM speakers s
                        JOIN sessions ss ON s.speaker_id = ss.speaker_id
                        JOIN events e ON ss.event_id = e.event_id
                        WHERE e.created_by = @userId";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@userId", userId);
            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    speakers.Add(new EventSpeaker
                    {
                        speaker_id = reader.GetInt32(0),
                        first_name = reader.GetString(1),
                        last_name = reader.GetString(2)
                    });
                }
            }
        }

        return speakers;
    }

    private List<EventParticipant> GetEventParticipants(NpgsqlConnection conn, int userId)
    {
        var participants = new List<EventParticipant>();

        string query = @"SELECT DISTINCT p.participant_id, p.user_id, p.first_name, p.last_name, p.email
                        FROM participants p
                        JOIN tickets t ON p.participant_id = t.participant_id
                        JOIN ticket_types tt ON t.ticket_type_id = tt.ticket_type_id
                        JOIN events e ON tt.event_id = e.event_id
                        WHERE e.created_by = @userId AND p.user_id IS NOT NULL";

        using (var cmd = new NpgsqlCommand(query, conn))
        {
            cmd.Parameters.AddWithValue("@userId", userId);
            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    participants.Add(new EventParticipant
                    {
                        participant_id = reader.GetInt32(0),
                        user_id = reader.GetInt32(1),
                        first_name = reader.GetString(2),
                        last_name = reader.GetString(3),
                        email = reader.GetString(4)
                    });
                }
            }
        }

        return participants;
    }
}
public class JsonExportService
{
    public void ExportToJson(List<UserExportModel> data, string filePath)
    {
        var json = JsonConvert.SerializeObject(data, Formatting.Indented);
        File.WriteAllText(filePath, json);
    }
}