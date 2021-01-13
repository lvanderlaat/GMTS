
gmtset PS_MEDIA            = 22cx17c
gmtset MAP_FRAME_TYPE      = plain
gmtset PS_PAGE_ORIENTATION = portrait

pscoast -JM10/17 -R-87.6/-79.30/7.64/14.05 -W0.7 -Ba1f1/a1f1wSnE -G230/230/230 -S198/229/231  -K -Di -Lf-85.5/8.3/10/400 > mapa.ps
psxy /Volumes/leo_1/SISMOLOGIA/ARMUELLES/RSN/gmtxy.out -R -J -Sc.3 -W0.5 -Gred -O -K >> mapa.ps
psxy /Volumes/leo_1/SISMOLOGIA/ARMUELLES/RSN/stations.txt -R -J -St.3 -W0.5 -Gblue -O >> mapa.ps

psconvert mapa.ps -Tg
open mapa.png
