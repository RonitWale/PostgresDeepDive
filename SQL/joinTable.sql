SELECT * FROM WEATHER AS W JOIN CITIES AS C ON W.city = C.name;
SELECT * FROM WEATHER AS W LEFT OUTER JOIN CITIES AS C ON W.city = C.name;


SELECT W1.city, W1.temp_lo AS LOW , W1.temp_hi AS HIGH, W2.temp_lo AS LOW_2, W2.temp_hi AS HIGH_2
FROM WEATHER AS W1
JOIN WEATHER AS W2 ON W1.temp_lo < W2.temp_lo AND W1.temp_hi > W2.temp_hi;