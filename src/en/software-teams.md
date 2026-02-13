---
title: Architectural Principles for Software Development Teams
keywords: software, architecture, principles, development, teams
image: https://ebzzry.com/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg
---
Architectural Principles for Software Development Teams
=======================================================

<div class="center">English ⊻ [Esperanto](/eo/programadaj-teamoj/)</div>
<div class="center">2025-12-28</div>

>Don’t tell me how hard you work. Tell me how much you get done.<br>
>—James J. Ling

<img src="/images/site/mateo-krossler-rJ-CD2e7iMQ-unsplash-2000x1125.jpg" style="display: block; width: 100%; margin-left: auto; margin-right: auto;" />


<a name="toc">Table of contents</a>
-----------------------------------

- [Background](#background)
- [Introduction](#introduction)
- [Changes](#changes)
- [Team](#team)
- [Shrink](#shrink)
- [Culture](#culture)
- [Language](#language)
- [Machines](#machines)
- [Open-source](#opensource)
- [Deployment](#deployment)
- [Configuration](#configuration)
- [Tests](#tests)
- [Monotonic](#monotonic)
- [Upgradability](#upgradability)
- [Managers](#managers)
- [Plans](#plans)
- [Architecture](#architecture)
- [Incentives](#incentives)
- [Feedback](#feedback)
- [Measurement](#measurement)


<a name="background">Background</a>
-----------------------------------

With explicit permission, the following article is a repost from a
[blog post](https://fare.livejournal.com/171998.html) by
[François-René Rideau (Faré)](http://fare.tunes.org) in May 29, 2013. Fare’s
ideas on how software development should be done, have stood the test of time.


<a name="introduction">Introduction</a>
---------------------------------------

Many software development organizations fail to follow these principles and pay
the price, which can lead to failure.  Google mostly doesn't make the mistakes
of going against them, though some projects at ITA used to.


<a name="changes">Changes</a>
-----------------------------

Every change should be reviewed, seriously. Code reviews not only improve code quality by having more eyes to find bugs, but most importantly they build the mutual knowledge of the code base, and cross-pollinate minds of team members.  This may look like it slows you down in the very short term, but is essential in the long run.  If you need to check in a critical fix right now, interrupt a colleague and get the just as critical review right now.  If it's so urgent that you can't wait for a review when no colleague is available at the moment (in the middle of the night, or they are all sick, in vacation, or in a retreat), then get it reviewed after the fact, but get it reviewed still (and of course run automated tests — your infrastructure won't let you commit and deploy without those tests, will it?); but such retro-active review is a symptom of failure and should remain an exception.  All your code must be subject to the same standards of quality, review and testing; no exception.  This requires that all code you write, you should write using a language and an according build and testing infrastructure that are part of a culture that you are actively growing.  Any "script" written in a way that violates those standards is a failure, however expedient it may seem at first, or a symptom of a bigger failure.  More on that below.


<a name="team">Team</a>
-----------------------

Change should never require more than one team. Every change requires at least one team, since all code must be reviewed.  But every time two or more teams are involved in implementing and deploying a single change, this means increased cost and time to synchronize these teams on one or multiple interfaces, which makes for a slower, damper, feedback loop.  Worse, these interfaces create conflicts of interest and become the locus of scar tissue as each team builds layers of cruft to protect itself from the changes of the other teams.  Due to each team's "investment" in it, these interfaces survive long past any validity they may once have had, which means you get to forever keep using the interfaces you threw together without much design back when you didn't know better.  Don't split your teams in horizontal layers of functionality.  An exception might be when the lower layer follows a commodity interface, and it is easy to experiment without it and switch away from it as needed, modulo change in price and quality.  Note that people with similar role (e.g. all test engineers) tend to share common concerns and congregate, exchanging information and developing tools together; that's perfectly fine and should be encouraged, not prevented; still they do not make a useful unit of decision making and responsibility taking, and should therefore not be constituted as a "team".


<a name="shrink">Shrink</a>
---------------------------

Your teams should be able to shrink as well as grow. Adding human resources doesn't require much thought, though it does require thought to add them effectively.  However removing human resources does require a lot of thought to keep the team functioning at all; yet that's something you will have to do.  Whether successful or unsuccessful, your software if launched at all will eventually be left in maintenance mode while people move on to their next project (which may or may not be a next version of the successful software), and your extant maintenance contracts may run for years during which time you'll have to run with reduced resources.  And if only mildly successful, you may have to downsize your team to adapt to the market.  In any case, a project not organized to scale down will soon enough have negative net present value as its maintenance costs far outweigh the generated revenues.  If you need fourteen different on-call rotations just to keep your service running, you're most likely doing it wrong.  So don't add gratuitous complexity; don't multiply components; don't divide into more teams than necessary; don't adopt multiple incompatible build and test infrastructures.  Which again leads us to the next point.


<a name="culture">Culture</a>
-----------------------------

Grow a culture, don't live off the land. Pick one good language (or a combination of a handful of complementary languages), and stick to it, invest in it, build infrastructure and proficiency around it, improve its ecosystem — your productivity will greatly increase as a result.  If you behave like a hunter-gatherer and pick whichever random languages and tools happen to be available for the job, without building a coherent community inside and outside your company, you will accumulate complexity you can't afford to maintain (see above), rest your services on a haphazard set of shoddy "scripts", dilute your efforts in many unhealthy small niches, multiply infrastructure costs, including the cognitive load on workers; your people and sub-teams will each grow their own subculture that no one else knows, and so won't be able to move between projects or maintain each other's code; your organization won't be able to change and adapt.  Investing in multiple cultures, while possible, will be a real drain on your resources, which can be fatal unless your company is big; and even a big company can only afford to grow so many cultures and keep all of them vibrant.


<a name="language">Language</a>
-------------------------------

Pick a programming language that scales. To grow a healthy culture, you must pick a single language that can handle your entire software stack, from the highest-level aspects to the lowest-level.  Common Lisp, Scala, F#, Haskell, OCaml, Clojure, Erlang, Racket, are possibly valid choices, depending on the context; many other languages may or may not qualify.  The point at hand isn't to discuss the merits and failures of various existing languages and establish a definitive list of decent languages; there is a changing market and there are many valid reasons why specific people working on a specific project might pick or not pick any given language over given competition.  The point is that you should pick a one language, the best you can find for you to implement your current and future intended tasks; and thereafter all your code should be in your language of choice, with only trivial wrappers and a few performance-critical loops in any other language, plus maybe some code to adapt your IDE to your language and style.  Every "script" needed to build your system or hold it together is a failure, whether in Bash, Zsh, Python, Perl, Ruby or any language except your language of choice.  Anything more than a performance-critical loop in C, C++, Java, Assembly or PL/SQL is a failure.  Any text-based code generator outside your normal build tools is a failure.  All these failures will come bite you in the end, preventing the refactoring of your code and/or your team when you need it most.  Yet "failure" does not mean you shouldn't do it — indeed the reason you do it is that not doing it would be a bigger failure; but each decision to violate the principle of sticking to a supported programming language is a symptom that this programming language has failed you.  Repeated failures may be the symptom of your having chosen a bad programming language to work with. If you made a bad decision, it's still time to fix it by adopting a better language.  But then do it right and don't build a concurrent culture: instead adopt that language for all development going forward, and slowly or quickly migrate or phase out past projects as needed.  Sure, keep experimenting with other languages; but the result of the experiment should be adoption or rejection, not dilution of your ecosystem.


<a name="machines">Machines</a>
-------------------------------

Don't have humans do the job of a machine .If you're manually transforming UML diagrams into code, writing a relational schema to match your object schema, following design patterns, coding in a low-level language, or otherwise doing through human labor what a machine could do, you're not just wasting precious company resources, you're committing a crime against the human mind.  Atone for your sin, or you'll end up in hell, as human labor is not just orders of magnitude more costly than computer labor for mindless repetitive tasks, it is also far more error-prone.  Subtle discrepancies will creep in between what was intended and what is implemented; shortcuts will be taken that really shouldn't; pieces will be missing.  In the end, this will lead to countless hours of debugging, and yet extremely bad quality code.  Meanwhile, every minute spent doing what a machine could do is a minute not spent doing what only a human can do (for now).  A corollary of this principle is that the language you choose above should provide a decent solution for metaprogramming.  Like Olin Shivers, you should object to doing what a computer can do.


<a name="opensource">Open-source</a>
------------------------------------

Use open-source tools everywhere you can. For any software not part of your core assets, that you keep as a trade secret for competitive advantage, you should be using, improving and/or developing the best available open-source tool.  Don't reinvent your own private wheel.  If it's not your main specialty, odds are you'll make it square, anyway; in any case, it will be a distraction to do a really good job at it all on your own even assuming you manage to do it.  And if you do possess cool software in-house, by not releasing it, you are not saving engineering resources, you are only keeping yourself out of the loop, and making it harder for you to recruit, and losing in both productivity gains and worse in community signals about what you're doing right or wrong.


<a name="deployment">Deployment</a>
-----------------------------------

Deployment should be automated at the push of a button. If a successful production deployment requires more than a single person pressing a button to validate the new code revision after successful tests, you're doing it wrong. If your tests themselves require a person at all, you're doing it wrong. In particular, don't have separate teams for "Development" and "Ops", or "Development" and "QA"; that's a recipe for test and deployment disaster (see also the second principle above). If the product can't be deployed, the development isn't complete yet; if the code doesn't include a test, the development isn't complete yet. You should thus use some infrastructure that automates reproducible testing and deployment of the entire distributed system. As per the previous point on open source software, unless deployment of distributed systems is your core business, you should be using and partaking in an existing open source solution such as NixOS and DisNix.


<a name="configuration">Configuration</a>
-----------------------------------------

Minimize configuration. Any setting that differs between test and production is the opportunity for a major screw-up.  Your tests should include checks against these opportunities, that ensure that nothing is amiss in what little production configuration is needed, even if you don't run tests directly using that configuration.  Any configuration setting you can't test in advance, should have a corresponding manual test on the production deployment checklist.


<a name="tests">Tests</a>
-------------------------

Tests should be runnable without costly setup. If you need ten minutes to build some huge mutable state just to be able to run functionality tests, you're doing it wrong, and won't be able to scale.  Run tests from pure immutable data that is trivial to share; if you need a mutable database, use copy-on-write from baseline test data.  Also, no any individual test should require more data than necessary to run it.  Have a data coverage system to automatically determine what data was necessary during some code run. Oh and of course a code coverage system to automatically determine what code was tested or not.


<a name="monotonic">Monotonic</a>
---------------------------------

Use monotonic (append-only) database semantics. Have your transaction logs always include commit ids and time stamps identifying all code, data and configuration, so it's always trivial to replay any production bug.  Make it easy to extract a minimal relevant subset of immutable data from the reproduced bug so you can import it in your regression test suite (after automatically scrubbing any sensitive information, of course).


<a name="upgradability">Upgradability</a>
-----------------------------------------

Include upgradability in your dynamic application model. Upgradability is important; and isn't just a matter of a static data model.  Use schema tools that can deal with multiple schema versions whereby you can always upgrade from any previous one.  Don't be content with a tool that can only represent the "current" schema.  Keep the regression test data upgradable and test against it.  Code and data upgrades are a normal part of the development cycle, to be supported by your normal tools, not an unforeseen exception.


<a name="managers">Managers</a>
-------------------------------

Managers are schedulers, not proxies. The role of a manager is to prioritize tasks, allocate resources, connect people.  It is emphatically not to make technical decisions, oversee technical implementation, or be a middleman in passing around technical information. Technical leads should make the technical decision, and peer code review should be the oversight mechanism; the manager shouldn't be involved in either — at least not as such: indeed it is quite possible that the same person could wear two caps, and be simultaneously manager and technical lead, especially when working in small teams, which can actually be a good idea when it's possible; then said person can take as technical lead decisions that he shouldn't take as manager.  As for information middlemen, they only decrease bandwidth, introduce noise and add latency, and therefore should not exist in the organization ([don't confuse](http://youtu.be/k2h2lvhzMDc?t=10m10s) the organization structure with the communication structure).  A manager should allocate human and material resources, and make adjustments as new information is available; but after subscribing the relevant people on the issue tracking system and making sure that the goal is clear and his managees are working towards it, he should otherwise let them sort it out and not only get the hell out of their way, but actively remove obstacles from their work, including any distraction from customers, himself, other managers, internal and external politics, etc.  Any manager who steps out of his role by doing any of the above no-no's should be fired for cause; much worse if he bullies workers or sets to build an empire.


<a name="plans">Plans</a>
-------------------------

Failing to plan is planning to fail. Work organization is not a natural thing people were evolved to do without thinking.  It requires careful thought to get it right.  Never try not to think, it won't work.  If you work from one artificial short deadline to the next artificial short deadline, always in alert mode thinking in the short term, and ever postponing the need to address big picture issues, then you won't have any long term to think about, and you're setting yourself up for failure: the big picture of your organization is one of miserable agitation followed by death; and you'll have been deliberately painting that picture by refusing to open your eyes and to look forward.  You need to intentionally design your system, along many axes: code, people, time, etc.


<a name="architecture">Architecture</a>
---------------------------------------

Architecture is not optional. Your code needs a computational model and a supporting architecture: what are the primitive events and combinators?  the consistency requirements? the security requirements?  the error handling mechanisms?  Most people, even most good programmers, don't think about computation models and architecture; and that's OK.  But you need a technical leader who does have a good architectural vision, or your software base will crumble under the weight of unmaintainable complexity.  Do you have anyone in your team capable of thinking about architecture?  Can he share his vision with other team members, and vet or reject changes based on this vision?  If there are disagreements between multiple options, is anyone in charge who understands the issues?


<a name="incentives">Incentives</a>
-----------------------------------

Incentives matter. Your people need to be organized in an effective way: is your organization such that the right job is done by the right person?  When the person with the information to get things done isn't the same as the person with the skill to get things done, isn't the same as the person with the resources to get things done, or isn't the same as the person with the incentive to get things done, how does your organization manage the transfer of information, skills, resources and incentives so they are eventually conjoined into one person who does it?  How do you minimize costly coordination between workers, or worse between teams?  A classic mistake, for instance, is to institute a strict hierarchy, where every non-local transfer has to go through the upper levels of the pyramid, that quickly become a bottleneck as the organization grows.  Worse, while people tend to understand information, skills and resources, most seem not to have a working understanding of incentives, and remain stumped why things don't get done when "all" the static elements are there, because are unable to recognize that the dynamic incentives of workers and teams are not aligned with the goal of the organization.  Does whoever is in charge of shaping the organization understand incentives?  This is not just about checks to prevent workers or managers from running amok with resources, this is about making sure that the goals of every team and member are complementary with each other, rather than in conflict with each other, causing them to have negative productivity the more they work "together".  What is your correction procedure when things will go wrong?  Does your organization have a feedback loop on the way it is itself organized?


<a name="feedback">Feedback</a>
-------------------------------

Keep feedback loops short. How long are your feedback loops between demands for change and supply of solutions? Your "OODA loop" determines how fast you can adapt to the market, how fast you can make and test scientific hypotheses, how fast you can invent features and see if they bring value, how fast you can change your designs and see if they are actual improvements, etc. Some people summarize it as "release often", and are satisfied if they have a frequent release schedule; but that's bogus. Releasing often is necessary if and only if the customer is part of your feedback loop, which might be the case if you're building a consumer website, but definitely isn't the case if you're building a life-critical device. However, releasing often is never sufficient: if you release every month, but each change actually takes four months, and you're just pipelining four or more changes at once, then your feedback loop is still four month long, not one month long. Of course in a large enough organization, there is not just one feedback loop, but plenty of feedback loops; the long ones will mean things necessarily get out of whack before they get adjusted. And if you don't actually adjust things based on the feedback received, you don't have a feedback loop.


<a name="measurement">Measurement</a>
-------------------------------------

Measurement is no substitute for judgment. There's worse than having a long feedback loop: you could be using information to actively make adjustments that shape your company in counter-productive ways. For instance, you could be measuring the number of issues resolved by each team member, and rewarding employees based on that, leading to employees introducing more bugs, splitting every bug into plenty of independently registered issues and sub-issues, and spending half their time on the issue-tracking system rather than on the actual issues.  Or you could reward developers based on lines of code, leading to unmaintainable code bloat.  Measuring things is very important to detect anomalies that need to be addressed, but it is important not to use measurements in a way that will skew incentives, or you'll fall victim of [Goodhart's law](http://en.wikipedia.org/wiki/Goodhart%27s_law).  Also, whatever effort you expand on measuring things that don't matter, or doing anything that doesn't matter, is effort you don't expand doing things that do matter.
