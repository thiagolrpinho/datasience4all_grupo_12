# Biblioteca com funções disponibizadas pelos responsáveis da disciplina 
setwd("~/Documents/Estudos/UnB/Data Science 4 All/Projeto Final - Grupo 12/Projeto_R_Studio_Pos_Educacao_fisica")
source("elattes.ls2df.R")
# Bibliotecas utilizadas no script abaixo
library(jsonlite)
library(plyr)
library(tidyverse)
library(igraph)
library(RColorBrewer)

# Ciências de Reabilitação  - 250
json.perfil.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.profile.json"
json.advise.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.advise.json"
json.graph.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.graph.json"
json.list.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.list.json"
json.publication.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.publication.json"

unb.perfil.ciencias_de_reabilitacao <- fromJSON(json.perfil.ciencias_de_reabilitacao)
unb.producao.ciencias_de_reabilitacao <- fromJSON(json.publication.ciencias_de_reabilitacao)
unb.graph.ciencias_de_reabilitacao <- fromJSON(json.graph.ciencias_de_reabilitacao)


areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
perfils.df <- extrai.perfis(unb.perfil.ciencias_de_reabilitacao)
producoes.df <- extrai.producoes(unb.perfil.ciencias_de_reabilitacao)
orientacoes.df <- extrai.orientacoes(unb.perfil.ciencias_de_reabilitacao)

#Laço para corrigir o erro de produções sem ano, mas com ano do trabalho
for (row in 1:nrow(producoes.df)) {
  if ( is.na(producoes.df$ano[row]) ){
    producoes.df$ano[row] <- producoes.df$ano_do_trabalho[row]
  } 
}
producao.df <- merge(producoes.df, count(producoes.df, "idLattes"))
producao.df %>%
  group_by(idLattes) %>%
  ggplot(aes(x=ano ,y=freq, color=idLattes)) +
  xlab("Quantidade de Produção") + ylab("Ano") + ggtitle("Produção de Ciências de Reabilitação") + geom_point() + geom_jitter() + facet_grid(tipo_producao~.)
