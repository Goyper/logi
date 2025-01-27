# Usa una imagen base oficial de Python
FROM python:3.9-slim

# Establece el directorio de trabajo
WORKDIR /app

# Instala las dependencias del sistema necesarias
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Instala JupyterLab
RUN pip install --no-cache-dir jupyterlab

# Configura Jupyter con una contraseña por defecto (puedes cambiarlo)
RUN mkdir -p /root/.jupyter && \
    echo "c.NotebookApp.password = '$(python3 -c \"from notebook.auth import passwd; print(passwd('tu_contraseña_aquí'))\")'" \
    > /root/.jupyter/jupyter_notebook_config.py

# Exponemos el puerto que usará JupyterLab
EXPOSE 8888

# Define el comando de inicio
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=$PORT", "--no-browser", "--allow-root"]
