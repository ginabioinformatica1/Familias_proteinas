transformar_a_tsv <- function(archivo_entrada, archivo_salida) {

  # Leer todas las líneas
  lineas <- readLines(archivo_entrada)

  # Eliminar comentarios (#)
  lineas_datos <- lineas[!grepl("^#", lineas)]

  # Eliminar líneas vacías
  lineas_datos <- lineas_datos[nchar(trimws(lineas_datos)) > 0]

  # Separar columnas por uno o más espacios
  tabla <- read.table(
    text = lineas_datos,
    header = FALSE,
    fill = TRUE,
    stringsAsFactors = FALSE
  )

  # Asignar nombres de columnas de tblout
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

  cat("Archivo TSV generado:", archivo_salida, "\n")
}
