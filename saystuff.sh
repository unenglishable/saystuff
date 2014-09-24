if [ $# -lt 1 ]
then
  echo "Usage: saystuff [file]"
  exit
fi

# The average length of a pause between humans speaking
# to each other
SPEECH_PAUSE=.469;
FILE=$1
FILE_LENGTH=$(wc -l < $FILE)
LINE_NUM=$(((RANDOM%FILE_LENGTH)+1))

#VOICES=($(say -v ? | sed 's/\(^[a-zA-Z0-9]*\).*/\1/g'))
VOICES=( Agnes Albert Alex Boing Bruce Cellos Fred Good Junior Kathy Princess Ralph Trinoids Vicki Victoria Zarvox )
VOICE_LENGTH=${#VOICES[@]}

IFS_OLD=$IFS
IFS=\|
LINE_TEXT=($(awk "NR==$LINE_NUM{print;exit}" "$FILE"))
IFS=$IFS_OLD
for i in $(seq 0 $((${LINE_TEXT[0]}-1)))
do
  CHARACTERS[i]=$((RANDOM%VOICE_LENGTH))
done

for i in $(seq 1 $((${#LINE_TEXT[@]}-1)))
do
  READ_VOICE=${VOICES[${CHARACTERS[$i%${#CHARACTERS[@]}]}]}
  echo $READ_VOICE: ${LINE_TEXT[$i]}
  say -v $READ_VOICE ${LINE_TEXT[$i]}
  sleep $SPEECH_PAUSE
done
