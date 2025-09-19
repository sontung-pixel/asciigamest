@echo off
setlocal enabledelayedexpansion

:: ====== GLOBAL GAME STATE ======
set "area=Village"

:: --- Village Map ---
set "v.mapw=20"
set "v.maph=12"
set "v.px=2"
set "v.py=2"
set "v.hp=25"
set "v.maxhp=25"
set "v.atk=4"
set "v.gold=0"
set "v.weapon=Stick"
set "v.inv="
set "v.quest=Find the Ancient Gem"
set "v.gemx=17"
set "v.gemy=10"
set "v.gemfound=0"
set "v.itemx=8"
set "v.itemy=4"
set "v.itemfound=0"
set "v.spikex=5"
set "v.spikey=7"
set "v.monsterx=15"
set "v.monstery=5"
set "v.monsterhp=14"
set "v.monsteralive=1"
set "v.npcx=3"
set "v.npcy=11"
set "v.shopx=10"
set "v.shopy=2"
set "v.questx=18"
set "v.questy=2"
set "v.dangerx=6"
set "v.dangery=9"
set "v.goldx=12"
set "v.goldy=8"
set "v.goldfound=0"
set "v.gatewayx=20"
set "v.gatewayy=12"
set "v.gatewayopen=0"

:: --- Forest Map ---
set "f.mapw=20"
set "f.maph=12"
set "f.px=2"
set "f.py=2"
set "f.hp=25"
set "f.maxhp=25"
set "f.atk=5"
set "f.gold=0"
set "f.weapon=Wood Sword"
set "f.inv="
set "f.quest="
set "f.gemx=10"
set "f.gemy=5"
set "f.gemfound=0"
set "f.itemx=6"
set "f.itemy=8"
set "f.itemfound=0"
set "f.spikex=4"
set "f.spikey=7"
set "f.monsterx=14"
set "f.monstery=6"
set "f.monsterhp=18"
set "f.monsteralive=1"
set "f.tree1x=5"
set "f.tree1y=3"
set "f.tree2x=12"
set "f.tree2y=9"
set "f.tree3x=17"
set "f.tree3y=4"
set "f.gatewayx=20"
set "f.gatewayy=12"
set "f.gatewayopen=1"

:: --- Cave Map ---
set "c.mapw=20"
set "c.maph=12"
set "c.px=2"
set "c.py=2"
set "c.hp=25"
set "c.maxhp=25"
set "c.atk=6"
set "c.gold=0"
set "c.weapon=Iron Sword"
set "c.inv="
set "c.quest="
set "c.gemx=15"
set "c.gemy=10"
set "c.gemfound=0"
set "c.itemx=9"
set "c.itemy=6"
set "c.itemfound=0"
set "c.monsterx=10"
set "c.monstery=5"
set "c.monsterhp=25"
set "c.monsteralive=1"
set "c.rock1x=6"
set "c.rock1y=3"
set "c.rock2x=13"
set "c.rock2y=8"
set "c.rock3x=17"
set "c.rock3y=7"
set "c.gatewayx=20"
set "c.gatewayy=12"
set "c.gatewayopen=1"

:: ====== MAIN GAME LOOP ======
:main
call :load_area
call :draw_map
echo.
echo Area: !area!
echo HP: !hp!/!maxhp!  Weapon: !weapon!  Gold: !gold!
echo Inventory: !inv!
if "!quest!" NEQ "" echo Quest: !quest!
if "!gemfound!"=="1" set "quest=Return to the NPC for your reward!"
echo.
set /p "cmd=Move (W/A/S/D), Q=Quit: "
set "cmd=!cmd:~0,1!"
if /i "!cmd!"=="q" exit /b
if /i "!cmd!"=="w" call :move 0 -1
if /i "!cmd!"=="a" call :move -1 0
if /i "!cmd!"=="s" call :move 0 1
if /i "!cmd!"=="d" call :move 1 0

:: Events
if "!px!"=="!gemx!" if "!py!"=="!gemy!" if "!gemfound!"=="0" (
    echo You found the Gem!
    set "gemfound=1"
    set "inv=!inv!Gem,"
    timeout /t 2 >nul
)
if "!px!"=="!monsterx!" if "!py!"=="!monstery!" if "!monsteralive!"=="1" call :fight_monster
if "!px!"=="!gatewayx!" if "!py!"=="!gatewayy!" (
    if "!gatewayopen!"=="1" call :gateway else echo The gateway is locked! Defeat the monster first.
)
goto main

