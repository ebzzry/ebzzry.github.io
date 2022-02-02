Sinkronigi Retnodojn per Usync
==============================

<div class="center">Esperanto ▪ [English](/en/usync/)</div>
<div class="center">la 7-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 2-an de Februaro 2022</div>

>Kion mi ne povas krei, mi ne komprenas.<br>
>―Richard P. FEYNMAN

Lok-al-loka sinkronigo estas kutime bezonata, kiam sendepende kreas du lokoj dosierajn ĝisdatigojn.
Supozu ni, ke la firmao _MMM_ havas du oficejojn. En la unua oficejo, havas ili la librotenadan kaj
loĝistikan fakojn. En la dua oficejo, havas ili la informadikan kaj homfaktoran fakojn. Havas ambaŭ
komunan `/pub`-arbon, kiu havas atribuitajn subdosierujojn al ĉiu fako. Sen sinkronigo, kiam bezonas
la unua oficejo la informon de la dua oficejo, permane bezonas tiri ili la ĝisdatigojn. Per
sinkronigo, povas aliri la unua oficejo la dosierojn el la dua oficejo, kvazaŭ la informadika kaj
homfaktora fakoj, estis en la unua oficejo. Helpas usync atingi tion. Ĝi estas kreita per
[Scsh](https://www.scsh.net). Uzas [Unison](http://www.cis.upenn.edu/~bcpierce/unison/) kaj
[rsync](http://rsync.samba.org/), por ambaŭ- kaj unudirekta sinkronigoj, respektive.


<a name="et">Enhavotabelo</a>
-----------------------------

- [Instalo](#instalo)
- [Baza uzado](#bazuzado)
- [Altnivela uzado](#altniveluzado)
- [Finrimarkoj](#finrimarkoj)


<a name="instalo">Instalo</a>
-----------------------------

Usync povas esti instali per Nixpkgs:

    $ nix-env -i usync

Por certigi, ke usync fakte estas instalita, plenumu:

    $ which usync


<a name="bazuzado"></a>Baza uzado
---------------------------------

Por fari ambaŭdirektan sinkronigon de la dosierujo `/pub/mis/dok`, inter la aktuala retnodo al la
retnodoj `loko1` kaj `loko2`, dum konservi la dosierujan strukturon defore, plenumu la jenan
komandon. Notu, ke ne devas ekzisti spacetoj inter la retnodaj precizigoj, pro la `IFS` media
variablo de la ŝelo:

    $ usync /pub/mis/dok/ loko1,loko2

Faros la komando ambaŭdirektan sinkronigon de la dosierujo `dok/` troveblas ĉe `/pub/mis`,
al `loko1:/pub/mis/` kaj `loko2:/pub/mis/`.

Per la antaŭa ekzemplo, la ambaŭdirekta sinkronigo simple diras, ke se la arbo `loko1:/pub/mis/dok/`
enhavas novajn aŭ ĝisdatigatajn erojn kontraste al `localhost:/pub/mis/dok/` kaj
`localhost:/pub/mis/ninam/` kiuj ankaŭ havas novajn aŭ ĝisdatigitajn erojn, tiam, ili intersanĝigas
ĝisdatigojn.

Ideale, la rezulto estas ke `localhost:/pub/mis/dok/`, `loko1:/pub/mis/ninam/`, kaj
`loko2:/pub/mis/dok/` ĉiuj egalas.


<a name="altniveluzado">Altnivela uzado</a>
-------------------------------------------

Estas ankaŭ eble fari sinkronigon de pluraj dosieroj kaj dosierujoj, al mallokaj retnodoj. Por
fari tiel, plenumu:

    $ usync /pub/mis/dok/ ~/file.txt ~rmm/*.txt loko1,loko2

Faros la komando ambaŭdirektan sinkronigon de la dosierindikoj `/pub/mis/dok/`, `~/file.txt`, kaj
`~rmm/*.txt` al la mallokaj retnodoj `loko1` kaj `loko2`, laŭ la sama dosieruja struktura sistemo
kiu estas priskribita supre.

Se volas fari oni unudirektan sinkronigon de la supraj, kiel _rsync_, plenumu:

    $ usync --one-way --prefer-local /pub/mis/dok/ \
    ~/file.txt ~rmm/draft.txt loko1,loko2

Por vidi pli da informo, plenumu:

    $ usync --help


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Kelkaj dosieroj kaj regulesprimoj estas enkonstruitaj kiel eksigoj. Eble ili senchavas aŭ ne. Se
opinias oni, ke ili devas esti ŝanĝitaj, estu libere por sendi tirpeton. Haveblas la fontoj [ĉi
tie](https://github.com/ebzzry/usync).

_Dank’ al [Raymund MARTINEZ](https://zhaqenl.github.io) pro la korektoj._
