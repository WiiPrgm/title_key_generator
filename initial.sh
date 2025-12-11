wiimagic=""
unenc_bits=""
disc_encryption=""
partition1_offset=""
partition2_offset=""
iv_hex_half=""
iv_hex=""


retail_key="EBE42A225E8593E448D9C5457381AAF7"
debug_key="A1604A6A7123B529AE8BEC32C816FCAA"

echo "alpha script"
echo "only checking parition 2"
echo "assuming retail disc"


partition1_offset=$(( $(printf '%d\n' 0x$(xxd -s 262176 -l 4 -p "$1")) *4 ))
partition2_offset=$(( $(printf '%d\n' 0x$(xxd -s 262184 -l 4 -p "$1")) *4 ))

#echo "current script only checks partition2"
dd if="$1" bs=1 skip=$(( partition2_offset + 447 )) count=16 status=none > enc_titlekey


iv_hex="$(xxd -s $(( partition2_offset+476 )) -l 8 -p "$1")""0000000000000000"

openssl enc -aes-128-cbc -d -K "$retail_key" -iv "$iv_hex" -nopad -in enc_titlekey | xxd -p

wiimagic=$(xxd -s 24 -l 4 -p "$1")
unenc_bits=$(xxd -s 96 -l 2 -p "$1")
#if unenc_bits=0101, disc is unencrypted

echo $wiimagic
echo $unenc_bits
echo $partition1_offset
echo $partition2_offset


#if wiimagic ne wiimagic, say so
#if it does have wii magic, check for unencrypted disc
#if not encrypted, check for encryption type, retail or debug or vwii?
#pull out titleid
#generate title key
