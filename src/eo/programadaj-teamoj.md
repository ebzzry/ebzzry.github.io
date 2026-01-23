---
title: Arĥitekturaj Principoj por Programadaj Teamoj
keywords: arĥitekturo, programado, principoj, teamoj
image: https://ebzzry.com/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg
---
Arĥitekturaj Principoj por Programadaj Teamoj
=============================================

<div class="center">[English](/en/software-teams/) ⊻ Esperanto</div>
<div class="center">2025-12-28</div>

>Ne diru al mi kiel laboreme vi laboras. Diru al mi kiom da laboro vi faris.<br>
>—James J. LING

<img src="/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Deveno](#deveno)
- [Enkonduko](#enkonduko)
- [Ĉiu ŝanĝo devas esti serioze ekzamenita](#sxangxo)
- [Ŝanĝo ne devas postuli pli ol unu teamo](#unuteamo)
- [Kapablas malpligrandiĝi viaj teamoj kaj ankaŭ grandiĝi](#malpligrandigxi)
- [Kresku kulturon, ne vivi ekster la lando](#kulturo)
- [Elektu programlingvon kiu skalas](#programlingvo)
- [Ne igu homojn fari la laborojn de maŝino](#masxino)
- [Uzu malfermitan kodon ĉie oni povas](#malfermitakodo)
- [Disponigo devas esti aŭtomata per premo de butono](#disponigo)
- [Minimumigu agordon](#agordo)
- [Ruleblas testoj sen aldona kosto](#testoj)
- [Uzu monotonajn datenbazajn semantikojn](#monotona)
- [Inkluzivu altgradigeblecon en via dinamika apa modelo](#algradigeblecon)
- [Estroj estas planantoj, ne prokurantoj](#estroj)
- [Malsukcesi plani estas plano por malsukceso](#plano)
- [Arĥitekturo ne estas opcia](#arhxitekturo)
- [Gravas motivoj](#motivoj)
- [Igu retrokuplajn iteraciojn mallonga](#retrokuplo)
- [Mezurado ne estas anstataŭigo de juĝo](#jugxo)


<a name="deveno">Deveno</a>
---------------------------

Kun eksplicita permeso, la jena artikolo estas reafiŝo de
[bloga afiŝo](https://fare.livejournal.com/171998.html) de sinjoro
[François-René Rideau (Faré)](http://fare.tunes.org) en la 29-an de majo 2013.
La ideoj de Fare kiel programado devas esti farita, staris tra la tempo.


<a name="enkonduko">Enkonduko</a>
---------------------------------

Multaj programadaj organizoj malsukcesas sekvi ĉi tiujn principojn kaj pagi la
punon, kiu kondukas al malsukceso. Guglo ne faras la erarojn pri iri kontraŭ
ili, sed kelkaj projektoj ĉe ITA faris antaŭe.


<a name="sxangxo">Ĉiu ŝanĝo devas esti serioze ekzamenita</a>
-------------------------------------------------------------

Kodrevuoj ne nur plibonigas kodan kvaliton per havi pli da okuloj por trovi
cimojn, sed pli grave ili kreas la reciprokan scion de la kodbazo, kaj
transpolenan menson de la teamanoj. Ĉi tio aspektas ke ĝi malrapidigas onin en
la mallonga tempo, sed ĝi estas esenca en la longa tempo. Se oni bezonas havi
kritikan riparon, nun, interropu kolegon kaj nur prenu la kritikan revuon tuj
nun. Se estas urge ke oni bezonas revuon nun kaj ne haveblas kolegon ĉi-momente
(en la mezo de la nokto, aŭ ili estas malsana, en ferio, aŭ en retiriĝo), do igu
ĝin revuita poste, sed ankoraŭ igu ĝin revuita (kaj kompreneble rulu aŭtomatajn
testojn — via infrastrakturo ne permesas onin kaj disponigi sen tiuj testoj, ĉu
ne?); sed tiaj retroefikaj revuoj estas simptomoj de paneo kaj devas ekzisti
kiel esceptoj. Ĉiom da kodo devas esti traktita al samaj normoj de kvalito,
revuado, kaj testado. Ne estas esceptoj. Ĉi tio bezonas, ke por ĉiom da kodo
kiun vi skribas, oni devas krei lingvon kaj taŭgan muntadan kaj testadan
infrastrukton kiuj estas parto de la kulturo kiun oni estas aktive kreskigas.
Ajna «skripto» skribita en maniero kiu malobservas ĉi tiujn normojn estas
paneo, kiom ajn necesa ili estas unue, aŭ simptomo de pli granda paneo. Pli da
tio malsupre.


<a name="unuteamo">Ŝanĝo ne devas postuli pli ol unu teamo</a>
--------------------------------------------------------------

Ĉiu ŝanĝo postulas almenaŭ unu teamon ĉar ĉiom da kodo devas esti revuita. Sed
ĉiufoje du aŭ pli teamoj estas engaĝita por realigi kaj disponigi solan ŝanĝon,
ĉi tiu implicas pli da kosto kaj tempo por sinkronigi ĉi tiujn teamojn al unu aŭ
pluraj interfacoj, kiu faras pli malrapidan, retrokulpan iteracion. Pli malbone,
ĉi tiuj interfacoj kreas konfliktojn de intereso kaj iĝas la lokuso de cikatra
histo dum ĉiu teamo kreas tavolojn de nedezirata programada kodaĵo por protekti
sin el la ŝanĝoj de aliaj teamoj. Pro la «investo» de ĉiu teamo en ĝi, ĉi tiuj
interfacoj travivi longe post ia ajn valideco kiun ili havis antaŭe, kiu
signifas ke oni iras senfine uzi la interfacojn oni forĵetis sen ia ajn desegno
antaŭe kiam oni ne havis sperton. Ne dividu viajn teamojn al horizontalaj
nivelo de funkciado. Eblus escepto kiam la pli malsupra nivelo sekvas krudan
interfacon, kaj estas facile eksperimenti sen ĝi kaj forŝalti de ĝi kiam
bezonata, module ŝanĝo en prezo kaj kvalito. Notu ke homoj kun similaj roloj
(e.g. ĉiom da testaj inĝenieroj) tendencas kunhavigi komunajn koncernojn kaj
kunvenas, interŝanĝas informojn kaj kreas ilojn kune; tio bonas kaj devas esti
kuraĝigita, ne malebligita; sed tio ne devas preni utilan eron de decidiĝo kaj
havi respondecon, kaj ne davas esti traktita kiel «teamo».



<a name="malpligrandigxi">Kapablas malpligrandiĝi viaj teamoj kaj ankaŭ grandiĝi</a>
------------------------------------------------------------------------------------

Aldoni homajn risurcojn ne bezonas multe da pensado, sed ĝi bezonas pensadon por
aldoni ilin efike. 
