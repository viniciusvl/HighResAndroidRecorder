#Requires AutoHotkey v2.0
#SingleInstance Force

scrcpyExe := A_ScriptDir . "\scrcpy\scrcpy.exe"
outDir := EnvGet("USERPROFILE") . "\Desktop\GravacoesTablet"
if !DirExist(outDir)
    DirCreate(outDir)

if !FileExist(scrcpyExe) {
    MsgBox("Nao encontrei o scrcpy em:`n" . scrcpyExe . "`n`nVerifique se a pasta 'scrcpy' esta ao lado deste programa.", "Erro", "IconX")
    ExitApp()
}

recording := false
recPID := 0

TrayTip("Gravador do Tablet", "Ctrl+Alt+G para iniciar a gravacao`nCtrl+Alt+S para parar", 1)

^!g:: {
    global recording, recPID, scrcpyExe, outDir
    if recording {
        SoundBeep(400, 150)
        return
    }
    stamp := FormatTime(, "yyyy-MM-dd_HH-mm-ss")
    file := outDir . "\gravacao_" . stamp . ".mp4"
    cmd := '"' . scrcpyExe . '" --record="' . file . '" --max-size=0'
    Run(cmd, , , &pid)
    recPID := pid
    recording := true
    SoundBeep(1000, 120)
    SoundBeep(1400, 120)
    TrayTip("Gravando...", file, 1)
}

^!s:: {
    global recording, recPID
    if !recording {
        SoundBeep(400, 150)
        return
    }
    if WinExist("ahk_pid " . recPID)
        WinClose("ahk_pid " . recPID)
    recording := false
    SoundBeep(700, 200)
    TrayTip("Gravacao parada", "Salva em Desktop\GravacoesTablet", 1)
}
