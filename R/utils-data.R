#' base_final_tidy
#'
#' Um conjunto de dados que contem informacoes os genericas sobre os casos.
#'
#' @format um data frame com 193 linhas e 17 variaveis:
#'
#' \describe{
#'   \item{num_bo }{numero do bo relacionado a infracao.}
#'   \item{ano_bo}{ano da infracao.}
#'   \item{numero_boletim}{numero do boletim.}
#'   \item{delegacia}{local que foi registrada a infracao.}
#'   \item{natureza_vinculada}{natureza juridica da infracao.}
#'   \item{infracoes}{tipificacao.}
#'   \item{bo_iniciado}{data e hora que o bo foi iniciado.}
#'   \item{bo_emitido}{data e hora que o bo foi emitido.}
#'   \item{dhocorrencia}{data e hora da ocorrencia.}
#'   \item{datacomunicacao}{data da comunicacao do crime.}
#'   \item{endereco}{endereco da infracao.}
#'   \item{numero}{numero do endereco da infracao.}
#'   \item{uf}{uf do endereco da infracao.}
#'   \item{latitude}{latitude do endereco da infracao.}
#'   \item{longitude}{longitude do endereco da infracao.}
#'   \item{descricaolocal}{descricao do local da infracao.}
#' }
#'
#' @source base_final_tidy
"base_final_tidy"

#' partes_tidy
#'
#' Um conjunto de dados que contem informações das partes envonvidas nos crimes.
#'
#' @format um data frame com 267 linhas e 20 variaveis:
#'
#' \describe{
#'   \item{num_bo }{numero do bo relacionado a infracao.}
#'   \item{ano_bo}{ano da infracao.}
#'   \item{bo_autoria}{identificacao do autor do crime.}
#'   \item{flagrante}{informacao de flagrante.}
#'   \item{exame}{local do exame.}
#'   \item{solucao}{solucao do bo.}
#'   \item{status}{informacao de consumado ou tentado.}
#'   \item{tipopessoa}{informacacao de vitima ou autor.}
#'   \item{vitimafatal}{informacao de vitima fatal ou nao.}
#'   \item{naturalidade}{naturalidade da vitima.}
#'   \item{nacionalidade}{nacionalidade da vitima.}
#'   \item{sexo}{sexo da vitima.}
#'   \item{datanascimento}{data nascimento da vitima.}
#'   \item{idade}{idade da vitima.}
#'   \item{estadocivil}{estado civil da vitima.}
#'   \item{profissao}{profissao da vitima.}
#'   \item{grauinstrucao}{grau de instrucao da vitima.}
#'   \item{corcutis}{etinia da vitima.}
#'   \item{tipovinculo}{tipo vinculo do crime.}
#'   \item{relacionamento}{relacionamento com o autor do crime.}
#' }
#'
#' @source partes_tidy
"partes_tidy"
