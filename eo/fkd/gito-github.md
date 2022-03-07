Lakona Rondvojaĝo de Gito kaj GitHub
====================================

<div class="center">Esperanto ▪ [English](/en/git-github/)</div>
<div class="center">Laste ĝisdatigita: la 7-an de Marto 2022</div>

>Sciu kiel solvi ĉiujn solvitajn problemon.<br>
>―Richard P. FEYNMAN

Ĉi tiu lakona gvidilo montros laborfluon per [Gito](https://git-scm.com/) kaj
[GitHub](https://github.com). Rapida interreta serĉo pri gitaj laborfluoj revenas multspecajn
rezultojn. Ĉi tiu artikolo priskribas nur unu el la eblaj manieroj de uzi giton kun gita gastiga
servo kiel GitHub .

En ĉi tiu artikolo, la simbolo `$` reprezentas la inviton . Por demonstradaj celoj, ni uzos la
redaktilon [*nano*](https://www.nano-editor.org/) . Tamen, kion ajn redaktilon oni liberas uzi.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Bazaj](#bazaj)
  + [Komenca uzo](#komenco)
  + [Sekvontaj uzadoj](#sekvontaj)
- [Labori enrete](#enrete)
  + [Generi la sekurŝelajn ŝlosilojn](#sxlosiloj)
  + [Krei la deponejon](#deponejonkrei)
  + [Ĝisdatigi la deponejon](#deponejongxisdatigi)
  + [Partopreni](#partopreni)
  + [Sinkronigi kun *upstream*](#sinkronigi)
- [Tiri ŝanĝojn](#tiri)
- [Kunfandi kun *upstream*](#kunfandi)
- [Finrimarkoj](#finrimarkoj)


<a name="bazaj">Bazaj</a>
-------------------------

### <a name="komenco">Komenca uzo</a>

Por plifaciligi la aferojn poste, oni devas krei `.gitignore`-dosieron. La _.gitignore_-dosiero
precizigas la dosierojn kiuj estas ekskluditaj el la deponejo. Multaj el ĉi tiuj estas duumaj
dosieroj kaj eraraj mesaĝoj kiuj estis kreitaj dum kompilado.

`.gitignore`-dosieroj specifas la tipon de projekto. Bona loko por precizigi tion, kion .gitignore
devas enhavi estas [gitignore.io](https://gitignore.io). Precizigi la tipon de projektoen la kampo,
tiam alklaku **Generate**, tiam kopiu le eligon al la tondejo.

Kreu dosierujon por la projekto, tiam iru al tiu dosierujo:

    $ mkdir foobar
    $ cd foobar

Redaktu la `.gitignore`-dosieron en la aktuala dosierujo:

    $ nano .gitignore

Tiam, algluu la enhavon de la tondejo. Konservu la ŝanĝojn.

Oni nun povas pravalorizi la gitan deponejon:

    $ git init

Komence, aldonu ĉiom da dosieroj en aktuala dosierujo:

    $ git add .

Tiam, la enmetu ŝanĝojn:

    $ git commit -m "Novdeponejon pravalorizu"


### <a name="sekvontaj"></a>Sekvontaj uzadoj

La bazajn komandojn kiuj oni uzos kiam deponejon oni jam havas ĉi tiu sekcio priskribas.

Branĉon kiu la ŝanĝojn tenas kreu:

    $ git checkout -b eksperimentaj

Se dosieron oni volas aldoni al la deponejo:

    $ git add Blah.java

Kiam ŝanĝojn al la dosieroj oni faris, ilin scenigu:

    $ git add -u

Por montri la ŝanĝojn kiuj oni scenigis:

    $ git diff

Por enmeti la ŝanĝojn:

    $ git commit -m "Ŝanĝojn faru"

Por montri la enmetoprotokolon:

    $ git log

Por montri la enmetoprotokolon kun la diferencoj:

    $ git log -p

Kiam stabilas la ŝanĝoj, kiujn oni jam testis, ŝaltu al la `master`-branĉo:

    $ git checkout master

Tiam, kunfandu `eksperimentaj`:

    $ git merge eksperimentaj

Post tio, oni povas forviŝi la `eksperimentaj`-branĉon:

    $ git branch -d eksperimentaj


<a name="enrete">Labori enrete</a>
----------------------------------

Ĉi tiu sekcio priskribas kiel labori kun aliaj programistoj. Oni uzos [GitHub](https://github.com)
en ĉi tiu diskuto.


### <a name="sxlosiloj">Generi la sekurŝelajn ŝlosilojn</a>

Oni devas esti kapabla por veriĝi ĉe la GitHub-konto, antaŭ ol oni povas puŝi la ŝanĝojn. Por
fari tion, oni devas krei la sekurŝelajn ŝlosilojn. Por fari tion, plenumu la jenan komandon. Certigu,
ke oni disponigos [fortan pasfrazon](https://xkcd.com/936/), kiam oni invitiĝis:

    $ ssh-keygen -t ed25519

Kreinte la ŝlosilojn, oni devas aldoni la ŝlosilojn al la propra GitHub-konto. Por fari
tion, plenumu la jenan komandon, tiam kopiu la eligon:

    $ cat ~/.ssh/id_ed25519.pub

Iru al [github.com/settings/ssh](https://github.com/settings/ssh), tiam alklaku **Add SSH key** aŭ
**New SSH key**:

![Add SSH key](/bil/sekursxelan-sxlosilon-aldonu.png)

Algluu la ŝlosilon, tiam tradaŭru.


### <a name="deponejonkrei">Krei la deponejon</a>

En la paĝo de la deponejoj, krei novan deponejon per klaki **New**:

![New](/bil/nova-deponejo.png)

Daŭru per la invitoj. Kiam oni jam plenigis la postulatajn kampojn, akiros signovicojn de komandojn
oni. Anstataŭigu `vakelo` kaj `foobar` per la GitHub-uzantnomo kaj la nomo de la deponejo,
respektive.

    $ git remote add origin git@github.com:vakelo/foobar.git
    $ git push -u origin master

Oni invitiĝos por provi la pasfrazon kiun oni eniris supre. La `git push` komando alŝutos la enhavon
de la deponejo al la fora deponejo.


### <a name="deponejongxisdatigi">La deponejon ĝisdatigi</a>

Kiam oni faris plian ŝanĝon al la deponejo, oni povas puŝi la ŝanĝojn per la jena komando:

    $ git push origin master


### <a name="partopreni">Partopreni</a>

Se oni volas kontribui al projekto, oni devas surlabori kopion de tiu dosiero, tiam oni puŝas la
ŝanĝojn al la propra forko:

Unue, forku la projekton. Iru al la projekto, kiun oni volas forki, tiam alklaku **Fork**:

![Fork](/bil/forku.png)

Ĉi tio kreas Kopion de la deponejo en la propra GitHub-konto.

Sekve, oni devas kloni tiun forkon al la loka disko. Kopiu la adreson kiu estas lokita en la **SSH
clone URL**-kampo:

![SSH clone URL](/bil/klonadreso-de-ssh.png)

Tiam plenumu la jenan komandon, en kiu, `memeho` estas la uzantnomo:

    $ git clone git@github.com:memeho/foobar.git

Sekve, kreu *remote* kiu nomiĝas *upstream* kiu spuras la ŝanĝojn de la fonta deponejo:

    $ git remote add upstream git@github.com:vakelo/foobar.git

Kiam oni volas fari ŝanĝojn al la kodo, kreu apartan branĉon. Kreu branĉan nomon kiu priskribas
la ŝanĝojn kiujn oni volas fari. La nomo povas esti ŝanĝita poste. En ĉi tiu ekzemplo, ni kreos branĉon
nomita `novopcioj`:

    $ git checkout -b novopcioj

Nun oni povas fari ŝanĝojn al la dosieroj en ĉi tiu branĉo. Kiam oni jam enmetis la ŝanĝojn, puŝu la
ŝanĝojn al via forko:

    $ git push origin novopcioj

Se oni volas, ke la fonta deponejo kunfandu la ŝanĝojn , kreu _Pull Request_ per iri al la paĝo de
la fonta deponejo, tiam alklaku **Pull requests**:

![Pull Requests](/bil/tirpetoj.png)

En la sekva paĝo, alklaku **New pull request**:

![New Pull Request](/bil/nova-tirpeto.png)

Elektu **compare across forks**:

![Compare Across Forks](/bil/komparu-trans-forkoj.png)

Maldekstre, sub la **base fork**-kampo, elektu **vakelo/foobar**, kaj en la **base**-kampo,
elektu **master**.

Dekstre, sub la **head fork**-kampo, elektu **memeho/foobar**, kaj en la **compare**-kampo,
elektu **novopcioj**.

Tiam, alklaku **Create pull request**:

![Create pull request](/bil/tirpeton-kreu.png)

Tiam, tradaŭru.


### <a name="sinkronigi">Sinkronigi kun *upstream*</a>

Por sinkronigi la *upstream*-branĉon kun la loka deponejo, tiru la ŝanĝojn el *upstream*:

    $ git pull upstream master

Tiam puŝu al via deponejo:

    $ git push origin master


<a name="tiri">Tiru ŝanĝojn</a>
-------------------------------

Se oni estas la proprulo de la fonta deponejo, kaj oni volas tiri la ŝanĝojn el la kontribuantoj,
klaku **Pull requests** en la paĝo de la deponejo:

![Pull requests](/bil/tirpetoj.png)

tiam, tradaŭru.


<a name="kunfandi">Kunfandi kun *upstream*</a>
----------------------------------------------

Se oni estas la kontribuanto, kaj la ŝanĝoj jam estis tiritaj de la fonta deponejo, sinkronigu la
*upstream*-branĉon:

    $ git pull upstream master

En ĉi tiu punkto, oni nun povas forviŝi la `novopcioj`-branĉon, kiun oni kreis antaŭe:

    $ git branch -d novopcioj
    $ git push origin -d novopcioj


<a name="finrimarkoj">Finrimarkoj</a>
-------------------------------------

La laborfluo priskribita en ĉi tiu dokumento estas nur unu el la uzeblaj laborfluoj kiujn oni povas
uzi. Ĉi tiu dokumento funkcias kiel enkonduko al la uzantoj kiuj estas komencantoj al Gito kaj
GitHub.
