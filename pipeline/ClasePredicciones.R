# Definición de la clase S4 para almacenar las predicciones de familias de proteínas
setClass(
  "PrediccionesProteinas",
  slots = list(
    datos        = "data.frame",  # Almacenará la tabla completa
    fecha_analisis = "POSIXct",    # Guardará el momento de la creación del objeto
    total_hits   = "numeric"      # Número total de filas/predicciones
  )
)

# Constructor de la clase
PrediccionesProteinas <- function(ruta_archivo) {
  if (!file.exists(ruta_archivo)) {
    stop(paste("El archivo no existe en la ruta proporcionada:", ruta_archivo))
  }
  
  # Leer el archivo .tsv de manera segura (maneja tabulaciones)
tabla_datos <- read.delim(ruta_archivo, sep = "\t", stringsAsFactors = FALSE, fill = TRUE, quote = "")
  
  # Instanciar el objeto de la clase S4
  new(
    "PrediccionesProteinas",
    datos = tabla_datos,
    fecha_analisis = Sys.time(),
    total_hits = nrow(tabla_datos)
  )
}

# Método para que al imprimir el objeto nos dé un resumen amigable
setMethod("show", "PrediccionesProteinas", function(object) {
  cat("=== Objeto de Predicciones de Familias de Proteínas ===\n")
  cat("Fecha de análisis:", format(object@fecha_analisis, "%Y-%m-%d %H:%M:%S"), "\n")
  cat("Total de aciertos (hits) detectados:", object@total_hits, "\n")
  cat("\nPrimeros registros del set de datos:\n")
  print(head(object@datos[, c("target_name", "query_name", "E_value", "score")], 5))
})

