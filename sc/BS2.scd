/*

////
s.boot;
s.volume.volume_(24)

NetAddr.langPort

a = BotSynth2.new(s, botSynthName: "p1n1", synthDefName:"fm1");b = BotSynth2.new(s, "p1n2", "fm1");
s.freeAll;


TODO:
	switching bs and ss, out of sync (phase)
py
	chatserver->osc only works only when two clients are logged in ?

	ncurses, color, presets, state etc.
	command history !!
	auto-completion
	-> maybe there's a library for all these ..?

	local: let client have his intrument(s) on his own computer (cue/prelisten)


OSCFunc.trace(bool: true, hideStatusMsg: false)
OSCFunc.trace(bool: true, hideStatusMsg: true)
OSCFunc.trace(bool: false, hideStatusMsg: true)
OSCdef(\test,{|msg, time, addr, recvPort| \oneShot.postln}, '/p1n2', nil).oneShot;

OSCdef(\p1n2,{|msg, time, addr, recvPort| msg.postln}, '/p1n2');
OSCdef(\p1n3,{|msg, time, addr, recvPort| msg.postln}, '/p1n3');

n = NetAddr.localAddr;
n.sendMsg("/p1n2", 56,56,78)
a.patt


NO: n.sendMsg("/p1n2", "asas".ascii)
s.freeAll;


*/

////////////////////////////////////////////////////

s.reboot
s.freqscope

Server.local.waitForBoot{

a.free;


b.free;
a = BotSynth2.new(s, botSynthName: "p1n1", synthDefName:"fm1");
b = BotSynth2.new(s, "p1n2", "fm1");
s.queryAllNodes;



a.free;
a = BotSynth2.new(s, botSynthName: "p1n1", synthDefName:"sspulse");


};


/*
(
e=IdentityDictionary.new;
8.do{|i|
	var bs;
	n = "p1n" ++ i.asString;
	b=BotSynth2(s, n, "fm1");
	e.put(n.asSymbol,b)
};
e[e.keys[0]]
)
*/

"ok".postln













//////////////////////////////////////////////////////////////////////////////////////////////

BotSynth2


Holds a synth and a pattern player.
Expects a pattern from an oscbot, but the pattern can be given directly too.

/////////////////////////////////////////////////////////////////////////////////////////////*

class methods:
	sync(stepSync, tempo)
		sync all locally running botsynths

instance methods:
	new(server, botSynthName, synthDefName)
								: start a new botsynth

	free 						: stop playing and clean up

	sync(stepSync, myNewTempo)  	: (re)sync this botsynth, if stepsync is false, use barsync

	synth_(synthDefName/synthFunction)
								: replace synth by synthdefname or function

	patt_(array/string) 			: set a pattern
	patt 						: get pattern

	process(synthDefName/synthFunction)												: replace effect by synthdefname or function


classvar <>shfl=0
var <>verbose=false, <>barLength=8, <>stepSynC=true, <>pmod = 127, <>transp=0, <pattlength,
<>botPid, <irssiPid, <amp=0.4, <server, <clock, <sy, <proc, <task, <oscTag,
<synthDefName="fm1", <procDefName="procverb", <group

*/////////////////////////////////////////////////////////////////////////////////////////////

s.boot;

// start a botsynth
a = BotSynth2.new(s, botSynthName: "p1n2", synthDefName:"fm1");
s.queryAllNodes;
// free it
a.free;
s.queryAllNodes;

////////////////////////////////////

a = BotSynth2.new(s, "h4nk", "fm1");

(
// another sound
SynthDef(\sound1, {arg out=0, t_trig=1, freq=440, dcy=0.2, amp=0.2;
	var snd, env;
	env = EnvGen.ar(Env.adsr(0.001,0.1,0.1,dcy), t_trig);
	snd = SinOsc.ar(freq);
	Out.ar(out, snd.tanh * amp * env)
}).store
)

