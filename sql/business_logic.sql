

use Mandat_Database
GO
-- i creatd this func to avoid multiple lines of code
    Create or alter FUNCTION student_result(@status NVARCHAR(50))
    RETURNS INT
    as 
    BEGIN 
        DECLARE @COUNT INT;
        IF @status in ('Grant','Kontrakt','Yiqilgan')
            SELECT @COUNT = COUNT(*) from Mandat WHERE Natija = @status
        ELSE
            SELECT @COUNT = COUNT(*) from Mandat

        RETURN @COUNT
    END;
go
with Status_Percentage as(

    -- Percentage of students who entered on grant, contract and failed
    SELECT  
        CAST(ROUND((dbo.student_result(N'Grant') * 100.0/dbo.student_result(N'all')),1) as float) as [Grantga_kirganlar],
        CAST(ROUND((dbo.student_result(N'Kontrakt') * 100.0/dbo.student_result(N'all')),1) as float) as [Kontraktga_kirganlar],
        CAST(ROUND((dbo.student_result(N'Yiqilgan') * 100.0/dbo.student_result(N'all')),1) as float) as [Yiqilganlar]
),Top_Universities as(
    -- Universiy rating
    SELECT  
            Top 1 Universitet,
            Cast(Round(AVG(Ball),1)as Float) as [Top_Rating]
    from Mandat
    WHERE Natija = 'Grant'
    GROUP BY Universitet
    ORDER BY Top_Rating DESC

),failed_student_with_topGrade as(
    -- tbl secondary student (failed with top grade)

    SELECT 
            Top 1 Ism_Sharif,
            Max(Ball) as Ball
    from Mandat
    WHERE Natija = 'Yiqilgan' AND Mutahasislik = 'Iqtisodiyot'
    GROUP BY Ism_Sharif
    ORDER BY Ball DESC
),Entry_Grade_Uzbek as (
    -- entry grade for grand uzbek

    select
            Top 1 Ball as [Grand_uzbek]
    from Mandat
    WHERE Natija = 'Grant' AND Til = 'O''zbekcha' -- i used ' to avoid error i think this error encoding problem or disadvantage of sql
    ORDER BY Ball
),Entry_Grade_russian as(
    
    -- entry grade for grand russian
    select
            Top 1 Ball as [Grand_ruscha]
    from Mandat
    WHERE Natija = 'Grant' AND Til = 'Русский'
    ORDER BY Ball
)


SELECT 
        S.Grantga_kirganlar as [Grandga Kirganlar Foizi],
        S.Kontraktga_kirganlar as [Kontrakt Kirganlar Foziri],
        S.Yiqilganlar as [Yiqilganlar Foizi],
        T.Universitet as [Talab Kuchli Universitet],
        F.Ism_Sharif as [Eng Yuqori bal bilan ham yiqilgan inson],
        EU.Grand_uzbek as [Grandga ilinish Bali Uzbek],
        ER.Grand_ruscha as [Grandga ilinish Bali Rus]

        
FROM Status_Percentage as S,Top_Universities as T,failed_student_with_topGrade as F,Entry_Grade_Uzbek as EU,Entry_Grade_russian as ER



