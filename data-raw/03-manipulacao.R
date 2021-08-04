# Preparaçao para visualização ------------------------------------------------------------------------------------------------------------------

# Visualização com a base principal

# Gráfico 1
# feminicidio::base_final_tidy |> # para visualização
#  dplyr::glimpse()

feminicidio::base_final_tidy |>
  dplyr::select(num_bo, ano_bo, dhocorrencia) |>
  dplyr::mutate(diasemana = lubridate::wday(dhocorrencia)) |>
  dplyr::filter(diasemana != "NA") |>
  dplyr::mutate(diasemana = as.character(diasemana)) |>
  dplyr::mutate(
    diasemana = dplyr::case_when(
      diasemana =  stringr::str_detect(diasemana, stringr::regex("1")) ~ "Segunda",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("2")) ~ "Terça",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("3")) ~ "Quarta",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("4")) ~ "Quinta",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("5")) ~ "Sexta",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("6")) ~ "Sábado",
      diasemana =  stringr::str_detect(diasemana, stringr::regex("7")) ~ "Domingo",
      TRUE ~ diasemana
    )
  ) |>
  dplyr::group_by(diasemana) |>
  dplyr::count(ano_bo) |>
  ggplot2::ggplot(ggplot2::aes(x = n, y = diasemana, fill = n)) +
  ggplot2::geom_tile(colour = "white") +
  ggplot2::facet_wrap( ~ ano_bo, ncol = 1) +
  ggplot2::labs(x = "Incidentes", y = "Dia da semana ", fill = "Nº de Incidentes") +
  ggplot2::scale_fill_gradient2(low = "#fad8fa",
                                mid = "#f5b6f5",
                                high = "#300630") +
  ggplot2::theme_light(10)

## Gráfico 2

base_com_datas |>
  dplyr::select(ano_bo, peridoocorrencia) |>
  dplyr::group_by(ano_bo) |>
  dplyr::mutate(peridoocorrencia = stringr::str_to_title(peridoocorrencia)) |>
  dplyr::mutate(
    peridoocorrencia = dplyr::case_when(
      stringr::str_detect(peridoocorrencia, stringr::regex("Pela Manha")) ~ "Pela Manhã",
      stringr::str_detect(peridoocorrencia, stringr::regex("A Noite")) ~ "Noite",
      stringr::str_detect(peridoocorrencia, stringr::regex("A Tarde")) ~ "Tarde",
      TRUE ~ peridoocorrencia
    )
  ) |>
  dplyr::count(peridoocorrencia) |>
  dplyr::mutate(prop = n / sum(n)) |>
  dplyr::mutate(prop = formattable::percent(prop)) |>
  dplyr::mutate(ano_bo = as.character(ano_bo)) |>
  dplyr::mutate(peridoocorrencia = forcats::fct_reorder(peridoocorrencia, n)) |>
  ggplot2::ggplot(ggplot2::aes(x = prop, y = peridoocorrencia, fill = ano_bo)) +
  ggplot2::geom_col(position = "dodge") +
  ggplot2::scale_x_continuous(labels = scales::percent) +
  ggplot2::scale_fill_manual(values = c("#D8BFD8", "#EE82EE")) +
  ggplot2::labs(x = "Proporção", y = "Periodo da ocorrência", fill = "Ano") +
  ggplot2::theme_minimal(10)

## Visualização com a base de partes

# feminicidio::partes_tidy |>
#  dplyr::glimpse() #para visualização

# Gráfico 3

feminicidio::partes_tidy |>
  dplyr::select(ano_bo, bo_autoria, relacionamento) |>
  dplyr::filter(relacionamento != "NA") |>
  dplyr::filter(relacionamento != "parentesco,envolvimento amoroso") |>
  dplyr::filter(relacionamento != "parentesco,casamento") |>
  dplyr::mutate(relacionamento  = stringr::str_to_title(relacionamento)) |>
  dplyr::mutate(
    relacionamento = dplyr::case_when(
      stringr::str_detect(relacionamento, stringr::regex("Uniao Estavel")) ~ "União Estável",
      stringr::str_detect(relacionamento, stringr::regex("Nenhuma Relacao")) ~ "Nenhuma Relação",
      TRUE ~ relacionamento
    )
  ) |>
  dplyr::group_by(ano_bo, relacionamento) |>
  dplyr::count(relacionamento) |>
  ggplot2::ggplot(ggplot2::aes(x = n, y = relacionamento, fill =  relacionamento)) +
  ggplot2::geom_boxplot(position = "dodge", alpha = 0.5) +
  ggplot2::scale_fill_manual(values = c("#8282ee", "#dc1edc", "#8eacff", "#b882ee", "#e49aa5")) +
  ggplot2::labs(x = "Incidentes", y = "Relacionamento") +
  ggplot2::theme_minimal(10) +
  ggplot2::theme(legend.position = "none")