// test it
x = Synth(\sound1)
x.set(\t_trig, 1, \freq, 1300, \dcy, 0.1)
a.sy.set(\t_trig, 1, \freq, 1000, \dcy, 4.4, \amp, 0.5)
x.free;

// play it in the botsynth
a.synth(\sound1)
s.queryAllNodes;

a.controlNames // post params
a.sy.set(\dcy, 0.1)

// the ascii <-> midinote relationship
a.patt_(".___");
a.patt_("..._ABD,iod.")

a.patt_([60, 70, 89])
a.pmod_(127).transp_(0)
a.patt_([60, 70, 91])

// see what's in there
a.patt

// " needs to be escaped
a.patt_("<N"8") // error...
a.patt_("<N\"8")

// _ is a musical rest (it's ascii value 95)
a.patt_("<N-__\"8")
a.patt

// pass pattern as an array of MIDI notes
a.patt_([95,89, 95, 95, 68, 95, 45, 67])
a.patt_([ 46, 46, 46, 95, 65, 66, 68, 88, 40 ])
a.patt


//// simple automation
{ 4.do{ a.patt_([80, 90, 45, 65].scramble * [0.33, 0.5, 0.75, 1, 1.5].choose); rrand(3,12).wait } }.fork;

// need .ascii here in order to do typical array manipulations like scrambling
{ 4.do{ a.patt_("..._ABD,".ascii.scramble * [0.33, 0.5, 0.75, 1, 1.5].choose); rrand(3,12).wait } }.fork;
{ 5.do{ a.patt_("00_D#________3QQAASS".ascii.scramble * [0.5, 0.75, 1, 1.5].choose); rrand(1, 4).wait } }.fork;

a.patt_("abcdefghijklm")

////////////////////////////////////

// timing
a.sync(true, 80); // stepsync(true)/barsync(false), tempo in BPM

a.sync(false, 80);

a.barLength_(3)
a.barLength_(1)
a.barLength_(8)

// default
a.sync(true, 110);


////////////////////////////////////

// limit range and transposition
a.pmod_(60)
a.transp_(32)
// default setting is 127 (midi notes) and no tranposition
a.pmod_(127).transp_(0)

a.patt_("0938")
a.patt_(",...")

////////////////////////////////////

a.sync(true, 106);

// synths
a.synth(\ana2)
a.sy.set(\sfreq, 10, \pfreq,650, \pwidth,0.1, \dcy,0.071, \pdcy,1.4, \ffreq, 7000)

a.synth(\fm2)
s.queryAllNodes

// or:
a.synth({ |freq, amp=0.2| SinOsc.ar(freq!2, 0, amp)})
a.synth({ |freq, rnd=0.0001, amp=0.2| Pan2.ar(SinOsc.ar(freq, 0).round(rnd).cubed.cubed, SinOsc.kr(1), amp) })
a.sy.set(\rnd, 0.1)
a.sy.set(\rnd, 0.001)

(
SynthDef(\mySound, {| outBus=0, t_trig=1, freq=1040, dcy=0.1, amp=0.4|
	var snd, env = EnvGen.kr(Env.perc(0.01,dcy), t_trig, doneAction:0);
	snd = Pan2.ar(SinOsc.ar(freq,0,env).cubed.cubed,0);
	Out.ar(outBus,snd * env * amp);
}).store;
)

a.synth(\mySound)
a.synth(\fm2)

////////////////////////////////////

// fx defaults to a reverb (procverb)
a.process;
a.controlNames
a.proc.set(\room, 10, \damp, 0.2, \mix, 0.4)
a.proc.set(\room, 0.1, \damp, 0.4, \mix, 0.9)

// supply a function or synthdef
v = { |in=0, room=1.7, damp=0.05, rnd=0.02, mix=1| FreeVerb.ar(In.ar(in), mix, room, damp).round(rnd) };
a.process(v)
a.proc.set(\rnd, 0.03)
a.proc.set(\rnd, 0.2)

// procverb, procfdly, and procgain are built-in
a.process(\procgain)
a.proc.set(\gain, 200)

a.process(\procfdly)
a.controlNames
a.sy.set(\ffreq, 4080)
// relate delay to tempo
a.proc.set(\time, a.clock.tempo.reciprocal * 1.5)
a.proc.set(\ffreq, 7200, ,\rls, 4, \dcy, 10, \mix, 1.9, \amp, 0.7)

a.patt = "..#..#";
a.patt = [70, 80, 72, 0, 0, 60, 60];

a.patt = "/..pr**..pr@,.!p000p!!,.\pr$$";
a.patt = "@!.#..#@!...>>";
a.patt = "@!.#..#@!...>>???";

a.patt = "!!.#!!.#!!---!.#";
a.patt = "5!.1!!.#!!---!.#";
a.patt = "!  !  !a1 ";


a.synth(\drum2)
a.patt_(",_xA_.x,,_xT_.x.")
a.process(\procfdly);
a.controlNames
a.proc.set(\mix, 1);


(
	Tdef(\auto3, {|envir|
		envir.tm = a.clock.tempo.reciprocal;
		envir.patterns = [",_xR", "_.x,,_xT", "K.x.", "__xR_.#_", ",_xTK.Zz", ",_xA_.x,,_xT_.x.",
		",_xR_.x,,_xTK.x.", "__xR_.#_,_xTK.Zz", ",_xA_.x,,_xT_.x."];

		inf.do{|i|
			j = i % envir.patterns.size;
			a.patt_(/* envir.patterns[j].ascii.scramble */ envir.patterns[j]);
			(envir.tm  * [1, 2, 3, 4].choose).wait;
			a.sy.set(\ffreq, exprand(200, 17000));
			a.proc.set(\ffreq, exprand(800, 17000));
			(envir.tm  * [1, 2, 3, 4].choose).wait;
			// a.proc.set(\time, 1 / ((12 + 60.rand).midicps));
			a.proc.set(\time, envir.tm  * [0.375, 0.75, 1.5].choose);
			(envir.tm  * [1, 2, 3, 4, 6, 8, 12].choose).wait;

		}
	}).play(a.clock)
)

Tdef(\auto3).stop
Tdef(\auto3).play

a.proc.set(\ffreq, 10000, \time, 0.1, \dcy, 14, \rls, 13, \amp, 2)

q.tempoMul = a.clock.tempo.reciprocal;
a.proc.set(\time, q.tempoMul * 0.375)
a.proc.set(\time, q.tempoMul * 0.75)
a.proc.set(\time, q.tempoMul * 1.5)
a.proc.set(\time, q.tempoMul * 3)

a.patt_(",_xR_.x,,_xTK.x.")
a.patt_("__xR_.#_,_xTK.Zz")
a.patt_(",_xA_.x,,_xT_.x.")

a.patt = "5!.1!!.#!!---!.#";
a.patt = "!!.#!!.#!!-9-!.#";
a.patt = "!!.#!!.#!!-5-!.#";

// supply a function

s.queryAllNodes;

a.sync(true, 110)


a.patt_(",,, ... .. ,,")
a.patt_(",,, ... ..D,,")



/////////////////////////////////////////

b = BotSynth2.new(s, synthDefName:"ana1")
b.patt_(",,, ... .. ,,")
b.patt_(".___")

b.controlNames;
a.sy.set(\dcy, 0.2);
b.sy.set(\dcy, 0.2);

b.sy.set(\amp, 0.4)
b.patt_("5!.1!!.#!!---!.#");

a.sy.set(\dcy, 0.041)
a.sy.set(\amp, 0.8, \dcy, 0.1)
b.sy.set(\amp, 0.2, \dcy, 0.04)

a.patt_("90909ere")
b.patt_("5!.1!!.#!!---!.#");

// sync up
BotSynth2.sync(true, 100)

//
a.free;
b.free;


///////////////////////////////////////////////////////////////////////////////////////////////////
