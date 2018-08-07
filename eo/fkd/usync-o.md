Retnodojn Usync-e Sinkronigi
============================

<div class="center">[Esperante](#) · [English](/en/usync)</div>
<div class="center">la 7-an de Februaro 2018</div>
<div class="center">Laste ĝisdatigita: la 6-an de aŭgusto 2018</div>

>Kion mi ne povas krei, mi ne komprenas.<br>
>―Richard P. FEYNMAN

Lok-al-loka sinkronigo kutime bezonatas, kiam du lokoj, sendepende kreas dosierajn ĝisdatigojn. Ni
diru, ke la firmao _Okininam_ havas du oficejojn. En la unua oficejo, ili havas la librotenadan kaj
loĝistikan fakojn. En la dua oficejo, ili havas la komputikan kaj homfaktoran fakojn. Ambaŭ havas
komunan `/pub` arbon, kiu havas atribuitajn subdosierujojn al ĉiu fako. Sen sinkronigo, kiam la unua
oficejo bezonas la informon de la dua oficejo, ili mane bezonas tiri la ĝisdatigojn. Per sinkronigo,
la unua oficejo povas aliri la dosierojn el la dua oficejo, kvazaŭ la komputika kaj homfaktora
fakoj, estis en la unua oficejo. Usync helpas atingi tion. Kreitas per
[Scsh](https://www.scsh.net). Uzas [Unison](http://www.cis.upenn.edu/~bcpierce/unison/) kaj
[rsync](http://rsync.samba.org/), por ambaŭ- kaj unudirekta sinkronigoj, respektive.


<a name="et"></a>Enhavotabelo
-----------------------------

- [Baza uzado](#bazuzado)
- [Altnivela uzado](#altniveluzado)
- [Finrimarkoj](#finrimarkoj)


<a name="bazuzado"></a>Baza uzado
---------------------------------

Por fari ambaŭdirektan sinkronigon de la dosierujo `/pub/jot/ninam`, inter la nuna retnodo al la
retnodoj `tarupam` kaj `taubetmo`, dum konservi la dosierujan strukturon defore, kuru la jenan
komandon. Notu, ke ne devas ekzisti spacetoj inter la retnodaj precizigoj, pro la `IFS` media
variablo:

    $ usync /pub/jot/ninam/ tarupam,taubetmo

La antaŭ komando faros ambaŭdirektan sinkronigon de la dosierujo `ninam/` troveblas sub `/pub/yot`,
al `tarupam:/pub/yot/` kaj `taubetmo:/pub/yot/`.

Per la antaŭ ekzemplo, la ambaŭdirekto sinkronigo simple diras, ke se la arbo
`tarupam:/pub/jot/ninam/` enhavas novajn aŭ ĝisdatigatajn erojn, kontraŭas
`localhost:/pub/jot/ninam/` kaj `localhost:/pub/jot/ninam/` ankaŭ havas novajn aŭ ĝisdatigatajn
erojn, tiam, ili intersanĝigas ĝisdatigojn.

Ideale, la rezulto estas `localhost:/pub/jot/ninam/`, `tarupam:/pub/jot/ninam/`, kaj
`taubetmo:/pub/jot/ninam/`, estas ĉiuj egalaj.


<a name="altniveluzado"></a>Altnivela uzado
-------------------------------------------

Estas ankaŭ ebla fari sinkronigon de pluraj dosieroj kaj dosierujoj, al mallokaj retnodoj. Por
fari tiel, kuru:

    $ usync /pub/jot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo

La antaŭ komando faros ambaŭdirektan sinkronigon de la dosierindikoj `/pub/jot/ninam/`,
`~/file.text`, kaj `~reyn/*.blend` al la mallokaj retnodoj `tarupam` kaj `taubetmo`, laŭ la sama
dosieruja struktura sistemo kiu estas priskribita supre.

Se vi volas fari unudirektan sinkronigon de la supraj, kiel _rsync_, kuru:

    $ usync --one-way --prefer-local /pub/jot/ninam/ \
    ~/file.text ~reyn/draft.blend tarupam,taubetmo


Por vidi pli da informo, kuru:

    $ usync --help


<a name="finrimarkoj"></a>Finrimarkoj
-------------------------------------

Kelkaj dosieroj kaj regulesprimoj enkonstruitas kiel eksigoj. Ili eble faras sencon aŭ ne. Se
vi opinias, ke ili devas esti ŝanĝitaj, liberiĝu por sendi tirpeton. La fontoj haveblas
[ĉi tie](https://github.com/ebzzry/usync).

_Dank’ al [Raymund Martinez](https://zhaqenl.github.io) pro la korektoj._
