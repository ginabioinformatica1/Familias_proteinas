# --- Rutas de los archivos ---
INPUT_FILE  <- "datos/Identificadores_uniprot.txt"
OUTPUT_DIR  <- "datos"

# --- Verificar si el archivo de identificadores existe ---
if (!file.exists(INPUT_FILE)) {
  stop(paste("Error: No se encontró el archivo", INPUT_FILE))
}

# --- Crear la carpeta de salida si no existe ---
if (!dir.exists(OUTPUT_DIR)) {
  dir.create(OUTPUT_DIR, recursive = TRUE)
}

message("Iniciando la descarga de formatos FASTA...")

# --- Leer el archivo línea por línea ---
# readLines lee automáticamente todo el archivo y elimina los saltos de línea
ids <- readLines(INPUT_FILE, warn = FALSE)

# Limpiar espacios en blanco, tabulaciones y retornos de carro (\r)
ids <- trimws(ids)          # Elimina espacios al inicio y al final (como xargs)
ids <- gsub("\r", "", ids)  # Elimina remanentes de formato Windows (como tr -d '\r')

# Filtrar líneas vacías
ids <- ids[ids != ""]

# --- Bucle de descarga ---
for (id in ids) {
  message(paste("Descargando:", id, "..."))
  
  # Construir la URL y la ruta de destino
  url_descarga <- paste0("https://rest.uniprot.org/uniprotkb/", id, ".fasta")
  archivo_destino <- file.path(OUTPUT_DIR, paste0(id, ".fasta"))
  
  # Realizar la descarga (mode = "wb" asegura compatibilidad entre sistemas)
  tryCatch({
    download.file(url = url_descarga, destfile = archivo_destino, mode = "wb", quiet = TRUE)
  }, error = function(e) {
    warning(paste("No se pudo descargar el ID:", id, "- Error:", e$message))
  })
}

message(paste("Descargas completadas con éxito en la carpeta /", OUTPUT_DIR, "!"))

