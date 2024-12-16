#!/bin/bash

# Script for converting video files in a folder.
# Set the options below.

# Parametrs
scale="960:480"     # Resolution (e.g., 1280:720, 960:480)
codec="libx264"     # Uses the H.264 codec for compression (e.g., libx264).
quality="23"        # Quality level (the higher the number, the lower the quality and file size). Typically, the range is 18–28.
speed="fast"        # Encoding speed (options include ultrafast, fast, slow, etc.; slower presets offer better compression).
audiocodec="aac"    # Audio codec (e.g., aac).
bitrate="128k"      # Audio bitrate (e.g., 128k).
map_video="0:v:0"   # Video track to keep (e.g., 0:v:0).
map_audio="0:a:0"   # Audio track to keep (e.g., 0:a:0).
map_subs=""         # Subtitles, if needed (e.g., 0:s:0; leave empty to exclude subtitles).
speed_factor=1.25   # Speed adjustment factor (e.g., 2.0 for 2x speed).


# Traverse all files with a given extension in the current folder
for file in *$extension; do
  if [ -f "$file" ]; then
    # Remove the extension from the file name and save the extension to a variable
    extension=".${file##*.}"
    filename="${file%$extension}"

    # Generate output file name
    output_file="${filename}_converted${extension}"

    # Building an ffmpeg command based on the selected tracks
    map_options="-map $map_video -map $map_audio"
    if [ -n "$map_subs" ]; then
      map_options+=" -map $map_subs"
    fi

    # Setting filters to change speed
    video_speed=1/$speed_factor
    audio_speed=$speed_factor
    # Changfe speed video and audio + change SCALE of video
    change_speed="-vf setpts=${video_speed}*PTS,scale=${scale} -filter:a atempo=${audio_speed}"

    # Convert video with CODEC, QUALITY and SPEED
    change_video="-c:v $codec -crf $quality -preset $speed"
    # Convert audio (only stereo) with AUDIOCODEC and BITRATE
    change_audio="-c:a $audiocodec -b:a $bitrate"

    # Executing the conversion command
    echo "File is being processed: $file"
    command="ffmpeg -i $file $map_options $change_speed $change_video $change_audio $output_file"
    echo "---------------------------------------------------------------------------------------------------------------------------------------"
    echo "COMMAND: $command"
    echo "---------------------------------------------------------------------------------------------------------------------------------------"
    $command

    if [ $? -eq 0 ]; then
      echo "The file has been successfully converted.: $output_file"
    else
      echo "Error processing file: $file"
    fi
  fi
done

echo "That's all, guys!"
