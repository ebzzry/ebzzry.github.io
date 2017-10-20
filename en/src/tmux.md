How I Roll with Tmux
====================

<div class="center">October 18, 2017</div>
<div class="center">Updated: October 18, 2017</div>

>“Furious activity is no substitute for understanding.”<br>
>―H.H. Williams

Just like with a text editor, a terminal multiplexer is one of the few tools that yields a lot of
productivity once you learn how to use it. In this article, I’ll talk about
[tmux](https://github.com/tmux/tmux)—a session manager, multiplexer, window manager, and one of the
most important pieces of software that changed the way I do computing.


<a name="toc">Table of contents</a>
-----------------------------------

- [Overview](#overview)
- [General](#general)
  + [Indexes](#indexes)
  + [Clients](#clients)
  + [Sourcing](#sourcing)
- [Windows](#windows)
  + [Movement](#windowsmovement)
  + [Control](#windowscontrol)
- [Panes](#panes)
  + [Movement](#panesmovement)
  + [Merging](#panesmerging)
- [Status bar](#statusbar)
- [Plugins](#plugins)
- [Selections](#selections)
- [Trying it out](#try)
- [Closing remarks](#closingremarks)


<a name="overview">Overview</a>
-------------------------------

For a long time, I have used [GNU Screen](https://www.gnu.org/software/screen/) for
multiplexing. There was such an exhilerating feeling when you lose connection to a host, only to
discover that the program that you ran on screen was still running.

However, when I discovered tmux, I quickly realized how much I was missing. Both tmux and screen,
are multiplexers, but somehow they are addressing different problems. In my personal case, tmux gave
me what I sorely missed from screen.

In this article, I will walk you through my configuration and give you a rough idea how I work with
tmux.


<a name="general">General</a>
-----------------------------

It is a good rule of thumb to start with the more general aspects of a configuration, before moving
on to the more specific ones. This section will look at some of those settings.


### <a name="indexes">Indexes</a>

```
set-option -g default-shell $SHELL

set -g base-index 1
setw -g pane-base-index 1
set -g history-limit 100000

unbind C-b
bind-key C-z send-prefix
set-option -g prefix C-z
```

This sets the the initial window number to start at 1, instead of 0; it makes it easier to switch
to a specific window, later. This also sets the history limit and the prefix key. I unbound
<kbd>C-b</kbd> because it is too damn important for Emacs and Zsh use.


### <a name="clients">Clients</a>

```
bind-key D detach-client
bind-key b choose-tree
bind-key n new-session -c "#{pane_current_path}"
bind-key @ setw synchronize-panes
```

This binds several keys to detach the current session, select a session from a tree chooser. The
<kbd>C-z @</kbd> key enables multiple panes in one window, to receive the same keyboard input. This is very
useful when troubleshooting remote connections simultaneously.


### <a name="sourcing">Sourcing</a>

```
bind-key . source-file ~/.tmux.conf
bind-key r move-window -r \; setw automatic-rename
bind-key x kill-pane
bind-key & kill-window \; move-window -r \; setw automatic-rename
```

When one kills a window between the first and the last windows, the numbering goes out of order. The
<kbd>C-z r</kbd> fixes that. I also rebound <kbd>C-z x</kbd> and <kbd>C-z &</kbd> to kill panes and
windows, respectively, without user prompts.


<a name="windows">Windows</a>
-----------------------------

Windows are the equivalent of browser tabs in tmux. It organizes sessions into subsessions.


### <a name="windowsmovement">Movement</a>

```
bind-key -n C-PPage previous-window
bind-key -n C-NPage next-window
bind-key -n S-left swap-window -t -1
bind-key -n S-right swap-window -t +1

bind-key -n M-1 select-window -t 1
bind-key -n M-2 select-window -t 2
bind-key -n M-3 select-window -t 3
bind-key -n M-4 select-window -t 4
bind-key -n M-5 select-window -t 5
bind-key -n M-6 select-window -t 6
bind-key -n M-7 select-window -t 7
bind-key -n M-8 select-window -t 8
bind-key -n M-9 select-window -t 9
```

We bound <kbd>C-PageUp</kbd> and <kbd>C-PageDown</kbd>, to switch windows, backwards and forwards,
respectively. We also bound <kbd>S-Left</kbd> and <kbd>S-Right</kbd>, to swap windows to the left
and to the right, respectively.

To quickly switch to specific windows, we bound several keys to <kbd>Meta</kbd> or <kbd>Alt</kbd> key.


### <a name="windowscontrol">Control</a>

```bash
bind-key c new-window -c "#{pane_current_path}"
bind-key C new-window -c ~

bind-key '"' split-window -v -c "#{pane_current_path}"
bind-key % split-window -h -c "#{pane_current_path}"
```

This binds keys to start a new session from the current working directory or from the home
directory. This also binds keys to split the view vertically or horizontally, with the current
working directory as a starting point.


<a name="panes">Panes</a>
-------------------------

Panes are the subdivisions of windows. They are similar to page frames in the context of web browsers.


### <a name="panesmovement">Movement</a>

```
bind-key -n C-Left select-pane -t :.-
bind-key -n C-Right select-pane -t :.+
bind-key -n C-Up swap-pane -U
bind-key -n C-Down swap-pane -D

bind-key 0 select-pane -t 0
bind-key 1 select-pane -t 1
bind-key 2 select-pane -t 2
bind-key 3 select-pane -t 3
bind-key 4 select-pane -t 4
bind-key 5 select-pane -t 5
bind-key 6 select-pane -t 6
bind-key 7 select-pane -t 7
bind-key 8 select-pane -t 8
bind-key 9 select-pane -t 9
```

We bound <kbd>C-Left</kbd> and <kbd>C-Right</kbd> to select panes, backwards and forwards,
respectively. We also bound <kbd>C-Up</kbd> and <kbd>C-Down</kbd>, to swap panes backwards and
forwards, respectively.

The other keys allow us to switch to specific panes.


### <a name="panesmerging">Merging</a>

```
bind-key m command-prompt -p "Merge pane to:"  "join-pane -t '%%'"
bind-key M command-prompt -p "Merge pane from:"  "join-pane -s '%%'"
bind-key h select-pane -m
```

This binds <kbd>C-z m</kbd> and <kbd>C-z M</kbd> to merge panes to and from, a specific window,
respectively. We also bound <kbd>C-z h</kbd> to highlight the borders of the current pane.


<a name="statusbar">Status bar</a>
----------------------------------

The status bar provides a lot of feedback, and we can also customize it. I set up mine as such:

```
set-option -g status-position bottom
set -g status-bg black
set -g status-fg white
set -g window-status-current-bg black
set -g window-status-current-fg blue
set -g window-status-current-attr bold
set -g status-interval 60
set -g status-left ' ★ '
set -g status-right-length 30
set -g status-right-attr bright
set -g status-right '%a %b %0d'
```

This displays the status bar on the bottom of the terminal, and shows all the windows starting from
1, while displaying the date on the right.


<a name="plugins">Plugins</a>
-----------------------------

I use several plugins to supplement my configuration. It ranges from the plugin manager, itself to
clipboard control.

    set -g @plugin 'tmux-plugins/tpm'

Loads the plugin manager itself.

    set -g @plugin 'tmux-plugins/tmux-resurrect'

Provides the keys <kbd>C-z C-s</kbd> and <kbd>C-z C-r</kbd> to save and restore sessions,
respectively.

    set -g @plugin 'tmux-plugins/tmux-continuum'

Complements tmux-resurrect by automatically restoring sessions on your initial tmux start up.

    set -g @plugin 'tmux-plugins/tmux-yank'

Adds a <kbd>y</kbd> key while in copy mode—<kbd>C-z [</kbd>—to put the current selection to the
clipboard.

    set -g @continuum-restore 'on'
    run '~/.tmux/plugins/tpm/tpm'

Loads the saved sessions on startup and runs the plugin manager.

To install all the plugins, press <kbd>C-z I</kbd>.


<a name="selections">Selection</a>
----------------------------------

With tmux, I can have access to three selections at once: the `PRIMARY`, `CLIPBOARD`, and the
tmux selections.

The `PRIMARY` selection is the one involved when you highlight something with your
(mouse) pointer. You can extract the contents using Middle-click or <kbd>Shift+Insert</kbd>.

The `CLIPBOARD` selection is the one involved when you explicity make a request to have something
copied, usually done with <kbd>C-c</kbd>, Right-click Copy, or `Edit > Copy`, with graphical
applications, like web browsers. You can extract the contents using <kbd>C-v</kbd>, Right-click
Paste, or `Edit > Paste`.

The tmux selection is the one involved when you enter copy mode—<kbd>C-z [</kbd>—make a selection
with <kbd>C-Space</kbd> and the movement keys, then copy the contents using <kbd>M-w</kbd>. You can
extract the contents by pressing <kbd>C-z ]</kbd>.

With tmux, I no longer have to use the (mouse) pointer to manipulate my selections.


<a name="try">Trying it out</a>
-------------------------------

If you want to play with these settings, you may download the config file to your system. But first,
let’s backup your existing configuration:

    $ mv ~/.tmux.conf ~/.tmux.conf.backup

Then, kill tmux:

    $ killall tmux

Then, let’s then install the config file:

    $ curl -SL -o ~/.tmux.conf https://raw.githubusercontent.com/ebzzry/dotfiles/master/tmux/.tmux.conf

Finally, restart tmux

    $ tmux

If tmux complains that you are missing some plugins, press <kbd>C-z I</kbd>.


<a name="closingremarks">Closing remarks</a>
--------------------------------------------

Tmux is one of the tools that one must be using when working with the terminal and command line. It
enables workflow that would otherwise be difficult to do with other multiplexers, or very difficult
to do with regular non-managed sessions. For the rest of the definitions, visit the repo
[here](https://github.com/ebzzry/dotfiles/tree/master/tmux/.tmux.conf).