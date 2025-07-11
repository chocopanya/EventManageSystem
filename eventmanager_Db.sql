PGDMP      8                }            eventmanager_Db    17.4    17.4 �               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    25268    eventmanager_Db    DATABASE     w   CREATE DATABASE "eventmanager_Db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'ru-RU';
 !   DROP DATABASE "eventmanager_Db";
                     postgres    false                       1259    25615 
   attendance    TABLE     �   CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    session_id integer,
    participant_id integer,
    check_in_time timestamp without time zone NOT NULL,
    check_out_time timestamp without time zone,
    duration integer
);
    DROP TABLE public.attendance;
       public         heap r       postgres    false                       1259    25614    attendance_attendance_id_seq    SEQUENCE     �   CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.attendance_attendance_id_seq;
       public               postgres    false    260                       0    0    attendance_attendance_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;
          public               postgres    false    259            �            1259    25317    event_categories    TABLE     �   CREATE TABLE public.event_categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    icon_url text
);
 $   DROP TABLE public.event_categories;
       public         heap r       postgres    false            �            1259    25316     event_categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.event_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.event_categories_category_id_seq;
       public               postgres    false    224                       0    0     event_categories_category_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.event_categories_category_id_seq OWNED BY public.event_categories.category_id;
          public               postgres    false    223            �            1259    25504    event_sponsors    TABLE     �   CREATE TABLE public.event_sponsors (
    event_sponsor_id integer NOT NULL,
    event_id integer,
    sponsor_id integer,
    benefits text[],
    contract_url text,
    is_published boolean DEFAULT false
);
 "   DROP TABLE public.event_sponsors;
       public         heap r       postgres    false            �            1259    25503 #   event_sponsors_event_sponsor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.event_sponsors_event_sponsor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.event_sponsors_event_sponsor_id_seq;
       public               postgres    false    246                       0    0 #   event_sponsors_event_sponsor_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.event_sponsors_event_sponsor_id_seq OWNED BY public.event_sponsors.event_sponsor_id;
          public               postgres    false    245            �            1259    25337    events    TABLE     y  CREATE TABLE public.events (
    event_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    start_date timestamp without time zone NOT NULL,
    end_date timestamp without time zone NOT NULL,
    location_id integer,
    category_id integer,
    format character varying(100),
    max_participants integer,
    target_audience text,
    cover_image_url text,
    status character varying(20) DEFAULT 'planned'::character varying,
    created_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.events;
       public         heap r       postgres    false            �            1259    25336    events_event_id_seq    SEQUENCE     �   CREATE SEQUENCE public.events_event_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.events_event_id_seq;
       public               postgres    false    228            	           0    0    events_event_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.events_event_id_seq OWNED BY public.events.event_id;
          public               postgres    false    227                       1259    25632    feedback    TABLE     K  CREATE TABLE public.feedback (
    feedback_id integer NOT NULL,
    event_id integer,
    participant_id integer,
    session_id integer,
    rating integer,
    comment text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT feedback_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);
    DROP TABLE public.feedback;
       public         heap r       postgres    false                       1259    25631    feedback_feedback_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feedback_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.feedback_feedback_id_seq;
       public               postgres    false    262            
           0    0    feedback_feedback_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.feedback_feedback_id_seq OWNED BY public.feedback.feedback_id;
          public               postgres    false    261            �            1259    25328 	   locations    TABLE     F  CREATE TABLE public.locations (
    location_id integer NOT NULL,
    name character varying(255) NOT NULL,
    address text NOT NULL,
    city character varying(100) NOT NULL,
    country character varying(100) NOT NULL,
    latitude numeric(10,8),
    longitude numeric(11,8),
    capacity integer,
    facilities text[]
);
    DROP TABLE public.locations;
       public         heap r       postgres    false            �            1259    25327    locations_location_id_seq    SEQUENCE     �   CREATE SEQUENCE public.locations_location_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.locations_location_id_seq;
       public               postgres    false    226                       0    0    locations_location_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.locations_location_id_seq OWNED BY public.locations.location_id;
          public               postgres    false    225                        1259    25589    notification_templates    TABLE       CREATE TABLE public.notification_templates (
    template_id integer NOT NULL,
    name character varying(100) NOT NULL,
    subject character varying(255) NOT NULL,
    body text NOT NULL,
    variables text[],
    notification_type character varying(50) NOT NULL
);
 *   DROP TABLE public.notification_templates;
       public         heap r       postgres    false            �            1259    25588 &   notification_templates_template_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_templates_template_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.notification_templates_template_id_seq;
       public               postgres    false    256                       0    0 &   notification_templates_template_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.notification_templates_template_id_seq OWNED BY public.notification_templates.template_id;
          public               postgres    false    255            �            1259    25574    notifications    TABLE     R  CREATE TABLE public.notifications (
    notification_id integer NOT NULL,
    user_id integer,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    notification_type character varying(50) NOT NULL,
    is_sent boolean DEFAULT false,
    sent_at timestamp without time zone,
    read_at timestamp without time zone
);
 !   DROP TABLE public.notifications;
       public         heap r       postgres    false            �            1259    25573 !   notifications_notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.notifications_notification_id_seq;
       public               postgres    false    254                       0    0 !   notifications_notification_id_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;
          public               postgres    false    253            �            1259    25432    orders    TABLE     �  CREATE TABLE public.orders (
    order_id integer NOT NULL,
    participant_id integer,
    total_amount numeric(10,2) NOT NULL,
    payment_status character varying(20) DEFAULT 'pending'::character varying,
    payment_method character varying(50),
    transaction_id character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    paid_at timestamp without time zone
);
    DROP TABLE public.orders;
       public         heap r       postgres    false            �            1259    25431    orders_order_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.orders_order_id_seq;
       public               postgres    false    238                       0    0    orders_order_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;
          public               postgres    false    237            �            1259    25403    participants    TABLE     �  CREATE TABLE public.participants (
    participant_id integer NOT NULL,
    user_id integer,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    company character varying(255),
    "position" character varying(255),
    interests text[],
    dietary_restrictions text[],
    special_needs text
);
     DROP TABLE public.participants;
       public         heap r       postgres    false            �            1259    25402    participants_participant_id_seq    SEQUENCE     �   CREATE SEQUENCE public.participants_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.participants_participant_id_seq;
       public               postgres    false    234                       0    0    participants_participant_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.participants_participant_id_seq OWNED BY public.participants.participant_id;
          public               postgres    false    233            �            1259    25479    promo_codes    TABLE     �  CREATE TABLE public.promo_codes (
    promo_code_id integer NOT NULL,
    code character varying(50) NOT NULL,
    discount_type character varying(10) NOT NULL,
    discount_value numeric(10,2) NOT NULL,
    valid_from timestamp without time zone NOT NULL,
    valid_to timestamp without time zone NOT NULL,
    max_uses integer,
    current_uses integer DEFAULT 0,
    is_active boolean DEFAULT true,
    event_id integer
);
    DROP TABLE public.promo_codes;
       public         heap r       postgres    false            �            1259    25478    promo_codes_promo_code_id_seq    SEQUENCE     �   CREATE SEQUENCE public.promo_codes_promo_code_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.promo_codes_promo_code_id_seq;
       public               postgres    false    242                       0    0    promo_codes_promo_code_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.promo_codes_promo_code_id_seq OWNED BY public.promo_codes.promo_code_id;
          public               postgres    false    241                       1259    25658    reports    TABLE       CREATE TABLE public.reports (
    report_id integer NOT NULL,
    event_id integer,
    report_type character varying(50) NOT NULL,
    generated_by integer,
    generated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    file_url text NOT NULL,
    parameters jsonb
);
    DROP TABLE public.reports;
       public         heap r       postgres    false                       1259    25657    reports_report_id_seq    SEQUENCE     �   CREATE SEQUENCE public.reports_report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reports_report_id_seq;
       public               postgres    false    264                       0    0    reports_report_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reports_report_id_seq OWNED BY public.reports.report_id;
          public               postgres    false    263            �            1259    25283    roles    TABLE     {   CREATE TABLE public.roles (
    role_id integer NOT NULL,
    name character varying(50) NOT NULL,
    description text
);
    DROP TABLE public.roles;
       public         heap r       postgres    false            �            1259    25282    roles_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.roles_role_id_seq;
       public               postgres    false    220                       0    0    roles_role_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;
          public               postgres    false    219            �            1259    25378    sessions    TABLE     �  CREATE TABLE public.sessions (
    session_id integer NOT NULL,
    event_id integer,
    title character varying(255) NOT NULL,
    description text,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    location_id integer,
    speaker_id integer,
    session_type character varying(50),
    is_online boolean DEFAULT false,
    streaming_url text,
    max_attendees integer
);
    DROP TABLE public.sessions;
       public         heap r       postgres    false            �            1259    25377    sessions_session_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sessions_session_id_seq;
       public               postgres    false    232                       0    0    sessions_session_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.sessions_session_id_seq OWNED BY public.sessions.session_id;
          public               postgres    false    231            �            1259    25364    speakers    TABLE     ;  CREATE TABLE public.speakers (
    speaker_id integer NOT NULL,
    user_id integer,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    bio text,
    photo_url text,
    company character varying(255),
    "position" character varying(255),
    social_links jsonb
);
    DROP TABLE public.speakers;
       public         heap r       postgres    false            �            1259    25363    speakers_speaker_id_seq    SEQUENCE     �   CREATE SEQUENCE public.speakers_speaker_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.speakers_speaker_id_seq;
       public               postgres    false    230                       0    0    speakers_speaker_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.speakers_speaker_id_seq OWNED BY public.speakers.speaker_id;
          public               postgres    false    229            �            1259    25495    sponsors    TABLE     x  CREATE TABLE public.sponsors (
    sponsor_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    logo_url text,
    website text,
    contact_person character varying(255),
    contact_email character varying(255),
    contact_phone character varying(20),
    sponsorship_level character varying(50),
    sponsorship_amount numeric(10,2)
);
    DROP TABLE public.sponsors;
       public         heap r       postgres    false            �            1259    25494    sponsors_sponsor_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sponsors_sponsor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.sponsors_sponsor_id_seq;
       public               postgres    false    244                       0    0    sponsors_sponsor_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.sponsors_sponsor_id_seq OWNED BY public.sponsors.sponsor_id;
          public               postgres    false    243                       1259    25600    streams    TABLE     I  CREATE TABLE public.streams (
    stream_id integer NOT NULL,
    session_id integer,
    platform character varying(50) NOT NULL,
    stream_url text NOT NULL,
    stream_key text,
    is_live boolean DEFAULT false,
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    recording_url text
);
    DROP TABLE public.streams;
       public         heap r       postgres    false                       1259    25599    streams_stream_id_seq    SEQUENCE     �   CREATE SEQUENCE public.streams_stream_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.streams_stream_id_seq;
       public               postgres    false    258                       0    0    streams_stream_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.streams_stream_id_seq OWNED BY public.streams.stream_id;
          public               postgres    false    257            
           1259    25678    system_settings    TABLE     �   CREATE TABLE public.system_settings (
    setting_id integer NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value text,
    description text,
    is_public boolean DEFAULT false
);
 #   DROP TABLE public.system_settings;
       public         heap r       postgres    false            	           1259    25677    system_settings_setting_id_seq    SEQUENCE     �   CREATE SEQUENCE public.system_settings_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.system_settings_setting_id_seq;
       public               postgres    false    266                       0    0    system_settings_setting_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.system_settings_setting_id_seq OWNED BY public.system_settings.setting_id;
          public               postgres    false    265            �            1259    25417    ticket_types    TABLE     �  CREATE TABLE public.ticket_types (
    ticket_type_id integer NOT NULL,
    event_id integer,
    name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    quantity_available integer,
    sale_start timestamp without time zone,
    sale_end timestamp without time zone,
    is_active boolean DEFAULT true,
    participant_type character varying(50)
);
     DROP TABLE public.ticket_types;
       public         heap r       postgres    false            �            1259    25416    ticket_types_ticket_type_id_seq    SEQUENCE     �   CREATE SEQUENCE public.ticket_types_ticket_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.ticket_types_ticket_type_id_seq;
       public               postgres    false    236                       0    0    ticket_types_ticket_type_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.ticket_types_ticket_type_id_seq OWNED BY public.ticket_types.ticket_type_id;
          public               postgres    false    235            �            1259    25446    tickets    TABLE     b  CREATE TABLE public.tickets (
    ticket_id integer NOT NULL,
    ticket_type_id integer,
    participant_id integer,
    order_id integer,
    qr_code text NOT NULL,
    is_checked_in boolean DEFAULT false,
    checked_in_at timestamp without time zone,
    checked_in_by integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.tickets;
       public         heap r       postgres    false            �            1259    25445    tickets_ticket_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tickets_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.tickets_ticket_id_seq;
       public               postgres    false    240                       0    0    tickets_ticket_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.tickets_ticket_id_seq OWNED BY public.tickets.ticket_id;
          public               postgres    false    239            �            1259    25294 
   user_roles    TABLE     �   CREATE TABLE public.user_roles (
    user_role_id integer NOT NULL,
    user_id integer,
    role_id integer,
    granted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    granted_by integer
);
    DROP TABLE public.user_roles;
       public         heap r       postgres    false            �            1259    25293    user_roles_user_role_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_roles_user_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.user_roles_user_role_id_seq;
       public               postgres    false    222                       0    0    user_roles_user_role_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.user_roles_user_role_id_seq OWNED BY public.user_roles.user_role_id;
          public               postgres    false    221            �            1259    25270    users    TABLE     �  CREATE TABLE public.users (
    user_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone character varying(20),
    avatar_url text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    is_active boolean DEFAULT true
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    25269    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public               postgres    false    218                       0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public               postgres    false    217            �            1259    25554    volunteer_assignments    TABLE     �   CREATE TABLE public.volunteer_assignments (
    assignment_id integer NOT NULL,
    volunteer_id integer,
    task_id integer,
    status character varying(20) DEFAULT 'assigned'::character varying,
    feedback text,
    rating integer
);
 )   DROP TABLE public.volunteer_assignments;
       public         heap r       postgres    false            �            1259    25553 '   volunteer_assignments_assignment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.volunteer_assignments_assignment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.volunteer_assignments_assignment_id_seq;
       public               postgres    false    252                       0    0 '   volunteer_assignments_assignment_id_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.volunteer_assignments_assignment_id_seq OWNED BY public.volunteer_assignments.assignment_id;
          public               postgres    false    251            �            1259    25540    volunteer_tasks    TABLE     I  CREATE TABLE public.volunteer_tasks (
    task_id integer NOT NULL,
    event_id integer,
    title character varying(255) NOT NULL,
    description text,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL,
    required_skills text[],
    volunteers_needed integer NOT NULL
);
 #   DROP TABLE public.volunteer_tasks;
       public         heap r       postgres    false            �            1259    25539    volunteer_tasks_task_id_seq    SEQUENCE     �   CREATE SEQUENCE public.volunteer_tasks_task_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.volunteer_tasks_task_id_seq;
       public               postgres    false    250                       0    0    volunteer_tasks_task_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.volunteer_tasks_task_id_seq OWNED BY public.volunteer_tasks.task_id;
          public               postgres    false    249            �            1259    25524 
   volunteers    TABLE     �   CREATE TABLE public.volunteers (
    volunteer_id integer NOT NULL,
    user_id integer,
    skills text[],
    experience text,
    availability jsonb,
    rating numeric(3,2) DEFAULT 0,
    total_events integer DEFAULT 0
);
    DROP TABLE public.volunteers;
       public         heap r       postgres    false            �            1259    25523    volunteers_volunteer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.volunteers_volunteer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.volunteers_volunteer_id_seq;
       public               postgres    false    248                       0    0    volunteers_volunteer_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.volunteers_volunteer_id_seq OWNED BY public.volunteers.volunteer_id;
          public               postgres    false    247            �           2604    25618    attendance attendance_id    DEFAULT     �   ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);
 G   ALTER TABLE public.attendance ALTER COLUMN attendance_id DROP DEFAULT;
       public               postgres    false    260    259    260            �           2604    25320    event_categories category_id    DEFAULT     �   ALTER TABLE ONLY public.event_categories ALTER COLUMN category_id SET DEFAULT nextval('public.event_categories_category_id_seq'::regclass);
 K   ALTER TABLE public.event_categories ALTER COLUMN category_id DROP DEFAULT;
       public               postgres    false    223    224    224            �           2604    25507    event_sponsors event_sponsor_id    DEFAULT     �   ALTER TABLE ONLY public.event_sponsors ALTER COLUMN event_sponsor_id SET DEFAULT nextval('public.event_sponsors_event_sponsor_id_seq'::regclass);
 N   ALTER TABLE public.event_sponsors ALTER COLUMN event_sponsor_id DROP DEFAULT;
       public               postgres    false    246    245    246            �           2604    25340    events event_id    DEFAULT     r   ALTER TABLE ONLY public.events ALTER COLUMN event_id SET DEFAULT nextval('public.events_event_id_seq'::regclass);
 >   ALTER TABLE public.events ALTER COLUMN event_id DROP DEFAULT;
       public               postgres    false    228    227    228            �           2604    25635    feedback feedback_id    DEFAULT     |   ALTER TABLE ONLY public.feedback ALTER COLUMN feedback_id SET DEFAULT nextval('public.feedback_feedback_id_seq'::regclass);
 C   ALTER TABLE public.feedback ALTER COLUMN feedback_id DROP DEFAULT;
       public               postgres    false    262    261    262            �           2604    25331    locations location_id    DEFAULT     ~   ALTER TABLE ONLY public.locations ALTER COLUMN location_id SET DEFAULT nextval('public.locations_location_id_seq'::regclass);
 D   ALTER TABLE public.locations ALTER COLUMN location_id DROP DEFAULT;
       public               postgres    false    226    225    226            �           2604    25592 "   notification_templates template_id    DEFAULT     �   ALTER TABLE ONLY public.notification_templates ALTER COLUMN template_id SET DEFAULT nextval('public.notification_templates_template_id_seq'::regclass);
 Q   ALTER TABLE public.notification_templates ALTER COLUMN template_id DROP DEFAULT;
       public               postgres    false    256    255    256            �           2604    25577    notifications notification_id    DEFAULT     �   ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);
 L   ALTER TABLE public.notifications ALTER COLUMN notification_id DROP DEFAULT;
       public               postgres    false    254    253    254            �           2604    25435    orders order_id    DEFAULT     r   ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);
 >   ALTER TABLE public.orders ALTER COLUMN order_id DROP DEFAULT;
       public               postgres    false    238    237    238            �           2604    25406    participants participant_id    DEFAULT     �   ALTER TABLE ONLY public.participants ALTER COLUMN participant_id SET DEFAULT nextval('public.participants_participant_id_seq'::regclass);
 J   ALTER TABLE public.participants ALTER COLUMN participant_id DROP DEFAULT;
       public               postgres    false    233    234    234            �           2604    25482    promo_codes promo_code_id    DEFAULT     �   ALTER TABLE ONLY public.promo_codes ALTER COLUMN promo_code_id SET DEFAULT nextval('public.promo_codes_promo_code_id_seq'::regclass);
 H   ALTER TABLE public.promo_codes ALTER COLUMN promo_code_id DROP DEFAULT;
       public               postgres    false    241    242    242            �           2604    25661    reports report_id    DEFAULT     v   ALTER TABLE ONLY public.reports ALTER COLUMN report_id SET DEFAULT nextval('public.reports_report_id_seq'::regclass);
 @   ALTER TABLE public.reports ALTER COLUMN report_id DROP DEFAULT;
       public               postgres    false    263    264    264            �           2604    25286    roles role_id    DEFAULT     n   ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);
 <   ALTER TABLE public.roles ALTER COLUMN role_id DROP DEFAULT;
       public               postgres    false    220    219    220            �           2604    25381    sessions session_id    DEFAULT     z   ALTER TABLE ONLY public.sessions ALTER COLUMN session_id SET DEFAULT nextval('public.sessions_session_id_seq'::regclass);
 B   ALTER TABLE public.sessions ALTER COLUMN session_id DROP DEFAULT;
       public               postgres    false    232    231    232            �           2604    25367    speakers speaker_id    DEFAULT     z   ALTER TABLE ONLY public.speakers ALTER COLUMN speaker_id SET DEFAULT nextval('public.speakers_speaker_id_seq'::regclass);
 B   ALTER TABLE public.speakers ALTER COLUMN speaker_id DROP DEFAULT;
       public               postgres    false    230    229    230            �           2604    25498    sponsors sponsor_id    DEFAULT     z   ALTER TABLE ONLY public.sponsors ALTER COLUMN sponsor_id SET DEFAULT nextval('public.sponsors_sponsor_id_seq'::regclass);
 B   ALTER TABLE public.sponsors ALTER COLUMN sponsor_id DROP DEFAULT;
       public               postgres    false    244    243    244            �           2604    25603    streams stream_id    DEFAULT     v   ALTER TABLE ONLY public.streams ALTER COLUMN stream_id SET DEFAULT nextval('public.streams_stream_id_seq'::regclass);
 @   ALTER TABLE public.streams ALTER COLUMN stream_id DROP DEFAULT;
       public               postgres    false    258    257    258            �           2604    25681    system_settings setting_id    DEFAULT     �   ALTER TABLE ONLY public.system_settings ALTER COLUMN setting_id SET DEFAULT nextval('public.system_settings_setting_id_seq'::regclass);
 I   ALTER TABLE public.system_settings ALTER COLUMN setting_id DROP DEFAULT;
       public               postgres    false    266    265    266            �           2604    25420    ticket_types ticket_type_id    DEFAULT     �   ALTER TABLE ONLY public.ticket_types ALTER COLUMN ticket_type_id SET DEFAULT nextval('public.ticket_types_ticket_type_id_seq'::regclass);
 J   ALTER TABLE public.ticket_types ALTER COLUMN ticket_type_id DROP DEFAULT;
       public               postgres    false    236    235    236            �           2604    25449    tickets ticket_id    DEFAULT     v   ALTER TABLE ONLY public.tickets ALTER COLUMN ticket_id SET DEFAULT nextval('public.tickets_ticket_id_seq'::regclass);
 @   ALTER TABLE public.tickets ALTER COLUMN ticket_id DROP DEFAULT;
       public               postgres    false    240    239    240            �           2604    25297    user_roles user_role_id    DEFAULT     �   ALTER TABLE ONLY public.user_roles ALTER COLUMN user_role_id SET DEFAULT nextval('public.user_roles_user_role_id_seq'::regclass);
 F   ALTER TABLE public.user_roles ALTER COLUMN user_role_id DROP DEFAULT;
       public               postgres    false    222    221    222            �           2604    25273    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public               postgres    false    217    218    218            �           2604    25557 #   volunteer_assignments assignment_id    DEFAULT     �   ALTER TABLE ONLY public.volunteer_assignments ALTER COLUMN assignment_id SET DEFAULT nextval('public.volunteer_assignments_assignment_id_seq'::regclass);
 R   ALTER TABLE public.volunteer_assignments ALTER COLUMN assignment_id DROP DEFAULT;
       public               postgres    false    251    252    252            �           2604    25543    volunteer_tasks task_id    DEFAULT     �   ALTER TABLE ONLY public.volunteer_tasks ALTER COLUMN task_id SET DEFAULT nextval('public.volunteer_tasks_task_id_seq'::regclass);
 F   ALTER TABLE public.volunteer_tasks ALTER COLUMN task_id DROP DEFAULT;
       public               postgres    false    249    250    250            �           2604    25527    volunteers volunteer_id    DEFAULT     �   ALTER TABLE ONLY public.volunteers ALTER COLUMN volunteer_id SET DEFAULT nextval('public.volunteers_volunteer_id_seq'::regclass);
 F   ALTER TABLE public.volunteers ALTER COLUMN volunteer_id DROP DEFAULT;
       public               postgres    false    248    247    248            �          0    25615 
   attendance 
   TABLE DATA           x   COPY public.attendance (attendance_id, session_id, participant_id, check_in_time, check_out_time, duration) FROM stdin;
    public               postgres    false    260   �:      �          0    25317    event_categories 
   TABLE DATA           T   COPY public.event_categories (category_id, name, description, icon_url) FROM stdin;
    public               postgres    false    224   Y;      �          0    25504    event_sponsors 
   TABLE DATA           v   COPY public.event_sponsors (event_sponsor_id, event_id, sponsor_id, benefits, contract_url, is_published) FROM stdin;
    public               postgres    false    246   �=      �          0    25337    events 
   TABLE DATA           �   COPY public.events (event_id, title, description, start_date, end_date, location_id, category_id, format, max_participants, target_audience, cover_image_url, status, created_by, created_at, updated_at) FROM stdin;
    public               postgres    false    228   K>      �          0    25632    feedback 
   TABLE DATA           t   COPY public.feedback (feedback_id, event_id, participant_id, session_id, rating, comment, submitted_at) FROM stdin;
    public               postgres    false    262   A      �          0    25328 	   locations 
   TABLE DATA           y   COPY public.locations (location_id, name, address, city, country, latitude, longitude, capacity, facilities) FROM stdin;
    public               postgres    false    226   �B      �          0    25589    notification_templates 
   TABLE DATA           p   COPY public.notification_templates (template_id, name, subject, body, variables, notification_type) FROM stdin;
    public               postgres    false    256   �D      �          0    25574    notifications 
   TABLE DATA              COPY public.notifications (notification_id, user_id, title, message, notification_type, is_sent, sent_at, read_at) FROM stdin;
    public               postgres    false    254   AG      �          0    25432    orders 
   TABLE DATA           �   COPY public.orders (order_id, participant_id, total_amount, payment_status, payment_method, transaction_id, created_at, paid_at) FROM stdin;
    public               postgres    false    238   �H      �          0    25403    participants 
   TABLE DATA           �   COPY public.participants (participant_id, user_id, first_name, last_name, email, phone, company, "position", interests, dietary_restrictions, special_needs) FROM stdin;
    public               postgres    false    234   KI      �          0    25479    promo_codes 
   TABLE DATA           �   COPY public.promo_codes (promo_code_id, code, discount_type, discount_value, valid_from, valid_to, max_uses, current_uses, is_active, event_id) FROM stdin;
    public               postgres    false    242   }J      �          0    25658    reports 
   TABLE DATA           u   COPY public.reports (report_id, event_id, report_type, generated_by, generated_at, file_url, parameters) FROM stdin;
    public               postgres    false    264   �K      �          0    25283    roles 
   TABLE DATA           ;   COPY public.roles (role_id, name, description) FROM stdin;
    public               postgres    false    220   lL      �          0    25378    sessions 
   TABLE DATA           �   COPY public.sessions (session_id, event_id, title, description, start_time, end_time, location_id, speaker_id, session_type, is_online, streaming_url, max_attendees) FROM stdin;
    public               postgres    false    232   mM      �          0    25364    speakers 
   TABLE DATA           �   COPY public.speakers (speaker_id, user_id, first_name, last_name, bio, photo_url, company, "position", social_links) FROM stdin;
    public               postgres    false    230   �O      �          0    25495    sponsors 
   TABLE DATA           �   COPY public.sponsors (sponsor_id, name, description, logo_url, website, contact_person, contact_email, contact_phone, sponsorship_level, sponsorship_amount) FROM stdin;
    public               postgres    false    244   DQ      �          0    25600    streams 
   TABLE DATA           �   COPY public.streams (stream_id, session_id, platform, stream_url, stream_key, is_live, start_time, end_time, recording_url) FROM stdin;
    public               postgres    false    258   �S      �          0    25678    system_settings 
   TABLE DATA           i   COPY public.system_settings (setting_id, setting_key, setting_value, description, is_public) FROM stdin;
    public               postgres    false    266   �T      �          0    25417    ticket_types 
   TABLE DATA           �   COPY public.ticket_types (ticket_type_id, event_id, name, description, price, quantity_available, sale_start, sale_end, is_active, participant_type) FROM stdin;
    public               postgres    false    236   �V      �          0    25446    tickets 
   TABLE DATA           �   COPY public.tickets (ticket_id, ticket_type_id, participant_id, order_id, qr_code, is_checked_in, checked_in_at, checked_in_by, created_at) FROM stdin;
    public               postgres    false    240   OX      �          0    25294 
   user_roles 
   TABLE DATA           \   COPY public.user_roles (user_role_id, user_id, role_id, granted_at, granted_by) FROM stdin;
    public               postgres    false    222   Y      �          0    25270    users 
   TABLE DATA           �   COPY public.users (user_id, email, password_hash, first_name, last_name, phone, avatar_url, created_at, last_login, is_active) FROM stdin;
    public               postgres    false    218   �Y      �          0    25554    volunteer_assignments 
   TABLE DATA           o   COPY public.volunteer_assignments (assignment_id, volunteer_id, task_id, status, feedback, rating) FROM stdin;
    public               postgres    false    252   �[      �          0    25540    volunteer_tasks 
   TABLE DATA           �   COPY public.volunteer_tasks (task_id, event_id, title, description, start_time, end_time, required_skills, volunteers_needed) FROM stdin;
    public               postgres    false    250   >\      �          0    25524 
   volunteers 
   TABLE DATA           s   COPY public.volunteers (volunteer_id, user_id, skills, experience, availability, rating, total_events) FROM stdin;
    public               postgres    false    248   ^                 0    0    attendance_attendance_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 5, true);
          public               postgres    false    259                        0    0     event_categories_category_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.event_categories_category_id_seq', 30, true);
          public               postgres    false    223            !           0    0 #   event_sponsors_event_sponsor_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.event_sponsors_event_sponsor_id_seq', 17, true);
          public               postgres    false    245            "           0    0    events_event_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.events_event_id_seq', 50, true);
          public               postgres    false    227            #           0    0    feedback_feedback_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.feedback_feedback_id_seq', 11, true);
          public               postgres    false    261            $           0    0    locations_location_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.locations_location_id_seq', 29, true);
          public               postgres    false    225            %           0    0 &   notification_templates_template_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.notification_templates_template_id_seq', 10, true);
          public               postgres    false    255            &           0    0 !   notifications_notification_id_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.notifications_notification_id_seq', 5, true);
          public               postgres    false    253            '           0    0    orders_order_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.orders_order_id_seq', 18, true);
          public               postgres    false    237            (           0    0    participants_participant_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.participants_participant_id_seq', 15, true);
          public               postgres    false    233            )           0    0    promo_codes_promo_code_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.promo_codes_promo_code_id_seq', 20, true);
          public               postgres    false    241            *           0    0    reports_report_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.reports_report_id_seq', 5, true);
          public               postgres    false    263            +           0    0    roles_role_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.roles_role_id_seq', 8, true);
          public               postgres    false    219            ,           0    0    sessions_session_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sessions_session_id_seq', 37, true);
          public               postgres    false    231            -           0    0    speakers_speaker_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.speakers_speaker_id_seq', 10, true);
          public               postgres    false    229            .           0    0    sponsors_sponsor_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.sponsors_sponsor_id_seq', 23, true);
          public               postgres    false    243            /           0    0    streams_stream_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.streams_stream_id_seq', 10, true);
          public               postgres    false    257            0           0    0    system_settings_setting_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.system_settings_setting_id_seq', 10, true);
          public               postgres    false    265            1           0    0    ticket_types_ticket_type_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ticket_types_ticket_type_id_seq', 9, true);
          public               postgres    false    235            2           0    0    tickets_ticket_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.tickets_ticket_id_seq', 29, true);
          public               postgres    false    239            3           0    0    user_roles_user_role_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.user_roles_user_role_id_seq', 26, true);
          public               postgres    false    221            4           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 32, true);
          public               postgres    false    217            5           0    0 '   volunteer_assignments_assignment_id_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('public.volunteer_assignments_assignment_id_seq', 5, true);
          public               postgres    false    251            6           0    0    volunteer_tasks_task_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.volunteer_tasks_task_id_seq', 7, true);
          public               postgres    false    249            7           0    0    volunteers_volunteer_id_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.volunteers_volunteer_id_seq', 15, true);
          public               postgres    false    247                       2606    25620    attendance attendance_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);
 D   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_pkey;
       public                 postgres    false    260            �           2606    25326 *   event_categories event_categories_name_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT event_categories_name_key UNIQUE (name);
 T   ALTER TABLE ONLY public.event_categories DROP CONSTRAINT event_categories_name_key;
       public                 postgres    false    224            �           2606    25324 &   event_categories event_categories_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.event_categories
    ADD CONSTRAINT event_categories_pkey PRIMARY KEY (category_id);
 P   ALTER TABLE ONLY public.event_categories DROP CONSTRAINT event_categories_pkey;
       public                 postgres    false    224            �           2606    25512 "   event_sponsors event_sponsors_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.event_sponsors
    ADD CONSTRAINT event_sponsors_pkey PRIMARY KEY (event_sponsor_id);
 L   ALTER TABLE ONLY public.event_sponsors DROP CONSTRAINT event_sponsors_pkey;
       public                 postgres    false    246            �           2606    25347    events events_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public                 postgres    false    228                       2606    25641    feedback feedback_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (feedback_id);
 @   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_pkey;
       public                 postgres    false    262            �           2606    25335    locations locations_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (location_id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public                 postgres    false    226                       2606    25598 6   notification_templates notification_templates_name_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.notification_templates
    ADD CONSTRAINT notification_templates_name_key UNIQUE (name);
 `   ALTER TABLE ONLY public.notification_templates DROP CONSTRAINT notification_templates_name_key;
       public                 postgres    false    256            	           2606    25596 2   notification_templates notification_templates_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.notification_templates
    ADD CONSTRAINT notification_templates_pkey PRIMARY KEY (template_id);
 \   ALTER TABLE ONLY public.notification_templates DROP CONSTRAINT notification_templates_pkey;
       public                 postgres    false    256                       2606    25582     notifications notifications_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public                 postgres    false    254            �           2606    25439    orders orders_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public                 postgres    false    238            �           2606    25410    participants participants_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (participant_id);
 H   ALTER TABLE ONLY public.participants DROP CONSTRAINT participants_pkey;
       public                 postgres    false    234            �           2606    25488     promo_codes promo_codes_code_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.promo_codes
    ADD CONSTRAINT promo_codes_code_key UNIQUE (code);
 J   ALTER TABLE ONLY public.promo_codes DROP CONSTRAINT promo_codes_code_key;
       public                 postgres    false    242            �           2606    25486    promo_codes promo_codes_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.promo_codes
    ADD CONSTRAINT promo_codes_pkey PRIMARY KEY (promo_code_id);
 F   ALTER TABLE ONLY public.promo_codes DROP CONSTRAINT promo_codes_pkey;
       public                 postgres    false    242                       2606    25666    reports reports_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (report_id);
 >   ALTER TABLE ONLY public.reports DROP CONSTRAINT reports_pkey;
       public                 postgres    false    264            �           2606    25292    roles roles_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_name_key;
       public                 postgres    false    220            �           2606    25290    roles roles_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public                 postgres    false    220            �           2606    25386    sessions sessions_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public                 postgres    false    232            �           2606    25371    speakers speakers_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.speakers
    ADD CONSTRAINT speakers_pkey PRIMARY KEY (speaker_id);
 @   ALTER TABLE ONLY public.speakers DROP CONSTRAINT speakers_pkey;
       public                 postgres    false    230            �           2606    25502    sponsors sponsors_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.sponsors
    ADD CONSTRAINT sponsors_pkey PRIMARY KEY (sponsor_id);
 @   ALTER TABLE ONLY public.sponsors DROP CONSTRAINT sponsors_pkey;
       public                 postgres    false    244                       2606    25608    streams streams_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (stream_id);
 >   ALTER TABLE ONLY public.streams DROP CONSTRAINT streams_pkey;
       public                 postgres    false    258                       2606    25686 $   system_settings system_settings_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (setting_id);
 N   ALTER TABLE ONLY public.system_settings DROP CONSTRAINT system_settings_pkey;
       public                 postgres    false    266                       2606    25688 /   system_settings system_settings_setting_key_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);
 Y   ALTER TABLE ONLY public.system_settings DROP CONSTRAINT system_settings_setting_key_key;
       public                 postgres    false    266            �           2606    25425    ticket_types ticket_types_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.ticket_types
    ADD CONSTRAINT ticket_types_pkey PRIMARY KEY (ticket_type_id);
 H   ALTER TABLE ONLY public.ticket_types DROP CONSTRAINT ticket_types_pkey;
       public                 postgres    false    236            �           2606    25455    tickets tickets_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (ticket_id);
 >   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_pkey;
       public                 postgres    false    240            �           2606    25457    tickets tickets_qr_code_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_qr_code_key UNIQUE (qr_code);
 E   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_qr_code_key;
       public                 postgres    false    240            �           2606    25300    user_roles user_roles_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_role_id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public                 postgres    false    222            �           2606    25281    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    218            �           2606    25279    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218                       2606    25562 0   volunteer_assignments volunteer_assignments_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_pkey PRIMARY KEY (assignment_id);
 Z   ALTER TABLE ONLY public.volunteer_assignments DROP CONSTRAINT volunteer_assignments_pkey;
       public                 postgres    false    252                       2606    25547 $   volunteer_tasks volunteer_tasks_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.volunteer_tasks
    ADD CONSTRAINT volunteer_tasks_pkey PRIMARY KEY (task_id);
 N   ALTER TABLE ONLY public.volunteer_tasks DROP CONSTRAINT volunteer_tasks_pkey;
       public                 postgres    false    250            �           2606    25533    volunteers volunteers_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (volunteer_id);
 D   ALTER TABLE ONLY public.volunteers DROP CONSTRAINT volunteers_pkey;
       public                 postgres    false    248                       1259    25702    idx_attendance_participant    INDEX     [   CREATE INDEX idx_attendance_participant ON public.attendance USING btree (participant_id);
 .   DROP INDEX public.idx_attendance_participant;
       public                 postgres    false    260                       1259    25701    idx_attendance_session    INDEX     S   CREATE INDEX idx_attendance_session ON public.attendance USING btree (session_id);
 *   DROP INDEX public.idx_attendance_session;
       public                 postgres    false    260                       1259    25703    idx_attendance_time    INDEX     S   CREATE INDEX idx_attendance_time ON public.attendance USING btree (check_in_time);
 '   DROP INDEX public.idx_attendance_time;
       public                 postgres    false    260            �           1259    25693    idx_events_category    INDEX     M   CREATE INDEX idx_events_category ON public.events USING btree (category_id);
 '   DROP INDEX public.idx_events_category;
       public                 postgres    false    228            �           1259    25691    idx_events_date    INDEX     R   CREATE INDEX idx_events_date ON public.events USING btree (start_date, end_date);
 #   DROP INDEX public.idx_events_date;
       public                 postgres    false    228    228            �           1259    25692    idx_events_location    INDEX     M   CREATE INDEX idx_events_location ON public.events USING btree (location_id);
 '   DROP INDEX public.idx_events_location;
       public                 postgres    false    228            �           1259    25694    idx_events_status    INDEX     F   CREATE INDEX idx_events_status ON public.events USING btree (status);
 %   DROP INDEX public.idx_events_status;
       public                 postgres    false    228                       1259    25704    idx_feedback_event    INDEX     K   CREATE INDEX idx_feedback_event ON public.feedback USING btree (event_id);
 &   DROP INDEX public.idx_feedback_event;
       public                 postgres    false    262                       1259    25705    idx_feedback_participant    INDEX     W   CREATE INDEX idx_feedback_participant ON public.feedback USING btree (participant_id);
 ,   DROP INDEX public.idx_feedback_participant;
       public                 postgres    false    262                       1259    25706    idx_feedback_rating    INDEX     J   CREATE INDEX idx_feedback_rating ON public.feedback USING btree (rating);
 '   DROP INDEX public.idx_feedback_rating;
       public                 postgres    false    262            �           1259    25695    idx_sessions_event    INDEX     K   CREATE INDEX idx_sessions_event ON public.sessions USING btree (event_id);
 &   DROP INDEX public.idx_sessions_event;
       public                 postgres    false    232            �           1259    25697    idx_sessions_speaker    INDEX     O   CREATE INDEX idx_sessions_speaker ON public.sessions USING btree (speaker_id);
 (   DROP INDEX public.idx_sessions_speaker;
       public                 postgres    false    232            �           1259    25696    idx_sessions_time    INDEX     V   CREATE INDEX idx_sessions_time ON public.sessions USING btree (start_time, end_time);
 %   DROP INDEX public.idx_sessions_time;
       public                 postgres    false    232    232            �           1259    25700    idx_tickets_checked_in    INDEX     S   CREATE INDEX idx_tickets_checked_in ON public.tickets USING btree (is_checked_in);
 *   DROP INDEX public.idx_tickets_checked_in;
       public                 postgres    false    240            �           1259    25699    idx_tickets_order    INDEX     I   CREATE INDEX idx_tickets_order ON public.tickets USING btree (order_id);
 %   DROP INDEX public.idx_tickets_order;
       public                 postgres    false    240            �           1259    25698    idx_tickets_participant    INDEX     U   CREATE INDEX idx_tickets_participant ON public.tickets USING btree (participant_id);
 +   DROP INDEX public.idx_tickets_participant;
       public                 postgres    false    240            �           1259    25689    idx_users_email    INDEX     B   CREATE INDEX idx_users_email ON public.users USING btree (email);
 #   DROP INDEX public.idx_users_email;
       public                 postgres    false    218            �           1259    25690    idx_users_name    INDEX     Q   CREATE INDEX idx_users_name ON public.users USING btree (first_name, last_name);
 "   DROP INDEX public.idx_users_name;
       public                 postgres    false    218    218            6           2606    25626 )   attendance attendance_participant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participants(participant_id) ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_participant_id_fkey;
       public               postgres    false    260    234    4842            7           2606    25621 %   attendance attendance_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.attendance DROP CONSTRAINT attendance_session_id_fkey;
       public               postgres    false    4840    260    232            .           2606    25513 +   event_sponsors event_sponsors_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.event_sponsors
    ADD CONSTRAINT event_sponsors_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.event_sponsors DROP CONSTRAINT event_sponsors_event_id_fkey;
       public               postgres    false    246    228    4829            /           2606    25518 -   event_sponsors event_sponsors_sponsor_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.event_sponsors
    ADD CONSTRAINT event_sponsors_sponsor_id_fkey FOREIGN KEY (sponsor_id) REFERENCES public.sponsors(sponsor_id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.event_sponsors DROP CONSTRAINT event_sponsors_sponsor_id_fkey;
       public               postgres    false    4859    246    244                       2606    25353    events events_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.event_categories(category_id);
 H   ALTER TABLE ONLY public.events DROP CONSTRAINT events_category_id_fkey;
       public               postgres    false    224    228    4825                        2606    25358    events events_created_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);
 G   ALTER TABLE ONLY public.events DROP CONSTRAINT events_created_by_fkey;
       public               postgres    false    4815    218    228            !           2606    25348    events events_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);
 H   ALTER TABLE ONLY public.events DROP CONSTRAINT events_location_id_fkey;
       public               postgres    false    226    228    4827            8           2606    25642    feedback feedback_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_event_id_fkey;
       public               postgres    false    262    228    4829            9           2606    25647 %   feedback feedback_participant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participants(participant_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_participant_id_fkey;
       public               postgres    false    234    262    4842            :           2606    25652 !   feedback feedback_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id);
 K   ALTER TABLE ONLY public.feedback DROP CONSTRAINT feedback_session_id_fkey;
       public               postgres    false    262    232    4840            4           2606    25583 (   notifications notifications_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_user_id_fkey;
       public               postgres    false    218    254    4815            (           2606    25440 !   orders orders_participant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participants(participant_id);
 K   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_participant_id_fkey;
       public               postgres    false    4842    238    234            &           2606    25411 &   participants participants_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.participants DROP CONSTRAINT participants_user_id_fkey;
       public               postgres    false    234    218    4815            -           2606    25489 %   promo_codes promo_codes_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.promo_codes
    ADD CONSTRAINT promo_codes_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id);
 O   ALTER TABLE ONLY public.promo_codes DROP CONSTRAINT promo_codes_event_id_fkey;
       public               postgres    false    4829    228    242            ;           2606    25667    reports reports_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.reports DROP CONSTRAINT reports_event_id_fkey;
       public               postgres    false    4829    228    264            <           2606    25672 !   reports reports_generated_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_generated_by_fkey FOREIGN KEY (generated_by) REFERENCES public.users(user_id);
 K   ALTER TABLE ONLY public.reports DROP CONSTRAINT reports_generated_by_fkey;
       public               postgres    false    218    264    4815            #           2606    25387    sessions sessions_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_event_id_fkey;
       public               postgres    false    232    4829    228            $           2606    25392 "   sessions sessions_location_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(location_id);
 L   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_location_id_fkey;
       public               postgres    false    232    4827    226            %           2606    25397 !   sessions sessions_speaker_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_speaker_id_fkey FOREIGN KEY (speaker_id) REFERENCES public.speakers(speaker_id);
 K   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_speaker_id_fkey;
       public               postgres    false    230    232    4835            "           2606    25372    speakers speakers_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.speakers
    ADD CONSTRAINT speakers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 H   ALTER TABLE ONLY public.speakers DROP CONSTRAINT speakers_user_id_fkey;
       public               postgres    false    218    230    4815            5           2606    25609    streams streams_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.streams
    ADD CONSTRAINT streams_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(session_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.streams DROP CONSTRAINT streams_session_id_fkey;
       public               postgres    false    4840    232    258            '           2606    25426 '   ticket_types ticket_types_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ticket_types
    ADD CONSTRAINT ticket_types_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.ticket_types DROP CONSTRAINT ticket_types_event_id_fkey;
       public               postgres    false    228    236    4829            )           2606    25473 "   tickets tickets_checked_in_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_checked_in_by_fkey FOREIGN KEY (checked_in_by) REFERENCES public.users(user_id);
 L   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_checked_in_by_fkey;
       public               postgres    false    4815    240    218            *           2606    25468    tickets tickets_order_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id);
 G   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_order_id_fkey;
       public               postgres    false    4846    238    240            +           2606    25463 #   tickets tickets_participant_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_participant_id_fkey FOREIGN KEY (participant_id) REFERENCES public.participants(participant_id);
 M   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_participant_id_fkey;
       public               postgres    false    234    240    4842            ,           2606    25458 #   tickets tickets_ticket_type_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_ticket_type_id_fkey FOREIGN KEY (ticket_type_id) REFERENCES public.ticket_types(ticket_type_id);
 M   ALTER TABLE ONLY public.tickets DROP CONSTRAINT tickets_ticket_type_id_fkey;
       public               postgres    false    240    236    4844                       2606    25311 %   user_roles user_roles_granted_by_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_granted_by_fkey FOREIGN KEY (granted_by) REFERENCES public.users(user_id);
 O   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_granted_by_fkey;
       public               postgres    false    218    4815    222                       2606    25306 "   user_roles user_roles_role_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_role_id_fkey;
       public               postgres    false    222    4819    220                       2606    25301 "   user_roles user_roles_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_user_id_fkey;
       public               postgres    false    4815    218    222            2           2606    25568 8   volunteer_assignments volunteer_assignments_task_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_task_id_fkey FOREIGN KEY (task_id) REFERENCES public.volunteer_tasks(task_id) ON DELETE CASCADE;
 b   ALTER TABLE ONLY public.volunteer_assignments DROP CONSTRAINT volunteer_assignments_task_id_fkey;
       public               postgres    false    250    252    4865            3           2606    25563 =   volunteer_assignments volunteer_assignments_volunteer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.volunteer_assignments
    ADD CONSTRAINT volunteer_assignments_volunteer_id_fkey FOREIGN KEY (volunteer_id) REFERENCES public.volunteers(volunteer_id) ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.volunteer_assignments DROP CONSTRAINT volunteer_assignments_volunteer_id_fkey;
       public               postgres    false    252    248    4863            1           2606    25548 -   volunteer_tasks volunteer_tasks_event_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.volunteer_tasks
    ADD CONSTRAINT volunteer_tasks_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.events(event_id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.volunteer_tasks DROP CONSTRAINT volunteer_tasks_event_id_fkey;
       public               postgres    false    250    228    4829            0           2606    25534 "   volunteers volunteers_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.volunteers DROP CONSTRAINT volunteers_user_id_fkey;
       public               postgres    false    4815    248    218            �   \   x�M��� г����|Z5Ct���p"�募L$T�u0���"��JS(������8���Ȑbm�n�!KH��1���L��      �     x��T�n�@}�|��	�N��/&�ԫ�vd���uR�p��]7n�$�a��83kR��"�ޝ�s�ɶ�O�Ѝ=�ʞP��3��;E��ld9�9�\D��k�,���ƌ�ؗT{�k�ks��%w�>A�Mӝ�H���@�q82�8JGxLt���N���}E��{���>��F�9��er��
���o� ���e�>�s��8���	H��쉢�1��¾�����T��_Y�C�� <T�� G��0^#N�@sl�S�ky^�dƶ�Jz���gA�摢Jgą�a	^�q��]zu���5�8~�_��K�sq�ډN3s��+��^L�m��Z>sw�
	��6�Ħ�{�����}���Zn!���0x'�iO�'̠�c��/�q*�oz�o���~�����a��T�w7Br�.}�Lf*�<8�ʍ	�0W�F*�j�J{в�7����3��.xXj������Nk�Bp����I��n2���-d$>�)�y���WT�_��?�TN�;:����`0�)ܥ�      �   �   x���=�@���S���ɲ�x
