#!/bin/bash
"""
Скрипт для автоматической транслитерации русского и английского текстов
TODO: в будущем надо разделить логику на срабатывание при выделении текста и на последнее слово,
либо доработать данный скрипт
"""
log_file="$HOME/switcher-output.log"
#exec > >(tee -a "$log_file") 2>&1

#Записываем имя окна, в котором срабатывает скрипт, в лог-файл
window_name=$(xdotool getactivewindow getwindowname)
echo >> $log_file
echo "Окно выполнения: "$window_name >> $log_file

#Очищаем буфер обмена
echo -n | xsel -b
qdbus org.kde.klipper /klipper clearClipboardHistory

xdotool key Ctrl+Insert

# Получаем выделенный текст (должен быть не из буфера обмена, по идее)
selected_text=$(xsel -o)
echo "Выделенный и скопированный текст: "$selected_text >> $log_file

#Проверка на вшивость
if [[ -z "$selected_text" || "$selected_text" == *" "* || "$selected_text" == $'\r' ]]; then
# Если куроср стоит в конце слова, исполняется код этого блока
    echo "Пустая строка" >> $log_file
    count=50
    selected_text=""

    # Пока не достигнуто начало слова
    while true; do
        xdotool key Shift+Left  # 
        sleep 0.1
        selected_text=$(xsel -o)
        #echo $selected_text

        # Текущий символ
        current_char="${selected_text:0:1}"

        # Если текущий символ пробел или переход на новую строку или начало строки, тогда прерываем цикл
        if [[ "$current_char" == " " || "$current_char" == $'\n' || "$current_char" == $'\r' ]]; then
            break
        fi

        # Прерывание на случай непредвиденных обстоятельств
        count=$((count-1))
        if [[ $count -eq 0 ]]; then
            echo "Неправильно отработал скрипт, было захвачено более 50 символов" >> $log_file
            break
            exit 1
        fi
    done

    #Если $selected_text не пустой, тогда производим транслитерацию
    if [ -n "$selected_text" ]; then
        echo "Текст собранный по буквам: "$selected_text >> $log_file
        # Код для изменения текста в переменной
        transliterated_text=$(echo "$selected_text" | sed "y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.\/<>?@#\$^&\`~фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбюБЮ№ёЁ/фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбю.БЮ,\"№;:?ёЁabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.<>#\`~/")
    else    
        echo "Текст собранный по буквам, оказался пустым."$selected_text >> $log_file
        exit 1
    fi

else
# Иначе, исполняется код этого блока
    # Код для изменения текста в переменной
    transliterated_text=$(echo "$selected_text" | sed "y/abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.\/<>?@#\$^&\`~фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбюБЮ№ёЁ/фисвуапршолдьтщзйкыегмцчняФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯхъХЪжэЖЭбю.БЮ,\"№;:?ёЁabcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ[]{};':\",.<>#\`~/")
fi

echo "Текст на выходе: "$transliterated_text >> $log_file

# Заменяем выделенный текст на новый текст в буфере обмена
echo -n "$transliterated_text" | xsel -b -i

sleep 0.1
xdotool key Shift+Insert    # Вставляем исправленный текст
xdotool key Meta+Alt+K      # Должен менять раскладку, но у меня на Манжаре КДЕ не меняет
