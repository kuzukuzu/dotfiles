HOW TO INSTALL
====================

## Initializations
### General initialization
Execute following commands.

```
$ git submodule init
$ git submodule update
$ ./install.sh
```

Now initializing process finished.

### Initializing vim
Execute following command in vim command mode.

```
:NeoBundleInstall
```

Now vim libraries are enabled.

### Setting zsh as login shell
Firstly, check available shells.

```
$ cat /etc/shells
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```

If you find zsh in list, you can set zsh as login shell.

```
chsh -s /bin/zsh
```

When zsh are not in list, ensure to install it.
And finally, relaunch your restart your terminal.

