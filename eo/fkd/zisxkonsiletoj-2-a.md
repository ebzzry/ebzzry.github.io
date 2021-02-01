Ziŝaj Konsiletoj 2-a: Dosierujstakoj
====================================

<div class="center">Esperanto ▪ [English](/en/zsh-tips-2/)</div>
<div class="center">la 26-an de Septembro 2018</div>
<div class="center">Laste ĝisdatigita: la 21-an de Februaro 2019</div>

>Kion ni faras por ni, mortas kun ni. Kion ni faras por ili, porĉiame restas.<br>
>―Albert Pɪᴋᴇ

Lastfoje mi skribis pri alinomoj kaj funkcioj, kial ilin uzi pol la komandlinian sperton
plibonigi. En ĉi tiu artikolo, mi parolos pri simplaj manieroj kiel dosierujstakojn konservi.


<a name="et"></a>Enhavotebelo
-----------------------------

- [Superrigardo](#superrigardo)
- [Konservi](#konservi)
- [Restaŭri](#restauxri)
- [Finrimarkoj](#finrimarkoj)


<a name="superrigardo"></a>Superrigardo
---------------------------------------

Ĉiufoje la dosierujo ŝanĝiĝas per `cd`, la komandon `pushd` mi uzas por tiun dosierujon konservi sur
la dosierujstako. Min ĉi tio ebligas por iri reen al la lasta dosierujo, antaŭ je `pushd` mi voku,
per la uzo de `popd`. La aktualan valoron de la dosierujstako la komando `dirs` montras.

Unue la helpilojn ni difinu:

```bash
function d () { pushd $@ }
function - () { popd }
function ds () { dirs -l $@ }
```

La la jenan seancon ni konsideru:

    % d ~/Downloads
    % ds -v
    0       /home/ebzzry/Downloads
    % d /etc/nixos
    % d /tmp
    % ds -v
    0       /tmp
    1       /etc/nixos
    2       /home/ebzzry/Downloads

En ĉi tiu punkto tri dosierujoj ekzistas en la dosierujstako. Se je `popd` mi kuros:

    % -

La jenan mi akiros:

    % pwd
    /etc/nixos
    % ds -v
    0       /etc/nixos
    1       /home/ebzzry/Downloads


<a name="konservi"></a>Konservi
-------------------------------

Onin dosierujstakoj permesas por movi tra la arboj kiujn ni nune prilaboras. Puŝi al la
dosierujstakoj onin permesas por dosierujon *viziti*, en kiu, agojn ni faros tie, tiam iri reen al
la lasta per elstakigado facile.

Bedaŭrinde, se novan ŝelon mi kreas, la stakon mi perdas. Je `exec` mi uzas por la ziŝan seancon
reŝarĝi, certigante, ke miaj agorddosieroj estas ŝarĝitaj freŝe.

    % exec zsh

Tion farante, la stakon kiun mi konstruis mi perdas. Por tion solvi, funkcion kiu la dosierujstakon
de la aktuala seanco konservas, mi havas.

```bash
function z! () {
  dirs -lv | awk -F '\t' '{print $2}' | tac >! $HOME/.z
  exec zsh
}
```

Je `z!` kurante, la enhavon de la aktuala stako konservas, kaj la ŝelon reŝarĝas:

    % pwd
    /home/ebzzry
    % d /etc/nixos
    % d ~/Downloads
    % d /var/lib
    % z!


<a name="restauxri"></a>Restaŭri
--------------------------------

Por iri kun `z!` funkcion kiu la konservitan dosierujstakon restaŭras mi havas:

```bash
function z+ () {
  if [[ -f $HOME/.z ]]; then
      local pwd=$PWD

      while read -r line; do
        pushd "$line"
      done < $HOME/.z

      pushd $pwd
  fi
}
```

Por la konservitan dosierujstakon restaŭri sur la aktuala seanco aŭ al nova aparta aperaĵo, plenumu:

    % z+
    % ds -v
    0       /var/lib
    1       /home/ebzzry/Downloads
    2       /etc/nixos
    3       /home/ebzzry


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Dosierujstakojn mi uzas kiel maniero por la dosieroj kiujn mi interagas konservi por ke estos pli
facile por ilin restaŭru al antaŭ funkcia stato. Ĉi tiujn du helpilojn havante, la laboron sur la komandlinio plifaciligas. Por la restantajn difinojn iru
[ĉi tien](https://github.com/ebzzry/dotfiles/tree/master/zsh).
