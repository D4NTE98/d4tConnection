# d4tConnection

d4tConnection is a lightweight MySQL query layer for d4tCore resources.

It provides a clean export API for database queries and keeps all framework resources independent from direct database driver calls.

## Features

- Query exports
- Single row export
- Execute export
- Insert export
- Transaction export
- Ready state export
- Query statistics
- Slow query logging
- Compatible with common FiveM MySQL drivers

## Installation

1. Install your MySQL driver.
2. Place `d4tConnection` in your resources folder.
3. Add this before other d4t resources:

```cfg
ensure oxmysql
ensure d4tConnection
```

or:

```cfg
ensure mysql-async
ensure d4tConnection
```

4. Configure your database connection using convars:

```cfg
set d4t_mysql_host "127.0.0.1"
set d4t_mysql_port "3306"
set d4t_mysql_database "fivem"
set d4t_mysql_user "root"
set d4t_mysql_password "password"
```

## Server Exports

### Query

```lua
local rows = exports.d4tConnection:Query('SELECT * FROM d4t_accounts WHERE id = ?', { 1 })
```

### Single

```lua
local row = exports.d4tConnection:Single('SELECT * FROM d4t_accounts WHERE email = ?', { email })
```

### Execute

```lua
exports.d4tConnection:Execute('UPDATE d4t_accounts SET last_login = NOW() WHERE id = ?', { accountId })
```

### Insert

```lua
local id = exports.d4tConnection:Insert('INSERT INTO d4t_accounts (username) VALUES (?)', { username })
```

### Transaction

```lua
local ok = exports.d4tConnection:Transaction({
    {
        query = 'UPDATE d4t_accounts SET username = ? WHERE id = ?',
        values = { username, accountId }
    }
})
```

### Ready

```lua
local ready = exports.d4tConnection:Ready()
```

### Stats

```lua
local stats = exports.d4tConnection:Stats()
```

## Notes

d4tConnection should be started before resources that use database queries.
