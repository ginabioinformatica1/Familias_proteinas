# Pipeline de Búsqueda con HMMER

Este repositorio contiene un pipeline automatizado para descargar secuencias de proteínas desde UniProt

# PROCESO
# 1. Descarga de familias Pfam
# Ejecutar la siguiente linea en la terminal de Ubuntu:
wget -P datos/ https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

# 2. Descomprimir
gunzip datos/Pfam-A.hmm.gz

# 3. Descarga de archivos fasta en terminar R
source("pipeline/Descarga_formatos_fasta.R")

# 4. Indexar el archivo HMM (Terminal de Ubintu)
hmmfetch --index datos/Pfam-A.hmm

# 5. Correción nombres familias (Temrinal de Ubuntu)
Rscript pipeline/Filtrar_familias.R

# 6. Extraer familias de interes (Temrinal de Ubuntu)
hmmfetch -f datos/Pfam-A.hmm datos/familias_pfam_correctas.txt > datos/familias_interes.hmm

# 7. Prueba de familias HMM completas (Temrinal de Ubuntu)
grep -c "NAME" datos/familias_interes.hmm

# 8. Correr el pipeline de análisis HMMER y procesar todas las proteínas, ejecuta el siguiente comando en la terminal:
Rscript pipeline/Codigo_pipeline.R

# 9. Transformar el archivo de resultados (.txt) a un formato de tabla limpia (.tsv)
Rscript pipeline/Transformar_tsv.R
