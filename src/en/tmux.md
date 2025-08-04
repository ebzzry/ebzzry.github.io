---
title: How I Use Tmux
keywords: tmux, configuration, setup, settings, linux, macos
image: https://ebzzry.com/images/site/lysander-yuen-wk833OrQLJE-unsplash-1008x250.jpg
---
How I Use Tmux
==============

<div class="center">English ∅ [Esperanto](/eo/timukso)</div>
<div class="center">2017-10-19 11:12:42 +0800</div>

>Furious activity is no substitute for understanding.<br>
>—H.H. Williams

<img src="/images/site/lysander-yuen-wk833OrQLJE-unsplash-1008x250.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="lysander-yuen-wk833OrQLJE-unsplash" title="lysander-yuen-wk833OrQLJE-unsplash"/>


<a name="toc">Table of contents</a>
-----------------------------------

- [Introduction](#introduction)
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


<a name="introduction">Introduction</a>
---------------------------------------

Just like with a text editor, a terminal multiplexer is one of the few tools that yields a lot of
productivity once you learn how to use it. In this article, I’ll talk about
[tmux](https://github.com/tmux/tmux)—a session manager, multiplexer, window manager, and one of the
most important pieces of software that changed the way I do computing.

For a long time, I have used [GNU Screen](https://www.gnu.org/software/screen/) for
multiplexing. There was such an exhilarating feeling when you lose connection to a host, only to
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
set -g default-shell $SHELL

set -g base-index 1
setw -g pane-base-index 1
set -g history-limit 100000

unbind C-b
bind C-z send-prefix
set -g prefix C-z
```

This sets the the initial window number to start at 1, instead of 0; it makes it easier to switch
to a specific window, later. This also sets the history limit and the prefix key. I unbound
<kbd>C-b</kbd> because it is too damn important for Emacs and Zsh use.


### <a name="clients">Clients</a>

```
bind D detach-client
bind b choose-tree
bind n new-session -c "#{pane_current_path}"
bind @ setw synchronize-panes
```

This binds several keys to detach the current session, and select a session from a tree chooser. The
<kbd>C-z @</kbd> key enables multiple panes in one window, to receive the same keyboard input. This
is very useful when troubleshooting remote connections simultaneously.


### <a name="sourcing">Sourcing</a>

```
bind . source-file ~/.tmux.conf
bind r move-window -r \; setw automatic-rename
bind x kill-pane \; move-window -r \; setw automatic-rename
bind & kill-window \; move-window -r \; setw automatic-rename
bind k send-keys C-l \; send-keys -R \; clear-history
```

Here, I rebound <kbd>C-z x</kbd> and <kbd>C-z &</kbd>, so that when windows are removed the
numberings are automatically updated. Manual override by means of <kbd>C-z r</kbd> is also
available.

I also rebound <kbd>C-z x</kbd> and <kbd>C-z &</kbd> to kill panes and windows, respectively,
without user prompts.

I bound the key <kbd>C-z k</kbd> to delete the buffer history to clear the view.


<a name="windows">Windows</a>
-----------------------------

Windows are the equivalent of browser tabs in tmux. It organizes sessions into subsessions.


### <a name="windowsmovement">Movement</a>

```
bind -n S-left previous-window
bind -n S-right next-window
bind -n S-up swap-window -t -1\; previous-window
bind -n S-down swap-window -t +1\; next-window

bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4
bind -n M-5 select-window -t 5
bind -n M-6 select-window -t 6
bind -n M-7 select-window -t 7
bind -n M-8 select-window -t 8
bind -n M-9 select-window -t 9
```

We bound <kbd>S-left</kbd> and <kbd>S-right</kbd>, to switch windows, backwards and forwards,
respectively. We also bound <kbd>C-z left</kbd> and <kbd>C-z right</kbd>, to swap windows to the left
and to the right, respectively.

To quickly switch to specific windows, we bound several keys to the <kbd>Alt</kbd> key, otherwise
known as <kbd>Meta</kbd>.


### <a name="windowscontrol">Control</a>

```sh
bind c new-window -c "#{pane_current_path}"
bind C new-window -c ~

bind '"' split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind Space last-window
```

This binds keys to start a new session from the current working directory or from the home
directory. This also binds keys to split the view vertically or horizontally, with the current
working directory as a starting point. I also want that there’s an easy key to change to the last
window.


<a name="panes">Panes</a>
-------------------------

Panes are the subdivisions of windows. They are similar to page frames in the context of web browsers.


### <a name="panesmovement">Movement</a>

```
bind -n C-Left select-pane -t :.-
bind -n C-Right select-pane -t :.+
bind -n C-Up swap-pane -U
bind -n C-Down swap-pane -D

bind 0 select-pane -t 0
bind 1 select-pane -t 1
bind 2 select-pane -t 2
bind 3 select-pane -t 3
bind 4 select-pane -t 4
bind 5 select-pane -t 5
bind 6 select-pane -t 6
bind 7 select-pane -t 7
bind 8 select-pane -t 8
bind 9 select-pane -t 9
```

We bound <kbd>C-Left</kbd> and <kbd>C-Right</kbd> to select panes, backwards and forwards,
respectively. We also bound <kbd>C-Up</kbd> and <kbd>C-Down</kbd>, to swap panes backwards and
forwards, respectively.

The other keys allow us to switch to specific panes.


### <a name="panesmerging">Merging</a>

```
bind m command-prompt -p "Merge pane to:"  "join-pane -t '%%'"
bind M command-prompt -p "Merge pane from:"  "join-pane -s '%%'"
bind h select-pane -m
```

This binds <kbd>C-z m</kbd> and <kbd>C-z M</kbd> to merge panes to and from, a specific window,
respectively. We also bound <kbd>C-z h</kbd> to highlight the borders of the current pane.


<a name="statusbar">Status bar</a>
----------------------------------

The status bar provides a lot of feedback, and we can also customize it. I set up mine as such:

```
set -g status-position bottom
set -g status-bg "#3F3F3F"
set -g status-fg default

setw -g window-status-format "#I:#W#F "
setw -g window-status-current-format "#I:#W#F "

setw -g window-status-attr bold
setw -g window-status-fg "#D8D8D8"
setw -g window-status-bg "#3F3F3F"

setw -g window-status-current-attr bold
setw -g window-status-current-fg green
setw -g window-status-current-bg black

set -g status-interval 1

set -g status-left ''
set -g status-left-fg green
set -g status-left-bg black

set -g status-right '#{prefix_highlight}'
set -g status-right-fg green
set -g status-right-bg black
set -g status-right-length 50

set -g pane-border-fg "#3F3F3F"
set -g pane-border-bg black
set -g pane-active-border-fg green
set -g pane-active-border-bg black
```

However, if you are already using the `2.9.X` series, use the following instead:

```
set -g status-position bottom
set -g status-bg "#3F3F3F"
set -g status-fg default

setw -g window-status-format "#I:#W#F "
setw -g window-status-current-format "#I:#W#F "

setw -g window-status-style fg="#D8D8D8",bg="#3F3F3F",bold
setw -g window-status-current-style fg=green,bg=black,bold

set -g status-interval 1

set -g status-left ''
set -g status-left-style fg=green,bg=black

set -g status-right '#{prefix_highlight}'
set -g status-right-length 50
set -g status-right-style fg=green,bg=black

set -g pane-border-style fg="#3F3F3F",bg=black
set -g pane-active-border-style fg=green,bg=black
```

This displays the status bar on the bottom of the terminal, and shows all the windows starting from
1, while displaying the date on the right.


<a name="plugins">Plugins</a>
-----------------------------

I use several plugins to supplement my configuration. It ranges from the plugin manager, itself to
clipboard control. The following is a summary.

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
copied, usually done with <kbd>C-c</kbd>, `Right-click > Copy`, or `Edit > Copy`, with graphical
applications, like web browsers. You can extract the contents using <kbd>C-v</kbd>,
`Right-click > Paste`, or `Edit > Paste`.

The tmux selection is the one involved when you enter copy mode. This is done by pressing
<kbd>C-z [</kbd> first, then <kbd>C-Space</kbd> to mark the selection, then use the movement keys to
define the area. The contents are copied using <kbd>M-w</kbd>. You can extract the contents by
pressing <kbd>C-z ]</kbd>.

With tmux, I no longer have to use the (mouse) pointer to manipulate my selections.


<a name="try">Trying it out</a>
-------------------------------

If you want to play with these settings, you may download the config file to your system. But first,
let’s backup your existing configuration:

    $ mv ~/.tmux.conf{,.backup}

Then, kill tmux:

    $ killall tmux

Then, let’s then install the config file:

    $ curl -SLo ~/.tmux.conf https://raw.githubusercontent.com/ebzzry/dotfiles/master/tmux/.tmux.conf

Finally, restart tmux

    $ tmux

If tmux complains that you are missing some plugins, press <kbd>C-z I</kbd>.


<a name="closingremarks">Closing remarks</a>
--------------------------------------------

Tmux is one of the tools that one must be using when working with the terminal and command line. It
enables workflow that would otherwise be difficult to do with other multiplexers, or very difficult
to do with regular non-managed sessions. For the rest of the definitions, visit the repo
[here](https://github.com/ebzzry/dotfiles/tree/main/tmux/.tmux.conf).

If you use git, you may also like the article about how I use it. It can be found [here](/en/git/).
