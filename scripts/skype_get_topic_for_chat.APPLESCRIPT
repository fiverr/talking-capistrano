on run argv
  tell application "Skype"
    send command "GET CHAT " & item 1 of argv & " TOPIC" script name "TalkingCapistrano"
  end tell
end run