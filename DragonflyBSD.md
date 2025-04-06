# Configuring DragonFlyBSD and Installing the Calm Window Manager (CWM)

This guide walks you through configuring DragonFlyBSD and installing the Calm Window Manager (CWM).

## Prerequisites
- A system with DragonFlyBSD installed.
- Internet access for downloading packages.

---

## Step 1: Configure DragonFlyBSD and install the Xorg

1. **Log in as Root or a User with Sudo Privileges **
   After logging in, ensure you have root privileges to perform system updates and installations.

2. **Update the System**
   Before installing any packages, update the package repository:
   ```sh
   pkg update
   ```

3. **Upgrade Installed Packages**
   To ensure your system has the latest updates and security patches, run:
   ```sh
   pkg upgrade
   ```

4. **Install Basic Tools** (Optional)
   Depending on your needs, you may want to install some utilities like `nano` or `vim` for editing configuration files:
   ```sh
   pkg install nano
   ```
---

## Step 2: Install Xorg

1. **Install the Xorg Server**
   CWM requires an X server to function. Install it with:
   ```sh
   pkg install xorg
   ```

2. **Enable dbus and hald Services**
   To ensure Xorg runs smoothly, enable and start the necessary services:
   ```sh
   echo 'dbus_enable="YES"' >> /etc/rc.conf
   echo 'hald_enable="YES"' >> /etc/rc.conf
   service dbus start
   service hald start
   ```

3. **Test Xorg**
   Run the following command to test your Xorg setup:
   ```sh
   startx
   ```
   If the test is successful, proceed to the next step. If not, troubleshoot your Xorg configuration.

4. **Load a Kernel module**

   Run this command as root:
   ```sh
   kldload i915
   ```
---

## Step 3: Install CWM

1. **Install CWM**
   Install the Calm Window Manager using the package manager:
   ```sh
   pkg install cwm
   ```

2. **Configure CWM**
   CWM reads its configuration from the `~/.cwmrc` file. Create and edit this file to customize your setup:
   ```sh
   nano ~/.cwmrc
   ```
   Here is an example configuration:
   ```
   # Example ~/.cwmrc configuration
   # Set up key bindings
   bind-key CM-Return "xterm"
   bind-key CM-w "firefox"
   bind-key CM-q "quit"

   # Set appearance
   color activeborder blue
   color inactiveborder gray
   ```

3. **Set CWM as Default Window Manager**
   To start CWM automatically, create or edit the `~/.xinitrc` file:
   ```sh
   echo "exec cwm" > ~/.xinitrc
   ```

4. **Start CWM**
   Launch CWM by running:
   ```sh
   startx
   ```

---

## Additional Notes
- For detailed configuration options, refer to the [CWM manual](https://man.openbsd.org/cwm).
- If you encounter issues, check the logs in `/var/log/Xorg.0.log` or run `dmesg` for system messages.

Happy DragonflyBSD computing!
