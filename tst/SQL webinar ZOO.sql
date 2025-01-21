/*
KOLEJNOŒÆ WYKONYWANIA ZAPYTAÑ

FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
TOP/LIMIT
*/

/*
poka¿ stany magazynowe produktów -> to co zosta³o dostarczone - to co zosta³o sprzedane + zwroty, nie powinno nic powy¿ej 100

SELECT ord.IdZamowienie, ord.Ilosc
FROM ZamowieniaAsortyment ord
LEFT JOIN ord.IdZamowienie on stk.IdAsortyment

SELECT stk.IdAsortyment, stk.Nazwa
FROM ASORTYMENT stk
*/

--1. ile mamy pracowników
/*
SELECT COUNT (*) AS IloscPracownikow, COUNT (DISTINCT Imie) AS Unikalne 
-- * liczy wszystko jak dasz count (imie) to liczy tylko to co nie puste i sugeruje ze tam jest NULL
-- DISTINCT w () jak formu³a, chyba ¿e masz samo SELECT DISTINCT Imie 
FROM Pracownicy

--2. ile mamy asortymentu danego typu

SELECT ta.nazwa, COUNT(*) AS Ilosc --kolumna z GROUP BY musi byc w SELECT i nic wiêcej, mo¿na u¿yæ jedynie tego co policzalne, jakaœ funkcja agreguj¹ca czy coœ
FROM Asortyment a
	INNER JOIN TypyAsortymentu ta
		ON ta.IdTypyAsortymentu = a.IdTypyAsortymentu
GROUP BY ta.Nazwa

--ZnajdŸ asortyment, który nie zosta³ nigdy kupiony


SELECT a.Nazwa
FROM Asortyment a
	LEFT JOIN Zakupy z
	ON a.IdAsortyment = z.IdAsortyment
WHERE z.IdZakupy IS NULL

SELECT Nazwa
FROM Asortyment
WHERE IdAsortyment NOT IN (SELECT DISTINCT IdAsortyment FROM Zakupy) --zapytanie zagnieŸd¿one


-- ZnajdŸ 3 najdro¿sze produkty

SELECT TOP 3 *
FROM Asortyment
ORDER BY Cena DESC
*/

--ZnajdŸ najdro¿szy produkt | w WHERE nie mo¿na u¿yæ funkcji agreguj¹cej, chyba ¿e zapytanie zagnieŸd¿one

/*SELECT *
FROM Asortyment
WHERE Cena = (SELECT MAX(Cena) FROM Asortyment)
--
DECLARE @maxCena decimal (10,2)

SELECT @maxCena = MAX (Cena) FROM Asortyment

SELECT *
FROM Asortyment
WHERE Cena = @maxCena*=
*/
--

--poka¿ stany magazynowe produktów

/*
SELECT a.Nazwa, SUM(za.Ilosc) - SUM(z.Ilosc)
FROM Asortyment a
	INNER JOIN Zakupy z
		ON z.IdAsortyment = a.IdAsortyment
	INNER JOIN ZamowieniaAsortyment za
		ON za.IdAsortyment = a.IdAsortyment
GROUP BY a.Nazwa

!to zapytanie duplikuje drug¹ tabelê */

SELECT a.Nazwa, ISNULL(zam.Ilosc,0) - ISNULL(zak.Ilosc, 0) AS stock --bez IS NULL jest bez wartoœci wiêc trzeba zmieniæ na 0
FROM Asortyment a
	LEFT JOIN 
		(SELECT za.IdAsortyment, SUM (za.Ilosc) AS Ilosc
		FROM ZamowieniaAsortyment za
		Group BY za.IdAsortyment) zam
		ON a.IdAsortyment = zam.IdAsortyment
	LEFT JOIN
		(SELECT z.IdAsortyment, SUM (z.Ilosc) AS Ilosc
		FROM Zakupy z
			LEFT JOIN Zwroty zw
				ON zw.IdZakupy = z.IdZakupy
		WHERE zw.IdZakupy IS NULL
		GROUP BY z.IdAsortyment) zak
		ON a.IdAsortyment = zak.IdAsortyment

/* 
¯EBY ZROBIÆ XOR, NALE¯Y WYKONAÆ AND NOT JAK PONI¯EJ
SELECT *
FROM world
WHERE (area > 3000000 OR population > 250000000) AND NOT
	(aream > 3000000 AND population > 250000000)

¯EBY ZAKR¥GLIÆ CA£KOWITE, CZYLI NP. Z 1 000 000 ZROBIÆ 1 000

SELECT name, ROUND(GDP/population,-3) AS "per capita"
FROM world
WHERE GDP > 1000000000000

D£UGOŒÆ LENGHT

SELECT name, capital
From world
WHERE LEN(name) = 6 AND
LEN(capital) = 6

SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND
name != capital
ORDER BY name, capital;

SELECT name
FROM world
WHERE (name LIKE '%a%' AND
name LIKE '%e%' AND
name LIKE '%i%' AND
name LIKE '%o%' AND
name LIKE '%u%') AND
name NOT LIKE '% %' 

*/