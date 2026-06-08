# Pipeline de Búsqueda con HMMER

Este repositorio contiene un pipeline automatizado para descargar secuencias de proteínas desde UniProt

# PROCESO

# 1. Creación de los archivos Identificadores_uniprot.txt y familias_pfam.txt. Ejecuta el siguiente comando en la terminal para crear los archivos de texto vacíos dentro de la carpeta 'datos':
touch datos/Identificadores_uniprot.txt datos/familias_pfam.txt

# 2. Descarga de familias Pfam
# Ejecutar la siguiente linea en la terminal de Ubuntu:
wget -P datos/ https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

# 3. Configuración de Gitignore
# Incluir las siguientes líneas en el archivo gitignore:
datos/Pfam-A.hmm.gz
datos/Pfam-A.hmm
datos/*.fasta

# 4. Descomprimir
gunzip datos/Pfam-A.hmm.gz

# 5. Descarga de archivos fasta en terminar R
source("pipeline/Descarga_formatos_fasta.R")

# 6. Indexar el archivo HMM (Terminal de Ubuntu)
hmmfetch --index datos/Pfam-A.hmm

# 7. Correción nombres familias (Temrinal de Ubuntu)
Rscript pipeline/Filtrar_familias.R

# 8. Extraer familias de interes (Temrinal de Ubuntu)
hmmfetch -f datos/Pfam-A.hmm datos/familias_pfam_correctas.txt > datos/familias_interes.hmm

# 9. Prueba de familias HMM completas (Temrinal de Ubuntu)
grep -c "NAME" datos/familias_interes.hmm

# 10. Correr el pipeline de análisis HMMER y procesar todas las proteínas, ejecuta el siguiente comando en la terminal:
Rscript pipeline/Codigo_pipeline.R

# 11. Transformar el archivo de resultados (.txt) a un formato de tabla limpia (.tsv)
Rscript pipeline/Transformar_tsv.R

# 12. Creación de clase S4


