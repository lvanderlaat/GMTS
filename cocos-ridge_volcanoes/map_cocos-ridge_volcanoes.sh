PS_MEDIA=$1
grd_file=$2
output=$3
region=$4
projection=$5
boundary=$6
position=$7
TMP_XY=$8
scale_ref=$9

cpt=relief
cpt_file=tmp.cpt

gmtset PS_MEDIA             = $PS_MEDIA 
gmtset FONT_ANNOT_PRIMARY	= 7p,Helvetica,black
gmtset FONT_ANNOT_SECONDARY	= 6p,Helvetica,black
gmtset FONT_LABEL			= 8p,Helvetica,black

grdgradient $grd_file -Gtmp_hillshade -A345 -N10

grd2cpt $grd_file -C$cpt > $cpt_file

out="${output}.ps"

psbasemap -K $region $projection $boundary $position > $out

grdimage -O -K -R -J $grd_file -C$cpt_file -Itmp_hillshade >> $out

psscale -O -K $scale_ref -Bxaf+l"Elevation [m]" -C$cpt_file >> $out

pscoast -O -K -R -J -W0.5 >> $out

psxy -O -R -J $TMP_XY -St.3 -Gred -W0.5 >> $out

rm tmp*
psconvert $out -Tf
rm $out
open "${output}.pdf"
