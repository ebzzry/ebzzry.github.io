Sinkronigi Retnodojn per Usync
==============================

<center>[Esperante](#)  [English](/en/usync)</center>
<center>la 7-an de Februaro 2018</center>
<center>Laste ŝanĝita: la 7-an de Februaro 2018</center>

>Kion mi ne povas krei, mi ne komprenas.<br>
>―Richard P. FEYNMAN


Enhavotabelo
------------

- [Baza uzado](#bazuzado)
- [Altnivela uzado](#altniveluzado)
- [Finaj rimarkoj](#finaj)


<a name="bazuzado"></a>Baza uzado
---------------------------------

Por fari ambaŭdirektan sinkronigon de la dosierujo `/pub/yot/ninam`, inter la nuna retnodo al la
retnodoj `tarupam`, kaj `taubetmo`, kun konservi la dosierujan strukturon loke, kuru la jenan
komandon. Notu, ke ne devas ekzisti spacetoj inter la retnodaj precizigo, pro la `IFS` media
variablo, troveblas en plejparto da ŝeloj:

    $ usync /pub/yot/ninam/ tarupam,taubetmo

La komando supre faros ambaŭdirektan sinkronigon de la dosierujo `ninam/` troveblas sub `/pub/yot`,
al `tarupam:/pub/yot/`, kaj `taubetmo:/pub/yot/`.

Per la ekzemplo supre, la amdaŭriekta sinkronigo simple diras, ke se la arbo `tarupam:/pub/yot/ninam/`
enhavas novan kaj/aŭ ĝisdatigatajn erojn, kontraŭas `localhost:/pub/yot/ninam/`, kaj
`localhost:/pub/yot/ninam/` ankaŭ novajn kaj/aŭ ĝisdatigatajn erojn, tiam, ili intersanĝigas
ĝisdatojn.


<a name="altniveluzado"></a>Altnivela uzado
-------------------------------------------

Estas ankaŭ ebla por fari sinkronigon de pluraj dosieroj, kaj dosierujoj, al mallokaj retnodoj. Por fari
kiel, kuru:

    $ usync /pub/yot/ninam/ ~/file.text ~reyn/*.blend tarupam,taubetmo

La komando supre faros ambaŭdirektan sinkronigon de la dosierindikoj `/pub/yot/ninam/`,
`~/file.text`, kaj `~reyn/*.blend` al la mallokaj retnodoj `tarupam`, kaj `taubetmo`, per la sama
dosieruja struktura sistemo kiu estas priskribita supre.

Se vi volas fari unudirektan sinkronigon de la supraj, kiel _rsync_, kuru:

    $ usync --one-way --prefer-local /pub/yot/ninam/ \
    ~/file.text ~reyn/draft.blend tarupam,taubetmo


Por vidi pli da informo, kuru:

    $ usync --help


<a name="finaj"></a>Finaj rimarkoj
----------------------------------

Kelkaj dosieroj kaj regulesprimoj estas enkonstruitaj kiel eksigoj. Ili eble sencas aŭ ne. Se vi opinias, ke ili devas ŝanĝita, liberiĝu por sendi tirpeton. La fontoj estas haveblaj [ĉi tie](https://github.com/ebzzry/usync).
