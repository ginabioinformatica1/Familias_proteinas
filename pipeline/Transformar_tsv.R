# 1. Definir rutas
archivo_txt <- "resultados/predicciones_totales.txt"
archivo_tsv <- "resultados/predicciones_totales.tsv"

# 2. Leer las líneas del archivo original
lineas <- readLines(archivo_txt)

# 3. Filtrar y limpiar el archivo
# Nos quedamos con la línea exacta de HMMER que contiene los nombres reales
linea_header <- lineas[grep("^#\\s+target name", lineas)]
lineas_datos <- lineas[!grepl("^#", lineas)]

# 4. Limpiar el '#' inicial del header
linea_header <- sub("^#\\s*", "", linea_header)

# Reemplazar los encabezados conflictivos con nombres unidos por guiones bajos (_)
linea_header <- gsub("target name", "target_name", linea_header)
linea_header <- gsub("query name", "query_name", linea_header)
linea_header <- gsub("E-value", "E_value", linea_header)
linea_header <- gsub("accession dom", "accession_dom", linea_header)

# 5. Convertir la estructura de espacios múltiples a Tabuladores (\t)
linea_header_tsv <- gsub("\\s+", "\t", linea_header)

# Hacemos lo mismo con los datos (limpiando espacios al inicio/final por seguridad si los hay)
lineas_datos_tsv <- gsub("\\s+", "\t", trimws(lineas_datos))

# Unimos todo
contenido_tsv <- c(linea_header_tsv, lineas_datos_tsv)

# 6. Guardar el nuevo archivo .tsv
writeLines(contenido_tsv, archivo_tsv)

message("¡Archivo convertido con éxito a .tsv en: ", archivo_tsv)