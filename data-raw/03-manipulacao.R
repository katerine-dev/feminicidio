# Preparaçao para visualização ------------------------------------------------------------------------------------------------------------------

base <- feminicidio::base_final_tidy

base |>
  dplyr::glimpse()

base |>
  dplyr::select(ano_bo, dhocorrencia) |>
  dplyr::mutate(mescrime = lubridate::as_date(dhocorrencia)) |>
  dplyr::mutate(diacrime = lubridate::as_date(dhocorrencia)) |>
  dplyr::mutate(diasemana = lubridate::week(dhocorrencia)) |>
  #dplyr::filter(diasemana != "NA") |>
  dplyr::group_by(diacrime, mescrime, ano_bo) |>
 # dplyr::count(diasemana) |>
  #ggplot2::ggplot() +
  ggplot2::ggplot(ggplot2::aes(x = mescrime, y = diasemana, fill = mescrime)) +
  ggplot2::geom_tile(colour = "red") +
  ggplot2::scale_x_date(date_labels = "%b", date_breaks = "1 month") +
  #ggplot2::scale_y_date(date_labels = "%a", date_breaks = "1 week") +
  ggplot2::facet_wrap( ~ ano_bo, ncol = 1)


## periodo da ocorrencia

## pensar em dois pontos para base de partes
