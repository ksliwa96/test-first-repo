SELECT p.Nazwa,
	SUM(111 + ISNULL(d.IloscDostawa,0) - ISNULL(so.IloscOnline,0) - ISNULL(ss.IloscSklep,0)) AS StanMagazynowy
FROM Produkty p
	LEFT JOIN 
		(SELECT IdProduktu, SUM(Ilosc) AS IloscOnline
		FROM ZakupySklepOnlineProdukt
		GROUP BY IdProduktu) so
	ON p.IdProdukty = so.IdProduktu
	LEFT JOIN
		(SELECT IdProduktu, SUM(Ilosc) AS IloscSklep
		FROM ZakupySklepStacjonarnyProdukt
		GROUP BY IdProduktu) ss
	ON p.IdProdukty = ss.IdProduktu
	LEFT JOIN
		(SELECT IdProduktu, SUM(Ilosc) AS IloscDostawa
		FROM DostawaProduktow
		GROUP BY IdProduktu) d
	ON p.IdProdukty = d.IdProduktu
GROUP BY p.Nazwa




















/*
SELECT x.Nazwa, COUNT(*) as Ilosc
FROM
	(SELECT kp.Nazwa 
	FROM Produkty p
		JOIN KategorieProduktow kp
			ON p.IdKategorii = kp.IdKategorieProduktow
		JOIN ZakupySklepOnlineProdukt zop
			ON p.IdProdukty = zop.IdProduktu
		JOIN ZakupySklepOnline zo
			ON zop.IdZakup = zo.IdZakupySklepOnline
		JOIN RodzajDostawy rd
			ON zo.Dostawa = rd.IdRodzajDostawy
	WHERE rd.Nazwa = 'Poczta Polska'
	GROUP BY kp.Nazwa, zo.IdZakupySklepOnline) x
GROUP BY x.Nazwa
*/
/*
SELECT p.IdProdukty, 
	p.Nazwa, z.Ilosc AS Sprzedane, 
	d.Ilosc AS Dostarczone, 
	ISNULL(d.Ilosc,0) - ISNULL(z.Ilosc,0) AS Stan
FROM Produkty p
	LEFT JOIN
		(SELECT IdProduktu, SUM(ILOSC) AS Ilosc
		FROM ZakupySklepOnlineProdukt
		GROUP BY IdProduktu) z
	ON p.IdProdukty = z.IdProduktu
	LEFT JOIN
		(SELECT IdProduktu, SUM(ILOSC) AS Ilosc
		FROM DostawaProduktow
		GROUP BY IdProduktu) d
	ON p.IdProdukty = d.IdProduktu
	*/