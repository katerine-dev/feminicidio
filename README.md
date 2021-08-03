
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Projeto final do Curso de Faxina de dados: Feminícidio

Esse pacote foi produzido especialmente para o trabalho final do curso
de Faxina de dados do [curso-r](https://curso-r.com/).

## Para instalar

    devtools::install_github("katerine-dev/feminicidio")

## O projeto

As bases brutas foram baixadas diretamente do [Portal de Transparência
do Governo](http://www.ssp.sp.gov.br/transparenciassp/). Foi escolhido o
prazo de março de 2020 a junho de 2021, chegando num total de 16
arquivos em .xls. As informações sobre outros meses posteriores ainda
não estavam disponíveis no site.

Atualmente existem vários estudos que demonstram um aumento relevante de
nºs de casos de feminicídio e agressões contra mulheres na pandemia. O
objetivo da análise é observar os casos de feminicídio entre o início da
pandemia e os dias de hoje.

O isolamento social acentuou a violência doméstica, as mulheres que já
viviam algum tipo de vulnerabilidade foram forçadas a passarem mais
tempo com seus agressores, seja por aderirem ao trabalho remoto,
desemprego ou pela responsabilidade familiar de ficar com as crianças ou
idosos em casa.

Além da violência, as mulheres convivem com uma sobrecarga do trabalho
doméstico e familiares que se concentram desigualmente entre o homem e a
mulher que reforçam ainda mais o machismo.

Esse tipo de convívio direto e forçado expos diretamente as mulheres a
agressões psicológicas, físicas e sexuais constantes. Dificultando
também o acesso a essas mulheres de suporte adequado para o
enfrentamento à violência.

A análise será diante desse cenário.

## Descrição da Base Untidy

Como citado anteriormente as bases foram baixadas de um portal de dados
públicos, sendo observado diferentes problemas que poderiam prejudicar a
análise.

Lista de problemas:

-   Colunas não necessárias
-   Problemas com enconding
-   Nºs de latitude e longitude fora do padrão
-   Letras maiúsculas nas colunas
-   Colunas separadas que eram da mesma espécie
-   Problemas com as datas datas e horas
-   Informações diferentes numa mesma coluna
-   Duplicidade de informações
-   Linhas com lacunas ou “0”
-   Nomes de colunas sem padrão

A base continha no total 55 colunas e 491 linhas.

## O planejamento

Foi decidido dividir os dados entre 4 bases tidys relacionadas pelo o
assunto para a arrumação principal.

-   A primeira divisão: `infracoes_arrumado` e `infracoes_arrumado2`
    (Foi escolhido realizar a limpeza dividindo entre tipicidade e
    natureza jurídica)
-   A segunda divisão: `datas_arrumado`
-   A terceira divisão: `endereco_arrumado`
-   A quarta divisão: `partes_arrumado`

Finalizando a arrumação foi realizado um join entre elas produzindo a
`base_final_tidy`. Escolhi separar as informações relacionadas as partes
constituindo assim a base específica de `partes_tidy`.

``` r
feminicidio::base_final_tidy |>  
 dplyr::glimpse()
#> Rows: 193
#> Columns: 17
#> $ num_bo             <int> 28, 33, 51, 57, 59, 71, 75, 82, 85, 99, 137, 191, 1…
#> $ ano_bo             <int> 2020, 2020, 2021, 2021, 2020, 2021, 2021, 2020, 202…
#> $ numero_boletim     <chr> "28/2020", "33/2020", "51/2021", "57/2021", "59/202…
#> $ delegacia          <chr> "09º d.p. campinas, 01ª del. sec. campinas - shpp",…
#> $ natureza_vinculada <chr> "homicidio qualificado (art. 121, §2o.)", "violenci…
#> $ infracoes          <chr> "homicidio qualificado (art. 121, §2o.), vi-feminic…
#> $ bo_iniciado        <dttm> 2020-03-10 08:56:12, 2020-07-23 10:42:29, 2021-05-…
#> $ bo_emitido         <dttm> 2020-03-10 08:58:33, 2020-07-23 12:17:41, 2021-05-…
#> $ dhocorrencia       <dttm> 2020-03-07 20:30:00, NA, 2021-05-12 09:20:00, 2021…
#> $ peridoocorrencia   <chr> "a noite", "em hora incerta", "pela manha", "a tard…
#> $ datacomunicacao    <date> 2020-03-10, 2020-07-23, 2021-05-12, 2021-02-02, 20…
#> $ endereco           <chr> "dic, campinas", "centro, dobrada", "pq r barreto, …
#> $ numero             <dbl> 0, 0, 0, 0, 229, 0, 0, 0, 0, 0, 0, NA, 0, 0, 0, 0, …
#> $ uf                 <chr> "SP", "SP", "SP", "SP", "SP", "SP", "SP", "SP", "SP…
#> $ latitude           <dbl> NA, NA, NA, NA, -22.81353, NA, NA, NA, NA, NA, NA, …
#> $ longitude          <dbl> NA, NA, NA, NA, -50.07174, NA, NA, NA, NA, NA, NA, …
#> $ descricaolocal     <chr> "residencia", "residencia", "residencia", "residenc…
```

Nessa observamos as informações mais genéricas sobre os casos, contendo
infrações, endereços e delegacias.

``` r
feminicidio::partes_tidy  |>  
 dplyr::glimpse()
#> Rows: 267
#> Columns: 20
#> $ num_bo         <int> 4917, 2452, 2620, 9896, 4254, 3105, 3105, 4245, 4245, 4…
#> $ ano_bo         <int> 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2020, 2…
#> $ bo_autoria     <chr> "conhecida", "conhecida", "conhecida", "conhecida", "co…
#> $ flagrante      <chr> "sim", "nao", "sim", "nao", "sim", "sim", "sim", "nao",…
#> $ exame          <chr> "ic-iml", "ic-iml", "não informado", "ic-iml", "não inf…
#> $ solucao        <chr> "bo para flagrante", "bo para inquerito", "bo para flag…
#> $ status         <chr> "consumado", "consumado", "consumado", "consumado", "co…
#> $ tipopessoa     <chr> "vitima", "vitima", "vitima", "vitima", "vitima", NA, "…
#> $ vitimafatal    <chr> "sim", "sim", "sim", "sim", "sim", NA, "sim", "sim", "s…
#> $ naturalidade   <chr> "s.paulo/sp", "s.paulo -sp", "ibitinga -sp", "aracatuba…
#> $ nacionalidade  <chr> "brasileira", "brasileira", "brasileira", NA, "brasilei…
#> $ sexo           <chr> "feminino", "feminino", "masculino", "feminino", "femin…
#> $ datanascimento <date> 1994-03-27, 1985-03-14, 2002-12-11, 1946-08-26, 1977-1…
#> $ idade          <dbl> 26, 35, 17, 74, 42, NA, 30, 38, 18, 38, 18, 29, 22, 29,…
#> $ estadocivil    <chr> "solteiro", "solteiro", "solteiro", "viuvo", "divorciad…
#> $ profissao      <chr> "atendente", NA, "estudante", "aposentado(a)", "manicur…
#> $ grauinstrucao  <chr> "2 grau completo", NA, NA, NA, NA, NA, NA, NA, NA, NA, …
#> $ corcutis       <chr> "branca", "branca", "branca", "amarela", "branca", NA, …
#> $ tipovinculo    <chr> "vitima", "vitima", "vitima", "vitima", "vitima", NA, "…
#> $ relacionamento <chr> "envolvimento amoroso", "envolvimento amoroso", NA, NA,…
```

Essa base é mais específica, contendo informações das partes envonvidas
nos crimes. Em alguns casos haviam mais de uma vítima com desfechos
diferentes e qualidades diferentes. Para deixar as informações mais
individuais foi decidido separar essas variáveis da base principal.

## Resultados

<img src='man/figs/feminista.png' align="left" height="139" /></a>

*“Feminismo é um movimento para acabar com sexismo, exploração sexista e
opressão”* <font size="1">1</font>

<font size="1"> \[1\]:BUENO, Winnie. *Feminist Theory: From Margin to
Center* \[Teoria feminista: da margem ao centro\]. Sounth End Press.
1984. </font>
