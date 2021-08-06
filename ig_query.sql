-- This file includes queries to understand the ig_clone db based on challenges presented in the tutorial.
-- The queries are vary from the official solutions but return the same results.

-- Find the top 5 oldest users
SELECT *
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- What day of the week do most users register on?
SELECT DAYNAME(created_at) as `day_of_week`, COUNT(*) AS `registration(s)`
FROM users
GROUP BY `day_of_week`
ORDER BY `registration(s)` DESC;

-- Find users who have never posted a photo
SELECT users.id, users.username, photos.user_id
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.user_id IS NULL;

-- Find the single photo, user with the most likes 
SELECT image_url, username, COUNT(*) as `likes`
FROM photos
JOIN likes ON photos.id = likes.photo_id
JOIN users ON photos.user_id = users.id
GROUP BY image_url, users.username
ORDER BY `likes` DESC
LIMIT 1;

-- How many times does the average user post?
SELECT 
    (SELECT COUNT(image_url) FROM photos) / 
    (SELECT COUNT(*) FROM users) AS avg_num_of_posts;
    
-- What are the 5 most commonly used hashtags?
SELECT tag_name, COUNT(tag_id) as num_of_tags
FROM photo_tags
JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tag_name
ORDER BY num_of_tags DESC
LIMIT 5;

-- Find users who have liked every single photo on the site (bots).
SELECT username, COUNT(likes.user_id) AS total_likes
FROM users
JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes = (SELECT COUNT(*) FROM photos);