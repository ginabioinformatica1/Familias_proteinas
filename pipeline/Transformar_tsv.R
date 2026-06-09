# 1. Definir Rutas
archivo_txt <- "resultados/predicciones_totales.txt"
archivo_tsv <- "resultados/predicciones_totales.tsv"

# 2. Leer la tabla original directamente usando el motor de espacios de R
datos_limpios <- read.table(archivo_txt, comment.char = "#", header = FALSE, stringsAsFactors = FALSE)

# 3. Definir manualmente los nombres de las columnas correctas en base a HMMER domtblout
colnames(datos_limpios) <- c(
  "target_name", "accession_target", "query_name", "accession_query",
  "E_value_full", "score_full", "bias_full",
  "E_value_dom", "score_dom", "bias_dom",
  "exp", "reg", "clu", "ov", "env", "dom", "rep", "inc",
  "description_of_target"
)

# 4. Guardar la tabla perfectamente formateada con pestañas reales (\t)
write.table(datos_limpios, file = archivo_tsv, sep = "\t", row.names = FALSE, quote = FALSE)

message("¡Archivo convertido con éxito y alineado a .tsv en: ", archivo_tsv)