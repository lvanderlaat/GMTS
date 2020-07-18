from os import system
import pandas as pd

grd_file = 'GMRTv3_7_20200717topo.grd'
gvp_file = 'GVP_Volcano_List_Holocene.xlsx'
xmin = -99
xmax = -79
ymin = -2
ymax = 16
# zmin = -6716.38623047
# zmax = 4028.23535156
output = 'coco_volcanoes'

margin2map_width = 8/1.5
MAP_WIDTH = 8
MARGIN = 1.6
SCALE_WIDTH = 0.7

WIDTH = MAP_WIDTH + MARGIN
height = WIDTH/(xmax-xmin)*(ymax-ymin)
map_height = MAP_WIDTH/(xmax-xmin)*(ymax-ymin)

WIDTH += 2*SCALE_WIDTH

x_topo_scale = MAP_WIDTH + 0.1
y_topo_scale = map_height/2
scale_ref = f'-Dx{x_topo_scale}/{y_topo_scale}/{map_height}/0.2'

PS_MEDIA   = f'{WIDTH}cx{height}c'
region     = f'-R{xmin}/{xmax}/{ymin}/{ymax}'
projection = f'-JM{(ymin+ymax)/2}/{MAP_WIDTH}'
boundary   = '-B5/5WSne'
position   = f'"-Xc{-SCALE_WIDTH} -Yc"'
TMP_XY     = 'tmp_xy'


df = pd.read_excel(gvp_file)

df = df[(df.Longitude >= xmin) & (df.Longitude <= xmax) &
        (df.Latitude >= ymin) & (df.Latitude <= ymax)]

df.to_csv(TMP_XY, sep=' ', columns=['Longitude', 'Latitude', 'Volcano Name'],
          header=False, index=False)

system((
    f'./map_cocos-ridge_volcanoes.sh {PS_MEDIA} {grd_file} {output} {region} '
    f'{projection} {boundary} {position} {TMP_XY} {scale_ref}'
))
