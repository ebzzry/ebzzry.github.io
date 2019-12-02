Maldaŭra Rondvojaĝo de Gito kaj GitHub
======================================

<div class="center">Esperanto ▪ [English](/en/git-github/)</div>
<div class="center">la 11-an de Julio 2018</div>
<div class="center">Laste ĝisdatigita: la 2-an de Decembro 2019</div>

>Ĉiujn solvitajn problemon sciu kiel solvi.<br>
>―Richard P. FEYNMAN

[Giton](https://git-scm.com/) kun [GitHub](https://github.com)-laborfluon ĉi tiu mallonga gvidilo
montras. Multspecajn rezultojn rapida Gugla serĉo pri gitaj laborfluoj revenas. Nur unu el la
manieroj de giton uzi kun gita gastiga servo kiel GitHub ĉi tiu artikolo priskribas.

En ĉi tiu artikolo, la inviton la `$` simbolo reprezentas. Por demonstradaj celoj, la redaktilon
[*nano*](https://www.nano-editor.org/) ni uzos. Tamen, kion ajn redaktilon oni liberas uzi.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Bazaj](#bazaj)
  + [Komenca uzo](#komenco)
  + [Sekvontaj uzadoj](#sekvontaj)
- [Enrete labori](#enrete)
  + [La sekurŝelajn ŝlosilojn generi](#sxlosiloj)
  + [La deponejon krei](#deponejonkrei)
  + [La deponejon ĝisdatigi](#deponejongxisdatigi)
  + [Partopreni](#partopreni)
  + [Sinkronigi kun *upstream*](#sinkronigi)
- [Ŝanĝojn tiri](#tiri)
- [Kunfandi kun *upstream*](#kunfandi)
- [Finrimarkoj](#finrimarkoj)


<a name="bazaj"></a>Bazaj
-------------------------

### <a name="komenco"</a>Komenca uzo

Por la aferojn plibonigi poste, na `.gitignore`-dosieron oni devas krei. La dosierojn kiuj estas
ekskluditaj el la deponejo la _.gitignore_-dosiero precizigas. Multaj el ĉi tiuj estas duumaj
dosieroj kaj eraraj mesaĝoj kiuj estis kreitaj dum kompiladoj.

La tipon de projekto `.gitignore`-dosieroj specifas. Bona loko por precizigi tion, kion .gitignore
devas enhavi estas [gitignore.io](https://gitignore.io). La tipon de projekto precizigi en la kampo,
tiam na **Generate** klaku, tiam le eligon kopiu al la tondejo.

Dosierujon por la projekto kreu, tiam ŝanĝiĝu ene:

    $ mkdir foobar
    $ cd foobar

La `.gitignore`-dosieron redaktu en la aktuala dosierujo:

    $ nano .gitignore

Tiam, la enhavon de la tondejo algluu. La ŝanĝojn konservu.

La gitan deponejon oni nun povas pravalorizi.

    $ git init

Komence, na ĉiom da dosieroj en la aktuala dosierujo aldonu:

    $ git add .

Tiam, la ŝanĝojn enmetu.

    $ git commit -m "Novdeponejon pravalorizu"


### <a name="sekvontaj"></a>Sekvontaj uzadoj

La bazajn komandojn kiuj oni uzos kiam deponejon oni jam havas ĉi tiu sekcio priskribas.

Branĉon kiu la ŝanĝojn tenas kreu:

    $ git checkout -b eksperimentaj

Se dosieron oni volas aldoni al la deponejo:

    $ git add Blah.java

Kiam ŝanĝojn al la dosieroj oni faris, ilin scenigu:

    $ git add -u

Por la ŝanĝojn montri kiuj oni scenigis:

    $ git diff

Por la ŝanĝojn enmeti:

    $ git commit -m "Ŝanĝojn faru"

Por la enmetoprotokolon montri:

    $ git log

Por la enmetoprotokolon kun la diferencoj montri:

    $ git log -p

Kiam la ŝanĝoj, kiujn oni jam testis, estas stabilaj, ŝaltu al la `master`-branĉo.

    $ git checkout master

Tiam, kunfandu na `eksperimentaj`:

    $ git merge eksperimentaj

Post tio, la `eksperimentaj`-branĉon oni povas forviŝi:

    $ git branch -d eksperimentaj


<a name="enrete"></a>Enrete labori
----------------------------------

Kiel labori kun aliaj programistoj ĉi tiu sekcio priskribas. Na [GitHub](https://github.com) oni
uzos en ĉi tiu diskuto.


### <a name="sxlosiloj"></a>La sekurŝelajn ŝlosilojn generi

La mem oni devas esti kapabla por veriĝi al la GitHub-konto, antaŭ ol la ŝanĝojn oni povas puŝi. Por
tion fari, la sekurŝelajn ŝlosilojn oni devas krei. Por tion fari, la jenan komandon plenumu. Certigu,
ke [fortan pasfrazon](https://xkcd.com/936/) oni disponigas, kiam oni invitiĝis:

    $ ssh-keygen -t ed25519

La ŝlosilojn kreinte, la ŝlosilojn oni devas aldoni al la propra GitHub-konto. Por tion
fari, la jenan komandon plenumu, tiam la eligon kopiu:

    $ cat ~/.ssh/id_ed25519.pub

Iru al [github.com/settings/ssh](https://github.com/settings/ssh), tiam na **Add SSH key** aŭ je
**New SSH key** klaku:

![Add SSH key](/bil/sekursxelan-sxlosilon-aldonu.png)

La ŝlosilon algluu, tiam tradaŭru.


### <a name="deponejonkrei"></a>La deponejon krei

En la paĝo de la deponejoj, novan deponejon krei per na **New** klaki:

![New](/bil/nova-deponejo.png)

Daŭru per la invitoj. Kiam la postulatajn kampojn oni jam plenigis, signovicojn de komandojn oni
akiros. Na `vakelo` kaj na `foobar` anstataŭigu per la GitHub-uzantnomo kaj la nomo de la
deponejo, respektive.

    $ git remote add origin git@github.com:vakelo/foobar.git
    $ git push -u origin master

Oni invitiĝos por la pasfrazon provi kiun oni eniris supre. La enhavon de la deponejo al la fora
deponejo la `git push` komando alŝutas.


### <a name="deponejongxisdatigi"></a>La deponejon ĝisdatigi

Kiam na pli da ŝanĝo oni faris al la deponejo, la ŝanĝojn oni povas puŝi per la jena komando:

    $ git push origin master


### <a name="partopreni"></a>Partopreni

Se oni volas kontribui al projekto, kopion de tiu dosiero oni devas surlabori, tiam la ŝanĝojn oni
puŝas al la propra forko:

Unue, la projekton forku. Iru al la projekto, kiun oni volas forki, tiam na **Fork** klaku:

![Fork](/bil/forku.png)

Kopion de la deponejo ĉi tio kreas en la propra GitHub-konto.

Sekve, tiun forkon oni devas kloni al la loka disko. La adreson lokitas en la **SSH clone URL**-kampo kopiu:

![SSH clone URL](/bil/klonadreso-de-ssh.png)

Tiam la jenan komandon plenumu, en kiu, `memeho` estas via uzantnomo:

    $ git clone git@github.com:memeho/foobar.git

Sekve, na *remote* kiu nomiĝas *upstream* kreu kiun la ŝanĝojn el la fonta
deponejo spuras:

    $ git remote add upstream git@github.com:vakelo/foobar.git

Kiam ŝanĝojn al la kodo oni volas fari, apartan branĉon kreu. Branĉan nomon kiu priskribas de
la ŝanĝojn kiujn oni volas fari kreu. La nomo povas esti ŝanĝita poste. En ĉi tiu ekzemplo, branĉon
nomiĝas `novopcioj` ni kreos:

    $ git checkout -b novopcioj

Nun ŝanĝojn al la dosieroj en ĉi tiu branĉo oni povas fari. Kiam la ŝanĝojn oni jam enmetis, la
ŝanĝojn puŝu al via forko:

    $ git push origin novopcioj

Se oni volas, ke la ŝanĝojn la fonta deponejo kunfandas, na _Pull Request_ kreu per iri al la paĝo
de la fonta deponejo, tiam na **Pull requests** klaku:

![Pull Requests](/bil/tirpetoj.png)

En la sekva paĝo, na **New pull request** klaku:

![New Pull Request](/bil/nova-tirpeto.png)

Na **compare across forks** elektu:

![Compare Across Forks](/bil/komparu-trans-forkoj.png)

Maldekstre, sub la **base fork**-kampo, na **vakelo/foobar** elektu, kaj en la **base**-kampo,
je **master** elektu.

Dekstre, sub la **head fork**-kampo, na **memeho/foobar** elektu, kaj en la **compare**-kampo,
je **novopcioj** elektu.

Tiam, na **Create pull request** klaku:

![Create pull request](/bil/tirpeton-kreu.png)

Tiam, tradaŭru.


### <a name="sinkronigi"></a>Sinkronigi kun *upstream*

Por la *upstream*-branĉon sinkronigi kun la loka deponejo, la ŝanĝojn el *upstream* tiru:

    $ git pull upstream master

Tiam puŝu al via deponejo:

    $ git push origin master


<a name="tiri"></a>Ŝanĝojn tiru
-------------------------------

Se oni estas la proprulo de la fonta deponejo, kaj la ŝanĝojn el la kontribuantoj oni volas tiri, je
**Pull requests** en la paĝo de la deponejo klaku:

![Pull requests](/bil/tirpetoj.png)

tiam, tradaŭru.


<a name="kunfandi"></a>Kunfandi kun *upstream*
----------------------------------------------

Se oni estas la kontribuanto, kaj la ŝanĝojn jam estis tiritaj en la fonta deponejo, la
*upstream*-branĉon sinkronigi:

    $ git pull upstream master

En ĉi tiu punkto, la `novopcioj`-branĉon kiu oni kreis antaŭe, oni nun povas forviŝi.

    $ git branch -d novopcioj
    $ git push origin -d novopcioj


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

La laborfluo priskribita en ĉi tiu dokumento nur estas unu el la uzeblaj laborfluoj kiujn oni povas
uzi. Ĉi tiu dokumento funkcias kiel enkonduko al la uzantoj kiuj estas komencantoj al Gito kaj
GitHub.
