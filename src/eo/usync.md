Sinkronigi Retnodojn per Usync
==============================

<div class="center">Esperanto • [English](/en/usync/)</div>
<div class="center">Laste ĝisdatigita: la 16-an de marto 2022</div>

>Kion mi ne povas krei, mi ne komprenas.<br>
>—Richard P. FEYNMAN

<img src="/images/site/thomas-jensen-ISG-rUel0Uw-unsplash-1008x250.webp" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" alt="thomas-jensen-ISG-rUel0Uw-unsplash" title="thomas-jensen-ISG-rUel0Uw-unsplash"/>


<a name="et">Enhavotabelo</a>
-----------------------------

- [Enkonduko](#enkonduko)
- [Instalo](#instalo)
- [Baza uzado](#bazuzado)
- [Altnivela uzado](#altniveluzado)
- [Finrimarkoj](#finrimarkoj)


<a name="enkonduko">Enkonduko</a>
---------------------------------

Lok-al-loka sinkronigo estas kutime bezonata, kiam du lokoj sendepende kreas dosierajn ĝisdatigojn.
Ni supozu, ke la firmao _MMM_ havas du oficejojn. En la unua oficejo, ili havas la librotenadan kaj
loĝistikan fakojn. En la dua oficejo, ili havas la informadikan kaj homfaktoran fakojn. Ambaŭ havas
komunan `/pub`-arbon, kiu havas atribuitajn subdosierujojn al ĉiu fako. Sen sinkronigo, kiam la unua
oficejo bezonas la informon de la dua oficejo, ili permane bezonas tiri la ĝisdatigojn. Per
sinkronigo, la unua oficejo povas aliri la dosierojn el la dua oficejo, kvazaŭ la informadika kaj
homfaktora fakoj, estis en la unua oficejo. Usync helpas atingi tion. Ĝi estas kreita per
[Scsh](https://www.scsh.net). Ĝi uzas [Unison](http://www.cis.upenn.edu/~bcpierce/unison/) kaj
[rsync](http://rsync.samba.org/) por ambaŭ- kaj unudirekta sinkronigoj, respektive.


<a name="instalo">Instalo</a>
-----------------------------

Usync povas esti instali per Nixpkgs:

    $ nix-env -i usync

Por certigi, ke usync fakte estis instalita, rulu:

    $ which usync


<a name="bazuzado"></a>Baza uzado
---------------------------------

Por fari ambaŭdirektan sinkronigon de la dosierujo `/pub/mis/dok`, inter la aktuala retnodo al la
retnodoj `loko1` kaj `loko2`, konservante la dosierujan strukturon defore, rulu la jenan
komandon. Notu, ke ne devas ekzisti spacetoj inter la retnodaj precizigoj, pro la `IFS` media
variablo de la ŝelo:

    $ usync /pub/mis/dok/ loko1,loko2

La komando faros ambaŭdirektan sinkronigon de la dosierujo `dok/` troveblas ĉe `/pub/mis`,
al `loko1:/pub/mis/` kaj `loko2:/pub/mis/`.

Per la antaŭa ekzemplo, la ambaŭdirekta sinkronigo simple diras, ke se la arbo `loko1:/pub/mis/dok/`
enhavas novajn aŭ ĝisdatigatajn erojn kontraste al `localhost:/pub/mis/dok/` kaj
`localhost:/pub/mis/ninam/` kiuj ankaŭ havas novajn aŭ ĝisdatigitajn erojn, tiam, ili intersanĝigas
ĝisdatigojn.

Ideale, la rezulto estas ke `localhost:/pub/mis/dok/`, `loko1:/pub/mis/ninam/`, kaj
`loko2:/pub/mis/dok/` ĉiuj egalas.


<a name="altniveluzado">Altnivela uzado</a>
-------------------------------------------

Estas ankaŭ eble fari sinkronigon de pluraj dosieroj kaj dosierujoj al mallokaj retnodoj. Por
fari tiel, rulu:

    $ usync /pub/mis/dok/ ~/file.txt ~rmm/*.txt loko1,loko2

La komando faros ambaŭdirektan sinkronigon de la dosierindikoj `/pub/mis/dok/`, `~/file.txt`, kaj
`~rmm/*.txt` al la mallokaj retnodoj `loko1` kaj `loko2`, laŭ la sama dosieruja struktura sistemo
kiu estas priskribita supre.

Se oni volas fari unudirektan sinkronigon de la supraj, kiel _rsync_, rulu:

    $ usync --one-way --prefer-local /pub/mis/dok/ \
    ~/file.txt ~rmm/draft.txt loko1,loko2

Por vidi pli da informo, rulu:

    $ usync --help


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Kelkaj dosieroj kaj regulesprimoj estas enkonstruitaj kiel eksigoj. Eble ili senchavas aŭ ne. Se oni
opinias, ke ili devas esti ŝanĝitaj, estu libere por sendi tirpeton. La fontoj haveblas [ĉi
tie](https://github.com/ebzzry/usync).
