#!/bin/sh

url="https://raw.githubusercontent.com/sanek200000/Linux_sources/main/manjaro/home/username/.i3/config"  # Замените ССЫЛКА_НА_ФАЙЛ на фактическую ссылку на файл

target_dir="$HOME/.i3/"  # Папка, куда нужно сохранить файл

# Создать директорию, если она не существует
mkdir -p "$target_dir"

# Имя файла, извлекаемое из ссылки
filename=$(basename "$url")

# Загрузка файла
curl -Lf -o "$target_dir/$filename" "$url"

echo "Файл успешно сохранен в $target_dir/$filename"
