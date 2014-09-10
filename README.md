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

### Initializing memo
If you want to use memo feature in zshrc,
please ensure doing followings.

Making .worktrace file in home directory with vim option -x.

```
  $ vim -x .worktrace
```

Then enter your password.

```
  Enter encryption key: ****
  Enter same key again: ****
```

Ensure writing something, and save it.
Now you can use memo mode.

