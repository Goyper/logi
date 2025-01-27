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

# Configura JupyterLab para que no requiera contraseña
RUN mkdir -p /app/.jupyter && \
    echo "c.NotebookApp.token = ''" > /app/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.password = ''" >> /app/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /app/.jupyter/jupyter_notebook_config.py

# Expone el puerto que usará JupyterLab
EXPOSE 8888

# Define el comando de inicio
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=$PORT", "--no-browser", "--config=/app/.jupyter/jupyter_notebook_config.py"]
