## Qué es esto

Prototipo estático exportado desde un proyecto de Claude Design (claude.ai/design). No es un proyecto Astro/Tailwind ni tiene build — es HTML + JS plano servido tal cual, a propósito, para no perder fidelidad visual/de interacción frente al diseño original.

- **`Spectrum Web.dc.html`** — archivo fuente real del sitio. Un SPA en React (sin JSX, `React.createElement` plano) con enrutamiento por estado (`view`: home/list/detail/compare/calc) en vez de URLs reales. Cualquier cambio de contenido, copy, datos de proyectos o comportamiento se edita **directamente en este archivo**.
- **`Spectrum Mobile.dc.html`** — mockup de referencia (marco iOS de ancho fijo) del mismo diseño para el canvas de Claude Design. No se usa en runtime, solo como referencia visual mobile.
- **`support.js`** — runtime generado por Claude Design (parsea el documento `<x-dc>`, implementa `sc-if`/`sc-for`, expone React). No se edita a mano.
- **`logo-spectrum.svg`, `logo-spectrum-white.svg`** — logos (nav / footer).
- **`i18n-en.js`** — strings de traducción para el toggle de idioma ES/EN (cargado desde `<helmet>` y por `loadI18n()`).
- **`img-opt/`** — imágenes optimizadas que el sitio referencia localmente (fallback cuando no corre dentro del canvas de Claude Design).
- **`uploads/`** — capturas de pantalla sueltas del usuario, no son assets del sitio.
- **`favicon.svg`** — el único archivo de esta carpeta que NO viene del export de Claude Design. Es el isotipo del logo, agregado a mano.

## Favicon (ojo al actualizar)

`Spectrum Web.dc.html` y `Spectrum Mobile.dc.html` no traen `<link rel="icon">` en su export — el favicon está inyectado a mano en el `<head>` estático de cada archivo:

```html
<link rel="icon" type="image/svg+xml" href="favicon.svg">
```

**Cada vez que el usuario reemplace `Spectrum Web.dc.html` / `Spectrum Mobile.dc.html` con un nuevo export de Claude Design, este link se pierde y hay que volver a agregarlo** (justo después del `<meta name="viewport">`, antes del `<script src="./support.js">`). `favicon.svg` en sí no se toca — solo la referencia dentro del HTML.

## Development

Servidor estático (`serve`), sin build:

```
npm run dev
```

Levanta en `http://localhost:4321`. `serve.json` reescribe `/` → `Spectrum Web.dc.html` (el archivo no está renombrado a `index.html`).

Para correrlo en background:

```
npx serve -l 4321 . &
```

No hay `astro dev`, no hay `.astro/` cache, no hay paso de build — es solo servir archivos estáticos.
