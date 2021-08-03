# Faxina de dados -------------------------------------------------------------------------------------------------------------------------------

# bases_empilhadas |>
# dplyr::glimpse() # visualizar a base

bases_empilhadas |>
  dplyr::count(ANO_BO,
               NUM_BO,
               DELEGACIA_CIRCUNSCRICAO,
               DELEGACIA_NOME) #identificando os duplicados

# Arrumando os nomes das colunas:
nomes_arrumado_base <- bases_empilhadas |>
  janitor::clean_names() |>
  janitor::remove_empty(c("rows", "cols"))  # retirando as colunas e linhas vazias para melhorar a visualizacao

# nomes_arrumado_base |>
# dplyr::glimpse()  # para visualização


# Ramificando a base  ---------------------------------------------------------------------------------------------------------------------------

# 1) Arrumando a duplicidade e unindo colunas relacionadas as delegacias e infrações (BASE: infracoes_arrumado e infracoes_arrumado2)

# Arrumando duplicidade relacionado a natureza jurídica

infracoes_arrumado <- nomes_arrumado_base |>
  dplyr::select(
    num_bo,
    ano_bo,
    numero_boletim,
    # colunas base para o join
    delegacia_circunscricao,
    delegacia_nome,
    naturezavinculada
  ) |>
  dplyr::distinct() |> # tira os duplicados
  dplyr::rename(natureza_vinculada = naturezavinculada) |>
  tidyr::unite(delegacia, delegacia_circunscricao, delegacia_nome, sep = ", ") |> # une delegacias
  dplyr::mutate(dplyr::across(c(delegacia,
                                natureza_vinculada),
                              limpa_strings)) |>
  dplyr::mutate(natureza_vinculada = tidyr::replace_na(natureza_vinculada, "não informado")) |>
  dplyr::group_by(num_bo,
                  ano_bo,
                  numero_boletim,
                  delegacia) |>
  dplyr::summarise(
    natureza_vinculada = stringr::str_c(natureza_vinculada, collapse = "|"),
    .groups = "drop"
  )


# Tirar os duplicados relacionado a tipificação

infracoes_arrumado2 <- nomes_arrumado_base |>
  dplyr::select(num_bo,
                ano_bo,
                numero_boletim,
                # colunas base para o join
                rubrica,
                desdobramento,
                especie) |>
  dplyr::distinct() |> # tira os duplicados
  tidyr::unite(infracoes, rubrica, desdobramento, especie, sep = ", ") |> # une infrações
  dplyr::mutate(infracoes = stringr::str_remove(infracoes, ", NA")) |>  #tira o ; NA da coluna infracões
  dplyr::mutate(infracoes = limpa_strings(infracoes)) |>
  dplyr::group_by(num_bo, ano_bo, numero_boletim) |>
  dplyr::summarise(infracoes = stringr::str_c(infracoes, collapse = "\n"),
                   .groups = "drop")


# infracoes_arrumado2 |>
#  dplyr::glimpse() # verificando classe das colunas


# 2) Arrumando a duplicidade e unindo colunas relacionadas a data e horarios (BASE: datas_arrumado)
datas_arrumado <- nomes_arrumado_base |>
  dplyr::select(
    num_bo,
    ano_bo,
    numero_boletim,
    # colunas base para o join
    bo_iniciado,
    bo_emitido,
    dataocorrencia,
    horaocorrencia,
    # dataelaboracao, # foi identificado que era igual a coluna bo_iniciado
    peridoocorrencia,
    datacomunicacao
    # resolvi não utilizar o numero boletim principal, informação irrelevante e repetida
  ) |>
  dplyr::distinct() |>
  dplyr::mutate(dplyr::across(c(bo_iniciado,
                                bo_emitido), lubridate::dmy_hms)) |>
  tidyr::unite(dhocorrencia, dataocorrencia, horaocorrencia, sep = " ") |>
  dplyr::mutate(dhocorrencia = stringr::str_remove(dhocorrencia, " NA")) |>
  dplyr::mutate(dhocorrencia = lubridate::dmy_hm(dhocorrencia)) |>
  dplyr::mutate(datacomunicacao =  lubridate::dmy(datacomunicacao)) |>
  dplyr::mutate(peridoocorrencia = limpa_strings(peridoocorrencia))

# datas_arrumado |>
#  dplyr::glimpse() # verificando classe das colunas



# 3) Arrumando a duplicidade e unindo colunas relacionadas as endereços (BASE: endereco_arrumado)

loc <-
  readr::locale(decimal_mark = ",", grouping_mark = ".") # para arrumar latitude e longitude

endereco_arrumado <- nomes_arrumado_base |>
  dplyr::select(
    num_bo,
    ano_bo,
    numero_boletim,
    # colunas base para o join
    logradouro,
    numero,
    bairro,
    cidade,
    uf,
    latitude,
    longitude,
    descricaolocal
  ) |>
  dplyr::distinct() |>
  dplyr::mutate(numero = as.numeric(numero)) |>
  tidyr::unite(endereco, logradouro, bairro, cidade, sep = ", ") |>
  dplyr::mutate(endereco = stringr::str_remove(endereco, "NA, ")) |>
  dplyr::mutate(dplyr::across(c(endereco,
                                descricaolocal), limpa_strings)) |>
  dplyr::mutate(dplyr::across(c(longitude, latitude), readr::parse_number, locale = loc))

# endereco_arrumado |>
#  dplyr::glimpse() # para visualização

# 4) Arrumando a duplicidade e unindo colunas relacionadas as partes (BASE: partes_arrumado, ela ficará separada pela amplitude das informações)
partes_tidy <- nomes_arrumado_base |>
  dplyr::select(
    num_bo,
    ano_bo,
    # colunas base para o join
    bo_autoria,
    flagrante,
    exame,
    solucao,
    status,
    tipopessoa,
    vitimafatal,
    naturalidade,
    nacionalidade,
    sexo,
    datanascimento,
    idade,
    estadocivil,
    profissao,
    grauinstrucao,
    corcutis,
    tipovinculo,
    relacionamento
  ) |>
  dplyr::distinct() |>
  dplyr::mutate(dplyr::across(
    c(
      bo_autoria,
      flagrante,
      exame,
      solucao,
      status,
      tipopessoa,
      vitimafatal,
      naturalidade,
      nacionalidade,
      sexo,
      estadocivil,
      profissao,
      grauinstrucao,
      corcutis,
      tipovinculo,
      relacionamento
    ),
    limpa_strings
  )) |>
  dplyr::mutate(idade = as.numeric(idade)) |>
  dplyr::mutate(datanascimento = as.Date(datanascimento)) |>
  dplyr::mutate(exame = tidyr::replace_na(exame, "não informado"))



# partes_tidy |>
#  dplyr::glimpse() # para visualização



# Join
base_join <- infracoes_arrumado |>
  dplyr::left_join(infracoes_arrumado2) |>
  dplyr::left_join(datas_arrumado) |>
  dplyr::left_join(endereco_arrumado)


base_final_tidy <- base_join |>
  dplyr::filter(infracoes != "na, na") # Arrumando a ultima linha


# base_final_tidy |>
# dplyr::select(num_bo, ano_bo) |>
#    janitor::get_dupes()

# base_final_tidy |>
#  dplyr::glimpse()

usethis::use_data(partes_tidy, overwrite = TRUE)
usethis::use_data(base_final_tidy, overwrite = TRUE)
