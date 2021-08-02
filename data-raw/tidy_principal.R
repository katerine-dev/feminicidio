# Pacotes -----------------------------------------------------------------
library(magrittr)
library(tidyverse)
library(dplyr)

# Faxina de dados ---------------------------------------------------------
bases_empilhadas %>%
  dplyr::glimpse() # visualizar a base

# função que limpa nome
limpa_nomes <- function(str) {
  str %>%
    abjutils::rm_accent() %>%
    stringr::str_to_lower() %>%
    stringr::str_squish()
} # achado!!

bases_empilhadas %>%
  dplyr::count(ANO_BO,
               NUM_BO,
               DELEGACIA_CIRCUNSCRICAO,
               DELEGACIA_NOME) #identificando os duplicados

# Arrumando os nomes das colunas:
base_nomes_arrumado <- bases_empilhadas %>%
  janitor::clean_names() %>%
   # dplyr::across(as.numeric(numero_boletim)) %>%
  janitor::remove_empty(., "cols") # retirando as colunas vazias para melhorar a visualizacao

# 1) Arrumando a duplicidade e unindo colunas relacionadas as delegacias e infrações
base_sem_duplicadas_infracoes <- base_nomes_arrumado %>%
  dplyr::select(
    num_bo,
    ano_bo,
    numero_boletim,
    # colunas base para o join
    delegacia_circunscricao,
    delegacia_nome,
    especie,
    rubrica,
    desdobramento,
    naturezavinculada
  )  %>%
  dplyr::distinct() %>%
  tidyr::unite(delegacia, delegacia_circunscricao, delegacia_nome, sep = ", ") %>%
  tidyr::unite(infracoes, rubrica, desdobramento, sep = ", ") %>%
  dplyr::mutate(
    infracoes = stringr::str_replace(infracoes, ", NA", ""),
    #tira o ; NA da coluna infracões
    delegacia = limpa_nomes(delegacia),
    especie = limpa_nomes(especie),
    infracoes = limpa_nomes(infracoes),
    naturezavinculada = limpa_nomes(naturezavinculada)
  ) %>%
  dplyr::rename(natureza_vinculada = naturezavinculada)


base_sem_duplicadas_infracoes %>%
  dplyr::glimpse() # verificando classe das colunas


# 2) Arrumando a duplicidade e unindo colunas relacionadas a data e horarios
base_sem_duplicadas_datas <- base_nomes_arrumado %>%
  dplyr::select(
    num_bo,
    ano_bo,
    numero_boletim,
    # colunas base para o join
    bo_iniciado,
    bo_emitido,
    dataocorrencia,
    horaocorrencia,
    #dataelaboracao, # foi identificado que era igual a coluna bo_iniciado
    peridoocorrencia,
    datacomunicacao,
    numero_boletim_principal
  ) %>%
  dplyr::distinct() %>%
  dplyr::mutate(
    bo_iniciado_data = str_split(bo_iniciado, " ")[[1]][1],
    bo_iniciado_hora = str_split(bo_iniciado, " ")[[1]][2],
   bo_iniciado = NULL,
    bo_emitido_data = str_split(bo_emitido, " ")[[1]][1],
    bo_emitido_hora = str_split(bo_emitido, " ")[[1]][2],
    bo_emitido = NULL,
  ) %>%
  dplyr::mutate(across(c(bo_iniciado_data,
                         bo_emitido_data,
                         dataocorrencia,
                         datacomunicacao), as.Date)) %>%
  dplyr::mutate(across(c(bo_iniciado_hora,
                         bo_emitido_hora,
                         horaocorrencia), lubridate::hms))

# VERIFICAR SE RELMENTE DEVO SEPARAR AS DATAS DAS HORAS.

base_sem_duplicadas_datas %>%
  dplyr::glimpse() # verificando classe das colunas

# 3) Arrumando a duplicidade e unindo colunas relacionadas as partes

# 4) Arrumando a duplicidade e unindo colunas relacionadas as endereços

# Join

#usethis::use_data(DATASET, overwrite = TRUE)
