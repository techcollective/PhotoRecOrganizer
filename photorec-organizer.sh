#!/bin/bash

### Config ####
recup_dir="${1%/}"
results_dir="${2%/}"
###############

#1. Sort recup.dir's by filetype
[ -d "$recup_dir" ] || {
    echo "Usage: $0 recup_dir";
    echo "Mirror files from recup_dir into recup_dir.by_ext, organized by extension";
    exit 1
};
find "$recup_dir" -type f | while read k; do
    ext="${k##*.}";
    ext_dir="$recup_dir.by_ext/$ext";
    [ -d "$ext_dir" ] || mkdir -p "$ext_dir";
    echo "${k%/*}"
    ln "$k" "$ext_dir";

done


#2. JPG: organize & move to results_dir
mkdir "$recup_dir/JPG/duplicates" "$recup_dir/JPG/by-date" "$recup_dir/JPG/no-date"
exiftool -ext JPG '-FileName<CreateDate' -d by-date/%Y/%m/%d_%H%M%S.jpg "$recup_dir/JPG/"
exiftool -ext JPG '-FileName<CreateDate' -d duplicates/%Y%m%d_%H%M%S.jpg "$recup_dir/JPG/"
mv "$recup_dir/JPG/b*" "$recup_dir/JPG/no-date/"
mv "$recup_dir/JPG/f*" "$recup_dir/JPG/no-date/"
mv "$recup_dir/JPG/t*" "$recup_dir/JPG/no-date/"

#3. MOV
mkdir "$recup_dir/MOV/duplicates" "$recup_dir/MOV/by-date" "$recup_dir/MOV/no-date"
exiftool -ext MOV '-FileName<CreateDate' -d by-date/%Y/%m/%d_%H%M%S.mov "$recup_dir/MOV/"
exiftool -ext MOV '-FileName<CreateDate' -d duplicates/%Y%m%d_%H%M%S.mov "$recup_dir/MOV/"
mv "$recup_dir/MOV/b*" "$recup_dir/MOV/no-date/"
mv "$recup_dir/MOV/f*" "$recup_dir/MOV/no-date/"
mv "$recup_dir/MOV/t*" "$recup_dir/MOV/no-date/"


#4. MP4
mkdir "$recup_dir/MP4/duplicates" "$recup_dir/MP4/by-date" "$recup_dir/MP4/no-date"
exiftool -ext MP4 '-FileName<CreateDate' -d by-date/%Y/%m/%d_%H%M%S.mp4 "$recup_dir/MP4/"
exiftool -ext MP4 '-FileName<CreateDate' -d duplicates/%Y%m%d_%H%M%S.mp4 "$recup_dir/MP4/"
mv "$recup_dir/MP4/b*" "$recup_dir/MP4/no-date/"
mv "$recup_dir/MP4/f*" "$recup_dir/MP4/no-date/"
mv "$recup_dir/MP4/t*" "$recup_dir/MP4/no-date/"

#5. Move the additional Photorec Data
mv "$recup_dir/*" "$results_dir/"
