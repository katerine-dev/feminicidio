#' Função de limpar os nomes
#'
#' Essa função facilita a limpeza de strings
#'
#' @param str string que esta suja.
#'
#' @export
limpa_strings <- function(str) {
  str |>
    abjutils::rm_accent() |>
    stringr::str_to_lower() |>
    stringr::str_squish()
}
