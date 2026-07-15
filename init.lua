local timer = 0

local TARGET_VALUE = 1000.0

local function FixSavageSling()
    local player = Game.GetPlayer()

    if not player then
        return
    end

    local playerID = player:GetEntityID()
    local stats = Game.GetStatsSystem()

    local current = stats:GetStatValue(
        playerID,
        gamedataStatType.NewPerkFinisherBlunt_TargetHealthMax
    )


    if current < TARGET_VALUE then

        stats:AddModifier(
            playerID,
            RPGManager.CreateStatModifier(
                gamedataStatType.NewPerkFinisherBlunt_TargetHealthMax,
                gameStatModifierType.Additive,
                TARGET_VALUE
            )
        )

        print("[SavageSling] Threshold restored")

    end
end


registerForEvent("onUpdate", function(deltaTime)

    timer = timer + deltaTime

    -- Only check every 5 seconds
    if timer >= 5 then
        timer = 0
        FixSavageSling()
    end

end)
