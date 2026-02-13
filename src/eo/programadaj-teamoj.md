---
title: Arĥitekturaj Principoj por Programadaj Teamoj
keywords: arĥitekturo, programado, principoj, teamoj
image: https://ebzzry.com/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg
---
Arĥitekturaj Principoj por Programadaj Teamoj
=============================================

<div class="center">[English](/en/software-teams/) ⊻ Esperanto</div>
<div class="center">2026-02-13</div>

>Ne diru al mi kiel laboreme vi estas. Diru al mi kiom da laboro vi faris.<br>
>—James J. LING

<img src="/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="et">Enhavotabelo</a>
-----------------------------

- [Deveno](#deveno)
- [Enkonduko](#enkonduko)
- [Ŝanĝoj](#sxangxoj)
- [Teamo](#teamo)
- [Malpligrandiĝi](#malpligrandigxi)
- [Kulturo](#kulturo)
- [Lingvo](#lingvo)
- [Maŝinoj](#masxinoj)
- [Malfermitkodo](#malfermitkodo)
- [Disponigado](#disponigado)
- [Agordo](#agordo)
- [Testoj](#testoj)
- [Monotone](#monotone)
- [Altgradigebleco](#altgradigeblecon)
- [Direktoroj](#direktoroj)
- [Planoj](#planoj)
- [Arĥitekturo](#arhxitekturo)
- [Rekompencoj](#rekompencoj)
- [Retrokuplo](#retrokuplo)
- [Mezurado](#mezurado)


<a name="deveno">Deveno</a>
---------------------------

Kun eksplicita permeso, la jena artikolo estas reafiŝo de [bloga afiŝo](https://fare.livejournal.com/171998.html) de sinjoro [François-René Rideau (Faré)](http://fare.tunes.org) en la 29-an de majo 2013. La ideoj de Fare kiel programado devas esti farita, staris tra la tempo.


<a name="enkonduko">Enkonduko</a>
---------------------------------

Multaj programadaj organizoj malsukcesas sekvi ĉi tiujn principojn kaj pagi la punon, kiu kondukas al malsukceso. Guglo ne faras la erarojn kontraŭbatalas ilin, sed kelkaj projektoj ĉe ITA faris antaŭe.


<a name="sxangxoj">Ŝanĝoj</a>
-----------------------------

Ĉiu ŝanĝo devas esti serioze reviziita. Kodekzamenoj ne nur plibonigas kodan kvaliton per pli da okuloj por trovi cimojn, sed pli grave ili muntas la reciprokan scion de la kodbazo, kaj transpolenan menson de la teamanoj. Ĉi tio aspektas ke ĝi malrapidigas onin en la mallonga tempo, sed ĝi estas esenca en la longa tempo. Se oni bezonas havi kritikan riparon, nun, interrompu kolegon kaj nur prenu la kritikan ekzamenon tuj nun. Se estas urĝe ke oni bezonas ekzamenon nun kaj ne haveblas kolegon ĉi-momente (en la mezo de la nokto, aŭ ili estas malsana, en ferio, aŭ en retiriĝo), do igu ĝin reviziita poste, sed ankoraŭ igu ĝin reviziita (kaj kompreneble rulu aŭtomatajn testojn—via infrastrukturo ne permesas onin kaj disponigi sen tiuj testoj, ĉu ne?); sed tiaj retroefikaj ekzamenoj estas simptomoj de paneo kaj devas ekzisti kiel esceptoj. Ĉiom da kodo devas esti traktita al samaj normoj de kvalito, ekzamenado, kaj testado. Ne estas esceptoj. Ĉi tio bezonas, ke pri ĉiom da kodo kiun oni skribas, oni devas krei lingvon kaj taŭgan muntadan kaj testadan infrastrukturon kiu estas parto de la kulturo kiun oni estas aktive kreskigas. Ajna «skripto» skribita en maniero kiu malobservas ĉi tiujn normojn estas paneo, kiom ajn necesa ili estas unue, aŭ simptomo de pli granda paneo. Pli pri tio ĉi-malsupre.


<a name="teamo">Teamo</a>
-------------------------

Ŝanĝo ne devas postuli pli ol unu teamon. Ĉiu ŝanĝo postulas almenaŭ unu teamon ĉar ĉiom da kodo devas esti reviziita. Sed ĉiufoje du aŭ pli teamoj estas engaĝitaj por realigi kaj disponigi solan ŝanĝon, ĉi tiu implicas pli da kosto kaj tempo por sinkronigi ĉi tiujn teamojn al unu aŭ pluraj interfacoj, kiu faras pli malrapidan, retrokuplan ciklon. Pli malbone, ĉi tiuj interfacoj kreas konfliktojn de intereso kaj iĝas la lokuso de cikatra histo dum ĉiu teamo kreas tavolojn de nedezirata programada kodaĵo por protekti sin el la ŝanĝoj de aliaj teamoj. Pro la «investo» de ĉiu teamo en ĝi, ĉi tiuj interfacoj travivi longe post ia ajn valideco kiun ili havis antaŭe, kiu signifas ke oni iras senfine uzi la interfacojn oni forĵetis sen ia ajn desegno antaŭe kiam oni ne havis sperton. Ne dividu viajn teamojn al horizontalaj nivelo de funkciado. Eblus escepto kiam la pli malsupra nivelo sekvas krudan interfacon, kaj estas facile eksperimenti sen ĝi kaj forŝalti de ĝi kiam bezonata, module ŝanĝo en prezo kaj kvalito. Notu ke homoj kun similaj roloj (e.g. ĉiom da testaj inĝenieroj) tendencas kunhavigi komunajn koncernojn kaj kunvenas, interŝanĝas informojn kaj kreas ilojn kune; tio bonas kaj devas esti kuraĝigita, ne malebligita; sed tio ne devas preni utilan eron de decidiĝo kaj havi respondecon, kaj ne devas esti traktita kiel «teamo».



<a name="malpligrandigxi">Malpligrandiĝi</a>
--------------------------------------------

Kapablas malpligrandiĝi viaj teamoj kaj ankaŭ pligrandiĝi. Aldoni homajn risurcojn ne bezonas multe da pensado, sed ĝi bezonas pensadon por aldoni ilin efike. Bedaŭrinde forigi homrisurcojn ja bezonas multe da pensado por igi la teamon funkcianta; sed tio estas io kion oni bezonas fari. Ĉu sukcese aŭ malsukcese, via programaro estas lanĉita, sed ĝi estas eventuale lasita en bontena reĝimo se homoj iras al iliaj aliaj projektoj (kiu povas aŭ ne povas esti la sekva versio de la sukcesa programaro), kaj via ekzistanta bontena kontraktoj povas kuri dum jaroj kaj tiutempe oni jam kuras kun malpli da risurcoj. Kaj se nur milde sukcese, oni devas malpligrandigi vian tempon por adapti al la merkato. Ĉiukaze, projekto kiu ne estas malpliskalita tre baldaŭ havos negativan retan nunan valoron, kaj ĝia bontena kosto pli ege superpezigas la generitajn enspezojn. Se oni bezonas dek kvar malsamajn laŭpetajn rotaciojn nur por igi la servojn kurantaj, plej verŝajne oni faras ilin malĝuste. Do ne aldonu senpagajn kompleksojn; ne obligu komponantojn; ne dividu al teamoj pli ol necese; ne adoptu multajn malkongruajn muntadajn kaj testadajn sistemojn. Kiu denove gvidas al la sekva punkto.


<a name="kulturo">Kulturo</a>
-----------------------------

Kreskigu kulturon, ne vivu ekstere. Elektu unu bonan lingvon (aŭ kombino de manplena da kompletigaj lingvoj), kaj daŭriĝu per ĝi, investu al ĝi, munti infrastrukturon kaj scipovon ĉirkaŭ ĝi, plibonigu ĝian ekosistemon—via produktiveco ege plialtiĝos kiel rezulto. Se oni kondutos kiel ĉasisto-kolektisto kaj elekti ian ajn hazardajn lingvojn kaj ilojn kiuj estas haveblaj por la tasko, sen krei koheran komunumon ene kaj ekster la firmao, oni amasigos komplikon kiun oni ne povas havi bonteni (vidu supre), ripozigi viajn servojn al malutilaj aroj de aĉaj «skriptoj», dilui viajn penojn pere de multaj malsanaj etaj niĉoj, pliobligi infrastrukturajn kostojn, inkluzive de sciiĝan koston al laborantoj, ĉiuj el viaj anoj kaj subteamoj kreskigos siajn proprajn subkulturojn kiujn neniu scios, kaj ili ne povas movi inter projektoj aŭ bonteni la projektojn de unu la alia; via organizo ne povas ŝanĝiĝi kaj adapti. Investu al multaj kulturoj, dum eble, povas fariĝi vera drenado al viaj rimedoj, kiuj povas iĝi fatala krom se la firmao grandas; kaj eĉ granda firmao nur povas kreskigi tiom da kulturoj kaj bonteni ilin verve.


<a name="lingvo">Lingvo</a>
---------------------------

Elektu lingvon kiu skalas. Por kreskigi bonegan kulturon, oni devas elekti simplan lingvon kiuj povas manipuli ĉiom da viaj programara stako, el la plej altaj projektoj al la plej malaltaj. Komuna Lispo, Scala, F#, Haskelo, OCaml, Kloĵuro, Erlang, Rakido, estas eblaj elektoj, depende je la kunteksto; multaj aliaj lingvoj povas aŭ ne povas kvalifi. La ĉefpunkto ne estas diskuti la meritojn kaj malsukcesojn de diversaj ekzistantaj lingvoj kaj fondi difinitivan liston de decaj lingvoj; ekzistas ŝanĝanta merkato kaj estas multaj validaj kialoj kial specifaj homoj labori al specifa projekto povas aŭ ne povas elekti iun lingvon super la aliaj. La ĉefpunkto estas oni elektu lingvon, la plej bonan por realigi viajn nunajn kaj estontajn celajn projektojn; kaj post tio ĉiom da via kodo devas esti en la elektita lingvo, kun nur bagatelaj kovriloj kaj malmultaj iteraciojn kritikajn per aliaj lingvoj, kaj eble alia kodo por adapti vian programadajn mediojn al via lingvo kaj stilo. Ĉiu «skripto» bezonata por munti vian sistemon aŭ teni ilin kune estas paneo, ĉu Baŝo, Ziŝo, Pitono, Perl, Rubeno, aŭ alia lingvo krom se la elektita lingvo. Io ajn krom kritikaj iteracioj en C, C++, Java, Assembly, aŭ PL/SQL estas paneo. Io ajn koda generilo per teksto ekster la normala muntadaj ilaroj estas paneo. Ĉiom da ĉi tiuj paneoj mordos onin en la fino, malebligi la restrukturadon de la kodo kaj/aŭ la teamo kiam oni bezonas ĝin plej multe. Tamen «paneo» ne signifas, ke oni ne devas fari ĝin—fakte oni faras ĝin ĉar ne fari ilin estus pli granda paneo; sed ĉiu decido por malobservi la principojn de elekti subtenitan lingvon estas simptomo, ke ĉi tiu lingvo malsukcesis. Multfoja paneo povas esti la simptomo de elekti malbonan lingvon por uzi. Se oni faris malĝustan decidon, estas ankoraŭ tempo por ripari ĝin kaj uzi pli bonan lingvon. Sed oni devas fari ĝin ĝuste kaj ne krei kunkuran kulturon: anstataŭe elekti lingvon por ĉiom da programado irante antaŭen kaj malrapide aŭ rapide migri aŭ progresive forigi pasintajn projektojn kiel bezonata. Certe, daŭru eksperimenti kun aliaj lingvoj, sed la rezulto de la eksperimento devas esti akcepto aŭ malakcepto, ne diluado de la ekosistemo.


<a name="masxinoj">Maŝinoj</a>
------------------------------

Ne igu homojn fari la laborojn de maŝino. Se oni permane aliformigas UML-diagramojn al kodo, skribi rilatajn skemojn por akordi al viaj objektaj skemoj, sekvi dezajnajn modelojn, kodumi per malaltnivela lingvo, aŭ fari homlaboron kiu maŝino povas fari, oni ne nur malŝparas firmaajn rimedojn, oni fifaras krimon kontraŭ la hommenso. Kompensu por la pekoj, aŭ oni iros al inferno, ĉar homlaboro ne nur ege pli kosta ol maŝina laboro por senmensaj taskoj, ĝi ankaŭ estas erarinklinaj. Subtilaj malakordoj povas rampi ene tio kio estas intencite realigita; kurtvojoj povas tenitaj eĉ oni ne devas teni; pecoj mankas. En la fino, ĉi tio kondukas al sennombraj horoj de sencimigado, sed tamen rezultas al ege malbona kodo. Dume, ĉiu minuto uzita por fari tiujn kiujn maŝinoj povas fari estas minuto ne uzita por tio kiu homoj povas fari (nune). Korolario de ĉi tiu principo estas la lingvo kiun oni elektis devas provizi decan solvon por metaprogramado. Kiel Olin Shivers, oni devas rifuzi taskojn, kiujn maŝinoj povas fari.


<a name="malfermitkodo">Malfermitkodo</a>
-----------------------------------------

Uzu malfermitan kodon ĉie ke oni povas. Por ĉiu programaro kiu ne estas parto de viaj kernaj havaĵoj, kiujn oni tenas kiel komerca sekreto por konkursa avantaĝo, oni devas uzi, plibonigi, kaj evolui la plej bonajn haveblajn malfermitajn ilojn. Ne reeltrovu vian privatan radon. Se ĝi ne estas la ĉefa fako, plej bone oni faros egale, iamaniere; en ĉiu kazo, estos distro fari bonegan laboron al ĝi se oni eĉ supozas, ke oni povas fari ĝin. Kaj se oni posedas mojosan programaron enfirmae, se oni ne disdonas ĝin, oni ne ŝparas inĝenieradajn rimedojn, oni nur sinforbaras ekstere, kaj plimalfaciliĝos rekruti, kaj malgajnos pere de produktivecaj gajnoj, kaj pli malbone, en komunumaj signaloj pri tio kion oni faras ĝuste aŭ malĝuste.


<a name="disponigado">Disponigado</a>
-------------------------------------

Disponigado devas esti aŭtomata pere de premo de butono. Se sukcesa produkta disponigado bezonas pli ol unu homon premanta butonon por validigi la novan kodan revizion post sukcesaj testoj, oni faras ĝin malĝuste. Se la testoj mem bezonas homon tute, oni faras ĝin malĝuste.

Precipe, ne havu apartajn teamojn por «programado», «operacioj», aŭ «demandoj kaj respondoj»; tio estas recepto por testo kaj disponigada katastrofo (ankaŭ vidu la duan principon ĉi-supre). Se la produkto ne povas disponiĝi, la programado estas ankoraŭ ne plena; se la kodo ne havas teston, la programado estas ankoraŭ ne plena. Tiel oni devas uzi ian infrastrukturon kiu aŭtomatigas reprodukteblan testadon kaj disponigadon en la tuta distribua sistemo. Pere de la punkto antaŭe per malfermita kodo, krom se disponigado de distribuaj sistemoj estas la ĉefa fako, oni devas uzi kaj partopreni en ekzistantaj malfermitaj kodaj solvoj kiel NixOS kaj DisNix.


<a name="agordo">Agordo</a>
---------------------------

Minimumigu agordon. Ajna agordo kiu malsamas inter testado kaj produktado estas okazo por ega fiasko. La testoj devas inkluzivi kontrolojn kontraŭ tiuj okazaĵoj, ke certigas ke nenio mankas en kiu ajn agordo estas bezonita, eĉ oni ne rulas testojn rekte pere de tiu agordo. Ajna agordaĵo kiun oni ne povas testi antaŭe, devas havi respondan permanan teston en la produktada disponigada kontrollisto


<a name="testoj">Testoj</a>
---------------------------

Testoj devas esti ruleblaj sen kosta agordo. Se oni bezonas dek minutojn por munti iun grandegan ŝanĝeblan staton nur por havi la kapablon por ruli funkciadajn testojn, oni faras ĝin malĝuste, kaj oni ne povos skali. Rulu testojn el pura neŝanĝebla dateno kiu estas bagatela por kunhavigi; se oni bezonas ŝanĝeblan datenbazon, uzu je kopii-en-skribi el bazlinia testa dateno. Kaj cetere, ne unuopa testo devas postuli pli da dateno ol necesita por ruli ĝin. Havu datenan raportadan sistemon por aŭtomate precizigi kiajn datenojn estis necesaj dum iu rulado de la kodo. Kaj kompreneble, kodraportada sistemo estas bezonita por aŭtomate precizigi kiujn kodojn estis testitaj aŭ ne.


<a name="monotone">Monotone</a>
-------------------------------

Uzu monotonajn datenbazajn semantikojn. Igu la transakciajn protokolojn ĉiam inkluzivi enmetajn identigilojn kaj tempindikojn, identiganta ĉiom da kodo, dateno, kaj agordo, por ke estu ĉiam bagatele por reludi ajnan produktan cimon. Plifaciligu la laboron de ĉerpi minimuman rilatan subaron da neŝanĝeblan dateno el la reproduktita cimo por ke oni povu enporti ĝin al la regresa testaro (post aŭtomate forpurigi ajnan delikatan informon, kompreneble).


<a name="altgradigeblecon">Altgradigebleco</a>
----------------------------------------------

Inkluzivu altgradigeblecon en la dinamika apa modelo. Gravas altgradigebleco; kaj ĝi ne estas afero de statika datena modelo. Uzu skemilojn kiuj povas trakti multajn skemajn versiojn en kiu oni povas plialtgridiĝi el ajna antaŭa stato. Ne estu kontente kun ilo kiu nur povas reprezenti la «aktualan» skemon. Igu la regresajn testajn datenojn altgradigeblajn kaj testu kontraŭ ĝi. Kodaj kaj datenaj altgradigoj estas norma parto de la programada ciklo, subtenota per la normalaj iloj, ne pere de neantaŭviditaj esceptoj.


<a name="direktoroj">Direktoroj</a>
-----------------------------------

Direktoroj estas planantoj, ne prokurantoj. La rolo de direktoro estas prioritatigi taskojn, distribui rimedojn, kaj konekti homojn. Estas emfaze ne fari teĥnikajn decidojn, superrigardi teĥnikan realigadon, aŭ esti makleranto en pasi teĥnikajn informojn ĉirkaŭ. Teĥnikaj estroj devas fari la teĥnikajn decidojn, kaj ekzameni kodon devas esti la preterlasa meĥanismo; la direktoro ne devas esti engaĝita ambaŭokaze—malpleje ne tiom multe: fakte estas ege ebla, ke la sama homo portas du ĉapelojn, kaj li samtempe povas esti direktoro kaj teĥnika estro, precipe kiam oni laboras en malgrandaj teamoj, en kiu estas bona ideo se eblas; kaj tiu sama homo povas teni, kiel teĥnika estro, decidojn kiujn li ne povas teni kiel direktoro. Kiel informa makleranto, ili nur malplialtigas bendlarĝon, enkonduki bruon kaj aldoni respondtempon, kaj tial ne devas ekzisti en la organizo ([ne intermiksu](http://youtu.be/k2h2lvhzMDc?t=10m10s) la organizan strukturon kun la komunikadan strukturon). Direktoro devas distribui homajn kaj materialajn rimedojn, kaj fari adaptiĝon dum nova informo haveblas; sed post aboni la laŭtemajn homojn en la aferkontrolsistemo kaj certigi ke la celo klaras kaj ĝiaj administratoj laboras al ĝi, alie ĝi devas igi ilin kompreni la taskojn, kaj ne nur foriri, sed aktive forigi malhelpaĵojn en ilia laboro, inkluzive de distroj el klientoj, ili mem, 
aliaj direktoroj, interna kaj ekstera politiko, kaj tiel plu. Ajna direktoro kiu trapasas ĝian rolon pro fari ion ajn ĉi-supre, devas esti maldungita pro kialo; pli malbone se ĝi ĉikanas laborantojn aŭ iras krei imperion.


<a name="planoj">Planoj</a>
---------------------------

Malsukcesi plani estas plano por malsukceso. Labora organizo ne estas natura afero kiun homoj evoluis fari senpense. Ĝi bezonas prudentan penson por fari ĝuste. Neniam klopodu ne pensi, ĝi ne funkcios. Se oni laboras el unu artifika limdato al la sekva artifika limdato, ĉiam en averta reĝimo pensi en la mallonga vojo, kaj ĉiam prokrasti la bezonon por trakti grandajn aferojn, do oni ne havos ion ajn por pensi longe, kaj oni igas sin por malsukceso: la granda bildo de la organizo estas unu el bedaŭriga agitacio poste pere de morto; kaj oni intence pentras tiun bildon pere de rifuzi malfermi la okulojn kaj vidu pli antaŭe. Oni devas intence dezajni la sistemon, laŭ pluraj aksisoj: kodo, homo, tempo, ktp.


<a name="arhxitekturo">Arĥitekturo</a>
--------------------------------------

Ne malnepras arĥitekturo. La kodo bezonas komputademan modelon kaj subtenantan arĥitekturon: kio estas la praaj eventoj kaj kombinatoroj? la kohereca postuloj? la sekureca postuloj? la erartraktadaj meĥanismoj? Plej multo da homoj, eĉ la plejparto de bonaj programistoj, ne pensas pri komputademaj modeloj kaj arĥitekturo; kaj tio bonas. Se oni bezonas teĥnikan gvidanton kiu ja havas bonegan arĥitekturan vidon, aŭ la programara baso elfalos sub la pezo de nebontenebla komplekso. Ĉu vi havas iun ajn en la teamo kiu kapablas pensi pri arĥitekturo? Ĉu ĝi povas kunhavigi sian vidon kun aliaj teamanoj, kaj aprobi aŭ malaprobi ŝanĝojn pere de ĝia vido? Se estas diskordoj inter pluraj opcioj, ĉu estas iu kiu traktas aferojn povas kompreni la problemojn?


<a name="rekompencoj">Rekompencoj</a>
-------------------------------------

Gravas rekompencoj. La dungitaro devas esti organizita efektive: ĉu ĝustaj taskoj faritaj ĝuste pere de la ĝustaj homoj? Kiam la homo kun la informo por fari aferojn ĝuste ne estas la sama homo kun la kapablo for fari aferojn ĝuste, ne estas la sama homo kun la rimedoj por fari aferojn ĝuste, aŭ ne estas la sama homo kun la rekompencoj por fari aferojn, kiel la organizo traktos la transmeton de informo, kapablojn, rimedojn, kaj rekompencojn por ke ili eventuale estu kunigitaj al unu homo kiu faras ĝin. Kiel oni malpliminimumigos kostan kunordigon inter laborantoj, aŭ plej malbone inter teamoj? Klasika ekzemplo estas fondi severan hierarĥion, en kiu ĉiu neloka transmeto devas iri tra la pli supraj niveloj de la piramido, kiu facile fariĝos botelkolo kiel la organizo kreskiĝas. Pli malbone, dum homoj tendencas kompreni informon, kapablojn, kaj rimedojn, pli multe da ili ŝajnas ne havas bonan komprenon de rekompencoj, kaj daŭras perpleksigita kial aferoj ne estas traktitaj kiam «ciom» da statikaj eroj jam estas tie, ĉar ili estas maleble akcepti, ke la dinamikaj rekompencoj de laborantoj kaj teamoj ne akordas kun la celo de la organizo. Ĉu tiu kiu prilaboras formi la organizon komprenas rekompencojn? Ĉi tio ne nur estas pri kontroloj por malebligi laborantojn aŭ estrojn por kuri berserke kun la rimedoj, ĉi tio estas pri certigi ke la celoj de ĉiu teamo kaj anoj akordas al unu la alia, anstataŭ malakordas al unu la alia, igi ilin havi negativan produktivecon ju pli ili laboras «kune». Kio estas la ĝusta proceduro kiam aferoj malĝustiĝos? Ĉu la organizo havas retrokuplan ciklon en la maniero en kiu ĝi estas organizita?


<a name="retrokuplo">Retrokuplo</a>
-----------------------------------

Igu retrokuplajn ciklojn mallongaj. Kiel longe estas viaj retrokuplaj cikloj inter la postuloj por ŝanĝo kaj provizo de solvoj? La observi-orienti-decidi-ciklo precizigas kiel rapide oni povas adapti al la merkato, kiel rapide oni povas fari kaj testi sciencajn hipotezojn, kiel rapide oni povas malkovri eblojn kaj kontroli ĉu ili portas valoron, kiel rapide oni povas ŝanĝi la decidojn kaj kontroli ĉu ili estas fakte plibonigoj, ktp. Iuj resumas ĝin kiel «eldoni ofte», kaj estas jam kontentigaj se ili havas oftan eldonan tempoplanon; sed tio estas falsa. Necesas eldoni ofte se kaj nur se la kliento estas parto de la retrokupla ciklo, en kiu povas esti la kazo se oni muntas konsumantan retejon, sed nepre ne estas la kazo se oni muntas vivkritikan aparaton. Tamen, eldoni ofte neniam estas sufiĉa: se oni eldonas ĉiumonate, sed ĉiu ŝanĝo fakte bezonas kvar monatojn, kaj oni nur duktigas kvar aŭ pli da ŝanĝoj samtempe, do via retrokupla ciklo ankoraŭ okazas dum kvar monatoj, ne nur unu monato. Kompreneble en sufiĉa granda organizo, ne nur estas unu retrokupla ciklo, sed estas multaj retrokuplaj cikloj; la longaj cikloj signifas, ke aferoj necese fariĝos difektaj antaŭ ol ili alĝustiĝos. Kaj se oni ne ĝustigas aferojn pere de la retrokuplo ricevita, oni ne havas retrokuplan ciklon.


<a name="mezurado">Mezurado</a>
-------------------------------

Mezurado ne estas anstataŭigo de juĝo. Estas io kiu estas pli malbona ol longa retrokupla ciklo: oni eble uzas informon por aktive fari ĝustigojn kiu formas la firmaon kontraŭproduktive. Ekzemple, oni eble mezuras la nombrojn de problemojn riparitaj de ĉiu teamano, kaj rekompencas dungitojn per ĝi, gvidante al dungitoj enkonduki pli da cimoj, dividi ĉiun cimon al multe da sendepende registritaj aferoj kaj subaferoj, kaj uzi duonan da tempo ĉe la aferkontrolsistemo anstataŭ al la aferoj mem. Aŭ oni eble rekompencas programistojn pere de la kvanto de linioj da kodo, gvidante al malbontenebla koda ŝveliĝo. Mezuri aferojn gravas por eltrovi anomaliojn kiuj devas esti traktitaj, sed estas grave ne uzi mezursistemojn kiu distordas rekompencojn, aŭ oni falas kiel viktimo al la [proverbo de Goodhart](http://en.wikipedia.org/wiki/Goodhart%27s_law). Kaj cetere, kio ajn klopodoj oni etendas por mezuri aferojn kiuj ne gravas, aŭ faras ion ajn kiuj ne gravas, estas klopodo kiu oni ne etendas fari aferojn kiuj gravas.
