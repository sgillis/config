'''
Changes wallpaper to some random picture in the given directory.
'''

import os
from random import choice

picture_dir = '/home/san/Pictures/Wallpapers/'

def change_wallpaper(directory):
  """Changes the current wallpaper to a random wallpaper in directory"""
  # Get a list of wallpapers
  wallpapers = os.listdir(directory)
  # Choose one at random
  file_path = 'file://' + directory + choice(wallpapers)
  # Create the bash command to change the wallpaper
  command = 'gsettings set org.gnome.desktop.background picture-uri ' + file_path
  print command
  # Execute the command
  os.system(command)

if __name__=="__main__":
  change_wallpaper(picture_dir)
