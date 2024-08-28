mkdir -p output

original_filename=$(basename -- "$1")
extension="${original_filename##*.}"
filename="${original_filename%.*}"
lut_location=~/batch-converter/FiLMiC_deHLG_V3.cube
lut_location_relative=$(realpath -s --relative-to="." $lut_location)

colorspace=$(ffprobe -v error -show_format -select_streams v:0 -show_entries stream=color_space -of default=noprint_wrappers=1 "$original_filename" | grep color_space)
echo $colorspace " = " $original_filename

if [[ $colorspace == "color_space=bt2020nc" ]]
then
    ffmpeg -y -i "$original_filename" -vf "pad=ih*16/9:ih:(iw-ow)/2:0, lut3d=$lut_location_relative:interp=trilinear" -q:v 0 -colorspace 1 -color_primaries 1 -color_trc 1 "output/$filename.mp4"
else
    ffmpeg -y -i "$original_filename" -vf "pad=ih*16/9:ih:(iw-ow)/2:0" -q:v 0 -colorspace 1 -color_primaries 1 -color_trc 1 "output/$filename.mp4"
fi
