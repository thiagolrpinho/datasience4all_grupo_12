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

### QUESTÃO 12
areas_atuacao.df <- extrai.areas.atuacao(unb.perfil.ciencias_de_reabilitacao)
perfils.df <- extrai.perfis(unb.perfil.ciencias_de_reabilitacao)

# Primeiro vamos relacionar perfils com área de atuação
perfil.area_atuacao.df <- merge(perfils.df, areas_atuacao.df)
# Depois vamos contar quantas produções e orientações cada pesquisador fez
perfil.df <- merge(perfil.area_atuacao.df,count(producoes.df$idLattes), by.x = "idLattes", by.y="x")
perfil.df <- merge(perfil.df,count(orientacoes.df$idLattes), by.x = "idLattes", by.y="x")
colnames(perfil.df)[18] <- "count_orientacoes"
colnames(perfil.df)[17] <- "count_producoes"

# Achei interessante avaliar se um pesquisador que produz mais também tende a orientar mais
# Com relação a área, grande área e especialidade, resolvi relacionar com cores
perfil.df %>%
  group_by(idLattes, grande_area) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= grande_area)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

perfil.df %>%
  group_by(idLattes, area) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= area)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

# Sub_area tem variações demais para ser representado por cor e achei melhor verificar quem eram os 
# pesquisadores que contribuíam mais para a pós com relação a produção e orientação
perfil.df %>%
  group_by(idLattes) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= nome)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()

perfil.df %>%
  group_by(idLattes, especialidade) %>%
  ggplot(aes(x=count_producoes ,y=count_orientacoes, color= especialidade)) +
  xlab("Número de Produções") + ylab("Número de Orientações") + ggtitle("Produções e Orientações de Ciências de Reabilitação") + geom_point() + geom_jitter()
