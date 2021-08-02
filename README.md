
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Projeto final do Curso de Faxina de dados: Feminícidio

Esse pacote foi produzido especialmente para o trabalho final do curso
de Faxina de dados do [curso-r](https://curso-r.com/).

## Para instalar

``` r
#devtools::install_github("katerine-dev/feminicidio")
```

## O projeto

As bases brutas foram baixadas diretamente do [Portal de Transparência
do Governo](http://www.ssp.sp.gov.br/transparenciassp/). Foi escolhido o
prazo de março de 2020 a maio de 2021, chegando num total de 14 arquivos
em .xls.

Atualmente existem vários estudos que demonstram um aumento relevante de
nºs de casos de feminicídio e agressões contra mulheres na pandemia. O
objetivo da análise é observar os casos de feminicídio entre o início da
pandemia e os dias de hoje.

O isolamento social acentuou a violência doméstica na medida que as
mulheres que já viviam algum tipo de vulnerabilidade foram forçadas a
passarem mais tempo com seus agressores, seja por aderirem ao trabalho
remoto, desemprego ou pela responsabilidade familiar de ficar com as
crianças ou idosos em casa. Além da violência, as mulheres convivem com
uma sobrecarga do trabalho doméstico e familiares que se concentram
desigualmente entre o homem e a mulher que reforçam ainda mais a relação
de patriarcado.

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

  - Colunas não necessárias
  - Problemas com enconding
  - Nºs de latitude e longitude fora do padrão
  - Letras maiúsculas nas colunas
  - Colunas separadas que eram da mesma espécie
  - Problemas com as datas datas e horas
  - Informações diferentes numa mesma coluna
  - Duplicidade de informações
  - Linhas com lacunas ou “0”
  - Nomes de colunas sem padrão

## O planejamento

Foi decidido dividir os dados entre 4 bases tidys relacionadas pelo o
assunto para a arrumação principal.

  - A primeira divisão: `base_sem_duplicadas_infracoes`
  - A segunda divisão: `base_sem_duplicadas_data`
  - A terceira divisão: `base_sem_duplicadas_partes`
  - A quarta divisão: `base_sem_duplicadas_enderecos`

Finalizando a arrumação foi realizado um join entre elas produzindo a
`base_final`

``` r
#base_final %>% 
 # glimpse()
```

## Resultados
