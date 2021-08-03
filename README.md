
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
#base_final_tidy |>  
 #dplyr::glimpse()
```

Nessa observamos as informações mais genéricas sobre os casos, contendo
infrações, endereços e delegacias.

``` r
#partes_tidy  |>  
 #dplyr::glimpse()
```

Essa base é mais específica, contendo informações das partes envonvidas
nos crimes. Em alguns casos haviam mais de uma vítima com desfechos
diferentes e qualidades diferentes. Para deixar as informações mais
individuais foi decidido separar essas variáveis da base principal.

## Resultados

*“Feminismo é um movimento para acabar com sexismo, exploração sexista e
opressão”* <font size="1">1</font>

<font size="1"> \[1\]:BUENO, Winnie. *Feminist Theory: From Margin to
Center* \[Teoria feminista: da margem ao centro\]. Sounth End Press.
1984. </font>
