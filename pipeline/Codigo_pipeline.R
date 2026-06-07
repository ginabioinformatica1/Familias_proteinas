# --- Configuración de rutas para el análisis ---
HMM_INTERES    <- "datos/familias_interes.hmm"
CARPETA_DATOS  <- "datos"
OUTPUT_BUSQUEDA <- "resultados/predicciones_totales.txt"

message("Iniciando el análisis HMMER desde R...")

# 1. Listar todos los archivos de proteínas (.fasta) que descargamos en la carpeta datos
archivos_fasta <- list.files(path = CARPETA_DATOS, pattern = "\\.fasta$", full.names = TRUE)

# 2. Crear un solo archivo temporal que junte todas las proteínas
fasta_unido <- tempfile(fileext = ".fasta")
file.create(fasta_unido)
for (archivo in archivos_fasta) {
  file.append(fasta_unido, archivo)
}

# 3. Construir el comando exacto de hmmsearch
comando_hmmsearch <- paste0(
  "hmmsearch --tblout ", OUTPUT_BUSQUEDA, " ",
  HMM_INTERES, " ",
  fasta_unido
)

# 4. Ejecutar el comando en el sistema a través de R
message("Corriendo hmmsearch para todas las proteínas juntas...")
resultado_status <- system(comando_hmmsearch)

# 5. Verificar si corrió con éxito
if (resultado_status == 0) {
  message(paste("¡Análisis completado con éxito! Resultados guardados en:", OUTPUT_BUSQUEDA))
} else {
  stop("Hubo un error al ejecutar hmmsearch en el sistema.")
}