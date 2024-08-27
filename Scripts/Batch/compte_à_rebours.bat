:: Nombre de tentative avant fermeture de la fenêtre.
set tentative=0

:Nombre

IF %tentative% geq 3 (
    cls
    echo Trop de tentatives.
    timeout /t 3 >nul
    EXIT /b
)

:: Demande à l'utilisateur de renseigner un nombre entre 50 et 100.
set /p Nombre=Un nombre compris entre 50 et 100 : 

:: Vérifie que le nombre soit renseigné.
IF "%Nombre%"=="" (
    echo Vous devez entrer un nombre.
    set /a tentative+=1
    GOTO Nombre
)

:: Vérifie que le nombre soit supérieur ou égal à 50.
IF %Nombre% lss 50 (
    echo Le nombre doit être superieur ou egal a 50.
    set /a tentative+=1
    GOTO Nombre
)

:: Vérifie que le nombre soit inférieur ou égal à 100.
IF %Nombre% gtr 100 (
    echo Le nombre doit être inferieur ou egal a 100.
    set /a tentative+=1
    GOTO Nombre
)

:: Compte à rebours
:Decompte
echo %Nombre%
set /a Nombre=%Nombre%-1
timeout /t 1 /nobreak >nul
IF %Nombre% geq 0 GOTO Decompte

PAUSE
