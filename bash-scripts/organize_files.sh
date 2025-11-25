nano organize_files.sh
#!/bin/bash
mkdir -p documents images scripts archives videos
mv *.txt *.doc *.pdf documents/ 2>/dev/null
mv *.jpg *.png *.gif images/ 2>/dev/null
mv *.sh *.py scripts/ 2>/dev/null
mv *.zip *.tar *.gz archives/ 2>/dev/null
mv *.mp4 *.avi *.mkv videos/ 2>/dev/null
echo "Files organized!"
