<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset=".logo/logomark+wordmark.svg">
    <source media="(prefers-color-scheme: dark)" srcset=".logo/logomark+wordmark.svg">
    <img alt="Oh my tmux! logo and wordmark" src=".logo/logomark+wordmark.svg">
  </picture>
</p>

˗ˏˋ ★ ˎˊ˗ My self-contained, pretty and versatile tmux configuration, made with ❤️ ˗ˏˋ ★ ˎˊ˗

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://cloud.githubusercontent.com/assets/553208/19740585/85596a5a-9bbf-11e6-8aa1-7c8d9829c008.gif">
    <source media="(prefers-color-scheme: dark)" srcset="https://cloud.githubusercontent.com/assets/553208/19740585/85596a5a-9bbf-11e6-8aa1-7c8d9829c008.gif">
    <img alt="Oh my tmux! in action" src="https://cloud.githubusercontent.com/assets/553208/19740585/85596a5a-9bbf-11e6-8aa1-7c8d9829c008.gif">
  </picture>
</p>

Installation
------------

Requirements:

  - tmux **`>= 2.6`** running on Linux, macOS, OpenBSD, Windows (WSL or Cygwin)
  - awk, perl (with Time::HiRes support), grep, and sed
  - Outside of tmux, the `TERM` environment variable must be set to
    `xterm-256color`

⚠️ Before installing, you may want to backup your existing configuration.

You can install Oh my tmux! at any of the following locations:
- `~`
- `$XDG_CONFIG_HOME/tmux`
- `~/.config/tmux`

Installing in `~`:
```
$ git clone https://github.com/markheramis/.tmux.git 
$ cd .tmux
$ ./install.sh
```

Installing in `$XDG_CONFIG_HOME/tmux`:
```
$ git clone --single-branch https://github.com/markheramis/.tmux.git "/path/to/oh-my-tmux"
$ mkdir -p "$XDG_CONFIG_HOME/tmux"
$ ln -s /path/to/oh-my-tmux/.tmux.conf "$XDG_CONFIG_HOME/tmux/tmux.conf"
$ cp /path/to/oh-my-tmux/.tmux.conf.local "$XDG_CONFIG_HOME/tmux/tmux.conf.local"
```

Installing in `~/.config/tmux`:
```
$ git clone --single-branch https://github.com/markheramis/.tmux.git "/path/to/oh-my-tmux"
$ mkdir -p ~/.config/tmux
$ ln -s /path/to/oh-my-tmux/.tmux.conf ~/.config/tmux/tmux.conf
$ cp /path/to/oh-my-tmux/.tmux.conf.local ~/.config/tmux/tmux.conf.local
```
⚠️ When installing `$XDG_CONFIG_HOME/tmux` or `~/.config/tmux`, the configuration
file names don't have a leading `.` character.

🚨 **You should never alter the main `.tmux.conf` or `tmux.conf` file. If you do,
you're on your own. Instead, every customization should happen in your
`.tmux.conf.local` or `tmux.conf.local` customization file copy.**

If you're a Vim user, setting the `EDITOR` environment variable to `vim` will
enable and further customize the `vi-style` key bindings (see tmux manual).

If you're new to tmux, I recommend you to read the [tmux getting started
guide][getting-started], as well as the [tmux 3: Productive Mouse-Free
Development][bhtmux3] book by [@bphogan].

Now proceed to [adjust] your `.local` customization file copy.

[getting-started]: https://github.com/tmux/tmux/wiki/Getting-Started
[bhtmux3]: https://pragprog.com/titles/bhtmux3/tmux-3/
[@bphogan]: https://bphogan.com/
[adjust]: #configuration

