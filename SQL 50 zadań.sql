--Ile zosta�o dokonanych zakup�w w marcu?
SELECT COUNT (*) AS SprzedaneWycieczki
FROM Zakup
WHERE MONTH (Data) = 3

--W kt�rym miesi�cu sprzedano najmniej wycieczek?
SELECT TOP 1 MONTH(Data) AS Miesiac
FROM Zakup
GROUP BY MONTH(Data)
ORDER BY COUNT(*)