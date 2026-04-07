/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT TOP 5 *
FROM users
ORDER BY created_at;


/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
SELECT DATENAME(WEEKDAY, created_at) AS [day of the week],
       COUNT(*) AS [total registration]
FROM users
GROUP BY DATENAME(WEEKDAY, created_at)
ORDER BY [total registration] DESC;

/*version 2*/
SELECT TOP 2
    DATENAME(WEEKDAY, created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY DATENAME(WEEKDAY, created_at)
ORDER BY total DESC;


/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
SELECT username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;


/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
SELECT TOP 1 users.username, photos.id, photos.image_url, COUNT(*) AS Total_Likes
FROM likes
JOIN photos ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY users.username, photos.id, photos.image_url
ORDER BY Total_Likes DESC;

/*version 2*/
SELECT TOP 1
    users.username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY users.username, photos.id, photos.image_url
ORDER BY total DESC;


/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/
SELECT ROUND(
    (SELECT COUNT(*) FROM photos) * 1.0 /
    (SELECT COUNT(*) FROM users), 2
);


/*user ranking by postings higher to lower*/
SELECT users.username, COUNT(photos.image_url) AS total_posts
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.username
ORDER BY total_posts DESC;


/*Total Posts by users (longer version of SELECT COUNT(*) FROM photos) */
SELECT SUM(user_posts.total_posts_per_user)
FROM (
    SELECT users.username, COUNT(photos.image_url) AS total_posts_per_user
    FROM users
    JOIN photos ON users.id = photos.user_id
    GROUP BY users.username
) AS user_posts;


/*total numbers of users who have posted at least one time */
SELECT COUNT(DISTINCT users.id) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id;


/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
SELECT TOP 5 tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY total DESC;


/*We have a small problem with bots on our site...
Find users who have liked every single photo on the site*/
SELECT users.id, username, COUNT(users.id) AS total_likes_by_user
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id, username
HAVING COUNT(users.id) = (SELECT COUNT(*) FROM photos);


/*We also have a problem with celebrities
Find users who have never commented on a photo*/
SELECT username
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id, username
HAVING COUNT(comments.id) = 0;

SELECT COUNT(*) FROM
(
    SELECT username
    FROM users
    LEFT JOIN comments ON users.id = comments.user_id
    GROUP BY users.id, username
    HAVING COUNT(comments.id) = 0
) AS total_number_of_users_without_comments;


/*Mega Challenges
Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented on a photo or have liked every photo*/

SELECT 
    tableA.total_A AS [Number Of Users who never commented],
    (tableA.total_A * 100.0 / (SELECT COUNT(*) FROM users)) AS [%],
    tableB.total_B AS [Number of Users who likes every photo],
    (tableB.total_B * 100.0 / (SELECT COUNT(*) FROM users)) AS [%]
FROM
(
    SELECT COUNT(*) AS total_A
    FROM (
        SELECT users.id
        FROM users
        LEFT JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(comments.id) = 0
    ) AS A
) AS tableA
CROSS JOIN
(
    SELECT COUNT(*) AS total_B
    FROM (
        SELECT users.id
        FROM users
        JOIN likes ON users.id = likes.user_id
        GROUP BY users.id
        HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)
    ) AS B
) AS tableB;


/*Find users who have ever commented on a photo*/
SELECT username
FROM users
JOIN comments ON users.id = comments.user_id
GROUP BY users.id, username;

SELECT COUNT(*) FROM
(
    SELECT users.id
    FROM users
    JOIN comments ON users.id = comments.user_id
    GROUP BY users.id
) AS total_number_users_with_comments;


/*Are we overrun with bots and celebrity accounts?
Find the percentage of our users who have either never commented or have commented before*/

SELECT 
    tableA.total_A AS [Number Of Users who never commented],
    (tableA.total_A * 100.0 / (SELECT COUNT(*) FROM users)) AS [%],
    tableB.total_B AS [Number of Users who commented on photos],
    (tableB.total_B * 100.0 / (SELECT COUNT(*) FROM users)) AS [%]
FROM
(
    SELECT COUNT(*) AS total_A
    FROM (
        SELECT users.id
        FROM users
        LEFT JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
        HAVING COUNT(comments.id) = 0
    ) AS A
) AS tableA
CROSS JOIN
(
    SELECT COUNT(*) AS total_B
    FROM (
        SELECT users.id
        FROM users
        JOIN comments ON users.id = comments.user_id
        GROUP BY users.id
    ) AS B
) AS tableB;
