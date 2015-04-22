This is an R-based project that tries to predict Box Office Revenues and Ratings of a movie prior to its launch.

This is a group project that was completed by a team of five members. The details of the team members in alphabetical order are:
1. Kshitij Sharma (ksharma3@ncsu.edu)
2. Ramakant Moka (rmoka@ncsu.edu)
3. Varun Aettapu (vaettap@ncsu.edu)
4. Vijay Sankar Ganesh (vgsankar@ncsu.edu)
5. Vivekananda Vakkalanka (vvakkal@ncsu.edu)

The aim of this project was to parse tweets about movies before its release date and perform a sentiment analysis on that data to predict the success of the movie. Of course, it is almost impossible to judge a movie before its release, especially based on "social buzz" about a movie, but the key assumption here is that movie franchises, directors or actors or other such entities who cause a huge social buzz are more likely to choose successful projects than otherwise. Since the "sentiment analysis" is performed only 1 week ahead of the movie's launch date, it is also safe to assume that the trailers and other promotional events would have already been released and would have given the public a general idea about the movie. When we perform sentiment analysis at such a time, we are able to accurately (to a certain extent) determine the success rating of the movie.

Another aspect of the project, but one which is far less open to misinterpretation is that it also aims to predict the opening week Box-Office Collections for the movie. This is far more accurate than the above mentioned aspect because whether the movie eventually turns out to be good or not, the social buzz is a great indicator of how the opening day collections will be.

One of the limitations of the project was that the Twitter API does not allow programmers to retrieve tweets that are over a week old. Hence, manual collection of tweets from other 3rd Party Services like the one provided by Topsy Labs was required to Train and Test the model that was built.

Although this project had a very basic and elementary aim, its completion was an important step in learning more about the Statistical Language - R and various Data Analysis Techniques such as Linear Regression. We hope to have this project as the first step in our endeavor to master the field of Data Analytics.
