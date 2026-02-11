chdir /d C:\Users\Black Mesa\Downloads\ffmpeg-5.0.1-full_build-shared\bin
set countfiles=0
:while1
if %countfiles% leq 360 (
    ffmpeg.exe -f dshow -t 240 -i audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{C7416F91-0DD0-4133-9ADD-1019462FDB50}" -acodec libmp3lame feed%countfiles%.mp3
    rem change countfile here
    set /a countfiles+=1
    goto :while1
)pause