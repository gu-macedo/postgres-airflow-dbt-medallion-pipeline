# Imagem oficial e gratuita do Apache Airflow
FROM apache/airflow:2.10.2-python3.12
 
# Muda para root só para instalar dependências de sistema, se precisar
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
 
# Volta para o usuário airflow (boa prática de segurança)
USER airflow
 
# Copia e instala dependências Python (dbt-core + dbt-postgres)
# Usa o constraints file oficial do Airflow para evitar conflitos de versão
# Sem --user: a imagem já roda dentro de um virtualenv, --user causaria conflito
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt \
    --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.10.2/constraints-3.11.txt"