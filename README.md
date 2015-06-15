# Bitmap_from_folder
I wanted to frame a print of the app I have been working on...
 
 
 This is a ruby script that will build a bitmap image using rmagic with one pixel for each file in a folder or any of its subfolders. Each filetype is assigned a color and some files are ignored (.cache).
 
 Play with it!
 Put some files/folders in -> `/imgen/folder_to_process` 
 Install your gems and run:
 `ruby run.rb`
 
 images are saved to -> `/imgen/imgen_output`
 
 cheers!
 
 
 Future Ideas 
====== 
 
colors that are complimentary

lighten / darken based on size of file

sinatra api that responds with image and json data of file colors
 
