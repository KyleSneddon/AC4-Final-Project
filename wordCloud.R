


library(tm)
library(SnowballC)
library(wordcloud)
library(dplyr)
library(RColorBrewer)
library(stringr)

data <- read.csv('data/cleandata.csv')
onestring <- paste( unlist(data$Description), collapse='')
onestring <- gsub('Lights', 'Light', onestring) 
onestring <- gsub('Shaped', 'Shape', onestring)
onestring <- gsub('Objects', 'Object', onestring)

print(onestring)
View(onestring)
dataCorpus <- Corpus(VectorSource(onestring))
dataCorpus <- tm_map(dataCorpus, content_transformer(tolower))
dataCorpus <- tm_map(dataCorpus, removePunctuation)
dataCorpus <- tm_map(dataCorpus, PlainTextDocument)
dataCorpus <- tm_map(dataCorpus, removeWords, stopwords('english'))
#dataCorpus <- tm_map(dataCorpus, stemDocument)

color_pal <- brewer.pal(5, "BuPu")
color_pal <- color_pal[(3:7)]

wordcloud(dataCorpus, max.words = 200, random.order = FALSE, colors =  color_pal)




