# Importação --------------------------------------------------------------

# caminho para as bases principais
path_bases <-  "~/Documents/feminicidio/data-raw/base_feminicidio/"

# fs::dir_ls() já pega o caminho completo, ai nao precisa do paste() depois, eu tentei utilizar
# um for para importar todas as 12 bases de uma vez, mas tive problemas com a escolha
# da função para empilhar.

importar_bases <- fs::dir_ls(path = path_bases, pattern = ".xls")

# empilhando as bases pela função criada.
bases_empilhadas <- purrr::map_dfr(importar_bases, ler_uma_base)


usethis::use_data(bases_empilhadas, overwrite = TRUE) # base suja
