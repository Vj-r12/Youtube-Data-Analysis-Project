
/**********     DATA ANALYSIS     **********/


-- Fetch the data from YouTube Analysis.

SELECT *
FROM YOUTUBE_ANALYSIS;

-- Fetch the channel name, channel category & country.

SELECT CHANNEL_NAME,
	   CHANNEL_CATEGORY,
	   COUNTRY
FROM YOUTUBE_ANALYSIS;

/* Arrange the channel names according to channel created year
& channel created month. */

SELECT CHANNEL_NAME,
       CHANNEL_CREATED_YEAR,
       CHANNEL_CREATED_MONTH
FROM YOUTUBE_ANALYSIS
ORDER BY CHANNEL_CREATED_YEAR,CHANNEL_CREATED_MONTH;

/* Fetch the channel category & 
count the channel name under channel category. */

SELECT CHANNEL_CATEGORY,
       COUNT(CHANNEL_NAME) AS NUMBER_OF_CHANNELS
FROM YOUTUBE_ANALYSIS
GROUP BY CHANNEL_CATEGORY;

/* Fetch the country & count the channel name under each country, 
sort the number of channels by desc. */

SELECT COUNTRY,
	   COUNT(CHANNEL_NAME) AS NUMBER_OF_CHANNELS
FROM YOUTUBE_ANALYSIS
GROUP BY COUNTRY
ORDER BY NUMBER_OF_CHANNELS DESC;

-- Find the top 5 channel names by subscribers under country.

SELECT CHANNEL_NAME,COUNTRY,
	   SUBSCRIBERS
FROM YOUTUBE_ANALYSIS
ORDER BY SUBSCRIBERS DESC
LIMIT 5;

-- Find the top 10 channel names by subscribers and assign the rank.

SELECT CHANNEL_NAME,
	   SUBSCRIBERS,
	   RANK() OVER (ORDER BY SUBSCRIBERS DESC) AS RANK
FROM YOUTUBE_ANALYSIS
LIMIT 10;

-- Find the top 5 channel names by video views and assign the rank.

SELECT CHANNEL_NAME,
	   VIDEO_VIEWS,
	RANK() OVER (ORDER BY VIDEO_VIEWS DESC) AS RANK
FROM YOUTUBE_ANALYSIS
LIMIT 5;

/* Find the top channel name by subscribers within each channel category 
& print the top channel name along with their corresponding categories. */

SELECT CHANNEL_NAME,
	   SUBSCRIBERS,
	   CHANNEL_CATEGORY,
	FIRST_VALUE(CHANNEL_NAME) OVER (PARTITION BY CHANNEL_CATEGORY
    ORDER BY SUBSCRIBERS DESC) AS TOP_CHANNEL_NAME
FROM YOUTUBE_ANALYSIS;

-- Find the top channel names by subscribers within each country.

SELECT X.CHANNEL_NAME,
	   COUNTRY,
	   SUBSCRIBERS
FROM
	(
	 SELECT CHANNEL_NAME,
			COUNTRY,
			SUBSCRIBERS,
		RANK() OVER (PARTITION BY COUNTRY
        ORDER BY SUBSCRIBERS DESC) AS TOP_CHANNEL
		FROM YOUTUBE_ANALYSIS
	) X
WHERE X.TOP_CHANNEL = 1; 

/* Find the top channel names by video views within each channel category 
& assign rank for channel name by views. */

SELECT CHANNEL_NAME,
	   CHANNEL_CATEGORY,
	   VIDEO_VIEWS,
	RANK() OVER (PARTITION BY CHANNEL_CATEGORY
    ORDER BY VIDEO_VIEWS DESC) AS RANK
FROM YOUTUBE_ANALYSIS;

/* Find the top channel names by video views within each country
& assign rank for channel names by views. */

SELECT CHANNEL_NAME,
	   COUNTRY,
	   VIDEO_VIEWS,
	RANK() OVER (PARTITION BY COUNTRY
    ORDER BY VIDEO_VIEWS DESC) AS RANK
FROM YOUTUBE_ANALYSIS;

-- Find the top 5 channel names by highest monthly earnings.

SELECT CHANNEL_NAME,
	   HIGHEST_MONTHLY_EARNINGS
FROM YOUTUBE_ANALYSIS
ORDER BY HIGHEST_MONTHLY_EARNINGS DESC
LIMIT 5;

-- Find the top 5 channel names by highest yearly earnings.

SELECT CHANNEL_NAME,
	   HIGHEST_YEARLY_EARNINGS
FROM YOUTUBE_ANALYSIS
ORDER BY HIGHEST_YEARLY_EARNINGS DESC
LIMIT 5;

/* Find the top 5 channel names & channel category by highest
video views in last 30 days */ 

SELECT CHANNEL_NAME,
	   CHANNEL_CATEGORY,
	   VIDEO_VIEWS_FOR_LAST_30_DAYS
FROM YOUTUBE_ANALYSIS
ORDER BY VIDEO_VIEWS_FOR_LAST_30_DAYS DESC
LIMIT 5;

-- Find the top 5 channel names by highest subscribers in last 30 days. 

SELECT CHANNEL_NAME,
	   SUBSCRIBERS_FOR_LAST_30_DAYS
FROM YOUTUBE_ANALYSIS
ORDER BY SUBSCRIBERS_FOR_LAST_30_DAYS DESC
LIMIT 5; 