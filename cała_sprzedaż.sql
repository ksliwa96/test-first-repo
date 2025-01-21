select 

cast(pdm.DATA as datetime)-36163 as data_s,
pdm.RODZAJ_POZYCJI,
pdm.id_poz_dok_mag,
dh.ID_DOKUMENTU_HANDLOWEGO,
pdm.ID_ARTYKULU,
art.NAZWA as artykul,
art.INDEKS_KATALOGOWY,
ka.NAZWA as kategoria,
k.NAZWA as producent,
f.NAZWA as nazwa_kontrahent,
dh.FORMA_PLATNOSCI,
wp.Ilosc,
wp.WartoscZakupuNetto,
wp.WartoscZakupuBrutto,
wp.WartoscNetto,
wp.WartoscBrutto,
wp.CenaNetto as cenaZaSztukeNetto,
wp.CenaBrutto as cenaZaSztukeBrutto,
wp.KodVAT,
wp.WartoscBrutto-wp.WartoscNetto as VAT,
wp.ZyskNetto

 from WAPRO.dbo.POZYCJA_DOKUMENTU_MAGAZYNOWEGO pdm 
 left join WAPRO.dbo.ARTYKUL art on pdm.ID_ARTYKULU=art.ID_ARTYKULU
 left join WAPRO.dbo.KONTRAHENT k on art.ID_PRODUCENTA=k.ID_KONTRAHENTA
 left join WAPRO.dbo.DOKUMENT_MAGAZYNOWY dm on pdm.ID_DOK_MAGAZYNOWEGO=dm.ID_DOK_MAGAZYNOWEGO
 left join WAPRO.dbo.KONTRAHENT f on dm.ID_KONTRAHENTA=f.ID_KONTRAHENTA
 left join WAPRO.dbo.WIDOK_POZYCJASTANU wp on pdm.ID_POZ_DOK_MAG=wp.IdPozycji
 left join WAPRO.dbo.KATEGORIA_ARTYKULU ka on art.ID_KATEGORII=ka.ID_KATEGORII
 left join WAPRO.dbo.DOKUMENT_HANDLOWY dh on dh.ID_DOKUMENTU_HANDLOWEGO=dm.ID_DOKUMENTU_HANDLOWEGO

 where
 pdm.RODZAJ_POZYCJI='R' and
 
 cast(pdm.DATA as datetime)-36163 >= '2021-01-01 00:00:00.000' and
 cast(pdm.DATA as datetime)-36163 < '2021-02-01 00:00:00.000' 