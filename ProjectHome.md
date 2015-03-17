Minimal and fast Fuzzy logic engine for games written in AS3.

DEMO:
http://www.winx.ws/blog/fuzzyDemo/index.html

BLOG:
http://winxalex.blogspot.com/2010/08/fuzzy-logic-games-library-01-in.html

Minimal and fast Fuzzy logic engine for games written in AS3.

Update: 06.02.12

The intention of library isn't making script inside AS3 script and not replacement of IF THEN condition of AS3

> Have you ever made living entities. How you made control of them for example using their ammo type depending of quantity of ammo and distance?

Simple! if(ammo&gt;200 &amp;&amp; distance==100) shootRocket() else if....shootOther thing. Decision TRUE or FALSE.

Is that so robotic and crisp? Doesn't using human logic?

Human think like this: The target is far or quite far or not so far or near...or I've loads of ammo or quite enough to lunch or okey. This way of thinking decision values isn't so crisp and they are overlapping between themselves, for example "few" might mean let get ammo or shoot one,two more shoots... meaning some decision can have some degree of truth.

Lets define fuzzificatior:

> fuz=new Fuzzyficator();

Lets define our ranges of Distance in human fuzzy logic inside group(FuzzyManifold).

> manifold = new FuzzyManifold("Distance\_to\_Target");

//we define input (changes of "Distance\_to\_Target" are connected thru this input to the fuzzificator)

> manifold.input = distanceStatusInput;



Functions defining ranges (Membership Functions) can be Triangle, Trapezoid, Gauss and many others.

//You can add function base points with separator, or like array [.md](.md) or like string with separator.

//Close would be everything(every distance) from 0 to 125

> func = factory.create(FuzzyMembershipFunction.LEFT\_SHOULDER, "Close", 0,25, 125 );//[0 25 125](0.md)

//Medium distance would be from 25 to 300

> func = factory.create(FuzzyMembershipFunction.TRIANGLE, "Medium", 25, 150, 300 );// [150 300](25.md)

> manifold.addMember(func);

//Far would be everything from 150 to 400

> func = factory.create(FuzzyMembershipFunction.RIGHT\_SHOULDER, "Far", "150, 300,400","," )  ;//  [300 400 400](150.md)

> manifold.addMember(func);

//Close would be everything(every distance) from 0 to 125 and Medium from 25 to 300 so

they overlap. Some target at distance 90 can be CLOSE an MEDIUM too with some degree of truth.

.

Ammo\_status group of ranges would be defined like this:.

You can have other inputs too like "Enemy\_Type", "Weapon\_Precision"....

and decision of selection of weapon based on ammo and distance:

How we can avoid classical IF THEN  statements  and still we have control?

We are defining FuzzyRules which can be any logical condition =&gt; result statements.

> rule = new FuzzyRule( " IF Distance\_to\_Target IS Far AND  Ammo\_Status IS Low THEN Desirability IS Undesirable ");

> fuz.addRule(rule);

> rule = new FuzzyRule( "IF Distance\_to\_Target IS Medium AND Ammo\_Status IS Loads THEN Desirability IS VeryDesirable ");

> fuz.addRule(rule);

> rule = new FuzzyRule( "IF Distance\_to\_Target IS Medium AND Ammo\_Status IS Okey THEN  Desirability IS VeryDesirable ");

> fuz.addRule(rule);

...so one every vs every possibility. Now I would mention reduction methods(methods reducing number of rules with same or approx same effect) but there are out of scope now.

> Update: 06.02.12

Rules  can be weighted (default weight=1)  and quantities can be quantified (VERY, SOMEWHAT) for ex. VERY VeryDesirable.

Rules are entered as strings in common language so developer is CLEAR how the condition are set and what is controlled.

Parser use RegEx and it should be quite fast.

Parser parse only once for building stack and compiled stack is used for every evaluation afterwards. You can compile export steak as AMF ByteArray and import in your run time game so no parsing is done at all.

You can also build your rules using OO:

rule = new FuzzyRule();

> tempStek = new Vector.(3,true);

> // creation antescendent(condition stack) stek like "Distance\_to\_Target IS Far AND Ammo\_Status IS Okey"
> tempStek[0](0.md) = new Token(0, FuzzyOperator.fDOM, ["Distance\_to\_Target", "Far", fuz]);
> tempStek[1](1.md) = new Token(1, FuzzyOperator.fDOM, ["Ammo\_Status", "Okey", fuz]);
> var result:Token=tempStek[2](2.md) = new Token(2, FuzzyOperator.fMIN, [tempStek[0](0.md), tempStek[1](1.md)]);
> rule.antCompiledStek = tempStek;

> // creation result stack like "Desirability IS Undesirable"
> tempStek = new Vector.(2,true);
> tempStek[0](0.md) = new Token(0, fuz.implication, [result,new Token(0,null,null,1)]);
> tempStek[1](1.md) = new Token(1, FuzzyOperator.fAGGREGATE, ["Desirability", "Undesirable",fuz,rule.weight,tempStek[0](0.md)]);

Let say in current checking tick we have 8 ammo and target is 200 far:

ammoStatusInput.value = 8;

distanceStatusInput.value = 200

> In the classical IF THEN statements only one of them will be true and in Fuzzy logic one or more rules can be true with some degree of truth( from 0 -totally untrue to 1 totally true) or current value of ammo quantity can have DOM(degree of membership in one of our memberfunctions LOADS,OKEY ,LOW)

> fuz.Fuzzify();

> Above process involve calculation DOM(degree of membership of every input value inside ranges-fuzzy member function), evaluation of the rules depending of the DOM and IF condition, implication and aggregation.

At the and we need crisp value so we made decision how desirable is this weapon:

fuzzyManifolds = fuz.Defuzzify(DefuzzificationMethod.CENTROID);



> trace("OUTPUT COG:" + FuzzyManifold(fuzzyManifolds["Desirability"]).output);

There are many defuzzification methods available. One of most accurate COG is used only for comparation with Math Lab but recommended for computer application is MaxAv (speed/accuracy).

What is demo about. See when target is at medium distance pistol is used against as best at medium range and best ammo quantity(30 ammo at start). When target got near shot gun is best despite have 10 ammo total, and when is very close knife, then switching to what is desirable( if no ammo in shoot gun shoot pistol no mater target is close and less desirable weapon).

Its planned Gauss function to be involved in future releases for more smooth transition.

SUGGESTIONS, REQUESTS OR CONTRIBUTION ARE WELCOME.