Troubleshooting
---------------

  - **I believe something's not quite right**

    Please, try make sure no tmux client or server process is currently running.

    Then launch tmux with:
    ```
    $ tmux -f /dev/null -L test
    ```

    Which launches a new tmux client/server pair without loading any
    configuration.

    If the issue is still reproducing, please reach out to the tmux project for
    support.

    Otherwise, please open an issue describing what doesn't work and I'll do my
    best to address it.

  - **I tried to used `set`, `bind` and `unbind` in my `.local` customization
    file, but Oh my tmux! overwrites my preferences**

    When that happens append `#!important` to the line:

    ```
    bind c new-window -c '#{pane_current_path}' #!important
    ```

    ```
    set -g default-terminal "screen-256color" #!important
    ```

  - **Status line is broken and/or gets duplicated at the bottom of the screen**

    This could happen on Linux when the distribution provides a version of glib
    that received Unicode 9.0 upgrades (glib `>= 2.50.1`) while providing a
    version of glibc that didn't (glibc `< 2.26`). You may also configure
    `LC_CTYPE` to use an `UTF-8` locale. Typically VTE based terminal emulators
    rely on glib's `g_unichar_iswide()` function while tmux relies on glibc's
    `wcwidth()` function. When these two functions disagree, display gets messed
    up.

    This can also happen on macOS when using iTerm2 and "Use Unicode version 9
    character widths" is enabled in `Preferences... > Profiles > Text`

    For that reason, the sample `.local` customization file stopped using
    Unicode characters for which width changed in between Unicode 8.0 and 9.0
    standards, as well as Emojis.

  - **I installed Powerline and/or (patched) fonts but I can't see the Powerline
    symbols**

    **🤯 Please realize that you don't need to install [Powerline].**

    You only need fonts patched with Powerline symbols or the standalone
    `PowerlineSymbols.otf` font.

    Then make sure your `.local` customization file copy uses the [Powerline
    code points] for the
    `tmux_conf_theme_left_separator_main`,
    `tmux_conf_theme_left_separator_sub`,
    `tmux_conf_theme_right_separator_main`
    and `tmux_conf_theme_right_separator_sub` variables.

[Powerline]: https://github.com/Lokaltog/powerline
[Powerline code points]: #enabling-the-powerline-look

Features
--------

  - `C-a` acts as secondary prefix, while keeping default `C-b` prefix
  - Visual theme inspired by [Powerline][]
  - [Maximize any pane to a new window with `<prefix> +`][maximize-pane]
  - Mouse mode toggle with `<prefix> m`
  - Laptop battery status line information
  - Uptime status line information
  - Optional highlight of focused pane
  - Configurable new sessions, windows and panes behavior (to optionally retain
    the current path)
  - SSH/Mosh aware username and hostname status line information
  - SSH/Mosh aware pane splitting (with automatic reconnection to the remote
    server)
  - Copy to OS clipboard (needs `xsel`, `xclip`, or `wl-copy` on Linux)
  - Support for 4-digit hexadecimal Unicode characters
  - [PathPicker][] integration, if available
  - [Urlscan][] (preferred) or [Urlview][] integration, if available

[maximize-pane]: http://pempek.net/articles/2013/04/14/maximizing-tmux-pane-new-window/
[PathPicker]: https://facebook.github.io/PathPicker/
[Urlview]: https://packages.debian.org/stable/misc/urlview
[Urlscan]: https://github.com/firecat53/urlscan

The "Maximize any pane to a new window with `<prefix> +`" feature is different
from the builtin `resize-pane -Z` command, as it allows you to further split a maximized
pane. It's also more flexible by allowing you to maximize a pane to a new
window, then change window, then go back and the pane is still in maximized
state in its own window. You can then minimize a pane by using `<prefix> +`
either from the source window or the maximized window.

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://cloud.githubusercontent.com/assets/553208/9890858/ee3c0ca6-5c02-11e5-890e-05d825a46c92.gif">
    <source media="(prefers-color-scheme: dark)" srcset="https://cloud.githubusercontent.com/assets/553208/9890858/ee3c0ca6-5c02-11e5-890e-05d825a46c92.gif">
    <img alt="Maximizing a pane" src="https://cloud.githubusercontent.com/assets/553208/9890858/ee3c0ca6-5c02-11e5-890e-05d825a46c92.gif">
  </picture>
</p>

Mouse mode allows you to set the active window, set the active pane, resize
panes and automatically switches to copy-mode to select text.

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://cloud.githubusercontent.com/assets/553208/9890797/8dffe542-5c02-11e5-9c06-a25b452e6fcc.gif">
    <source media="(prefers-color-scheme: dark)" srcset="https://cloud.githubusercontent.com/assets/553208/9890797/8dffe542-5c02-11e5-9c06-a25b452e6fcc.gif">
    <img alt="Mouse mode" src="https://cloud.githubusercontent.com/assets/553208/9890797/8dffe542-5c02-11e5-9c06-a25b452e6fcc.gif">
  </picture>
