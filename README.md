# Agenda

Agenda personal para organizar eventos y tareas, tomar notas y llevar un registro de tus lecturas.

**[Abrir la agenda en GitHub Pages](https://ag-hp.github.io/agenda/)**

## Qué puedes hacer

- **Calendario.** Anota tareas, eventos y cumpleaños, y conecta Google Calendar para consultar tus eventos.
- **Notas.** Crea notas con texto, dibujo, subrayado, plantillas, colores de papel y notas adhesivas.
- **Libros.** Busca por título o autor, añade libros a tu galería de portadas y guarda una valoración y un comentario en cada ficha.

En la agenda publicada puedes crear una cuenta o entrar con Google. Las notas, los eventos que añades y tu colección de libros se guardan en tu cuenta.

## Desarrollo web

Desde la raíz del repositorio, ejecuta `python3 -m http.server 8000` y abre [la agenda con cuenta](http://localhost:8000/prueba-cuentas.html) o [la versión local](http://localhost:8000/).

GitHub Actions publica `prueba-cuentas.html` como portada y `index.html` como [versión local](https://ag-hp.github.io/agenda/local.html). En la versión local, los datos se guardan en el navegador.

La carpeta `supabase/` contiene la función de búsqueda web de libros y su migración de base de datos.
