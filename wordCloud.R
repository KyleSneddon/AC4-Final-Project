

install.packages("wordcloud2")

library(tm)
library(SnowballC)
library(wordcloud2)
library(dplyr)
library(RColorBrewer)
library(stringr)
library(tidytext)
data <- read.csv('data/cleandata.csv')
onestring <- paste( unlist(data$Description), collapse='')
onestring <- gsub('Lights', 'Light', onestring) 
onestring <- gsub('Shaped', 'Shape', onestring)
onestring <- gsub('The', '', onestring)
onestring <- gsub('Objects', 'Object', onestring)

#onestring <- gsub("[[:punct:][:blank:]]+", " ", onestring)
#onestring <- gsub(stopwords("en"), onestring)
print(onestring)

#rm_words <- function(string, words) {
#  stopifnot(is.character(string), is.character(words))
#  spltted <- strsplit(string, " ", fixed = TRUE) # fixed = TRUE for speedup
#  vapply(spltted, function(x) paste(x[!tolower(x) %in% words], collapse = " "), character(1))
#}

#onestring222 <- rm_words(onestring, tm::stopwords("en"))
onestring222 <- tolower(onestring222)

onestringtest <- strsplit(onestring222, " ") %>% 
  as.data.frame() 

colnames(onestringtest)[1] <- "word"

onestringtest <- 
  anti_join(onestringtest, stop_words, by="word")

onestring.df <-  onestringtest %>% 
  group_by(word) %>% 
  summarize(count = n()) %>% 
  arrange(-count)

wordcloud2
wordcloud2(onestring.df, size=1.6, backgroundColor=404348)
wow <- letterCloud(onestring.df, size=1.6,word = "UFO",color = 'white', backgroundColor=404348)

wow
png(filename="faithful.png")
 plot(wow)
 dev.off()


