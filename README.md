# Pipeline de Búsqueda con HMMER

Este repositorio contiene un pipeline automatizado para descargar secuencias de proteínas desde UniProt

# PROCESO
# 1. Creación de los archivos Identificadores_uniprot.txt y familias_pfam.txt. Ejecuta el siguiente comando en la terminal para crear los archivos de texto vacíos dentro de la carpeta 'datos':
touch datos/Identificadores_uniprot.txt datos/familias_pfam.txt


# 2. Descarga de familias Pfam
# Ejecutar la siguiente linea en la terminal de Ubuntu:
wget -P datos/ https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

# 3. Descomprimir
gunzip datos/Pfam-A.hmm.gz

# 4. Descarga de archivos fasta en terminar R
source("pipeline/Descarga_formatos_fasta.R")

# 5. Indexar el archivo HMM (Terminal de Ubuntu)
hmmfetch --index datos/Pfam-A.hmm

# 6. Correción nombres familias (Temrinal de Ubuntu)
Rscript pipeline/Filtrar_familias.R

# 7. Extraer familias de interes (Temrinal de Ubuntu)
hmmfetch -f datos/Pfam-A.hmm datos/familias_pfam_correctas.txt > datos/familias_interes.hmm

# 8. Prueba de familias HMM completas (Temrinal de Ubuntu)
grep -c "NAME" datos/familias_interes.hmm

# 9. Correr el pipeline de análisis HMMER y procesar todas las proteínas, ejecuta el siguiente comando en la terminal:
Rscript pipeline/Codigo_pipeline.R

# 10. Transformar el archivo de resultados (.txt) a un formato de tabla limpia (.tsv)
Rscript pipeline/Transformar_tsv.R
