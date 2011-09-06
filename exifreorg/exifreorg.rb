=begin
 read a list of files jpg in a dir
 when file is in ".originals" or ".picasa' then don't copy or copy where? to originals

Given I have a filepath to a jpg foo/bar/originalifename.jpg
I want to copy it and organize my fotos by exif data
to dest such that year/month/day/exif-year-month-day-cameramodel-originalfilename.jpg
for example
2011/08/0809/exif-year-month-day-cameramodel-originalfilename.jpg
let's use prefix 'exif-' for naming files
if destiination file exists with this filename then don't copy it, unless force it.
downcase filenames
When file is in foo/bar/.picasaoriginals/file.jpg
Then copy it to day/picasoriginals/exif-etc.... as above

 when model is nil then put it in unknown
=end


