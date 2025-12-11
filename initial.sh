wiimagic=$(xxd -s 24 -l 4 -p $1)

#if wiimagic ne wiimagic, say so
#if it does have wii magic, check for unencrypted disc
#if not encrypted, check for encryption type, retail or debug or vwii?
#pull out titleid
#generate title key
