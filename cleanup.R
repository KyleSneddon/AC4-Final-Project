library(dplyr)
library(stringr)

#import data
data <- read.csv("~/Desktop/info201/AC4-Final-Project/data/ufo.csv") %>% 
  filter(Country == "us") %>% 
  select(City,State,Shape,Unknown,Description,Date,Longitude,Latitute)

#Change Unkown column to Duration.in.seconds
colnames(data)[colnames(data)=="Unknown"] <- "Duration.in.seconds"

#mutate by columns
data$Description <- str_to_title(data$Description)
data$City <- str_to_title(data$City)
data$State <- str_to_upper(data$State)
data$Shape <- str_to_title(data$Shape)

#substring all the unnessasary words
data$Description <- gsub('&#44', '', data$Description)  
data$Duration <- gsub('&#44', '', data$Duration)
data$City <- gsub('&#44', '', data$City)

data$Description <- gsub('&#39', '', data$Description)  
data$Duration <- gsub('&#39', '', data$Duration)
data$City <- gsub('&#39', '', data$City)

data$Description <- gsub('&#33', '', data$Description)  
data$Duration <- gsub('&#33', '', data$Duration)
data$City <- gsub('&#33', '', data$City)

data$Description <- gsub('&quot;','', data$Description)
data$Description <- gsub('&amp;','', data$Description)
data$Description <- gsub('&#160;','', data$Description)
data$Description <- gsub('&#8217;','', data$Description)
data$Description <- gsub('&#9;','', data$Description)
data$Description <- gsub('&#8220;','', data$Description)
data$Description <- gsub('&#8221;','', data$Description)
data$Description <- gsub('&#8211;','', data$Description)
data$Description <- gsub('&#8230;','', data$Description)
data$Description <- gsub('&#8212;','', data$Description)
data$Description <- gsub('&#8226;','', data$Description)
data$Description <- gsub('&#188;','', data$Description)
data$Description <- gsub('&#186;','', data$Description)
data$Description <- gsub('&#176;','', data$Description)
data$Description <- gsub('&#8216;','', data$Description)



