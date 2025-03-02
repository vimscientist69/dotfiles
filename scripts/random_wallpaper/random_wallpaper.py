import os
import random
import subprocess


def random_wallpaper_path(wallpaper_path: str) -> str:
    files = os.listdir(wallpaper_path)
    choice = f"{wallpaper_path}/{random.choice(files)}"
    return choice


def main():
    wallpapers_folder_path = "/Users/williamferns/.config/wallpapers"
    wallpaper = random_wallpaper_path(wallpapers_folder_path)
    subprocess.run([
        "automator",
        "-i",
        wallpaper,
        "/Users/williamferns/.config/automator/setDesktopPix.workflow"
    ])


if __name__ == "__main__":
    main()
