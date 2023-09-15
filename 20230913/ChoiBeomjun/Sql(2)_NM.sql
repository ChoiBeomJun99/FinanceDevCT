SELECT O.ANIMAL_ID, O.NAME
FROM ANIMAL_INS I JOIN ANIMAL_OUTS O ON I.ANIMAL_ID = O.ANIMAL_ID
WHERE O.DATETIME < I.DATETIME
ORDER BY I.DATETIME