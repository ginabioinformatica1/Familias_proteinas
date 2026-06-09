# El argumento comment.char = "#" le dice a R que ignore esas líneas
# El argumento sep = "" maneja automáticamente múltiples espacios en blanco
datos <- read.table("resultados/predicciones_totales.txt", comment.char = "#", sep = "", header = FALSE)

# Guardarlo desde R como un verdadero archivo .tsv:
write.table(datos, "resultados/predicciones_limpias.tsv", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)