local function hasMySQL()
    return MySQL ~= nil
end

function ConnectionFetch(query, params)
    if not hasMySQL() then
        return {}
    end

    params = params or {}

    if MySQL.query and MySQL.query.await then
        return MySQL.query.await(query, params) or {}
    end

    if MySQL.Sync and MySQL.Sync.fetchAll then
        return MySQL.Sync.fetchAll(query, params) or {}
    end

    return {}
end

function ConnectionSingle(query, params)
    local result = ConnectionFetch(query, params)

    if type(result) == 'table' then
        return result[1]
    end

    return nil
end

function ConnectionExecute(query, params)
    if not hasMySQL() then
        return 0
    end

    params = params or {}

    if MySQL.update and MySQL.update.await then
        return MySQL.update.await(query, params) or 0
    end

    if MySQL.Async and MySQL.Async.execute then
        local promise = promise.new()

        MySQL.Async.execute(query, params, function(affected)
            promise:resolve(affected or 0)
        end)

        return Citizen.Await(promise)
    end

    return 0
end

function ConnectionInsert(query, params)
    if not hasMySQL() then
        return 0
    end

    params = params or {}

    if MySQL.insert and MySQL.insert.await then
        return MySQL.insert.await(query, params) or 0
    end

    if MySQL.Async and MySQL.Async.insert then
        local promise = promise.new()

        MySQL.Async.insert(query, params, function(id)
            promise:resolve(id or 0)
        end)

        return Citizen.Await(promise)
    end

    ConnectionExecute(query, params)

    return 0
end

function ConnectionTransaction(queries)
    if not hasMySQL() then
        return false
    end

    if MySQL.transaction and MySQL.transaction.await then
        return MySQL.transaction.await(queries)
    end

    return false
end
