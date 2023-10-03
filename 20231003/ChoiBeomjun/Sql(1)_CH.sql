WITH RENEWEL AS (
    SELECT C.DAILY_FEE, C.CAR_TYPE, H.HISTORY_ID,
           DATEDIFF(END_DATE, START_DATE) + 1 AS PERIOD,
    CASE
      WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 90 THEN '90일 이상'
      WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 30 THEN '30일 이상'
      WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 7 THEN '7일 이상'
      ELSE 'NONE' END AS DURATION_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H JOIN CAR_RENTAL_COMPANY_CAR C ON C.CAR_ID = H.CAR_ID
WHERE C.CAR_TYPE = '트럭')

SELECT HISTORY_ID, ROUND(R.DAILY_FEE * R.PERIOD * ((100 - IFNULL(P.DISCOUNT_RATE, 0)) / 100)) AS FEE
FROM RENEWEL R LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P ON R.CAR_TYPE = P.CAR_TYPE AND R.DURATION_TYPE = P.DURATION_TYPE
ORDER BY FEE DESC, HISTORY_ID DESC