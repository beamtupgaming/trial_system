local ongoingTrials = {} -- To store ongoing trials

-- Function to start a trial
function StartTrial(judge, defense, accused)
    local trial = {
        judge = judge,
        defense = defense,
        accused = accused,
        verdict = nil,
    }

    table.insert(ongoingTrials, trial)

    TriggerClientEvent("trial:start", -1, trial) -- Broadcast the trial start to all players
end

-- Function to submit a verdict
function SubmitVerdict(judge, verdict)
    for _, trial in ipairs(ongoingTrials) do
        if trial.judge == judge then
            trial.verdict = verdict
            TriggerClientEvent("trial:verdict", -1, trial) -- Broadcast the verdict to all players
            table.remove(ongoingTrials, _)
            break
        end
    end
end

-- Event handler for a player submitting a verdict
RegisterServerEvent("trial:submitVerdict")
AddEventHandler("trial:submitVerdict", function(verdict)
    local judge = source
    SubmitVerdict(judge, verdict)
end)

-- Event handler for a player requesting a trial
RegisterServerEvent("trial:requestTrial")
AddEventHandler("trial:requestTrial", function(defense, accused)
    local judge = source
    StartTrial(judge, defense, accused)
end)
