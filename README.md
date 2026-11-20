# David Ramírez Palacios: Personal Website

Personal portfolio site: about, experience, projects, skills, education and contact.
It is plain HTML, CSS and JavaScript with no build step, served by nginx in a Docker container and deployed on [Render](https://render.com).

Deploy app: https://mysite-s3ud.onrender.com/

## Project structure

```
.
├── index.html                    # Page content (all sections)
├── styles.css                    # Styles, light/dark theme, responsive layout
├── script.js                     # Theme toggle, mobile menu, scroll effects
├── favicon.svg                   # Site icon
├── nginx/
│   └── default.conf.template     # nginx config; ${PORT} is filled in at startup
├── Dockerfile                    # nginx:alpine image that serves the site
├── .dockerignore
└── render.yaml                   # Render Blueprint (Docker web service)
```

## Run locally

**Without Docker:** open `index.html` in a browser, or serve the folder:

```bash
python3 -m http.server 8000
# → http://localhost:8000
```

**With Docker:**

```bash
docker build -t mysite .
docker run --rm -p 10000:10000 mysite
# → http://localhost:10000
```

To use a different port, set `PORT` and map the same port:

```bash
docker run --rm -e PORT=8080 -p 8080:8080 mysite
```

> **Working on a remote machine over SSH (for example VS Code Remote-SSH)?**
> `localhost` in your browser points to your own computer, not the server.
> Forward port `10000` from VS Code's **Ports** panel, or open `http://<server-ip>:10000`.

Health check endpoint: `GET /healthz` returns `ok`.

## Deploy to Render

The container listens on the port in the `PORT` environment variable, which Render sets automatically (default `10000`).

**Option A: Blueprint (uses `render.yaml`)**
1. Push the repo to GitHub.
2. In Render, choose **New → Blueprint** and select the repository.
3. Render creates the `david-ramirez-site` web service on the free plan.

**Option B: Manual web service**
1. In Render, choose **New → Web Service** and connect the repository.
2. Set **Runtime** to **Docker**. The Dockerfile path is `./Dockerfile`.
3. Optionally set **Health Check Path** to `/healthz`.

With auto-deploy enabled, every push to `main` redeploys the site.

## Editing content

- All text lives in `index.html`. Each section has an id (`#about`, `#experience`, `#projects`, `#skills`, `#education`, `#contact`).
- To add a project, copy an `<article class="project">` block inside `#projects`.
- To add a skill, add an `<li>` to the matching `<ul class="tags">`.
- Theme colours are CSS variables at the top of `styles.css`.
- If you add a new file (for example `cv.pdf` or images), also add it to the `COPY` line in the `Dockerfile`.

## Contact

- GitHub: [@davidraamirez](https://github.com/davidraamirez)
- LinkedIn: [David Ramírez Palacios](https://www.linkedin.com/in/david-ram%C3%ADrez-palacios-352376120/)
- Email: ramirezpalaciosd@gmail.com
