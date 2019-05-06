-- Requête 1 : Palmarès des 5 premiers pays qui consacrent le plus de temps au travai

Select *  FROM (SELECT pa.nomPays, ac.nomActivite, AVG(t.tempsActiviteMinute) AS Durée
FROM tableFaits t,  Activite ac, Pays pa
WHERE t.idPays = pa.idPays 
AND t.idActivite = ac.idActivite
AND (ac.nomActivite = 'Work')
GROUP BY pa.nomPays, ac.nomActivite
ORDER BY Durée DESC) 
WHERE ROWNUM <= 5;

-- Requête 2 : Top 5 des activités sur lesquelles un individu passe le plus de temps sur une journée

SELECT * FROM (SELECT a.nomActivite 
AS Activité, ROUND(AVG(t.tempsActiviteMinute)/60,0)
AS Duree_heure
FROM TableFaits t, Pays pa,
tDate d, Activite a 
WHERE t.idPays = pa.idPays 
AND t.idDate = d.idDate 
AND t.idActivite = a.idActivite 
GROUP BY a.NomActivite 
ORDER BY Duree_heure DESC) 
WHERE ROWNUM <=5;

-- Requête 3 : Temps moyen consacré aux tâches ménagères par pays et par sexe


SELECT pa.nomPays AS Pays, pe.Sexe AS Sexe, ROUND(AVG(t.tempsActiviteMinute),0) AS Temps
FROM TableFaits t, Pays pa, tDate d, 
Activite a, Personne pe
WHERE t.idPays = pa.idPays 
AND t.idDate = d.idDate 
AND t.idActivite = a.idActivite 
AND t.idPersonne = pe.idPersonne
AND a.nomActivite = 'Housework'
GROUP BY CUBE (pa.nomPays, pe.Sexe)


-- Requête 4 : Palmarès des pays consacrant le plus de temps aux médias (ordinateur, taélévision) le soir, à compter des années 2000

SELECT p.nomPays as Pays, ROUND(AVG(t.tempsActiviteSoir),0) AS Temps_min
FROM Pays p, tableFaits t, Activite a, tDate d 
WHERE t.idDate = d.idDate 
AND t.idActivite = a.idActivite 
AND t.idActivite = a.idActivite 
AND t.idPays = p.idPays 
AND a.nomActivite = 'Media'
AND d.annee >= 2000 
GROUP BY p.nomPays ORDER BY Temps_min DESC;


-- Requête 5 : Évolution du temps consacré aux activités Travail et Repos aux Pays-Bas entre 1975 et 2005


SELECT a.nomActivite AS Activité, d.annee AS Année, ROUND(AVG(t.tempsActiviteMinute),0) AS Temps
FROM TableFaits t, Pays pa, tDate d, Activite a 
WHERE t.idPays = pa.idPays AND t.idDate = d.idDate 
AND t.idActivite = a.idActivite 
AND (a.nomActivite = 'Work' OR
 a.nomActivite = 'Sleep') 
AND pa.nomPays = 'Pays-Bas' 
AND (d.annee = 1975 OR d.annee = 2005) 
GROUP BY GROUPING SETS ((d.annee,a.nomActivite), (a.nomActivite));


-- Requête 6 : Temps moyen consacré aux activités de type loisirs pour une situation maritale et une zone d’habitation données


SELECT pe.situationMaritale, f.lieuResidence, AVG(t.tempsActiviteMinute) as moyenne
FROM TableFaits t, Activite a, Personne pe, Foyer f
WHERE t.idActivite = a.idActivite 
AND t.idPersonne = pe.idPersonne 
AND  t.idFoyer = f.idFoyer 
AND a.nomActivite = 'homeLeisure'
GROUP BY ROLLUP (pe.situationMaritale, f.lieuResidence);