O@�	�	`bCgk��H(����YB��13��7ｌ!#uи¡�0�dz��]�>��K�����V�4.\M���h[B;��8E)���H�)􅑫9t�=���-�U(��?�p!��k��1��dE~��)�%/ &�I���ɤH�&d6_���R,f��      �   �  x��U�N1>{��/���k�߽�z�#Z���BE#��E��U{�zh��$ Y^a�F��� 9D6�z>{���8��~Є.h@�4�̜�#*iD3sBcF�h`��Ʀ�]�eלp�����t`9��9Ɩ.v�45=�^M��H�0��������;��"��4�	�����n5���z~��h���L�C:��Pj.t�nd:SOA��{��v���i
�`u�軕�c0ps��\��f4
�.�p��Tb�1Yug5�8�W�'�٤��&S�����iQ�����l��J �����y��c�L%�WN9"`�sm��tL���>q����Z��/3�"��R&��K�7k!�T��M��S�G� 9Wu�|d�sLra�^��	Mj�:�.l���˘�W����?���>:� $|��uA�������R2�Rb�6m5����T�dn�Y�8))[k~j�W��V�:�w�i!�F
."�ԇ�-�{��w�C�����
�5����'�c9^O8\��<�5�6�\�<��ć�X��S}(P/�1/�l�y�n��!��,�G.@��^�TCj�~سH3�4��=�P �Ay����%m[��H=�i��>�T2����>�Ӊ��s�Zghd�U�/h�0�մ��K����y7}sd�-��9��+[z׶lA�MKcY��x���o.Թ*d\D(�'B=� �xy�t      �   z  x��SKn�0]ۧ� �7�C��T�Eb�����J��BDȏ+�o��$���FQ,g�~��̋fZ3���YF�ԺG*�o������QE5���6��:��t/���m}`I{�[*��3�[���s͕��T��(L��H�c&����0���wnM�gkz���X���+�(S"�Qi4�x05	L,V��c�IXڄR��\
�f&��������c��%a�J�]&�����T�#`�t�iZd��tƦF�؇N���,@�=(��86����cy�|0�|�>sh=5�y�������Og��c�@��[Gy�x��oP�`��,p����9�0mF/hFC_=9���V_��f,��lփ��`�9�����=�E�9����      �   �  x��S[N�0�vN��F�]��%8AӦ<>���U>���@I�����BEQ�xgfg֩�ZQMS��ty�J�9��)-����*h�3�.�p+N]Ҋ'�J�T(��|V|��K�M_keI?X�K��mGF�5��^L7BNo���[�z��r��W�~��͡��WλtрA�O�\|��%�홡�Z�X�t���6t���1��ELw�����A���s,�~�*�[�Vt�@��@?k�٢�N���I2�{�2AO� q��^�V�F��;2h����RnwhV���ZtZŧ�p�XT�_"<�ɧk�g gk>��x��-�k���#�*=�g�'�� uAJ�$�5h%����[\yȼ�q$����ӆ󷐂�fD̰9!��K�{]d�� ��r0��m�cjĆ�K��THUͳ��	0�O#�AB]��_'��7��L��$���UN5      �   �  x��T�N�@}�|Ŋ����o��d+�C�M�E"A*T �V���VU��I�/��Qό7�pi�TEN�ۙ3ggM�f+Llذ��h3����;�t�F4��ۥs:�	�)����N)sC7��Խ�q��'|Sx�0��!]�>�%�m3�j�C��ܐ��� �rM�_Η��%���J5�DNWb?,��7=ٚm�VVU�^�lR����SUƦF+��*W�;C�9W���뾊�� tZ�n�b���?�Vᘡ�;�ޣX3@%�j��x�lXo[����� 1E��⁦��'̝ A��xJY�埘�h</|5����|���Gu�&��ʲ�w�\�:�nd��kA��[QJ��LD"P���J3A�ݾ(3��c�я������h����zs�1��QݴZ��|C�3)}?���W�q��`��տ*�����:qbO��!"��
�r9M�g�aMz37Sr�rWY=��zerq��!F����K�Z+����R�y��41�0�v�bD��HRʯ����r�K�,48��"[c�C�{�Ug�i]R����v5E�6˝%����s5��Ϝ�q�n��f���x���+#w�µ'jӘ�FPob�o�&�x��^Z��r�ጅ>aNAҥ이��JA�Q1�똇�ߣнY�T*��
�d      �   N  x�}��N�P��ӧ�a���Lܰr��Ě�&����`҄�Ը�*R���W8�F�����wΜ��5�JLt�12��d(�#s����\cp���s�H�S�/�s>%mR&(�:̼i���',c���K���b�C��.,YE���ѱ�������T�)�1���$x���Bn���Ӌ:Nc��Ōq�8��}d����u��"5	V�(mv��z��o�gg�il���Qd��
�H@�g�^ԖïZu	��ݐ�-o~%��<���ݪ25ӟN���w��zA}���an�w��h&�$��3o�߆�,	-o��+�6� ��Q�X      �   �   x���1
�0�Y>E/�/Y��C�Y
)%K���چ�u@����N )3Gf�<σ�����¾�=`+dm���mC&�#���%����S����-�~�ժ�M3]�#0�z�&9���n��v!�S,�n3�$��U|�2�J�V�l�!�/��p%      �   "  x�u��J�@���S����N4ݸ���nbzС�$d�Һ�
�ō *��L�3�y#OR����0|��oY`;@�T�{�������V4�La�����!�A¦e;ngk{g<T�BvӬ/"��ò�v��dj��i������[��M�彩�w��3<�p�q$���T�k�@oTВŒ�rv}�OpbJ1h��3%$*u%q�wk����8��@�LW)��u9#1����E�bpٍ�Y*"�������q�g�\J��$�м�'m�ቇ1�
Q��g��a"Ź      �   )  x����J�0��'O�/�e&?�ݻ֦R���-"�hoDd/||��˶�����|�s�ph��֖#���9<!��*"��V����;>�m ����f�3�����8��^ ���S����B�Օ�r&�&=LЊ��J��	�R(mc:m��$9<��%C�`���met�:�aj@?!P2R`����$�@�-���,R�Iq��|��$�9�q���R�@g��>�l����=v���ll_�?��\���(��tq�n�2�������h1#�ÿl
���_gFl�f�}�CҐ      �   �   x���A� @��p
/P(Lib�	���Hl)b<�ݠ�����$�R(,68���W���N�ԓ'�s��Q"<J�y��v�qw�"Q<Rɂ^�4?��e==� �>��ۭ��̗�DX���u�VM�*? m*��hCɭ���ku�5�x�|��6U���c�Y�)      �   �   x�}�1N�@E��S�H@��Ь�Y�]�1Tq((RQ#$�������D�(L�+�����P�p���آF�Z+��K���i��olu�2�7Z|�ѹIX�Kw$���ݦ����7�����6�����5>ܱ��0-|�|�x�a{�'[M��eBo��{�,�X���ī�P���˺�x�H�2��rJ��ߵ}�S�䩿4�^���qF:�I�і������+�      �   I  x��T�r�@���� ��!�ܤt���a ��qk�LRP�M�|�����a�Gy{g8	\��<��t��ݾݭ	%��i��g�lBKJ$�(�u����<� �txA��۵KlJ��[�H�s�þ9ݻe��|]U~Uե
<wk�`J��D�?<��"��Q����]e`C�l*?��_��$��O*刷�~���.Ά��/Ñ��aV��4>�)X7νD����_����B<%�����5D?�ħ�ȅ���S��Ē79B$"��y�s��#E��;6-tMv{�H�̚X��1�w�Z,'�)�q�7�o�kB�fH�*��]����(�)=�l<L <�J�h�U_��a����� 껐Ai>���s����(�����x�\эuٰ�ynd�*ր�r�~�p��@[Q؃��(̬'3�Rz�?63��	
��b�f�GQ15o���V+d�D���cӔW
�Gl�c ��lG��S���6�����ʮ9�����f-)���m��kޝ��+����W�W3js��Ȗ��i�B�p�0l{��V�V.�>��-�>�^.��n��,�ևJ���M �      �   n  x�MQ�N�@<o�b_�F=�Q��1@�K��`k�b�6���FM`HC)��0�F~�b��mҙݙ��+�͂�>��]��#Չ�b���r㛠�N$ƒ���X'�A��Mׇ���t��D�H��Ӛj�ār�dI]���b�-��@R��b�	��5L��s}C!b���`Z��з�IL�4#���tI�n�;|Q"YrՈ|�m����̙a&0 ќ�|5��d��6��?��N�z*����EUy��Z�jv��;uD��^��;�3�h�f�yyČkD�O���累C7{-W���oĪ�Fv�1hY)�~��F�
�劭��o���+�BE5��](/����4WY�k�e� W�H      �   �  x��T�n�@]O�b~��Jy�*� Q!�e6�ؤ���8ݥAQAY�ī��i�&M��?��$mU�<噹�{ﹳ�vD"�T����P�F4�NN��VN)�m���s<Nh������$R�
��"���dP�e]��T5E�Ga���l=7}�1tr�k[ Ϩ�xq(�[�]�<��ƬT4�|��+=d;����F�#��?S���O�Q�t�z�P��le7W�^s[A#��Fy1/�>�%j���(��Z�u���2��n �c�֭��vO0�F�X���(]�A�����72N����-(@�8]�L�B�G� ��
�8	����&p� 2��G�2S×����V��c�J����|7���&�TR�A��L�\fQ��"�"[f�%��6��T$C%�a��J���2����s�N}ks��g-�ζ�ѱ>�{�#�'�v�1�M�'J-��H�V�� �,✙��.���8r{�P�I�/,as>����BW��a���Y�`����)�c�D��&6�;;Yz��QW�:L'�V*[k�y�ٞ|�`�n������u8��c�'3۬�Ҥ�/F�>��
4��\������~��-��1�}��I���)p����󻢼y]�J>���b��      �   �   x���M�0F���PZ��	؈Z�v3%���a�ɗ/y��׀�7E��C��g��\\�k�/^ߐ�=��KS-T�!�AY?��U}jڮϔly$8Ev��d���<�n'J.���4S���t�̴D�g�B)��*[�      �     x����n�@���S�$$��hR� Z$˺[#{��ׁK�9�R\��$�h�L���y��7��)4IAq��=����;�EbU��L��C��<�t�Ve||=.��}�9]R��j��nB����Z������8*S�$SGFV�f��b`>�Estu�tt%�:7s��Vx�t��w�c��(I�87��&W�t�B��bs�G��V�m3	ZE���k����5�-�]�'~%���Ȣ�a�	G*�B�b{K�74_�3t�A=CO��AT�R�MÂDM�q���J�|��9�`.�^pa���ur���O搲+l2x�l�>��H��-����x��Ն��`j�a�^bæ�	O�)ic�8D61�6/��/�]�s�n]�Τ�ܸ/7j�'�K�1����o4�Q0;e���@V�#@[l0�����	ٲ�4�Z���c^&�n�NL��e����Ф��
�F&��#���fK��zqҫ���iz�����ۻ��w}�`�*.��4�Ş�����4,s���W����
G�L��� �`&S      �   �  x����J�@�ϛ��h�d������"�RES�I=(��MP��m�I�W�y#�MR��"vv���曵�-�C�(�)E�s�a���h&�J)�Pr �s�!�т�I����1�d~p���2�*��J	��(G7l�P�T�X�́��y�{1�][(O�N��BQ�O�� 5�����I�>.ShR�P"�%���m��ҕb�{�+s~4����f�^Q|a�h��G�Ҭ�A>F����	���w��2@oh?��f�z�'��H��u6`��l�~ Ԩ :���wW�_��A�r�v6�nҵ�8ay�X{&�����﵈}���O��. _���%��w�^l������[M=���TN��{X|�3�Lu��v��e� /�e�      �   �   x���-��0`l�b.��v�ӄ]��������C#U���{ffp8/������yBb�&�b�\;y�C�8�D�HU�!�폔B���J�)����`��	��8޿�6Y(�n�����T:��q�Rtw��b�5�H�J�����S�X#�I')��k����#���˃U*������&vh�      �   b   x����1CѳRlƖ-�����,78��G���w4겺��碭�n�iވO߄+�sLY�d�� ���гn`Q�B�>)��} ��Wo��'�-�      �   Q  x����n�@���S�����m��X �nM�n1I/�#�I���"��!!!��Aԋ��g��*���^xl����P��ٺw���=�x�Фn��͑�?t�!�U/�}��O����׍��g8p_�Dʸ�
�q<��V��r�n�Q�;�P��5S�Qq�pGH�C1E���7(�<��CA�K$\'Gz���d�K�NǛ��}*�]9˪u��\"s��I_�Er����B��#j�8\�V��kUb5��h칻^Hj`�gl�m2ON@C�1�k�ZNDV�(�{�Q�ՋD��@�X��W.QN"���&b/��d˚2x��%�5}�r�pwLbH��M�,�4����l�f�3�f⻣��>𳔱����0W��0C*"-U����ȯ��~ �Au�t�4,SH&� �}pN�$�]߅YP���(K�bRܾ�=���A{��������#ֳ_u6;̳��{{q����v�-�?#��1�l�x����Y{~�;���&����	�Iæ�r;m��mz����t��<�1�=�6�+�}�_�X��j�piPe���&�`�IJQ�e4��~���      �   B   x�3�44�4�L��-�I-IM��".#NC#NacNCcNSaNCN3aSNCSNs�=... hS      �   �  x��S�N�@}���,fZ�~��4�bm�6�՘��/��-�/��#Ͻ����	�a�eF��^)�-%vd�vH����ʵ;� e�Оrڜ�K	��6 �����h���np�<m,zF���O)���tDk���\,���SЌ���QF+z�I��ۥkGTȸ�PZ~��U�P�L.^� � �	1[݁d�sJe�����ue����վ�B�T���6�b@D$��7P��*c���I�y'��*z�xDW�{%���lelnC�,�>#����ƴ���)�P�#���)?Ő��e:��c��͚�l�PA��'�*D���#�ל|L�rn�ԋG���]����:���)k����1UuHn��\*�U�@���!ii;31�u��|�7��3@�#O);R�s�`ž��/C�����_xp�}J�9�΍�х4���q�/,�M�      �   �   x�]Pm
�@���B�m�Z�-:�7���"�*�fه��ި7+!�.3�ޛ7��*[��mQàC�'�;�u�8B�v�d�qg��+4xE����Dk��4����;��ŝ�!��7LL�=-�{�S��� [xqT�I�ޠ����)u1�?Y_o���<��0~��T`9�ܚ�a��b��5�������V=��y���y     