</p>

Bindings
--------

tmux may be controlled from an attached client by using a key combination of a
prefix key, followed by a command key. This configuration uses `C-a` as a
secondary prefix while keeping `C-b` as the default prefix. In the following
list of key bindings:

| Key | Meaning |
|---|---|
| `<prefix>` | Press <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd> |
| `<prefix> c` | Press <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>, then <kbd>c</kbd> |
| `<prefix> C-c` | Press <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>, then <kbd>Ctrl</kbd> + <kbd>c</kbd> |

This configuration uses the following bindings:

| Key Binding | Description  | Overwritten by this config? |
|---|---|---|
| `<prefix> C-c` | Creates a new session | Yes |
| `<prefix> e` | Opens `~/.tmux.conf.local` with the editor defined by `$EDITOR` (defaults to `vim` when empty) | Yes |
| `<prefix> r` | Reloads the configuration | Yes |
| `<prefix> C-f` | Switches to another session by name | Yes |
| `<prefix> C-h` and `<prefix> C-l` | Navigate windows (default `<prefix> n` and `<prefix> p` are unbound) | Yes |
| `<prefix> Tab` | Brings you to the last active window | Yes |
| `<prefix> h` | Navigate to the left pane (Vim style) | Yes |
| `<prefix> j` | Navigate to the pane below (Vim style) | Yes |
| `<prefix> k` | Navigate to the pane above (Vim style) | Yes |
| `<prefix> l` | Navigate to the right pane (Vim style) | Yes |
| `<prefix> H` | Resize pane left  | Yes |
| `<prefix> J` | Resize pane down  | Yes |
| `<prefix> K` | Resize pane up    | Yes |
| `<prefix> L` | Resize pane right | Yes |
| `<prefix> <` | Swap pane to the left | Yes |
| `<prefix> >` | Swap pane to the right | Yes |
| `<prefix> +` | Maximizes the current pane to a new window | Yes |
| `<prefix> m` | Toggles mouse mode on or off | Yes |
| `<prefix> U` | Launches Urlview (if available) | Yes |
| `<prefix> F` | Launches Facebook PathPicker (if available) | Yes |
| `<prefix> Enter` | Enters copy-mode | Yes |
| `<prefix> b` | Lists the paste-buffers | Yes |
| `<prefix> p` | Pastes from the top paste-buffer | Yes |
| `<prefix> P` | Lets you choose the paste-buffer to paste from | Yes |
| `C-l` | Clears both the screen and the history | Yes |
| `<prefix> d` | Detach the current client | No |
| `<prefix> &` | Kill the current window | No |
| `<prefix> "` | Split window horizontally | No |
| `<prefix> %` | Split window vertically | No |
| `<prefix> o` | Select next pane | No |
| `<prefix> x` | Kill the current pane | No |
| `<prefix> z` | Toggle pane zoom (resize-pane -Z) | No |
| `<prefix> ,` | Rename the current window | No |
| `<prefix> .` | Move the current window | No |
| `<prefix> f` | Find window | No |
| `<prefix> w` | Choose window from a list | No |
| `<prefix> t` | Show clock | No |
| `<prefix> ?` | List all key bindings | No |
| `<prefix> :` | Enter command prompt | No |
| `<prefix> [` | Enter copy-mode | No |
| `<prefix> ]` | Paste buffer | No |
| `<prefix> n` | Select next window | No |
| `<prefix> p` | Select previous window | No |
| `<prefix> l` | Select last (previously used) window | No |
| `<prefix> 0`–`9` | Select window by number | No |

Additionally, `copy-mode-vi` matches [my own Vim configuration]

[my own Vim configuration]: https://github.com/gpakosz/.vim.git

