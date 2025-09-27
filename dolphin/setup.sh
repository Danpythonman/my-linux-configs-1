# Installs the Dolphin file manager and a dark theme for it, editing its
# .desktop entry and the local profile to use that theme.

sudo apt install dolphin qt5-style-kvantum qt5ct breeze-icon-theme

echo 'export QT_QPA_PLATFORMTHEME=qt5ct' >> ~/.profile

icon_path=$(realpath dolphin/Dolphin_icon.png)
sed -i "s|^Icon=.*|Icon=$icon_path|" /usr/share/applications/org.kde.dolphin.desktop

qss_path=$(realpath dolphin/dolphin.qss)
sed -i "s|^Exec=.*|Exec=dolhpin %u -stylesheet $qss_path|" /usr/share/applications/org.kde.dolphin.desktop