:: ====== FUNCTIONS ======
:load_area
for %%V in (mapw maph hp maxhp atk gold weapon inv quest gemx gemy gemfound itemx itemy itemfound spikex spikey monsterx monstery monsterhp monsteralive npcx npcy shopx shopy questx questy dangerx dangery goldx goldy goldfound gatewayx gatewayy) do (
    set "%%V=!%area:~0,1%.%%V!"
)
goto :eof

:draw_map
cls
if "!area!"=="Village" set "border=V"
if "!area!"=="Forest" set "border=F"
if "!area!"=="Cave" set "border=C"

:: Top border
set "line="
for /l %%i in (1,1,!mapw!) do set "line=!line!."
echo +%border%!line!%border%+

:: Rows
for /l %%y in (1,1,!maph!) do (
    set "row=%border%"
    for /l %%x in (1,1,!mapw!) do (
        set "cell=."
        if "!px!"=="%%x" if "!py!"=="%%y" set "cell=#"
        if "!gemx!"=="%%x" if "!gemy!"=="%%y" if "!gemfound!"=="0" set "cell=*"
        if "!itemx!"=="%%x" if "!itemy!"=="%%y" if "!itemfound!"=="0" set "cell=!"
        if "!spikex!"=="%%x" if "!spikey!"=="%%y" set "cell=^"
        if "!monsterx!"=="%%x" if "!monstery!"=="%%y" if "!monsteralive!"=="1" set "cell=@"
        if "!npcx!"=="%%x" if "!npcy!"=="%%y" set "cell=\""
        if "!shopx!"=="%%x" if "!shopy!"=="%%y" set "cell=S"
        if "!questx!"=="%%x" if "!questy!"=="%%y" set "cell=?"
        if "!dangerx!"=="%%x" if "!dangery!"=="%%y" set "cell=!!"
        if "!goldx!"=="%%x" if "!goldy!"=="%%y" if "!goldfound!"=="0" set "cell=="
        if "!gatewayx!"=="%%x" if "!gatewayy!"=="%%y" set "cell=??"

        :: Forest trees
        if "!area!"=="Forest" (
            if "!tree1x!"=="%%x" if "!tree1y!"=="%%y" set "cell=%"
            if "!tree2x!"=="%%x" if "!tree2y!"=="%%y" set "cell=%"
            if "!tree3x!"=="%%x" if "!tree3y!"=="%%y" set "cell=%"
        )

        :: Cave rocks
        if "!area!"=="Cave" (
            if "!rock1x!"=="%%x" if "!rock1y!"=="%%y" set "cell=#"
            if "!rock2x!"=="%%x" if "!rock2y!"=="%%y" set "cell=#"
            if "!rock3x!"=="%%x" if "!rock3y!"=="%%y" set "cell=#"
        )

        set "row=!row!!cell!"
    )
    set "row=!row!!border!"
    echo !row!
)

:: Bottom border
echo +%border%!line!%border%+
goto :eof

:move
setlocal enabledelayedexpansion
set "dx=%1"
set "dy=%2"
set /a "nx=px+dx, ny=py+dy"
if !nx! LSS 1 set "nx=1"
if !nx! GTR !mapw! set "nx=!mapw!"
if !ny! LSS 1 set "ny=1"
if !ny! GTR !maph! set "ny=!maph!"
endlocal & set "px=%nx%" & set "py=%ny%"
goto :eof

:gateway
echo Choose your destination: F=Forest, C=Cave, B=Back
set /p "dest=Choice: "
if /i "!dest!"=="f" set "area=Forest"
if /i "!dest!"=="c" set "area=Cave"
if /i "!dest!"=="b" set "area=Village"
goto main

:fight_monster
echo A wild monster appears!
:monster_loop
echo Monster HP: !monsterhp!
echo Your HP: !hp!
set /p "action=[A]ttack or [R]un: "
if /i "!action!"=="a" (
    set /a "dmg=5+!random!%%3"
    echo You dealt !dmg! damage!
    set /a "monsterhp-=dmg"
    if !monsterhp! LEQ 0 (
        echo You defeated the monster!
        set "monsteralive=0"
        set "gatewayopen=1"
        timeout /t 2 >nul
        goto :eof
    )
    timeout /t 2 >nul
    goto monster_loop
)
echo You ran away!
goto :eof

:show_inventory
echo Inventory: !inv!
timeout /t 2 >nul
goto :eof
