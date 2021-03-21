meta.name = 'Sound test'
meta.version = 'WIP'
meta.description = 'Tests sound stuff'
meta.author = 'Malacath-92'

message('Loaded sound test mod...')

-- If you wanna test music place your own file next to this script
--[[
test_music = create_sound('music.mp3')
if test_music ~= nil then
    test_music:play(false, SOUND_TYPE.MUSIC)
end
]]

test_sound = create_sound('stupid.mp3')
if test_sound ~= nil then
    test_sound:play()
end
count = 0

set_callback(function()
    if test_sound ~= nil then
        interval_id = set_interval(function()
            message('Playing sound...')
            playing_sound = test_sound:play(true)
            if count == 0 then
                message('Panning all left...')
                playing_sound:set_pan(-1.0)
            elseif count == 1 then
                message('Panning all right...')
                playing_sound:set_pan(1.0)
            elseif count == 2 then
                message('High pitch...')
                playing_sound:set_pitch(2.0)
            elseif count == 3 then
                message('Low pitch...')
                playing_sound:set_pitch(0.5)
            elseif count == 4 then
                message('Low volume...')
                playing_sound:set_volume(0.25)
            elseif count == 5 then
                message('Muted...')
                playing_sound:set_mute(true)
            end
            playing_sound:set_pause(false)
    
            count = count + 1
            if count > 5 then
                message('Destroying sound...')
                test_sound = nil
                clear_callback(interval_id)
            end
        end, 60 * 5)
    else
        message('Sound was not found...')
    end
end, ON.CAMP)