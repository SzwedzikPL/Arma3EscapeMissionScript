/* =================== POSZUKIWACZE =================== */

// Lista jednostek poszukiwaczy
ESCAPE_setting_searching_units = [poszukiwacz_1, poszukiwacz_2, poszukiwacz_3];

// Lista pojazdów poszukiwaczy
// Pojazdy będą zablokowane do czasu rozpoczęcia pościgu
ESCAPE_setting_searching_vehicles = [smiglo_1, smiglo_2];

// Ścieżka do pliku dźwiękowego który zostanie odtworzony w momencie rozpoczęciu pościgu
// Ustaw pusty tekst jeśli chcesz wyłączyć dźwięk
ESCAPE_setting_searching_pursuit_alarm_sound = "A3\Sounds_F\sfx\alarm_blufor.wss";

// Obiekt którego pozycja będzie użyta jako źródło dźwięku odtworzonego
// przy rozpoczęciu pościgu.
ESCAPE_setting_searching_pursuit_alarm_source = gamelogic_megafon;

// Treść notyfikacji wyświetlonej wszystkim graczom w momencie rozpoczęcia pościgu
ESCAPE_setting_searching_pursuit_notification_text = "POŚCIG ROZPOCZĘTY!";

/* =================== UCIEKINIERZY =================== */

// Lista jednostek uciekajacych
ESCAPE_setting_escaping_units = [uciekinier_1, uciekinier_2, uciekinier_3];

// Lista markerów określających możliwe spawny jednostek uciekających
// Na starcie misji zostanie wybrana jedna losowa pozycja
ESCAPE_setting_escaping_spawns = ["spawn_1", "spawn_2", "spawn_3"];

// Promień w metrach od miejsca spawnu w obrębie którego pojawią się jednostki uciekinierów
// Np. 3 oznacza, że jednostki zrespią się w promieniu 3 metrów od miejsca spawnu
ESCAPE_setting_escaping_spawn_radius = 3;

// Obiekt skrzyni z wyposażeniem dla uciekinierów
// Skrzynia wraz z uciekienierami zostanie przeniesiona na początku misji
// do wylosowanego miejsca spawnu
// Ustaw objNull jeśli brak skrzynki
ESCAPE_setting_escaping_supply_box = skrzynka_uciekinierow;

// Odległość w metrach od miejsca spawnu którą któryś z uciekinierów musi
// przekroczyć aby rozpocząć pościg
ESCAPE_setting_escaping_spawn_distance_limit = 35;

// Lista triggerów określająych strefy ucieczki
// Po zniszczeniu celu zostanie wybrana jedna losowa strefa a
// jej pozycja (środek triggera) zostanie oznaczona dla uciekinierów
ESCAPE_setting_escaping_zones = [strefa_ucieczki_1, strefa_ucieczki_2, strefa_ucieczki_3];

// Typ markera który wyświetli się uciekinierom na pozycji strefy ucieczki
ESCAPE_setting_escaping_zone_marker_type = "hd_pickup";
// Kolor markera który wyświetli się uciekinierom na pozycji strefy ucieczki
ESCAPE_setting_escaping_zone_marker_color = "ColorGreen";
// Tekst markera który wyświetli się uciekinierom na pozycji strefy ucieczki
ESCAPE_setting_escaping_zone_marker_text = "";

// Marker określający pozycję na jaką ma zostać przeniesiony uciekinier
// po wbiegnięciu w strefę ucieczki
ESCAPE_setting_escaping_safe_zone = "oboz_uciekinierow";

/* =================== BOMBA =================== */

// Lista markerów oznaczająych pozycje w których może pojawić się bomba
// Na początku misji uciekinierzy zobaczą wszystkie te pozycje na mapie
// W jednej losowo wybranej pojawi się bomba
ESCAPE_setting_bomb_spawns = ["bomba_1", "bomba_2", "bomba_3"];

// Typ markera który wyświetli się uciekinierom przy możliwych pozycjach bomby
ESCAPE_setting_bomb_spawn_marker_type = "hd_unknown";
// Kolor markera który wyświetli się uciekinierom przy możliwych pozycjach bomby
ESCAPE_setting_bomb_spawn_marker_color = "ColorBlack";
// Tekst markera który wyświetli się uciekinierom przy możliwych pozycjach bomby
ESCAPE_setting_bomb_spawn_marker_text = "";

// Klasa obiektu który ma się pojawić jako bomba do wzięcia
// Obiekt ten będzie miał dla uciekinierów akcję "Weź bombę"
ESCAPE_setting_bomb_class = "Land_Suitcase_F";

// Klasa itemu który zostanie dany uciekinierowi po wzięciu bomby
// Item ten będzie też wymagany do podłożenia bomby
ESCAPE_setting_bomb_item = "SatPhone";

// Treść notyfikacji wyświetlonej wszystkim graczom w momencie gdy któryś z
// uciekinierów weźmie bombę
ESCAPE_setting_bomb_taken_notification_text = "UCIEKINIERZY ZNALEŹLI BOMBĘ!";

// Lista obiektów które mogą mieć akcję podłożenia bomby
// Po wzięciu przez uciekiniera bomby jeden losowy obiekt zostanie
// wybrany, pojawi się na nim akcja podłożenia bomby a jego pozycja
// pozstanie uciekinierom pokazana na mapie
ESCAPE_setting_bomb_targets = [bomb_target_1, bomb_target_2, bomb_target_3];

// Typ markera który wyświetli się uciekinierom na pozycji obiektu do wysadzenia
ESCAPE_setting_bomb_target_marker_type = "hd_destroy";
// Kolor markera który wyświetli się uciekinierom na pozycji obiektu do wysadzenia
ESCAPE_setting_bomb_target_marker_color = "ColorRed";
// Tekst markera który wyświetli się uciekinierom na pozycji obiektu do wysadzenia
ESCAPE_setting_bomb_target_marker_text = "";

// Czas trwania akcji podkładania bomby w sekundach
ESCAPE_setting_bomb_planting_duration = 5;

// Czas w sekundach od podłożenia bomby do detonacji
ESCAPE_setting_bomb_timer = 10;