Bindings for `copy-mode-vi`:

  | Key      | Action                                              |
  |----------|-----------------------------------------------------|
  | `v`      | Begins selection / visual mode                      |
  | `C-v`    | Toggles between blockwise visual mode and visual mode |
  | `H`      | Jumps to the start of line                          |
  | `L`      | Jumps to the end of line                            |
  | `y`      | Copies the selection to the top paste-buffer        |
  | `Escape` | Cancels the current operation                       |

It's also possible to preserve the tmux stock bindings by setting the
`tmux_conf_preserve_stock_bindings` variable to `true` in your `.local`
customization file copy.

Configuration
-------------

While this configuration tries to bring sane default settings, you may want to
customize it further to your needs.

🚨 Again, you should never alter the main `.tmux.conf` or `tmux.conf` file.
If you do, you're on your own.

Please refer to the sample `.local` customization file to know more about the
variables that allow you to alter different behaviors. Upon successful
installation, pressing `<prefix> e` will open your `.local` customization file
copy with the editor defined by the `EDITOR` environment variable (defaults to
`vim` when empty).

### Enabling the Powerline look

Powerline originated as a status-line plugin for Vim. Its popular eye-catching
look is based on the use of special symbols:

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/55afd317-150b-42f0-9ef3-fa619be7b160">
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/55afd317-150b-42f0-9ef3-fa619be7b160">
    <img alt="Powerline symbols" src="https://github.com/user-attachments/assets/55afd317-150b-42f0-9ef3-fa619be7b160">
  </picture>
</p>

To make use of these symbols, there are several options:

  - Use a font that already bundles those: this is the case of the [Source Code
    Pro][source code pro] font
  - Use a [pre-patched font][powerline patched fonts]
  - Use your preferred font along with the standalone [Powerline font][powerline
    font] (that only contains the Powerline symbols): [this highly depends on
    your operating system and your terminal emulator][terminal support], for
    instance here's a screenshot of iTerm2 configured to use
    `PowerlineSymbols.otf` for non ASCII symbols:
    <p align="center">
      <picture>
        <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/553208/62243890-8232f500-b3de-11e9-9b8c-51a5d38bdaa8.png">
        <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/553208/62243890-8232f500-b3de-11e9-9b8c-51a5d38bdaa8.png">
        <img alt="iTerm2 + Powerline font" src="https://user-images.githubusercontent.com/553208/62243890-8232f500-b3de-11e9-9b8c-51a5d38bdaa8.png">
      </picture>
    </p>

[source code pro]: https://github.com/adobe-fonts/source-code-pro/releases/latest
[powerline patched fonts]: https://github.com/powerline/fonts
[powerline font]: https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
[terminal support]: http://powerline.readthedocs.io/en/master/usage.html#usage-terminal-emulators

Then edit your `.local` customization file copy (with `<prefix> e`) and adjust
the following variables:

```
tmux_conf_theme_left_separator_main='\uE0B0'
tmux_conf_theme_left_separator_sub='\uE0B1'
tmux_conf_theme_right_separator_main='\uE0B2'
tmux_conf_theme_right_separator_sub='\uE0B3'
```

The [Powerline manual] contains further details on how to install fonts
containing the Powerline symbols.

[Powerline manual]: http://powerline.readthedocs.org/en/latest/installation.html#fonts-installation

### Configuring the status line

Edit your `.local` customization file copy (`<prefix> e`) and adjust the
`tmux_conf_theme_status_left` and `tmux_conf_theme_status_right` variables to
your liking.

This configuration supports the following builtin variables:

  - `#{battery_bar}`: horizontal battery charge bar
  - `#{battery_hbar}`: 1 character wide, horizontal battery charge bar
  - `#{battery_vbar}`: 1 character wide, vertical battery charge bar
  - `#{battery_percentage}`: battery percentage
  - `#{battery_status}`: is battery charging or discharging?
  - `#{circled_session_name}`: circled session number (from ⓪) to ⑳)
  - `#{hostname}`: SSH/Mosh aware hostname information
  - `#{hostname_ssh}`: SSH/Mosh aware hostname information, blank when not
    connected to a remote server through SSH/Mosh
  - `#{loadavg}`: load average
  - `#{pairing}`: is the current session attached to more than one client?
  - `#{pretty_pane_current_path}`: prettified `#{pane_current_path}` when its
    length is too long
  - `#{prefix}`: is prefix being depressed?
  - `#{root}`: is the current user root?
  - `#{synchronized}`: are the panes synchronized?
  - `#{uptime_y}`: uptime years
  - `#{uptime_d}`: uptime days, modulo 365 when `#{uptime_y}` is used
  - `#{uptime_h}`: uptime hours
  - `#{uptime_m}`: uptime minutes
  - `#{uptime_s}`: uptime seconds
  - `#{username}`: SSH/Mosh aware username information
  - `#{username_ssh}`: SSH aware username information, blank when not connected
    to a remote server through SSH/Mosh

