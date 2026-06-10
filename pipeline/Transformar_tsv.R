# Archivo de entrada y salida fijos
archivo_entrada <- "resultados/predicciones_totales.txt"
archivo_salida <- "resultados/predicciones_totales.tsv"

# Leer todas las líneas
lineas <- readLines(archivo_entrada)

# Eliminar comentarios (líneas que comienzan con #)
lineas_datos <- lineas[!grepl("^#", lineas)]

# Eliminar líneas vacías
lineas_datos <- lineas_datos[nchar(trimws(lineas_datos)) > 0]

# Convertir a tabla
tabla <- read.table(
  text = lineas_datos,
  header = FALSE,
  fill = TRUE,
  stringsAsFactors = FALSE
)

# Nombres de columnas
colnames(tabla) <- c(
  "target_name",
  "target_accession",
  "query_name",
  "query_accession",
  "E_value",
  "score",
  "bias",
  "E_value_domain",
  "score_domain",
  "bias_domain",
  "exp",
  "reg",
  "clu",
  "ov",
  "env",
  "dom",
  "rep",
  "inc",
  "descripcion"
)

# Guardar como TSV
write.table(
  tabla,
  archivo_salida,
  sep = "\t",
  row.names = FALSE,
  quote = FALSE
)

cat("Archivo TSV generado correctamente en:", archivo_salida, "\n")