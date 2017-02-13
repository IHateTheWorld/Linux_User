#!/bin/bash

#date function
DATE=`which date`

#mount ramdisk (uncomment and change if you want to use ramdisk - dont forget to change directory as well)
#gksu mount -t tmpfs -o size=3096M tmpfs /tmp/ramdisk/

#package select (avconv or ffmpeg)
RECORDER=ffmpeg
#How many threads used (0 for automatic)
THREADS=0
#Resolution
#XWININFO=$(xwininfo -frame)
#RESO=$(echo $XWININFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
XWININFO=$(xwininfo -root)
RESO=$(echo $XWININFO | grep -oEe 'geometry [0-9]+x[0-9]+' | grep -oEe '[0-9]+x[0-9]+')
#Xserver Display number(:0.0 is default)
#WIN_XY=$(echo $XWININFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' | grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/\+/,/' )
#XDISP=:0.0+$WIN_XY
XDISP=:0.0
#Audio Device
AUDIO=alsa
#Channels
CHANNELS=2
#SoundCard (pulse for pulseaudio, hw:0,1 for directly communicating with your soundcard - use aplay -l to see whats your value)
SOUNDCARD=pulse
#Frames per second
FPS=30
#Constant Rate Factor(0 is the highest quality 50 is the lowest)
CRF=0
#libx264 presets(slow, fast, superfast, ultrafast; additionaly check sudo find /usr -iname '*.ffpreset' for more)
PRESET=ultrafast
#Audio Codec (libmp3lame or libvorbis are most common)
ACODEC=libmp3lame
#Directory where your video is gonna be saved.(include / at the end)
DIRECTORY=$PWD/
#File name
if [ -z $1 ]; then
    FILENAME=`$DATE +%d%m%Y_%H.%M.%S`.mp4
else
    FILENAME=$1_`$DATE +%d%m%Y_%H.%M.%S`.mp4
fi

#script
SCRIPT="$RECORDER -f $AUDIO -i $SOUNDCARD -f x11grab -r $FPS -s $RESO -i $XDISP -vcodec libx264 -preset $PRESET -crf $CRF -acodec $ACODEC -ab 256k -async 1 -f mp4 -threads $THREADS $DIRECTORY$FILENAME"
echo $SCRIPT
#run the script
eval $SCRIPT

#old examples
##sample:ffmpeg -f alsa -ac 2 -i hw:0,1 -f x11grab -r 30 -s 1280x1024 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.avi
#sample2:avconv -f alsa -i pulse -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec mpeg4 -b 12000k -g 300 -bf 2 -acodec libmp3lame -ab 256k Screencast.avi
#sample3:ffmpeg -threads 0 -f alsa -i pulse -f x11grab -s 1280x720 -r 30 -i :0.0+0,0 -vcodec libx264 -preset superfast -crf 16 -acodec libmp3lame -ab 256k -ar 44100 -f mp4 screencast.mp4
