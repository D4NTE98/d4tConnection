CreateThread(function()
    local started = GetGameTimer()

    while GetGameTimer() - started < Config.ReadyTimeout do
        if MySQL ~= nil then
            ConnectionState.ready = true
            print('[d4tConnection] ready')
            return
        end

        Wait(250)
    end

    print('[d4tConnection] MySQL driver was not detected')
end)
