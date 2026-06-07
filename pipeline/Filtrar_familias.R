# --- Configuración de rutas ---
HMM_FILE    <- "datos/Pfam-A.hmm"
INPUT_TXT   <- "datos/familias_pfam.txt"
OUTPUT_TXT  <- "datos/familias_pfam_correctas.txt"

message("Leyendo base de datos Pfam para extraer códigos oficiales...")

# 1. Leer las líneas de la base de datos que contienen NAME y ACC (ID de acceso)
lines <- readLines(HMM_FILE, warn = FALSE)
name_lines <- lines[grep("^NAME", lines)]
acc_lines  <- lines[grep("^ACC", lines)]

# Limpiar para quedarnos solo con el texto limpio
names_pfam <- gsub("^NAME\\s+", "", name_lines)
accs_pfam  <- gsub("^ACC\\s+", "", acc_lines)
accs_pfam  <- gsub("\\..*$", "", accs_pfam) # Quita la versión (ej: PF00069.25 -> PF00069)

# Crear una tabla de mapeo interna
map_pfam <- data.frame(Name = names_pfam, Acc = accs_pfam, stringsAsFactors = FALSE)

# 2. Leer tus familias deseadas
mis_familias <- readLines(INPUT_TXT, warn = FALSE)
mis_familias <- trimws(mis_familias)
mis_familias <- mis_familias[mis_familias != ""]

# Cambiar espacios por guiones bajos para que coincidan con el formato de Pfam
mis_familias_format <- gsub(" ", "_", mis_familias)

# 3. Buscar las coincidencias exactas o parciales
codigos_finales <- c()

for (i in seq_along(mis_familias_format)) {
  fam <- mis_familias_format[i]
  
  # Buscar coincidencia exacta (ignorando mayúsculas)
  match_idx <- which(tolower(map_pfam$Name) == tolower(fam))
  
  # Si no hay exacta, buscar si el nombre "Protein_kinase" mapea a "Pkinase"
  if (length(match_idx) == 0 && fam == "Protein_kinase") {
    match_idx <- which(map_pfam$Name == "Pkinase")
  }
  if (length(match_idx) == 0 && fam == "Pkinase_Tyr") {
    match_idx <- which(map_pfam$Name == "Pkinase_Tyr")
  }
  
  if (length(match_idx) > 0) {
    codigos_finales <- c(codigos_finales, map_pfam$Acc[match_idx])
  } else {
    warning(paste("No se encontró una familia equivalente para:", mis_familias[i]))
  }
}

# 4. Guardar la lista de códigos PF listos para hmmfetch
writeLines(codigos_finales, OUTPUT_TXT)
message(paste("¡Listo! Archivo creado con los códigos correctos en:", OUTPUT_TXT))