# 1. Leer todas las líneas del archivo original
lineas <- readLines("resultados/predicciones_totales.txt")

# 2. Filtrar y quedarse solo con las líneas que NO empiezan con '#'
# (Y que tampoco estén vacías)
lineas_limpias <- lineas[!grepl("^#", lineas) & lineas != ""]

# 3. Convertir las líneas filtradas en una tabla de datos (Data Frame)
# Usamos 'text = lineas_limpias' para que R lea directamente el texto en memoria
datos <- read.table(text = lineas_limpias, sep = "", header = FALSE, stringsAsFactors = FALSE)

# 4. Asignar nombres limpios a las columnas principales (opcional pero recomendado)
colnames(datos)[1:5] <- c("target_name", "accession_target", "query_name", "accession_query", "E_value")

# 5. Guardar el resultado en formato .tsv (separado por tabuladores)
write.table(datos, 
            file = "resultados/predicciones_limpias.tsv", 
            sep = "\t", 
            row.names = FALSE, 
            col.names = TRUE, 
            quote = FALSE)

cat("¡Archivo transformado con éxito a .tsv!\n")