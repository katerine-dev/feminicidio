#' Função de leitura das bases
#'
#' Essa função facilita a leitura das bases principais
#'
#' @param path caminho para a pasta que esta as bases.
#'
#' @return
#'
#' @export
ler_uma_base <- function(path) {
  read.delim(
    path,
    fileEncoding = "UTF-16LE",
    sep = "\t",
    header = TRUE,
    stringsAsFactors = FALSE,
    na.strings = c("NA", "")
  )
}
