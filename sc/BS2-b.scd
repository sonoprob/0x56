Server.killAll
s = Server.local;
a = BotSynth21.new(s, botSynthName: "p1n1", synthDefName:"fm1");
b = BotSynth21.new(s, "p1n2", "ana2");
b.free;
a.patt
a.patt_([ 46, 95, 95, 95, 95, 95, 95, 98 ])

a.patt_(".__000(((9999___________")

a.patt_(".__x___b")



s.queryAllNodes;

a.free;
a = BotSynth2.new(s, botSynthName: "p1n1", synthDefName:"sspulse");


// simple sequenser pulse
SynthDef(\sspulse,{ |out=0, t_trig=1, freq=200, width=0.5, dcy=2, amp=0.6|
	var env, snd;
	env = EnvGen.ar(Env.perc(1e-2,dcy), t_trig);
	snd = Pulse.ar(freq!2, width);
	OffsetOut.ar(out, snd * env * amp * 0.5);
}).store;


a.free;
a = BotSynth2.new(s, botSynthName: "p1n1", synthDefName:"sspulse");

b = BotSynth2.new(s, "p1n2", "fm1");

b.free;

b = BotSynth2.new(s, "p1n2", "drum1");
b = BotSynth2.new(s, "p1n2", "ana2");

s.queryAllNodes;


Synth(\sspulse,[\freq, 40, \width, 0.03, \dcy, 10])
Synth(\sspulse,[\freq, 250, \width, 0.5, \dcy, 0.04])

Synth(\sspulse,[\freq, 40, \width, 0.03, \dcy, 10])
a.synth(\sspulse)
a.synth
s.queryAllNodes;





// simple sequencer sine
SynthDef(\sssine,{ |out=0, t_trig=1, freq=440, dcy=0.2, fdcy=0.2, amp=0.9|
	var env, fenv, snd;
	env = EnvGen.ar(Env.perc(1e-3,dcy), t_trig);
	fenv = EnvGen.ar(Env.perc(1e-3,fdcy), t_trig);
	snd = SinOsc.ar(freq*[1,1.01] * fenv);
	OffsetOut.ar(out, snd * env * amp);
}).store;

/*
Synth(\sssine,[\freq, 4000, \dcy, 2, \fdcy, 10])

Synth(\sssine,[\freq, 4000, \dcy, 20, \fdcy, 10])

SynthDef(\sssine,{ |out=0, t_trig=1, freq=440, dcy=0.2, fdcy=0.2, amp=0.9|
	var env, fenv, snd;
	env = EnvGen.ar(Env.perc(1e-3,dcy), t_trig);
	fenv = EnvGen.ar(Env.perc(1e-3,fdcy), t_trig);
	snd = SinOsc.ar(freq*[1,1.01] * fenv);
	OffsetOut.ar(out, snd * env * amp);
}).store;


an Impulse with frequency 0 returns a single impulse:

SynthDef(\imp, { OffsetOut.ar(0, Impulse.ar(0)); FreeSelf.kr(Impulse.kr(0)); }).add;

Synth(\imp);


fork { (1 / (1..60).scramble).do { |dt| Synth.grain(\imp);  dt.wait } };


-- bscass

*/

// simple sequenser pulse
SynthDef(\sspulse,{ |out=0, t_trig=1, freq=200, width=0.5, dcy=0.1, amp=0.6|
	var env, snd;
	env = EnvGen.ar(Env.perc(1e-2,dcy), t_trig);
	snd = Pulse.ar(freq!2, width);
	OffsetOut.ar(out, snd * env * amp * 0.5);
}).store;

/*
Synth(\sspulse,[\freq, 1000, \width, 0.02, \dcy, 2])

Synth(\sspulse,[\freq, 250, \width, 0.1, \dcy, 2])


Synth(\sspulse,[\freq, 250, \width, 0.5, \dcy, 0.04])

Synth(\sspulse,[\freq, 250, \width, 0.1, \dcy, 0.01])


*/

SynthDef(\ssfm, {| outBus=0, t_trig=1, freq=1040, modfreq=100, modindex=1, dcy=0.2, amp=0.3|
	var snd, env = EnvGen.ar(Env.perc(0.01, dcy ), t_trig, doneAction:2);
	snd = PMOsc.ar(freq, modfreq, modindex,[0, SinOsc.kr(0.3,0,pi)]);
	OffsetOut.ar(outBus, snd * env * amp);
}).store;

