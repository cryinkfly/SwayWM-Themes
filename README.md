# SwayWM-Themes

This repository contains a collection of themes for the Sway window manager, designed to customize and enhance your desktop experience. It also includes configuration options to adjust the scale factor, allowing your themes to look sharp and consistent on displays with different DPI settings.

---

## Chameleon Grove Green

- **Inspiration:** Colors based on the openSUSE color palette.  
- **Description:** A dark, comfortable theme with green accents, ideal for long work sessions.  
- **Contents:** Config files, wallpapers, and color settings for Sway bars and terminals.

<div id="forest-dark-green-screenshots">
<img src="https://github.com/user-attachments/assets/003fb3c5-ba36-42f4-8e3f-a2c78e26fbc3" width="400px" height="250px">
<img src="https://github.com/user-attachments/assets/869b85d2-1845-4ae2-94a2-73678bf9641c" width="400px" height="250px">
<img src="https://github.com/user-attachments/assets/bf04fe72-f229-4882-a6b9-42890147a6ff" width="400px" height="250px">
<img src="https://github.com/user-attachments/assets/9a7c0138-b00d-4a6f-abe2-bf563946bd4d" width="400px" height="250px">
 </br></br>
</div>

- Chameleon Grove Green theme with 4K support: https://github.com/cryinkfly/SwayWM-Themes/tree/main/themes/chameleon-grove-green/xhdpi

What you also need:

- [Orchis-Green-Dark](https://www.gnome-look.org/p/1357889) -> external Link
- [ArcAurora-cursors](https://www.gnome-look.org/p/1665694) -> external Link
- [Colloid-Green-Dark](https://www.gnome-look.org/p/1661983) -> external Link
- [Wallpaper collection](https://github.com/cryinkfly/SwayWM-Themes/tree/main/wallpapers) -> internal Link

---

## Installation

After downloading or cloning the repository, copy the theme folders to the correct locations.

> [!WARNING]  
> Make sure the target directories exist before copying the files.

```
mkdir -p $HOME/.config/{dunst,foot,rofi,sway,waybar}
mkdir -p $HOME/.local/share/backgrounds
```

Some theme installation or helper scripts need execute permissions. For example:

```
chmod +x $HOME/.config/waybar/scripts/network-speed.sh
```

## Important

> [!NOTE]  
> These configurations must be adapted to your own system, especially regarding outputs and hardware setup.

For example, in my setup I have two graphics cards installed, which means multiple display outputs are available. One output is disabled because one of the GPUs is used exclusively for KVM guests.

You will likely need to adjust:

- Monitor/output names in the Sway config
- Waybar modules referencing specific interfaces or outputs
- Network interface names
- GPU-specific settings

Make sure to check your output names with:

```
swaymsg -t get_outputs
```

---

## Flatpak App Scaling (HiDPI / 4K Support)

When using a theme on high-resolution displays (e.g. 4K), native Wayland applications usually scale correctly. However, Flatpak apps may require additional configuration to scale properly under Sway.

### 🔧 Fix Flatpak Scaling Issues

Flatpak applications often run in a sandbox and may not automatically inherit your system’s scaling settings. You can fix this by setting environment variables.

**Option 1: Set Global Flatpak Scaling**

```flatpak override --user --env=GDK_SCALE=1.5```

```flatpak override --user --env=QT_SCALE_FACTOR=1.5```

Why 1.5?

- `150%` scaling ensures the `correct` physical `size` of UI elements on 4K displays.
- `100%` → everything appears too small
- `200%` → everything appears too large
- `150%` → closely matches the natural size on ~27" 4K monitors

With 1.5:

- Font sizes remain comfortably readable
- Icons stay proportional
- Window dimensions scale appropriately

Especially under `Sway + Wayland`, `1.5` is often the most realistic DPI adjustment when moving from a traditional 1440p setup to 4K.

**Option 2: Per-App Scaling Override**

If only specific apps need scaling, you can override them individually.

🎮 Example: Steam (Flatpak)

If you are using the Flatpak version of Steam, you can apply scaling like this:

```flatpak override --user com.valvesoftware.Steam --env=GDK_SCALE=2```

```flatpak override --user com.valvesoftware.Steam --env=GDK_DPI_SCALE=2```

After applying the override, fully restart Steam.

Adjust the scaling value (2 = 200%) depending on your display resolution and Sway scaling settings.

**Reset the Flatpak-Overrides**

```
latpak override --user --reset
```

or

```
flatpak override --user --reset com.valvesoftware.Steam
```
