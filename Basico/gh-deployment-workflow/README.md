# 🌐 GitHub Pages Deployment (CI/CD)

¡Bienvenido a mi proyecto **GitHub Pages Deployment**! Este es un proyecto de nivel **básico**, ideal para adentrarme en el mundo de la **Integración Continua (CI)** y el **Despliegue Continuo (CD)** utilizando las herramientas nativas de GitHub.

## 🎯 Objetivo del Proyecto
El objetivo principal de este proyecto es aprender cómo **automatizar el despliegue** de una página web estática. 

En lugar de subir los archivos manualmente a un servidor cada vez que hago un cambio en mi código, he creado un flujo de trabajo o *workflow* en GitHub Actions que lo hace por mí de forma automática. De esta manera, cada vez que modifico el archivo `index.html` y subo los cambios a GitHub (push), el flujo detecta la modificación y publica la nueva versión de mi web en internet automáticamente.

## ⚙️ Cómo configurar un repositorio para usar GitHub Actions

Para que GitHub Actions funcione y publique una web en GitHub Pages, hay que preparar el repositorio siguiendo dos pasos muy concretos:

### 1. La estructura de carpetas
GitHub **solo** buscará instrucciones de automatización si están guardadas en una carpeta muy específica que debe estar obligatoriamente en la **raíz del repositorio**. He creado esta ruta exacta:
```text
.github/workflows/
```
Dentro de esta carpeta de `workflows` es donde he creado y guardado mis archivos `.yml` (como mi archivo `deploy.yml`).

### 2. Habilitar GitHub Pages por Actions
Por defecto, los repositorios en GitHub no publican páginas web. Para activarlo y decirle que GitHub Actions se va a encargar del proceso:
1. Fui al repositorio en GitHub.
2. Hice clic en la opción superior **Settings**.
3. En el menú de la izquierda, busqué el apartado **Pages**.
4. Donde dice **Build and deployment**, abrí el desplegable "Source" y seleccioné **GitHub Actions**.

Con esto el repositorio queda totalmente configurado para alojar web

## 🧠 Explicación de mi código YML

El archivo `.yml` es simplemente un guion o lista de instrucciones paso a paso para los servidores de GitHub. Así es como se lee el código que he utilizado:

- **¿Cuándo se ejecuta de forma automática? (`on: push`)**: Le indico al flujo que esté "dormido" hasta que detecte un `push` a la rama `master`, pero con una restricción especial (`paths:`): **solo** debe despertarse si el archivo modificado ha sido mi `index.html`.
- **¿Cómo lo ejecuto manualmente? (`workflow_dispatch`)**: He añadido esta instrucción mágica porque Actions es muy estricto. Si subo una configuración pero no he modificado el `index.html`, el flujo automático no arranca. Gracias a `workflow_dispatch`, se habilita un botón en la web de GitHub (en la pestaña *Actions*) que me permite forzar el despliegue a mano con un solo clic en "Run workflow", ideal para poder probar que todo funciona sin tener que ensuciar mi historial con *commits falsos*.
- **¿Qué permisos necesita? (`permissions`)**: Para evitar hackeos o problemas de seguridad, los flujos de Actions nacen sin poder tocar casi nada. Tengo que darle permiso explícito de escritura para que le dejen publicar cosas en el servicio de Pages (`pages: write`).
- **El Trabajo a realizar (`jobs` -> `steps`)**:
  1. **Checkout**: El primer paso es decirle a la máquina virtual que descargue todo mi código fuente para poder leerlo.
  2. **Upload Artifact (Empaquetar)**: Como mi repositorio tiene varios proyectos de DevOps y no quiero subirlo entero, uso el comando `path: './Basico/gh-deployment-workflow'` para que empaquete **solo y exclusivamente** la carpeta de mi web. A este paquete se le llama "Artefacto".
  3. **Deploy (Desplegar)**: Finalmente, el sistema pasa ese paquete a la herramienta de GitHub Pages para que la suba a internet y devuelva la URL.

## 🔗 Enlaces
- [Ver mi web desplegada en GitHub Pages](https://izann06.github.io/DevOps-Proyectos-RoadMap/)
- [Reto original propuesto por roadmap.sh](https://roadmap.sh/projects/github-actions-deployment-workflow)
