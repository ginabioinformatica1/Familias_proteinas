# Pipeline de Búsqueda con HMMER

Este repositorio contiene un pipeline automatizado para descargar secuencias de proteínas desde UniProt

# PROCESO
# 1. Descarga de familias Pfam
# Ejecutar la siguiente linea en la terminal de Ubuntu:
wget -P datos/ https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz

# 2. Descomprimir
gunzip datos/Pfam-A.hmm.gz
