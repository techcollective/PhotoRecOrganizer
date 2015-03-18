# PhotoRec Organizer
The PhotoRec Organizer helps to automate the oft-tedious process of sorting through raw file recovery from PhotoRec.
This tool does the following:
- sorts all files in recup_dir.* into folders based on their file extension
- sorts JPG, MP4, and MOV files into year/month folders, and renames files with date, based on exiftool's CreateDate property

## Usage
	photorecorganizer.sh /path/to/photorec_results /path/to/copy/organized/results


