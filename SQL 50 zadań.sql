--Ile zosta³o dokonanych zakupów w marcu?
SELECT COUNT (*) AS SprzedaneWycieczki
FROM Zakup
WHERE MONTH (Data) = 3

--W którym miesi¹cu sprzedano najmniej wycieczek?
SELECT TOP 1 MONTH(Data) AS Miesiac
FROM Zakup
GROUP BY MONTH(Data)
ORDER BY COUNT(*)