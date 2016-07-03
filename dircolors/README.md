Put this line in your .bash_profile or .bashrc or .profile

```bash
# Remember to copy your file to ~/.dircolors
# Feel free to name it whatever you want, ~/.dircolors is just an example
eval `dircolors ~/.dircolors`
```

Note that `dircolors` is a part of GNU `coreutils`. GNU/Linux distros come with coreutils.

For Mac OS X, you have to use brew or other package management to install it:
```
brew install coreutils
```

