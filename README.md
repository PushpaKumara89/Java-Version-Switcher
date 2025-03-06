# Java Version Switcher (jvs.bat)

This is a simple Windows batch script to manage multiple Java versions installed in `C:\Program Files\Java`. It allows you to list available Java versions, switch between them, and check the currently active version.

## 📌 Features
- **List** all installed Java versions
- **Switch** between different Java versions
- **Check** the currently active Java version
- **Persistent JAVA_HOME and PATH updates**

## 🚀 Installation
1. Download or copy `jvs.bat` to a directory included in your `PATH` (e.g., `C:\Windows` or `C:\Users\YourUser\scripts`).
2. Open a command prompt and type `jvs --help` to verify the script is accessible.

## 📖 Usage
### 1️⃣ List available Java versions
```sh
jvs list
```
Example output:
```
Available Java versions:
  jdk-11
  jdk-17
  jdk-21
```

### 2️⃣ Switch to a specific Java version
```sh
jvs use jdk-17 
```
This will:
- Set `JAVA_HOME` to `C:\Program Files\Java\jdk-17`
- Update `PATH` to prioritize `jdk-17/bin`
- Apply changes immediately and persist them for future sessions

### 3️⃣ Check the currently active Java version
```sh
jvs used
```
Example output:
```
java version "17.0.1" 2021-10-19 LTS
Java(TM) SE Runtime Environment (build 17.0.1+12)
Java HotSpot(TM) 64-Bit Server VM (build 17.0.1+12, mixed mode)
```

### 4️⃣ Help command
```sh
jvs --help
```
Displays usage instructions.

## ⚠️ Notes
- **Terminal Restart**: Changes made with `setx` apply to new terminal sessions. To use the new Java version immediately, open a **new command prompt**.
- **Custom Java Path**: The script assumes Java installations are in `C:\Program Files\Java`. If your Java versions are installed elsewhere, modify `jvs.bat` accordingly.

## 🛠️ Troubleshooting
- **Java version not found**: Ensure the specified Java version exists in `C:\Program Files\Java`.
- **Path issues**: If switching Java versions does not work, manually check your `PATH` with:
  ```sh
  echo %PATH%
  ```
- **Multiple Java paths**: The script automatically removes old Java paths before adding a new one, preventing duplicate entries.

## 📜 License
MIT License
---
**Enjoy hassle-free Java version switching!** 🎯