Beside the variables mentioned above, the `tmux_conf_theme_status_left` and
`tmux_conf_theme_status_right` variables support the usual tmux syntax, e.g.
using `#()` to call an external command that inserts weather information
provided by [wttr.in]:
```
tmux_conf_theme_status_right='#{prefix}#{pairing}#{synchronized} #(curl -m 1 wttr.in?format=3 2>/dev/null; sleep 900) , %R , %d %b | #{username}#{root} | #{hostname} '
```
The `sleep 900` call makes sure the network request is issued at most every 15
minutes whatever the value of `status-interval`.

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://user-images.githubusercontent.com/553208/52175490-07797c00-27a5-11e9-9fb6-42eec4fe4188.png">
    <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/553208/52175490-07797c00-27a5-11e9-9fb6-42eec4fe4188.png">
    <img alt="Weather information from wttr.in" src="https://user-images.githubusercontent.com/553208/52175490-07797c00-27a5-11e9-9fb6-42eec4fe4188.png">
  </picture>
</p>

[wttr.in]: https://github.com/chubin/wttr.in#one-line-output

💡 You can also define your own custom variables by defining your own POSIX
shell functions, see the sample `.local` customization file for instructions.

Finally, remember that `tmux_conf_theme_status_left` and
`tmux_conf_theme_status_right` end up being given to tmux as `status-left` and
`status-right` which means they're passed through `strftime()`. As such, the `%`
character has a special meaning and needs to be escaped by doubling it, e.g.
```
tmux_conf_theme_status_right='#(echo foo %% bar)'
```
See also `man 3 strftime`.

### Using TPM plugins

This configuration comes with built-in [TPM] support:

  - Use the `set -g @plugin ...` syntax to enable a plugin
  - Whenever a plugin introduces a variable to be used in `status-left` or
    `status-right`, you can use it in the `tmux_conf_theme_status_left` and
    `tmux_conf_theme_status_right` variables, see instructions above 👆
  - ⚠️ Do not add `set -g @plugin 'tmux-plugins/tpm'` to any configuration file
  - ⛔️ Do not add `run '~/.tmux/plugins/tpm/tpm'` to any configuration file

⚠️ The TPM bindings differ slightly from upstream:
  - Installing plugins: `<prefix> + I`
  - Uninstalling plugins: `<prefix> + Alt + u`
  - Updating plugins: `<prefix> + u`

See the sample `.local` customization file for further instructions.

[TPM]: https://github.com/tmux-plugins/tpm

### Using Oh my tmux! on Windows

<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://github.com/user-attachments/assets/7f84a687-fb4d-4817-a445-419e63ccfac5">
    <source media="(prefers-color-scheme: dark)" srcset="https://github.com/user-attachments/assets/7f84a687-fb4d-4817-a445-419e63ccfac5">
    <img alt="Windows Terminal + WSL" src="https://github.com/user-attachments/assets/7f84a687-fb4d-4817-a445-419e63ccfac5">
  </picture>
</p>

⚠️ I don't recommend running this configuration with [Cygwin] anymore. Forking
under Cygwin is extremely slow and this configuration issues a fair amount
`run-shell` commands under the hood. As such, you will experience high CPU
usage.

Instead I recommend [Windows Subsystem for Linux][WSL] along with [Windows
Terminal]. As an alternative, you may also consider using [Mintty as a terminal
for WSL][wsltty].

[Cygwin]: https://www.cygwin.com
[WSL]: https://learn.microsoft.com/en-us/windows/wsl
[wsltty]: https://github.com/mintty/wsltty
[Windows Terminal]: https://aka.ms/terminal
