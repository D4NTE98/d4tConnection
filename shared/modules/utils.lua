D4TConnection = D4TConnection or {}

function D4TConnection.Time()
    return GetGameTimer()
end

function D4TConnection.Debug(message)
    if Config.Debug then
        print(('[d4tConnection] %s'):format(message))
    end
end

function D4TConnection.TableName(name)
    return ('d4t_%s'):format(name)
end
