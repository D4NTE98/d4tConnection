Config = {}

Config.Driver = 'mysql-async'
Config.Debug = false
Config.ReadyTimeout = 30000

Config.Connection = {
    host = GetConvar('d4t_mysql_host', '127.0.0.1'),
    port = GetConvarInt('d4t_mysql_port', 3306),
    database = GetConvar('d4t_mysql_database', 'fivem'),
    user = GetConvar('d4t_mysql_user', 'root'),
    password = GetConvar('d4t_mysql_password', ''),
    charset = 'utf8mb4'
}

Config.Pool = {
    max = 10,
    idleTimeout = 60000
}

Config.SlowQuery = {
    enabled = true,
    threshold = 750
}
