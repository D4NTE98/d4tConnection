local function traceQuery(kind, query, started)
    ConnectionState.stats.queries = ConnectionState.stats.queries + 1

    local elapsed = GetGameTimer() - started

    if Config.SlowQuery.enabled and elapsed >= Config.SlowQuery.threshold then
        ConnectionState.stats.slow = ConnectionState.stats.slow + 1
        print(('[d4tConnection] slow %s query %sms: %s'):format(kind, elapsed, query))
    end
end

function Query(query, params)
    local started = GetGameTimer()
    local ok, result = pcall(ConnectionFetch, query, params)

    traceQuery('fetch', query, started)

    if not ok then
        ConnectionState.stats.errors = ConnectionState.stats.errors + 1
        print(('[d4tConnection] query error: %s'):format(result))
        return {}
    end

    return result or {}
end

function Single(query, params)
    local started = GetGameTimer()
    local ok, result = pcall(ConnectionSingle, query, params)

    traceQuery('single', query, started)

    if not ok then
        ConnectionState.stats.errors = ConnectionState.stats.errors + 1
        print(('[d4tConnection] single error: %s'):format(result))
        return nil
    end

    return result
end

function Execute(query, params)
    local started = GetGameTimer()
    local ok, result = pcall(ConnectionExecute, query, params)

    traceQuery('execute', query, started)

    if not ok then
        ConnectionState.stats.errors = ConnectionState.stats.errors + 1
        print(('[d4tConnection] execute error: %s'):format(result))
        return 0
    end

    return result or 0
end

function Insert(query, params)
    local started = GetGameTimer()
    local ok, result = pcall(ConnectionInsert, query, params)

    traceQuery('insert', query, started)

    if not ok then
        ConnectionState.stats.errors = ConnectionState.stats.errors + 1
        print(('[d4tConnection] insert error: %s'):format(result))
        return 0
    end

    return result or 0
end

function Transaction(queries)
    local started = GetGameTimer()
    local ok, result = pcall(ConnectionTransaction, queries)

    traceQuery('transaction', 'transaction', started)

    if not ok then
        ConnectionState.stats.errors = ConnectionState.stats.errors + 1
        print(('[d4tConnection] transaction error: %s'):format(result))
        return false
    end

    return result == true
end

function Ready()
    return ConnectionState.ready
end

function Stats()
    return ConnectionState.stats
end

exports('Query', Query)
exports('Single', Single)
exports('Execute', Execute)
exports('Insert', Insert)
exports('Transaction', Transaction)
exports('Ready', Ready)
exports('Stats', Stats)
