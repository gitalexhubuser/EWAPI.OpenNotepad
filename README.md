# HNG

## Описание

В Wow(е) добавляем функционал, чтоб открывать файлы в блокноте, в винде через свой `hng протокол` и библиотеку [ER](http://erotation.ru/).

Работает на базе апи `LaunchURL`

## Видео

https://www.youtube.com/@%D0%9B%D1%83%D0%B0%D0%A1%D0%BA%D1%80%D0%B8%D0%BF%D1%82%D1%8B%D0%9D%D0%B0%D0%97%D0%B0%D0%BA%D0%B0%D0%B7

## Wow - LaunchURL

/run EWAPI().LaunchURL("https://forum.wowcircle.com/showthread.php?t=655891")

/run EWAPI().LaunchURL("hng://notepad/C:/HNG/test.txt")

/run EWAPI().LaunchURL("hng://notepad/D:\Byster\Interface\AddOns\_GM[AdminskieUtehi3]\Шмотки\Шмотки на мм ханта.txt")

## Wow - OpenNotepad

/run OpenNotepad("hng://notepad/D:\Byster\Interface\AddOns\_GM[AdminskieUtehi3]\Шмотки\Шмотки на мм ханта.txt")

/run EWAPI().OpenNotepad("D:\\Byster\\Interface\\AddOns\\_GM[AdminskieUtehi3]\\Шмотки\\Шмотки на мм ханта.txt")

/run EWAPI().OpenNotepad([[D:\Byster\Interface\AddOns\_GM[AdminskieUtehi3]\Шмотки\Шмотки на мм ханта.txt]])

## cmd

python E:\PythonProjects\hggProtocol\hng_handler.py "hng://notepad/E:/PythonProjects/hggProtocol/test.txt"

## Install

C:\HNG\install_hng.bat

## Protocol

Win+r

hng://notepad/C:/HNG/test.txt

# Link
https://github.com/gitalexhubuser/EWAPI-.OpenNotepad
