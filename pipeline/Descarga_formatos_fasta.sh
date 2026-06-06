#!/bin/bash

# Rutas de los archivos
INPUT_FILE="datos/Identificadores_uniprot.txt"
OUTPUT_DIR="datos"

# Verificar si el archivo de identificadores existe
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: No se encontró el archivo $INPUT_FILE"
    exit 1
fi

echo "Iniciando la descarga de formatos FASTA..."

# Leer el archivo línea por línea
while IFS= read -r id || [ -n "$id" ]; do
    # Limpiar espacios en blanco o saltos de línea extraños
    id=$(echo "$id" | tr -d '\r' | xargs)
    
    # Saltar líneas vacías si las hay
    if [ -z "$id" ]; then
        continue
    fi

    echo "Descargando: $id..."
    
    # Realizar la descarga con wget hacia la carpeta datos/
    wget -q -O "$OUTPUT_DIR/${id}.fasta" "https://rest.uniprot.org/uniprotkb/${id}.fasta"

done < "$INPUT_FILE"

echo "¡Descargas completadas con éxito en la carpeta /$OUTPUT_DIR!"