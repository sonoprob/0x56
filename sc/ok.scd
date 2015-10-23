s.record("/Users/a/Downloads/x/dkl.aif");

s.makeWindow;

Synth(\wuxia5, [\amp, 0.005, \lenght, 32]);
Synth(\wuxia7, [\amp, 0.05, \start, 100, \end, 2000, \lenght, 22]);

Synth(\wuxia7, [\amp, 0.09, \start, 36.midicps, \end, 87.midicps, \lenght, 22]);
Synth(\wuxia7, [\amp, 0.005, \start, 36.midicps, \end, 84.midicps, \lenght, 122]);


// long
Synth(\wuxia9, [\amp, 0.2, \start, 36.midicps.reciprocal, \end, 84.midicps.reciprocal, \lenght, 42]);


Synth(\wuxia9, [\amp, 0.1, \start, 56.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,22, \fb, 3]);

Synth(\wuxia9, [\amp, 0.05, \start, 56.midicps.reciprocal, \end, 212.midicps.reciprocal, \lenght,12, \fb, 6]);
Synth(\wuxia9, [\amp, 0.005, \start, 126.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,32, \fb, 9]);


Synth(\wuxia9, [\amp, 0.1, \start, 56.midicps.reciprocal, \end, 102.midicps.reciprocal, \lenght,22, \fb, 3]);




s.boot;

"~/dev/versioned/scwork/scwork_13/_perf/pbup-sds.scd".standardizePath.load;

CmdPeriod.doOnce{

	{

Synth(\wuxia9, [\amp, 0.005, \start, 56.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,32, \fb, 6]);

	}.();
	{SinOsc.ar(XLine.kr(2000,20,10),0,0.1) }.play

}


s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(2000, 12000), \sustain, 60, \amp, 0.05, \out, ~out,\pan, 1.0.rand2);


s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(12000, 18000), \sustain, 10, \amp, 0.09, \out, ~out,\pan, 1.0.rand2);

s.sendMsg("/s_new", "hatXLine", -1, 0, 0, \freq, rrand(2000, 12000), \sustain, 10, \amp, 0.03, \pan, 0, \out, ~out,\pan, 1.0.rand2);

s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 1,\out, ~out);
// long curves of flying birds
s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 3, \sustain, 15,\out, ~out);


/////////////////////

(
SynthDef("pluck", {arg beat=1.0, dec=1.0, pitch=60, amp=0.5;
	var sig, delay, trig, source;
	// calculate the delay time from MIDI pitch:
	delay = pitch.midicps.reciprocal;
	// a clock:
	trig = Impulse.ar(beat);
	// a sound source to process:
	source = GrayNoise.ar(amp);
	// a triggered percussive envelope on the source:
	sig = Decay2.ar(trig, 0.003, 0.05, source);
	// comb filter (delay with feedback) on the percussive signal:
	sig = CombL.ar(sig, 0.2, [delay, delay*1.01], dec);
	// remove the DC offset that comes from the comb:
    sig = LPF.ar(LeakDC.ar(sig), 800);

	// send the signal to the output:
	Out.ar(0, sig)
	}).send(s);
)

// test it with a single synth:
Ndef(\pluck).play

Ndef(\pluck).set(\beat, 1, \pitch, 60, \dec, 3, \amp, 0.4 );


a = Synth("pluck", [\beat, 0.51, \pitch, 48.01, \dec, 3, \amp, 0.4 ]);
b = Synth("pluck", [\beat, 0.5, \pitch, 48, \dec, 3, \amp, 0.4 ]);
v = Synth("pluck", [\beat, 0.251, \pitch, 36, \dec, 5, \amp, 0.2 ]);
y = Synth("pluck", [\beat, 0.25, \pitch, 24, \dec, 7, \amp, 0.4 ])
z = Synth("pluck", [\beat, 1, \pitch, 60, \dec, 3, \amp, 0.4 ]);




//////////////////

(
a = BS(s, bus:0, makeWin:true);
b = BS(s, 1, makeWin:true);
c = BS(s, 0, makeWin:true);
d = BS(s, 1, makeWin:true);
BS.quant = 1;
)

a.generateSynthDef(\bs14, {|t=0, p1=5, p2=7| t & (( t >> p1) % (t >> p2)) })
a.generateSynthDef(\bs1, {|t=0, p1=5, p2=7| t * ((t>>p1 | t>>p2) | 48&t>>2) });
a.generateSynthDef(\bs5, {|t=0, p1=5, p2=7| t * ((t>>p1 | t>>p2) | 48&t>>2) })
a.generateSynthDef(\bs6, {|t=0, p1=5, p2=7| t & (( t >> p1) & (t >> p2)) })
a.generateSynthDef(\bs7, {|t=0, p1=5, p2=7| t % (( t >> p1) & (t >> p2)) })

a.p_((instrument:\bs1,outBus:Prand([0,1],inf),dur:Prand([1,2,8],inf),sustain:Pseq([0.25],inf), amp:0.4, p1:Prand([2,4],inf)));

b.p_((instrument:\bs0,outBus:Prand([0,1],inf),dur:0.75,sustain:Pseq([0.01,0.1],inf), amp:0.1, p2:Prand([2,4],inf)))

c.p_((instrument:\bs3,outBus:Prand([0,1],inf),dur:3,sustain:Pseq([0.1,0.03],inf), amp:0.03, p2:Prand([2,3,4],inf)))

a.p.play;

a.p.stop;
b.p.stop;
c.p.stop;


a.s_(\bs7,(p1:7, p2:8, envScale:4))


BS.quant = 1

/
a.p_((instrument:\bs7,outBus:Prand([0,1],inf),dur:Prand([1,2,0.5],inf),sustain:Pseq([1],inf),amp:0.4,p1:Prand([2,1,0],inf)));

b.p_((instrument:\bs0,outBus:Prand([0,1],inf),dur:0.75,sustain:Pseq([0.01,0.1],inf), amp:0.1, p2:Prand([2,4],inf)))

c.p_((instrument:\bs3,outBus:Prand([0,1],inf),dur:3,sustain:Pseq([0.1,0.03],inf), amp:0.03, p2:Prand([2,3,4],inf)))

a.p.stop;
b.p.stop;
c.p.stop;



b.p_((instrument:\bs14, outBus:Prand([0,1],inf),
    dur: Pseq([Pgeom(3,0.9,10),Pgeom(0.03,1.1,10)],inf),
    p1: Prand([0,1,2,3,5,8,13],inf),
    p2: Prand([0,1,2,3,5,8,13],inf),
    sustain: Pseq([Pgeom(1,0.9,10),Pgeom(0.03,1.1,10)],inf) * 0.1,
    samplerate: 12000,
    amp:0.1, p2:Prand([2,4],inf))
)

////////////////