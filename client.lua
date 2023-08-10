local isInTrial = false

-- Function to start the trial UI
function StartTrialUI(trialData)
    isInTrial = true

    SendNUIMessage({
        type = "startTrial",
        trial = trialData
    })
    SetNuiFocus(true, true)
end

-- Function to close the trial UI
function CloseTrialUI()
    isInTrial = false

    SendNUIMessage({
        type = "closeTrial"
    })
    SetNuiFocus(false, false)
end

-- Event handler for receiving a trial start event
RegisterNetEvent("trial:start")
AddEventHandler("trial:start", function(trialData)
    StartTrialUI(trialData)
end)

-- Event handler for receiving a verdict event
RegisterNetEvent("trial:verdict")
AddEventHandler("trial:verdict", function(trialData)
    -- Process the verdict and display it to the player
end)

-- Trigger a verdict submission
function SubmitVerdict(verdict)
    TriggerServerEvent("trial:submitVerdict", verdict)
    CloseTrialUI()
end

-- Trigger a trial request
function RequestTrial(defense, accused)
    TriggerServerEvent("trial:requestTrial", defense, accused)
end