/*
Synth(\ssfm,[\freq, 1250, \modfreq, 1.5, \modindex, 5, \dcy, 2, \amp, 1])
Synth(\ssfm,[\freq, 150, \modfreq, 200.5, \modindex, 10, \dcy, 2, \amp, 1])
*/

SynthDef(\ssfnoise, {| outBus=0, t_trig=1, freq=1000, rq=0.1, dcy=0.2, amp=0.3|
	var snd, env = EnvGen.ar(Env.perc(0.001, dcy ), t_trig, doneAction:2);
	snd = BPF.ar(WhiteNoise.ar(4), freq, rq); // freq is filter cutoff frequency here, rq is the reciprocal of q (bandwith of filter)
	OffsetOut.ar(outBus, snd!2 * env * amp);
}).store;

/*
Synth(\ssfnoise, [\freq, 2000, \rq,0.001, \dcy, 0.9, \amp, 1]);
*/

SynthDef(\ssfnoise2, {| outBus=0, t_trig=1, freq=1000, rq=0.1, dcy=0.2, fdcy=0.04, amp=0.3|
	var snd, fenv, env = EnvGen.ar(Env.perc(0.001, dcy ), t_trig, doneAction:2);
	fenv = EnvGen.ar(Env.perc(1e-5, fdcy, curve:-4), t_trig, doneAction:0);
	snd = BPF.ar(WhiteNoise.ar(4), freq*(1+fenv), rq); // freq is filter cutoff frequency here, rq is the reciprocal of q (bandwith of filter)
	OffsetOut.ar(outBus, snd!2 * env * amp);
}).store;

/*
Synth(\ssfnoise2, [\freq, 4000, \rq,0.1, \dcy, 0.1, \fdcy, 0.03, \amp, 3]);
*/

SynthDef(\honky,{ |out=0, t_trig=1, freq, dcy=0.1, amp=0.9|
	var snd, env = EnvGen.ar(Env.perc(1e-3,dcy), t_trig);
	snd = SinOsc.ar(freq!2).cubed.cubed;
	OffsetOut.ar(out, snd * amp * env);
}).store;

SynthDef(\drum1, {|out=0, t_trig=1, freq, freqMul=4, dcy=0.1, fdcy=0.02, rq=0.2, amp=0.7|
	var snd, fenv, env = EnvGen.ar(Env.perc(1e-5, dcy, curve:-8), t_trig);
	fenv = EnvGen.ar(Env.perc(1e-5, fdcy, curve:-4), t_trig, doneAction:0);
	snd = BPF.ar( WhiteNoise.ar(10) ! 2, freq * freqMul * fenv + 100, rq);
	OffsetOut.ar(out, snd.softclip * amp * env);
}).store;

/*
Synth(\drum1, [\freq, 1500, \freqMul, 10, \dcy, 0.6, \fdcy, 0.3, \amp, 3]);
*/

//SynthDef(\drum2, {|out=0, t_trig=1,freq, freqMul=4, dcy=0.1, rq=0.1, amp=0.4|
//	var snd, env = EnvGen.ar(Env.perc(1e-5, dcy, curve:-8), t_trig);
//	snd = BPF.ar( WhiteNoise.ar(10)!2, freq * freqMul + 100, rq)
//	+ SinOsc.ar(freq/2)!2;
//	OffsetOut.ar(out, snd * amp * env * 0.3);
//}).store;

SynthDef(\drum2, {|out=0, t_trig=1,freq, freqMul=4, dcy=0.1, ffreq=1000, rq=0.3, amp=0.4|
	var snd, env = EnvGen.ar(Env.perc(1e-9, dcy, curve:-8), t_trig);
	snd = BPF.ar( WhiteNoise.ar(10)!2, freq * freqMul + 100, rq)
	+ SinOsc.ar(freq/2)!2;
	OffsetOut.ar(out, LPF.ar(snd, ffreq, amp * env * 0.5));
}).store;

SynthDef(\fm1, {| outBus=0, t_trig=0, freq=1040, dcy=0.3, amp=0.2|
	var snd, env = EnvGen.ar(Env.perc(0.01, freq.reciprocal * 200 * dcy ), t_trig, doneAction:0);
	snd = PMOsc.ar(freq, freq*0.5, 2*TExpRand.kr(0.5, 4, t_trig),[0, SinOsc.kr(0.3,0,pi)]);
	OffsetOut.ar(outBus, snd * env * amp);
}).store;


