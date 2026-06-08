# 1. Definir rutas
archivo_txt <- "resultados/predicciones_totales.txt"
archivo_tsv <- "resultados/predicciones_totales.tsv"

# 2. Leer las líneas del archivo original
lineas <- readLines(archivo_txt)

# 3. Filtrar y limpiar el archivo
# Nos quedamos solo con la línea de encabezado (la que tiene los nombres de las columnas)
# y las líneas de datos (que no empiezan con #)
linea_header <- lineas[grep("# target name", lineas)]
lineas_datos <- lineas[!grepl("^#", lineas)]

# Limpiar el '#' inicial de la línea del header y recortar espacios
linea_header <- sub("^#\\s*", "", linea_header)

# 4. Unir el encabezado modificado con los datos
contenido_limpio <- c(linea_header, lineas_datos)

# 5. Convertir la estructura de espacios múltiples a Tabuladores (\t)
# HMMER usa múltiples espacios para alinear las columnas visualmente.
# Reemplazamos dos o más espacios consecutivos por un tabulador.
contenido_tsv <- gsub("\\s{2,}", "\t", contenido_limpio)

# 6. Guardar el nuevo archivo .tsv
writeLines(contenido_tsv, archivo_tsv)

message("¡Archivo convertido con éxito a .tsv en: ", archivo_tsv)