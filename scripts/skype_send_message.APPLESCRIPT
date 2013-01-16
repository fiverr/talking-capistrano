on run argv
  tell application "Skype"
    send command "CHATMESSAGE " & item 1 of argv & " " & item 2 of argv script name "TalkingCapistrano"
  end tell
end run