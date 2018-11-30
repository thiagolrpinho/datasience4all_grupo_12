# Biblioteca com funções disponibizadas pelos responsáveis da disciplina 
setwd("~/Documents/Estudos/UnB/Data Science 4 All/Projeto Final - Grupo 12/Projeto_R_Studio_Pos_Educacao_fisica")
source("elattes.ls2df.R")
# Bibliotecas utilizadas no script abaixo
library(jsonlite)
library(plyr)
library(tidyverse)


# Ciências de Reabilitação  - 250
json.perfil.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.profile.json"
json.advise.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.advise.json"
json.graph.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.graph.json"
json.list.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.list.json"
json.publication.ciencias_de_reabilitacao <- "dataset/pos_ciencias_de_reabilitacao/250.publication.json"

unb.perfil.ciencias_de_reabilitacao <- fromJSON(json.perfil.ciencias_de_reabilitacao)

areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
producoes.df <- extrai.producoes(unb.perfil.ciencias_de_reabilitacao)

perfil.producoes.df <- merge(producoes.df, areas_atuacao.df)

perfil.producoes.df %>%
  group_by(ano,especialidade, idLattes) %>%
  filter( pais_de_publicacao != "Brasil" && !is.na(pais_de_publicacao)) %>%
  ggplot(aes(x=ano,y=especialidade, color= tipo_producao)) +
  xlab("Ano") + ylab("Especialidade")+ ggtitle("Produções de Ciências de Reabilitação Internacionais") + geom_point() + geom_jitter()

perfil.producoes.df %>%
  group_by(ano,especialidade, idLattes) %>%
  filter( pais_de_publicacao == "Brasil" || is.na(pais_de_publicacao)) %>%
  ggplot(aes(x=ano,y=especialidade, color= tipo_producao)) +
  xlab("Ano") + ylab("Especialidade") + ggtitle("Produções de Ciências de Reabilitação Não-Internacionais") + geom_point() + geom_jitter()
  