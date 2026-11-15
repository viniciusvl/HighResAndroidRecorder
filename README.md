# High-Resolution Android Screen Recorder

## The Problem: Why Play Store Recorders Fail at Maximum Resolution

Most screen recording apps in the Google Play Store have a critical limitation: **they cannot record at the device's maximum resolution**. Here's why and how this tool solves it:

### The Issue

Play Store apps like **AZ Screen Recorder**, **Screen Recorder**, **Mobizen**, and other alternatives use the standard `MediaProjection` API, which has built-in limitations:

- They cap recording resolution to avoid consuming too much CPU and battery
- Many default to 720p or 1080p, even if your device supports 1440p or 4K
- They downscale high-resolution displays to lower bitrates
- The encoding process is constrained by the app's own settings and limitations

### The Solution: Desktop Streaming via scrcpy

This tool bypasses these limitations by using **scrcpy**, a desktop streaming application that:

1. **Records directly from the Android device** without app-level limitations
2. **Maintains native resolution** (`--max-size=0` means no downscaling)
3. **Runs from your Windows PC**, offloading processing to your computer
4. **Captures the raw frame buffer**, not a projected surface with limitations

**Result:** Flawless 4K/1440p recordings at your device's native resolution, something Play Store apps simply cannot do.

---

## Features

A screen recorder for Android tablets controlled by keyboard shortcuts on Windows. Connect your tablet via USB, press **Ctrl+Alt+G** and recording starts; **Ctrl+Alt+S** to stop.

- Global keyboard shortcuts with no terminal needed
- Audio and visual feedback (beeps + system notifications)
- Timestamped filenames (`recording_YYYY-MM-DD_HH-mm-ss.mp4`)
- **Native device resolution** (`--max-size=0`)
- **Zero installation:** everything needed is in this repository
- No runtime dependencies on the tablet or PC

## Requirements

- Windows 10/11
- Android tablet with **USB Debugging** enabled
- USB cable

To run the `.exe`, no installation is required. To run or edit the `.ahk` script, you need [AutoHotkey v2](https://www.autohotkey.com/).

## Quick Start

1. **On your tablet**, enable USB Debugging (one-time setup):
   - Settings > About tablet > tap "Build number" 7 times
   - Settings > Developer options > enable "USB Debugging"

2. Connect the tablet to your PC. When prompted on the tablet, select "Always allow from this computer."

3. Run `HighResAndroidRecorder.exe` (or `HighResAndroidRecorder.ahk`). An icon appears in the system tray.

4. Use these shortcuts:

| Shortcut | Action | Feedback |
|---|---|---|
| `Ctrl` + `Alt` + `G` | Start recording | 2 beeps + notification |
| `Ctrl` + `Alt` + `S` | Stop recording | 1 beep + notification |

Videos are saved to `Desktop\RecordingsTablet`.

## File Structure

```
HighResAndroidRecorder/
├── HighResAndroidRecorder.ahk   # source code (AutoHotkey v2)
├── HighResAndroidRecorder.exe   # compiled executable
├── scrcpy/                      # scrcpy 4.1 + adb (Apache 2.0)
└── docs/README.txt              # original documentation
```

## How It Works

When you press `Ctrl+Alt+G`, the script runs:

```
scrcpy.exe --record="<folder>\recording_<timestamp>.mp4" --max-size=0
```

When you press `Ctrl+Alt+S`, it closes the scrcpy window, finalizing and saving the file.

## Customization

Edit `HighResAndroidRecorder.ahk`:

- **Output folder:** modify the `outDir` variable
- **Shortcuts:** `^!g` (start) and `^!s` (stop). `^` = Ctrl, `!` = Alt
- **scrcpy options:** edit the `cmd :=` line, e.g., `--video-bit-rate=16M` or `--no-audio`

To create a new `.exe`, compile the `.ahk` with Ahk2Exe (bundled with AutoHotkey) and keep it alongside the `scrcpy/` folder.

## Troubleshooting

- **Nothing happens when recording:** Run `scrcpy\adb.exe devices` to verify the tablet shows as `device`. If it shows `unauthorized`, accept the permission prompt on the tablet.
- **Error "scrcpy not found":** Ensure the `scrcpy/` folder is in the same directory as the executable.
- **SmartScreen warning:** The `.exe` is not digitally signed. Click "More info" > "Run anyway."
- **Video encoder failure:** Some devices require specifying an encoder, e.g., `--video-encoder=c2.android.avc.encoder`. List available encoders with `scrcpy --list-encoders`.

## Credits & License

Recording is powered by [scrcpy](https://github.com/Genymobile/scrcpy) (Genymobile), distributed under the Apache 2.0 license. A copy is included in `scrcpy/LICENSE.txt`.
