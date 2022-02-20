d = hs.logger.new('mylogger')

Anycomplete = hs.loadSpoon("Anycomplete")
Anycomplete.bindHotkeys()

MusicMenuItem = hs.menubar.new()
MusicMenuItem:setClickCallback(function()
  hs.itunes.playpause()
end)
function MusicMenuPP(info)
  local cond
  if info then
    cond = info['Player State'] == 'Paused'
  else
    local pbs = hs.itunes.getPlaybackState()
    cond = pbs == hs.itunes.state_paused or pbs == hs.itunes.state_stopped
  end
  return cond and '(paused) ' or ''
end
MusicNotifications = hs.distributednotifications.new(function(name, object, userInfo)
  local info = userInfo
  d:e(hs.inspect(info))
  local playerState = MusicMenuPP(userInfo)
  MusicMenuItem:setTitle(string.format('%s%s - %s', playerState, info['Name'], info['Artist']))
end, 'com.apple.Music.playerInfo', 'com.apple.Music.player'):start()
MusicMenuItem:setTitle(string.format('%s%s - %s', MusicMenuPP(), hs.itunes.getCurrentTrack(), hs.itunes.getCurrentArtist()))

hs.hotkey.bind({"cmd", "ctrl"}, "C", function()
  os.execute('open "https://classroom.google.com/u/1"')
end)


hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

Emojis = hs.loadSpoon("Emojis")
Emojis:bindHotkeys({ toggle = {{"cmd", "alt", "ctrl"}, "e"} })
