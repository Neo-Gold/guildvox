chdir /d C:\Users\Black Mesa\Downloads\ffmpeg-5.0.1-full_build-shared\bin
ffmpeg -loop 1 -i download.jpg -i feed1.mp3 -vf "scale=1920:1080:force_original_aspect_ratio=decrease,pad=1920:1080:-1:-1:color=black,setsar=1,format=yuv420p" -shortest -fflags +shortest output.mp4
pause