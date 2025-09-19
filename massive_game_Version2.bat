@echo off
title MASSIVE STORAGE GAME
:menu
cls
echo ================================
echo         MASSIVE STORAGE GAME
echo ================================
echo 1. Doan so
echo 2. Xo so
echo 3. Giai do
echo 4. Snake (mini)
echo 5. Pong (mini)
echo 6. Tetris (mini)
echo 7. Thoat
echo -------------------------------
set /p choice=Chon game (1-7): 

if "%choice%"=="1" goto doanso
if "%choice%"=="2" goto xoso
if "%choice%"=="3" goto giaido
if "%choice%"=="4" goto snake
if "%choice%"=="5" goto pong
if "%choice%"=="6" goto tetris
if "%choice%"=="7" exit
goto menu

:doanso
cls
setlocal enabledelayedexpansion
set /a random=%RANDOM% %% 100 + 1
set /a dem=0
echo ==== GAME DOAN SO ====
:again
set /p so=Nhap so ban doan (1-100): 
set /a dem+=1
if "%so%"=="%random%" (
    echo Chuc mung! Ban da doan dung sau %dem% lan!
    pause
    goto menu
)
if %so% LSS %random% echo So bi mat lon hon!
if %so% GTR %random% echo So bi mat nho hon!
goto again

:xoso
cls
echo ==== GAME XO SO ====
set /a so1=%RANDOM% %% 10
set /a so2=%RANDOM% %% 10
set /a so3=%RANDOM% %% 10
echo Ket qua xo so: %so1% %so2% %so3%
set /p du_doan=Doan so (VD: 1 2 3): 
if "%du_doan%"=="%so1% %so2% %so3%" (
    echo Chuc mung! Ban trung giai dac biet!
) else (
    echo Rat tiec! Chuc ban may man lan sau!
)
pause
goto menu

:giaido
cls
echo ==== GAME GIAI DO ====
echo Cau hoi: Loai chu nao bay khong can canh?
set /p traloi=Tra loi: 
if /I "%traloi%"=="Chu bay" (
    echo Chinh xac! Chu "bay" bay khong can canh!
) else (
    echo Sai roi! Dap an la "Chu bay".
)
pause
goto menu

:snake
cls
echo ==== GAME SNAKE MINI ====
echo Day la ban mo phong cuc don gian.
echo Ban la "O" di chuyen bang phim: A (trai), D (phai)
set /a pos=10
:snake_move
setlocal enabledelayedexpansion
set "row="
for /l %%i=1,1,20 do (
    if %%i==!pos! (
        set "row=!row!O"
    ) else (
        set "row=!row!-"
    )
)
echo !row!
choice /c AD /n /m "Nhan A (trai), D (phai), ESC de thoat"
if errorlevel 3 goto menu
if errorlevel 2 set /a pos+=1
if errorlevel 1 set /a pos-=1
if %pos% LSS 1 set pos=1
if %pos% GTR 20 set pos=20
goto snake_move

:pong
cls
echo ==== GAME PONG MINI ====
echo Pong don gian: Ban la "O", bong la "*"
echo Di chuyen O (A: trai, D: phai), bong tu dong
set /a pong_pos=10
set /a ball_pos=5
set /a ball_dir=1
:pong_loop
setlocal enabledelayedexpansion
set "row="
for /l %%i=1,1,20 do (
    if %%i==!pong_pos! (
        set "row=!row!O"
    ) else if %%i==!ball_pos! (
        set "row=!row!^"
    ) else (
        set "row=!row!-"
    )
)
echo !row!
ping localhost -n 1 >nul
set /a ball_pos+=ball_dir
if %ball_pos% LEQ 1 set ball_dir=1
if %ball_pos% GEQ 20 set ball_dir=-1
if %ball_pos%==%pong_pos% (
    echo Ban cham bong!
)
choice /c AD /n /m "Nhan A (trai), D (phai), ESC de thoat"
if errorlevel 3 goto menu
if errorlevel 2 set /a pong_pos+=1
if errorlevel 1 set /a pong_pos-=1
if %pong_pos% LSS 1 set pong_pos=1
if %pong_pos% GTR 20 set pong_pos=20
goto pong_loop

:tetris
cls
echo ==== GAME TETRIS MINI ====
echo Day chi la mo phong cuc don gian hinh chu nhat roi xuong.
set /a tet_pos=10
:tetris_loop
setlocal enabledelayedexpansion
for /l %%i=1,1,20 do (
    if %%i==!tet_pos! (
        echo [####]
    ) else (
        echo .
    )
)
choice /c AD /n /m "Nhan A (trai) D (phai) ESC (thoat)"
if errorlevel 3 goto menu
if errorlevel 2 set /a tet_pos+=1
if errorlevel 1 set /a tet_pos-=1
if %tet_pos% LSS 1 set tet_pos=1
if %tet_pos% GTR 20 set tet_pos=20
goto tetris_loop