# Allegro 5 bindings for Oberon

![Oberon graphics program screenshot](screenshot.png)

*Read in Russian below*

Allegro5 is a cross-paltform graphics library. It supports GPU-based drawing.

Oberon is the most simple yet very powerful general-purpose programming language.

## Compiler

You will need
[Free Oberon Compiler](https://github.com/oberoncompiler/foc)
to compile the library binding and the tests.

## Building

1. Install [Free Oberon Compiler](https://github.com/oberoncompiler/foc)
and add the directory containing `foc` exectuable to your `PATH`
environment variable (or run `foc` executable directly, using full path).

2. Download and unpack this repo.

3. Go to the this repo's directory (containing `RunTests.Mod`) and run:
```
foc RunTests
```

A file `RunTests.exe` will be created. Run it.

_________________________________________________

# Привязка Аллегро-5 для Оберона

Аллегро-5 — это кроссплатформенная графическая библиотека. Она поддерживает
прорисовку с использованием ГПУ.

Оберон — это самый простой, но очень мощный язык программирования.

## Компилятор

Вам понадобится
[компилятор Free Oberon](https://github.com/oberoncompiler/foc),
чтобы скомпилировать привязку к библиотеке и испытательные программы.

## Сброка

1. Установите [компилятор Free Oberon](https://github.com/oberoncompiler/foc)
и добавьте пусть к каталогу, содержащиму исполнимый файл `foc`, в переменную
окружения `PATH` (или запускайте `foc` напрямую, указывая полный путь к нему).

2. Скачайте и распакуйте данный репозиторий.

3. Перейдите в каталог этого репозитория (содержащий `RunTests.Mod`)
и наберите:
```
foc RunTests
```

Появится файл `RunTests.exe`. Запустите его.