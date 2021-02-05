whiteChecker_GUID = 'a76946'

setup_params = {}
setup_params.click_function = 'setup'
setup_params.function_owner = nil
setup_params.label = 'Setup Game'
setup_params.position = {0,0.8,4}
setup_params.rotation = {0,0,0}
setup_params.width = 3000
setup_params.height = 1000
setup_params.font_size = 300

deck_params = {
    type = "Deck",
    rotation = {x=0, y=0, z=180}
}



function onload()
    whiteChecker = getObjectFromGUID(whiteChecker_GUID)

    whiteChecker.setName('Squeak Master')
    
    -- setup button
    whiteChecker.createButton(setup_params)

    -- Squeak button
end

function sendObjectPlayerHand(obj, player) -- not working, failing because it says player hand transform is nil
    -- adapted from:
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=791150113
    local offset = 4
    -- https://api.tabletopsimulator.com/player/#gethandtransform
    local hand = player.getHandTransform()
    local target =
    { hand.position.x + hand.forward.x * offset
    , hand.position.y + hand.forward.y * offset
    , hand.position.z + hand.forward.z * offset
    }

    obj.setPositionSmooth(target)
    obj.setRotationSmooth(
    {hand.rotation.x
    , hand.rotation.y + 180 --make object look out from hand
    , hand.rotation.z }
)
end

function setup()
    -- Give a deck to each player and arrange it in the squeak patter
    players = getSeatedPlayers()
    
    for i, player in ipairs(players) do
        deck = spawnObject(deck_params)
        player_table = Player[player]
        broadcastToAll(player)
        broadcastToAll("Gets a deck!")
        sendObjectPlayerHand(deck, player_table)
    end

    -- for i=1, 10 do
    --     broadcastToAll(i)
    -- end
    -- broadcastToAll('Get ready to squeak your butts off!')
end
