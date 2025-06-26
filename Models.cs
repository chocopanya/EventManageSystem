using System;
using System.Collections.Generic;

public class UserExportModel
{
    public int UserId { get; set; }
    public string email { get; set; }
    public string first_name { get; set; }
    public string last_name { get; set; }
    public List<UserEvent> events { get; set; } = new List<UserEvent>();
    public List<EventSpeaker> speakers { get; set; } = new List<EventSpeaker>();
    public List<EventParticipant> participants { get; set; } = new List<EventParticipant>();
}

public class UserEvent
{
    public int event_id { get; set; }
    public string title { get; set; }
    public DateTime created_at { get; set; }
    public int location_id { get; set; }
    public List<int> category_id { get; set; } = new List<int>();
}

public class EventSpeaker
{
    public int speaker_id { get; set; }
    public string first_name { get; set; }
    public string last_name { get; set; }
}

public class EventParticipant
{
    public int participant_id { get; set; }
    public int user_id { get; set; }
    public string first_name { get; set; }
    public string last_name { get; set; }
    public string email { get; set; }
}