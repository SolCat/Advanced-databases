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


-- Requête 7 : Temps moyen consacré aux activités Média, Sport et Voyage par tranche d’âge
                                                                                                    
SELECT a.nomActivite AS Activite, CASE
WHEN pe.age <= 10 THEN '1-10'
WHEN pe.age BETWEEN 11 and 20 THEN '11-20'
WHEN pe.age BETWEEN 21 and 30 THEN '21-30'
WHEN pe.age BETWEEN 31 and 40 THEN '31-40'
WHEN pe.age BETWEEN 41 and 50 THEN '41-50'
WHEN pe.age BETWEEN 51 and 60 THEN '51-60'
WHEN pe.age BETWEEN 61 and 70 THEN '61-70'
WHEN pe.age BETWEEN 71 and 80 THEN '71-80'
WHEN pe.age BETWEEN 81 and 90 THEN '81-90' ELSE '90+' END AS Age,
ROUND(AVG(t.tempsActiviteMinute)), dense_rank() OVER (PARTITION BY
a.nomActivite ORDER BY AVG(t.tempsActiviteMinute) DESC) rank AS Rang
FROM tableFaits t, Personne pe, Activite a
WHERE a.idActivite = t.idActivite AND pe.idPersonne = t.idPersonne
AND pe.age != '-8' AND (a.nomActivite = 'Sport' OR a.nomActivite =
'Travel' OR a.nomActivite = 'Media')
19
GROUP BY a.nomActivite, CASE WHEN pe.age <= 10 THEN '1-10'
WHEN pe.age BETWEEN 11 and 20 THEN '11-20'
WHEN pe.age BETWEEN 21 and 30 THEN '21-30'
WHEN pe.age BETWEEN 31 and 40 THEN '31-40'
WHEN pe.age BETWEEN 41 and 50 THEN '41-50'
WHEN pe.age BETWEEN 51 and 60 THEN '51-60'
WHEN pe.age BETWEEN 61 and 70 THEN '61-70'
WHEN pe.age BETWEEN 71 and 80 THEN '71-80'
WHEN pe.age BETWEEN 81 and 90 THEN '81-90' ELSE '90+' END;                                                  

          
-- Requête 8 : Temps moyen consacré aux activités Loisirs et Médias pour un individu donné, lorsque celui possède un ordinateur ou un véhicule

SELECT a.nomActivite AS Activite, f.aOrdinateur AS A_ordinateur,
f.aVehicule AS A_vehicule, AVG(t.tempsActiviteMinute) AS Temps,
GROUPING(a.nomActivite) AS Grouping_Activite, GROUPING(f.aOrdinateur) AS
Grouping_Ordi, GROUPING(f.aVehicule) AS Grouping_Vehicule
FROM tableFaits t, Personne pe, Activite a, Foyer f
WHERE (a.nomActivite = 'HomeLeisure' OR a.nomActivite = 'Media')
AND a.idActivite = t.idActivite
AND pe.idPersonne = t.idPersonne
AND f.idFoyer = t.idFoyer
GROUP BY ROLLUP a.nomActivite, f.aOrdinateur, f.aVehicule
 
          
-- Requête 9 :Temps moyen consacré aux activités Loisirs et Médias pour un individu donné, lorsque celui possède un ordinateur ou un véhicule
    
SELECT a.nomActivite AS Activite, f.aOrdinateur AS A_ordinateur,
f.aVehicule AS A_vehicule, AVG(t.tempsActiviteMinute) AS Temps,
GROUPING(a.nomActivite) AS Grouping_Activite, GROUPING(f.aOrdinateur) AS
Grouping_Ordi, GROUPING(f.aVehicule) AS Grouping_Vehicule
FROM tableFaits t, Personne pe, Activite a, Foyer f
WHERE (a.nomActivite = 'HomeLeisure' OR a.nomActivite = 'Media')
AND a.idActivite = t.idActivite
AND pe.idPersonne = t.idPersonne
AND f.idFoyer = t.idFoyer
GROUP BY ROLLUP a.nomActivite, f.aOrdinateur, f.aVehicule         

          
--  Requête 10 : Top des activités auxquelles un individu consacre le plus de temps, par région habitée (Europe, Amérique du Nord, Moyen-Orient), hors activités Travail, Repos, Pause Travail et Études
          
SELECT a.nomActivite AS Activite, p.Region AS Region,
AVG(t.tempsActiviteMinute) AS Temps,
RANK() OVER (ORDER BY AVG(t.tempsActiviteMinute) DESC) AS Rang
FROM tableFaits t, Activite a, Pays p
WHERE a.idActivite = t.idActivite
AND p.idPays = t.idPays
AND a.nomactivite != 'Work' AND a.nomactivite != 'WorkBreak'
AND a.nomactivite != 'School' AND a.nomactivite != 'Sleep'
GROUP BY a.nomActivite, p.Region;
                                                 
