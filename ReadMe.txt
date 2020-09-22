              Floppy Imaging Information

Caution! This program can destroy any
information on a floppy disk!!!

NOTE: The support files included MUST be in present in
the directory with the project or executable including:
   1. Save.bat
   2. Restore.bat
   3. Format.bat
   4. Wipe.bat
   5. FddImage.com
   6. Dosfat
   7. ReadMe.txt
Do not attemp to run program from a floppy or in the
root directory of your hard disk!
   
CONTROLS:

Save Floppy Image - Archives an image of the disk in
drive A:  Disk must contain valid formatting. Name the
image though common dialog. Does NO writing to disk.
Files are stored in this directory with the ".img" ext. 

Restore Image - Restores selected image to the disk in 
drive A:  Disk must be formatted and contain NO bad
sectors. All information currently on disk will be lost.
Images are files (1.40MB) in this directory with the
extension ".img". Use Windows Format to verify that 
there are no bad sectors on the disk before using it
to store a disk image.

Wipe Data - Creates a disk image from a CLEAN Dos boot/
fat sector and a generated file of Hex:00 characters.
This character is used by Dos to erase fat entries. All
data on disk will be erased including second copy fat
entries and boot records. This resembles formatting
but DOES NOT mark bad sectors. Disk must have valid
formatting and no bad sectors. To mark bad sectors use
the Windows Format.

Remove All Data and Formatting - Creates a disk image
from ALL Hex:00 characters and writes it to the disk
in drive A:, all data and formatting will be lost.
Disk must contain valid Dos format.  MUST be reformatted
by Windows before reuse. Will contain NO filesystem.

Windows Format - Opens the Windows format dialog.
To be sure that wiped or unformatted disks have no
bad sectors and can reliably read and store information
always reformat wiped or unformatted disks before
reusuing.

CAUTION: While I have tested these functions, I will in
no way be responsible for damages. Use at your own risk.
