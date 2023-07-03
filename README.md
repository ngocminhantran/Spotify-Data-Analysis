# Spotify EDA
## Project Description
### Introduction
Spotify is the world’s most popular audio streaming subscription service with more than 500 million users, including over 200 million subscribers in over 180 markets.

In this project, we use SQL to conduct EDA on 2 Spotify datasets: tracks.csv and artists.csv with nearly 600 thousand tracks (released from 1922 to 2021) and more than 1 million artists. 

The dataset can be found here: https://www.kaggle.com/datasets/lehaknarnauli/spotify-datasets?select=artists.csv

For further explanation of the dataset, please refer to this link: https://developer.spotify.com/documentation/web-api

### Problem Statement
The projects aims to conduct exploratory data analysis of the datasets to answer the following questions:
1. What are the most popular tracks?
2. What are the least popular tracks?
3. Is there any correlation between popularity and the track's traits?
4. What is the proportion between explicit tracks and non-explicit tracks?
5. What are the years with the highest number of tracks published?
6. Is there any change in the track average duration over years?
7. Which artists are behind the most popular track?
8. Which artists have the highest number of followers?
9. Who are the most popular artists?
10. Does the number of followers determine the popularity of an artist?
11. How popular are artists with the least popular tracks?
12. What are the genres with the largest number of artists?

## Insights
1. 3 most popular tracks were Peaches, Drivers License, Astronaut in the Ocean, all of which were published in 2021.
2. 3 least popular tracks were Wildberry Tracks 2008 - Léo Cuenca Vocal Mix (2012), A Commemoration Symphony to Stephen Foster: IV. Allegro quasi recitativo - Arr. and Orch. by Robert Russell Bennett (1960), Hold That Sucker Down - Vocal Radio Edit (2013).
3. Overall, no variables have a significant correlation with popularity. Loudness and energy has the most positive (though still considered low) correlation with popularity (with correlation coefficient recorded at 0,33 and 0,30 respectively). Acousticness has the most negative (though still considered low) correlation with popularity (-0.37).
4. The vast majority of tracks have non-explicit content. There are almost 22 times more non-explicit tracks (560,808) than explicit tracks (25,864). To further see whether there is a relation between explicit score and popularity, I found out that 98.7% (44108 out of 44690) least popular tracks don't have explicit content. However, the proportion for entire dataset is nearly the same (96.6% without explicit content (560808 out of 586672)). Probably this is the overall trend of the entire surveyed period.
5. 15 years in which the total number of tracks published each year exceeded 10000 fall into 2 periods: 2013-2020 and 1992-1999.
6. Except for the year 2013, in the 12 year period from 2010 to 2021, the average duration of track has decreased constantly form 250,5 sec (ranking 100/101 in terms of shortness) to 197,74 sec (ranking 14/101 in terms of shortness).
7. The artist of the most popular track in the entire dataset are Giveon, Daniel Caesar, Justin Bieber, all of whom ranking high with regards to artist popularity (91, 89 and 100 respectively). Noticeably, Justin Bieber is the most popular artist (100/100) and has the most popular track (100/100).
8. Ed Sheeran, Ariana Grande, Drake are the only to have over 500M followers on Spotify.
9. The most popular artists are Justin Bieber (popularity score 100), Bad Bunny (98), Taylor Swift (98)and Drake (98).
10. There is low correlation (correlation score 0.17) between popularity of an artist and his/her number of followers 
11. Popularity of the track does not indicate popularity of the artists. Even the most popular artist (Justin Bierber) has 0 popularity score tracks.
12. Rock, pop and electro house are the genres with the highest number of tracks.
