# Usa una imagen base oficial de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias necesarias del sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Instala JupyterLab
RUN pip install --no-cache-dir jupyterlab

# Crea una configuración para JupyterLab en el directorio de trabajo
RUN mkdir -p /app/.jupyter && \
    python3 -c "from notebook.auth import passwd; \
    hashed_password = passwd('tu_contraseña_segura'); \
    with open('/app/.jupyter/jupyter_notebook_config.py', 'w') as f: \
        f.write(f\"c.NotebookApp.password = '{hashed_password}'\\n\")"

# Expone el puerto que usará JupyterLab
EXPOSE 8888

# Define el comando de inicio
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=$PORT", "--no-browser", "--config=/app/.jupyter/jupyter_notebook_config.py"]
