unb.area <- fromJSON(json.researchers_by_area)
unb.area.df <- cbind(names(unb.area$`Areas dos pesquisadores`),
(sapply(unb.area$`Areas dos pesquisadores`, function(x) length(x))))
rownames(unb.area.df) <- c(1:nrow(unb.area.df)); colnames(unb.area.df) <- c("Area", "Professores")
head(unb.area.df[])t