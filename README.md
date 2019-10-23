# BuscaminasVala
El clásico juego Buscaminas hecho en Vala con amor :sparkling_heart:

> ## Instalación
> Lo que necesitas para instalar Vala (en Ubuntu):
>
>     $ sudo apt-get update
>     $ sudo apt install valac

> ## Pruebas
> Lo que necesitas para instalar Vala (en Ubuntu):
>
>     $ sudo apt-get update
>     $ sudo apt install valac

> ## Requiere
> sudo apt-get install libgee-0.8-2 libgee-0.8-dev

## Pruebas
---
> Es importante haber instalado las los paquetes requeridos (estan arriba)
Para ejecutar las pruebas utilize el administrador de paquetes ´meson´.
El el directorio donde se encuentra el archivo ´meson.build´ ejecutamos:

     $ meson build
     $ cd build
     $ meson test
>> Tambien podemos ver con más detalles los errores con:
     $ meson test --print-errorlogs
