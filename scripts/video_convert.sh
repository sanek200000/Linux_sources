#!/bin/bash

# Скрипт для конвертации видеофайлов в папке.
# Задайте параметры ниже.

# Параметры
extension=".mkv"    # Расширение файлов для обработки (например, .mkv, .avi)
scale="1280:720"    # Разрешение (например, 1280:720)
codec="libx264"    # использует кодек H.264 для сжатия.(например, libx264)
quality="23"       # уровень качества (чем выше число, тем ниже качество и меньше размер файла). Обычно диапазон 18–28.
speed="fast"       # скорость кодирования (можно использовать ultrafast, fast, slow и т.д., медленные пресеты дадут лучшее сжатие).
audiocodec="aac"   # Аудиокодек (например, aac)
bitrate="128k"     # Битрейт аудио (например, 128k)
map_video="0:v:0"  # Видеодорожка, которую оставить (например, 0:v:0)
map_audio="0:a:0"  # Аудиодорожка, которую оставить (например, 0:a:0)
map_subs=""        # Субтитры, если нужно (например, 0:s:0; оставьте пустым, чтобы исключить субтитры)
speed_factor=1.25 # Фактор изменения скорости (например, 2.0 для ускорения в 2 раза)

# Создание выходной директории
output_dir="converted"
mkdir -p "$output_dir"

# Обход всех файлов с заданным расширением в текущей папке
for file in *$extension; do
  if [ -f "$file" ]; then
    # Убираем расширение из имени файла
    filename="${file%$extension}"

    # Генерация имени выходного файла
    output_file="$output_dir/${filename}_converted${extension}"

    # Построение команды ffmpeg с учетом выбранных дорожек
    map_options="-map $map_video -map $map_audio"
    if [ -n "$map_subs" ]; then
      map_options+=" -map $map_subs"
    fi

    # Установка фильтров для изменения скорости
    video_speed=1/$speed_factor
    audio_speed=$speed_factor

    # Выполнение команды конвертации
    echo "Обрабатывается файл: $file"
    #ffmpeg -i input.mkv -map 0:v:0 -map 0:a:1 -vf "setpts=0.8*PTS,scale=1280:720" -filter:a "atempo=1.25" -c:v libx264 -crf 23 -preset fast -c:a aac -b:a 128k output.mkv
    # ffmpeg -i in.mp4 -map 0:v:0 -map 0:a:3 -vf "setpts=0.8*PTS" -filter:a "atempo=1.25" -c:v libx264 -crf 23 -preset fast -c:a aac -b:a 128k output.mp4
    ffmpeg -i "$file" $map_options -vf "setpts=${video_speed}*PTS,scale=${scale}" -filter:a "atempo=${audio_speed}" -c:v $codec -crf $quality -preset $speed -c:a $audiocodec -b:a $bitrate "$output_file"

    if [ $? -eq 0 ]; then
      echo "Файл успешно конвертирован: $output_file"
    else
      echo "Ошибка при обработке файла: $file"
    fi
  fi
done

echo "Обработка завершена. Все файлы сохранены в папке '$output_dir'."
