function onShutdown()
    Game.sendConsoleMessage('>> Saving Hirelings', CONSOLEMESSAGE_TYPE_INFO)
    SaveHirelings()
    return true
end
