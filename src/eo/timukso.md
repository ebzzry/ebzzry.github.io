---
title: Kiel Mi Uzas Timukson
keywords: tmux, timukso, agordo, agordaĵo, agordajxo, linukso, makintoŝo, makintosxo 
image: https://ebzzry.com/images/site/lysander-yuen-wk833OrQLJE-unsplash-2000x1125.jpg
---
Kiel Mi Uzas Timukson
=====================

<div class="center">[English](/en/tmux/) ⊻ Esperanto</div>
<div class="center">2022-02-19 15:27:23 +0800</div>

>Furioza agado ne estas anstataŭaĵo de komprenado.<br>
>—H.H. WILLIAMs

<img src="/images/site/lysander-yuen-wk833OrQLJE-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />

<a name="et">Enhavotabelo</a>
-----------------------------

- [Introduction](#introduction)
- [Ĝeneralaĵoj](#gxeneralajxoj)
  + [Indeksoj](#indeksoj)
  + [Klientoj](#klientoj)
  + [La agordon reŝargi](#resxargxi)
- [Fenestroj](#fenestroj)
  + [Movado](#fenestrojmovado)
  + [Regado](#fenestrojregado)
- [Paneloj](#paneloj)
  + [Movado](#panelojmovado)
  + [Kunfandado](#panelojkunfandado)
- [Statbreto](#statbreto)
- [Kromprogramoj](#kromprogramoj)
- [Zonoj](#zonoj)
- [Elprovado](#elprovado)
- [Finrimarkoj](#finrimarkoj)


<a name="introduction">Introduction</a>
---------------------------------------

Samkiel redaktilo, terminalsimulila kunigilo estas unu el la malmultaj iloj kiu
multan produktivecon liveras ekde ĝin oni lernas kiel uzi. En ĉi tiu artikolo mi
parolos pri [timukso](https://github.com/tmux/tmux)—seanca administrilo,
kunigilo, fenesadministrilo, kaj unu el la plej gravaj programaroj kiu la
manieron ŝanĝis en kiu komputadon mi faras.

De longe je [GNU Screen](https://www.gnu.org/software/screen/) mi uzis por
kunigilado. Estis tia vigliga sento kiam la konekton al maŝino oni perdas nur
por malkovri poste, ke la porgramo kiun oni kurigis antaŭe ankoraŭ kuras.

Tamen, kiam timukson mi malkovris, mi rapide eksciis tiom mankadis al mi. Kaj
timukso kaj screen estas kunigiloj, sed iel malsamajn problemojn ili taktas. En
mia propra kazo, tiuj, kiuj mankis al mi de screen, timukso provizis.

En ĉi tiu artikolo, onin mi kondukas al mia agordaĵo kaj krudan ideon kiel mi
ruliĝas per timukso mi donos.


<a name="gxeneralajxoj">Ĝeneralaĵoj</a>
---------------------------------------

Estas bona ideo por komenci de la pli ĝeneralaj fazoj de agordaĵo, moviĝonte al
la plej specifaj. Iomajn agordaĵn ĉi tiu sekcio rigardos.


### <a name="indeksoj">Indeksoj</a>

```
set -g default-shell $SHELL

set -g base-index 1
setw -g pane-base-index 1
set -g history-limit 100000

unbind C-b
bind C-z send-prefix
set -g prefix C-z
```

La komencan fenestran ciferon ĉi tio agordas al 1, anstataŭ 0; plifaciliĝas por
specifan fenestron ŝanĝi poste. La limon de la historio kaj la prefiksklavon ĝi
ankaŭ agordas. je <kbd>C-b</kbd> mi malbindis pro tiu klavo estas tro grava al
emaksa kaj ziŝa uzo.


### <a name="klientoj">Klientoj</a>

```
bind D detach-client
bind b choose-tree
bind n new-session -c "#{pane_current_path}"
bind @ setw synchronize-panes
```

Kelkajn klavojn ĉi tio bindas por la aktualan seancon malligi, kaj seancon
elekti el la arbelektilo. Plurajn panelojn la klavkombino <kbd>C-z @</kbd>
permesas por la saman klavaran enigon ricevi. Ĉi tio tre utilas kiam forajn
konektojn problemsolvi samtempe.


### <a name="resxargxi">La agordon reŝargi</a>

```
bind . source-file ~/.tmux.conf
bind , command-prompt -I "#W" "rename-window '%%'"
bind k send-keys C-l \; send-keys -R \; clear-history
bind r move-window -r\; setw automatic-rename

bind x kill-window\; move-window -r
bind X kill-window\; previous-window\; move-window -r
bind w kill-pane
```

Ĉi tie, je <kbd>C-z x</kbd> kaj je <kbd>C-z X</kbd> mi rebindis por ke kiam
fenestroj estas forigitaj la numerado aŭtomate ĝisdatigu. Mana transpaso pere de
<kbd>C-z r</kbd> estas alia alterna havebla metodo.

La klavon <kbd>C-z k</kbd> mi bindis por la bufran historion purigi por la vidon
klarigi.


<a name="fenestroj">Fenestroj</a>
---------------------------------

Fenestroj estas la ekvivalentoj de retumilaj langetoj en timukso. Seancojn ĝi organizas al subseancoj.


### <a name="fenestrojmovado">Movado</a>

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

Mi bindis <kbd>S-left</kbd> kaj <kbd>S-right</kbd> por ŝanĝi fenestrojn
malantaŭen kaj antaŭen, respektive. Mi bindis <kbd>S-up</kbd> kaj
<kbd>S-down</kbd> por fenestrojn interŝanĝi al maldekstren kaj dekstren,
respektive.

Por rapide ŝanĝi al specifaj fenestroj, kelkajn klavkombinojn ni bindis al la
klavon <kbd>Alt</kbd>, alie nomata la klavo <kbd>Meta</kbd>.


### <a name="fenestrojregado">Regado</a>

```
bind A new-window -c "#{pane_current_path}"
bind A new-window -c ~

bind "'" split-window -v -c "#{pane_current_path}"     # ⌘'
bind ";" split-window -h -c "#{pane_current_path}"     # ⌘;
bind Space last-window

bind h select-layout even-horizontal
bind v select-layout even-vertical
```

La klavojn ĉi tio bindis por novan seancon krei de la aktuala labora dosierujo
aŭ de la hejma dosierujo. La klavojn ĉi tio ankaŭ bindis por la vidon dividi
vertikale kaj horizontale, kun la aktuala dosierujo kiel komenca punkto. Mi
ankaŭ volas, ke estas facila klavo por iri al la lasta fenestro.


<a name="paneloj">Paneloj</a>
-----------------------------

Paneloj estas la subdividoj de fenestroj. Ili similas al kadropaĝo en la
kunteksto de retumiloj.


### <a name="panelojmovado">Movado</a>

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

La klavojn <kbd>C-Left</kbd> kaj <kbd>C-Right</kbd> mi bindis por panelojn
elekti, malantaŭen kaj antaŭen, respektive. La klavojn <kbd>C-Up</kbd> kaj
<kbd>C-Down</kbd> mi ankaŭ bindis por panelojn interŝanĝi, malantaŭen kaj
antaŭen, respektive.

Onin la aliaj klavoj permesas por ŝanĝi al speciaj paneloj.


### <a name="panelojkunfandado">Kunfandado</a>

```
bind < command-prompt -p "<" "join-pane -s '%%'"\; move-window -r
bind > command-prompt -p ">" "join-pane -t '%%'"\; move-window -r
```

La klavojn <kbd>C-z <</kbd> kaj <kbd>C-z ></kbd> ĉi tio bindis por panelojn
kunfandi, al kaj de, specifaj fenestroj, respektive.  panelo marki.


<a name="statbreto">Statbreto</a>
---------------------------------

Multan prisondon la statbreto donas, kaj ĝin ni povas personecigi. La mian mi
agordis jene:

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

Sed se la `2.9.x` serion oni jam uzas, ĉi tiun uzu anstataŭe:

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


La statbreton ĉi tio montras en la subo de la terminalsimulilo, kaj ĉiujn
fenestroj de 1 montras, la daton en la dekstra parto montrante.


<a name="kromprogramoj">Kromprogramoj</a>
----------------------------------------

Kelkan kromprogramon mi uzas por mian agordon subteni. Ĝi ampleksiĝas de la
kromprograma administrilo mem al tondeja regado. Jen la resumo.

    set -g @plugin 'tmux-plugins/tpm'

la krompragraman administrilon mem ŝargas.

    set -g @plugin 'tmux-plugins/tmux-resurrect'

La klavojn <kbd>C-z C-s</kbd> kaj <kbd>C-z C-r</kbd> provizas por la seancojn
konservi kaj restaŭri, respektive.

    set -g @plugin 'tmux-plugins/tmux-continuum'


Je *tmux-resurrect* ĉi tio komplementas per la seancojn aŭtomate restaŭri en la
komenca startigo de timukso.

    set -g @plugin 'tmux-plugins/tmux-yank'

Novan klavon <kbd>y</kbd> ĉi tio aldonas dum en kopireĝimo—<kbd>C-z [</kbd>—por
la aktualan zonon kopii al la tondejo.

    set -g @continuum-restore 'on'
    run '~/.tmux/plugins/tpm/tpm'

La konservitajn seancojn ĉi tio ŝargas dum la startigo kaj la kromprograman
administrilon ŝargas.

Por ĉiomajn kromprogramojn instali, je <kbd>C-z I</kbd> premu.


<a name="zonoj">Zonoj</a>
-------------------------

Per timukso, aliron al la tri zonoj mi havas samtempe: la `PRIMARY`-,
`CLIPBOARD`-, kaj la timukso-zonoj.

La `PRIMARY`-zono estas tiu, kiu estas engaĝita kiam ion oni markas per la
musmontrilo. La enhavon de ĝi oni povas elĉerpi per la mezklaka musbutono aŭ
<kbd>Shift+Insert</kbd>.

La `CLIPBOARD`-zono estas tiu, kiu estas engaĝita kiam eksplicitan peton por
kopiado oni faras, kutime farite per <kbd>C-c</kbd>, `Dekstre alklaki > Kopii`,
aŭ `Redakti > Kopii`, per grafikaj apoj kiel retumiloj. La enhavon de ĝi oni
povas elĉerpi per <kbd>C-v</kbd>, `Dekstre alklaki > Alglui`, aŭ `Redakti >
Alglui`.

La timukso-zono estas tiu, kiu estas engaĝita kiam la kopian reĝimon oni eniras.
Ĉi tio estas farita per je <kbd>C-z [</kbd> premi unue, tiam je
<kbd>C-Space</kbd> premu por la komencon marki, tiam la movadajn klavojn premi
por la areon etendi, kaj fine je <kbd>M-w</kbd> premu por la enhavojn kopii. La
enhavon de ĝi oni povas elĉerpi per je <kbd>C-z ]</kbd> premi.

Per timukso la musmontrilon mi ne plu bezonas uzi por la zonojn administri.


<a name="elprovado">Elprovado</a>
---------------------------------

Se ĉi tiujn agordojn oni volas priludi, mian agordon oni povas elŝuti al la
sistemo. Sed unue, la ekzistantan agordon ni savkopiu:

    $ mv ~/.tmux.conf{,.backup}

Tiam timukson mortigu:

    $ killall tmux

Tiam la agorddosieron ni instalu:

    $ curl -SLo ~/.tmux.conf https://raw.githubusercontent.com/vedatechnologiesinc/dotfiles/master/tmux/.tmux.conf

Fine, timukson reŝargu:

    $ tmux

Se timukso plendas, ke mankas iom da kromprogramoj, je <kbd>C-z I</kbd> premu:


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

Timukso estas unu el la iloj, kiun oni devas havi laborante ĉe la
terminalsimulilo kaj komandlinio.  Laborfluon kio estas aliokaze malfacila per
aliaj kunigiloj, aŭ tre malfacila por fari per kutimaj neadministritaj seancoj
ĝi ebligas. Por la restantaj difinoj iru [ĉi
tien](https://github.com/vedatechnologiesinc/dotfiles/tree/main/tmux/.tmux.conf).

Se giton vi uzas, la artikolo pri kiel ĝi mi uzas, eble ankaŭ plaĉas al vi. Ĝi
troviĝas [ĉi tie](/eo/gito/).
