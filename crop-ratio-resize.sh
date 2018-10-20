# Converts all images in the directory to jpg, crop them to 1:1 ratio, and resize them to given size.

size='%[fx: w>h ? h : w ]'
offset_x='%[fx: w>h ? (w-h)/2 : 0 ]'
offset_y='%[fx: w>h ? 0 : (h-w)/2 ]'
viewport="${size}x${size}+${offset_x}+${offset_y}"

images="$(find . \( -iname "*.jpg" -or -iname "*.jpeg" -or -iname "*.png" -or -iname "*.tif" -or -iname "*.bmp" -or -iname "*.gif" -or -iname "*.xpm" -or -iname "*.nef" -or -iname "*.cr2" -or -iname "*.arw" \))"
resize="200x200"

for file in $images; do
    convert $file  -set option:distort:viewport "$viewport" -filter point -distort SRT 0  +repage -resize $resize "${file%.*}.jpg" ;
done
