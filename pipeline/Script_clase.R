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
  tabla_datos <- read.delim(ruta_archivo, sep = "\t", stringsAsFactors = FALSE)
  
  # Instanciar el objeto de la clase S4
  new(
    "PrediccionesProteinas",
    datos = tabla_datos,
    fecha_analisis = Sys.time(),
    total_hits = nrow(tabla_datos)
  )
}