pscoast -K -Rg -JA-84/10/3.5i -Bg -Dc -A1000 -Ggray > mapa.ps
psxy recuadro.txt -O -R -J -W1 >> mapa.ps

psconvert mapa.ps -Tf
