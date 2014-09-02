fishline
========

**Powerline prompt for Fish Shell in Fish Shell.**

![fishline_preview](https://raw.githubusercontent.com/0rax/fishline/screenshots/prompt.png "Fishline Preview")

Install
-------
Clone fishline where you want:

`git clone https://github.com/0rax/fishline.git/ ~/.config/fish/`

Set in your `config.fish` this fishline path and source it.
```sh
set FLINE_PATH $HOME/.config/fish/fishline
source $FLINE_PATH/fishline.fish
```

Now call the fishline function with your last status in your `fish_prompt` function
```sh
function fish_prompt
    fishline $status
end
```

[More informations about installation and configuration availlable in the wiki.](Home)