SynthDef(\fm2, {| outBus=0, t_trig=0, freq=1040, dcy=0.09, amp=0.6|
	var snd, env = EnvGen.ar(Env.perc(0.01,dcy*LFNoise2.kr(0.1,0.1,1)), t_trig, doneAction:0);
	snd = RLPF.ar(
	PMOsc.ar(freq, freq*[1.5, 2, 1].choose, TRand.kr(0.5, 3, t_trig),0),
	SinOsc.kr([0.1,0.11]).range(400, 1900),
	0.4
	);
	OffsetOut.ar(outBus, snd * env * amp);
}).store;

SynthDef(\ana1, {|t_trig=1, freq=100, sfreq=100, pfreq, pwidth=0.2, dcy=0.3, pdcy=0.07,
	ffreq=700, rq=0.3, amp=0.3|
	var aenv, penv, osc1, osc2, filtd;
	aenv = EnvGen.ar(Env.perc(0.01, rrand(dcy/2,dcy*2)), t_trig, doneAction: 0);
	penv = 1 + EnvGen.ar( Env.perc(0.01, pdcy), t_trig, timeScale:0.2, levelScale:-0.1, doneAction: 0);
	pwidth = pwidth * SinOsc.kr(0.1, [0, pi], 0.24, 0.25);
	sfreq = freq;
	pfreq = freq * SinOsc.kr([0.5, 1.333],0,0.01,1);
	osc1 = VarSaw.ar(sfreq*penv,0,pwidth);
	osc2 = LFPulse.ar((pfreq?sfreq)*penv,0,pwidth);
	filtd = RLPF.ar(Mix([osc1, osc2]), ffreq, rq);
	OffsetOut.ar(0, filtd * aenv * amp * 0.7)
}).store;

SynthDef(\ana2, {|t_trig=1, freq=100, sfreq=100, pfreq, pwidth=0.2, dcy=0.3,
	pdcy=0.07, ffreq=700, rq=0.3, amp=0.4|
	var aenv, penv, osc1, osc2, filtd;
	aenv = EnvGen.ar(Env.perc(0.01, rrand(0.02,dcy)), t_trig, doneAction: 0);
	penv = 1 + EnvGen.ar(Env.perc(0.01, pdcy), t_trig, timeScale:0.2, levelScale:-0.1, doneAction: 0);
	pwidth = pwidth * SinOsc.kr(0.1, [0, pi], 0.24, 0.25);
	sfreq = freq  * TChoose.kr(t_trig, [1.5, 1.0, 0.5, 2]);
	pfreq = freq * SinOsc.kr([0.5, 1.333],0,0.01,1) * TChoose.kr(t_trig, [1.5, 1.0, 0.5, 2]);
	osc1 = VarSaw.ar(sfreq*penv,0,pwidth);
	osc2 = LFPulse.ar((pfreq?sfreq)*penv,0,pwidth);
	filtd = RLPF.ar(Mix([osc1, osc2]), ffreq, rq);
	OffsetOut.ar(0, filtd * aenv * amp * 0.5)
}).store;

SynthDef(\procverb, {|in=0, out=0, room=0.7, damp=0.5, mix=0.2|
	var function = FreeVerb.ar(In.ar(in), mix, room, damp);
 	Out.ar(out, Pan2.ar(function, 0.2*SinOsc.kr))
}).store;

SynthDef(\procgain, {|in=0, out=0, gain=2, amp=0.2|
	Out.ar(out,
Pan2.ar((In.ar(in)*gain).softclip * amp , 0.2 * SinOsc.kr)
	)
}).store;

SynthDef(\procfdly, {|in=0, out=0, ffreq=1000, time=0.5, rls=2, rq=0.6, mix=0.3, amp=0.9|
	var dry;
	in = In.ar(in);
	dry = in;
	in = in + CombC.ar(in, 2*time, time, time*rls);
	in = RLPF.ar(in, ffreq, rq); //.round(rnd);
	in = (dry * (1-mix)) + (in*mix);
	Out.ar(out, Pan2.ar(in * amp , 0))
}).store;
