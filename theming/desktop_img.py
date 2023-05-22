"""
taken from pywal
"""

import os
import sys
import subprocess

HOME="/Users/ml"

def set_mac_wallpaper(img):
    """Set the wallpaper on macOS."""
    db_file = "Library/Application Support/Dock/desktoppicture.db"
    db_path = os.path.join(HOME, db_file)

    # Put the image path in the database
    sql = "insert into data values(\"%s\"); " % img
    subprocess.call(["sqlite3", db_path, sql])

    # Get the index of the new entry
    sql = "select max(rowid) from data;"
    new_entry = subprocess.check_output(["sqlite3", db_path, sql])
    new_entry = new_entry.decode('utf8').strip('\n')

    # Get all picture ids (monitor/space pairs)
    get_pics_cmd = ['sqlite3', db_path, "select rowid from pictures;"]
    pictures = subprocess.check_output(get_pics_cmd)
    pictures = pictures.decode('utf8').split('\n')

    # Clear all existing preferences
    sql += "delete from preferences; "

    # Write all pictures to the new image
    for pic in pictures:
        if pic:
            sql += 'insert into preferences (key, data_id, picture_id) '
            sql += 'values(1, %s, %s); ' % (new_entry, pic)

    subprocess.call(["sqlite3", db_path, sql])

    # Kill the dock to fix issues with cached wallpapers.
    # macOS caches wallpapers and if a wallpaper is set that shares
    # the filename with a cached wallpaper, the cached wallpaper is
    # used instead.

    # i don't think i need this

    subprocess.call(["killall", "Dock"])

if sys.argv[1] == 'light':
    set_mac_wallpaper('/Users/ml/Downloads/wallhaven-5785m3_3840x2160.png')
else:
    set_mac_wallpaper('/System/Library/Desktop Pictures/Solid Colors/Blue Violet.png')
