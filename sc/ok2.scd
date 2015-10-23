/00.projects/Schreck/schreck2013/schreck-badcuyp-inits.scd

// "~/00.projects/Schreck/schreck2013/schreck-badcuyp-inits.scd".standardizePath.load;
// "~/dev/sc/perf/schreck-badcuyp-inits.scd".standardizePath.openTextFile;
s.boot

"~/00.projects/Schreck/schreck2013/schreck-badcuyp-loads.scd".standardizePath.load;
"~/dev/sc/perf/schreck-badcuyp-loads.scd".standardizePath.openTextFile;
"~/dev/sc/perf/basses.scd".standardizePath.openTextFile;

"~/00.projects/Schreck/schreck2013/pbup-sds.scd".standardizePath.load;

s.boot;
s.scope
s.freqscope
s.freqscope.window
dr1

texture

s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 2);
s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 2);


~freq = 36
s.freqscope
NdefMixer(s, 12)

(
Tdef(\autobird,{
    loop{
        s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, [1,2,3,4].choose, \att, [0.1,1].choose,\sustain, exprand(0.001,7), \amp, 0.5);
        exprand(2,20).wait;
        if(0.4.coin){
            s.sendMsg("/s_new", "grain", -1, 0, 0, \freq, (~freq + 36+ [ 12, 24, 31, 36 ].choose).midicps,
                \sustain, exprand(0.02,2), \out, [0,1].choose, \amp, 0.02, \pan, 1.0.rand2);
        };

    }
}).play;

Tdef(\oi1,{
	loop{
		s.sendMsg("/s_new", "glisson", -1, 0, 0,\freq2, exprand(20, 20000), \sustain, exprand(0.001,0.03),
            \amp, 0.03, // exprand(0.0001,0.01),
            \pan, 1.0.rand2, \out, [0,1].choose);
		0.004.exprand(1).wait;
	}
}).play;

)

TdefAllGui.new
Tdef(\oi1).pause
Tdef(\oi1).resume

s.scope
Ndef(\texture1).play

s.freqscope

Ndef(\dr1).fadeTime =9
Ndef(\dr1).play


// single sine (slow env)
s.sendMsg("/s_new", "grain", -1, 0, 0, \freq, (~freq + 24+ [ 0, 12, 24, 31, 36 ].choose).midicps, \sustain, 12, \out, [0,1].choose, \amp, 0.01, \pan, 1.0.rand2);


Ndef(\klankinger1).fadeTime =9
Ndef(\klankinger1).play
Ndef(\klankinger1).end(10)




s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 12);
s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 2);

[0,1].choose=0


s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(2000, 12000), \sustain, 10, \amp, 0.05, \out, [0,1].choose,\pan, 1.0.rand2);
s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(12000, 18000), \sustain, 10, \amp, 0.09, \out, [0,1].choose,\pan, 1.0.rand2);
s.sendMsg("/s_new", "hatXLine", -1, 0, 0, \freq, rrand(2000, 12000), \sustain, 10, \amp, 0.03, \pan, 0, \out, [0,1].choose,\pan, 1.0.rand2);

s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 2, \sustain, 20,\out, [0,1].choose);
// long curves of flying birds
s.sendMsg("/s_new", "bird", -1, 0, 0, \trans, 3, \sustain, 15,\out, [0,1].choose);


///////////
Synth(\wuxia5, [\amp, 0.005, \lenght, 20]);

Synth(\wuxia5, [\amp, 0.005, \lenght, 32]);

Synth(\wuxia7, [\amp, 0.005, \start, 100, \end, 2000, \lenght, 22]);

Synth(\wuxia7, [\amp, 0.009, \start, 36.midicps, \end, 87.midicps, \lenght, 22]);
Synth(\wuxia7, [\amp, 0.005, \start, 36.midicps, \end, 84.midicps, \lenght, 122]);


// long
Synth(\wuxia9, [\amp, 0.02, \start, 36.midicps.reciprocal, \end, 84.midicps.reciprocal, \lenght, 42]);

Synth(\wuxia9, [\amp, 0.1, \start, 56.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,22, \fb, 3]);

Synth(\wuxia9, [\amp, 0.05, \start, 56.midicps.reciprocal, \end, 212.midicps.reciprocal, \lenght,12, \fb, 6]);

Synth(\wuxia9, [\amp, 0.005, \start, 126.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,32, \fb, 9]);

Synth(\wuxia9, [\amp, 0.03, \start, 56.midicps.reciprocal, \end, 102.midicps.reciprocal, \lenght,22, \fb, 3]);





////////////////////////////////////////////////////////////////////////////////////KLANKINGER
Ndef(\klankinger1).fadeTime =9
Ndef(\klankinger2).fadeTime =9
Ndef(\klankinger3).fadeTime =9
Ndef(\klankinger1).playN([0,1]);
Ndef(\klankinger2).playN([0,1]);
Ndef(\klankinger3).playN([0,1]);

~freq=36
~freq=37
~freq=51
~freq=54


Ndef(\klankinger1).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger2).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger3).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\dr2).end(10)
Ndef(\klankinger1).end(10)
Ndef(\klankinger2).end(10)
Ndef(\klankinger3).end(10)




////////////////////////////////////////////////////////////////////////////////////
[0,1].choose=0
[0,1].choose=2

(
Tdef(\oi1,{
	loop{
		s.sendMsg("/s_new", "glisson", -1, 0, 0, 	\freq2, exprand(2000, 20000), \sustain, exprand(0.01,0.2), \amp, exprand(0.0001,0.01), \pan, 1.0.rand2, \out, [0,1].choose);
		0.004.exprand(0.3).wait;
	}
}).play
)

Tdef(\oi1).stop

a = Synth("pluck", [\beat, 0.51, \pitch, 48.01, \dec, 3, \amp, 0.4 ]);
b = Synth("pluck", [\beat, 0.5, \pitch, 48, \dec, 3, \amp, 0.4 ]);
v = Synth("pluck", [\beat, 0.251, \pitch, 36, \dec, 5, \amp, 0.2 ]);
y = Synth("pluck", [\beat, 0.25, \pitch, 24, \dec, 7, \amp, 0.4 ])
z = Synth("pluck", [\beat, 1, \pitch, 60, \dec, 3, \amp, 0.4 ]);


s.sendMsg("/s_new", "grainLine", -1, 0, 0, \freq, 45.midicps, \sustain, 10, \out, [0,1].choose, \pan, -1,\amp, 0.1);
s.sendMsg("/s_new", "grainLine", -1, 0, 0, \freq, 33.midicps, \sustain, 10, \out, [0,1].choose, \pan, 1,\amp, 0.1);
s.sendMsg("/s_new", "grainLine", -1, 0, 0, \freq, 45.midicps, \sustain, 40, \out, [0,1].choose, \pan, 1,\amp, 0.1);
s.sendMsg("/s_new", "grainLine", -1, 0, 0, \freq, 33.midicps, \sustain, 10, \out, [0,1].choose, \pan, 1,\amp, 0.1);


////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////
////////////////////////////////////////////////////////


Ndef(\dr1).end(0);
Ndef(\dr1).playN([0,1]); // monitor, headphones
Ndef(\dr1).end(0.1);Ndef(\dr2).end(0.1);
Ndef(\dr1).playN([2,3]); // speakers
Ndef(\dr1).playN([0,1, 2,3]); // both


Ndef(\dr1).playN([0,1]); // monitor, headphones
Ndef(\dr2).playN([0,1]); // monitor, headphones
Ndef(\dr1).end(3);
Ndef(\dr2).end(3);

//////
1 = C#, 37

~freq=37
[0,1].choose=2
// single sine (slow env)
s.sendMsg("/s_new", "grain", -1, 0, 0, \freq, (~freq + [ 0, -12 ].choose).midicps, \sustain, 12, \out, [0,1].choose, \amp, 0.04, \pan, 1.0.rand2)
s.sendMsg("/s_new", "grain", -1, 0, 0, \freq, (~freq + [ 0, 12, 24, 31, 36 ].choose).midicps, \sustain, 12, \out, [0,1].choose, \amp, 0.1, \pan, 1.0.rand2);

Ndef(\dr1).fadeTime = 9;
Ndef(\dr2).fadeTime = 9;
Ndef(\dr1).set(\freq,37.midicps,\pan,0, \amp,0.2,\lag,7,\mix,0.9)

// lo
Ndef(\dr1).xset(\freq,28.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,35.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)

// hi
Ndef(\dr1).xset(\freq,(28+12).midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,(35+12).midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)


Ndef(\dr1).end(10);Ndef(\dr2).end(10);

2 = E-B, 40 47 (+c# g#), 37-44

Ndef(\dr1).clear
Ndef(\dr2).clear


~freq=40
[0,1].choose=2

Ndef(\klankinger1).play

Ndef(\klankinger1).xset(\out, [0,1].choose, \i_freq, (~freq + [0, 7, 12, 19, 24 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger2).xset(\out, [0,1].choose, \i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger3).xset(\out, [0,1].choose, \i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send


3 = C-A, 36 45
Ndef(\dr1).clear
Ndef(\dr1).playN([0,1]); // monitor, headphones
Ndef(\dr2).playN([0,1]); // monitor, headphones
Ndef(\dr1).end(0.1);Ndef(\dr2).end(0.1);
Ndef(\dr1).playN([2,3]); // speakers
Ndef(\dr2).playN([2,3]); // speakers

// lo
Ndef(\dr1).xset(\freq,36.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,45.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)

// hi
Ndef(\dr1).xset(\freq,(36+12).midicps,\pan,1.0.rand2, \amp,0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,(45+12).midicps,\pan,1.0.rand2, \amp,0.02,\lag,0.1,\mix,0.9)


4 = F-Ab, 29 44
Ndef(\dr1).clear
Ndef(\dr2).playN([0,1]); // monitor, headphones
Ndef(\dr1).playN([0,1]); // monitor, headphones
Ndef(\dr1).end(30);Ndef(\dr2).end(30);
Ndef(\dr1).playN([2,3]); // speakers
Ndef(\dr2).playN([2,3]); // speakers

// lo
Ndef(\dr1).xset(\freq,29.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,44.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)

// hi
Ndef(\dr1).xset(\freq,(29+12).midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)
Ndef(\dr2).xset(\freq,(44+12).midicps,\pan,1.0.rand2, \amp, 0.02,\lag,0.1,\mix,0.9)


~freq=29
Ndef(\klankinger1).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger2).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger3).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send



5 = Bb, 35

Ndef(\dr1).clear
Ndef(\dr2).playN([0,1]); // monitor, headphones
Ndef(\dr1).playN([0,1]); // monitor, headphones
Ndef(\dr1).end(0.1);Ndef(\dr2).end(0.1);

// lo
Ndef(\dr1).xset(\freq,23.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,2,\mix,0.9)
Ndef(\dr2).xset(\freq,35.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,2,\mix,0.9)

// hi
Ndef(\dr1).set(\freq,(35+12).midicps,\pan,1.0.rand2, \amp, 0.02,\lag,10,\mix,0.9)
Ndef(\dr2).set(\freq,(47+12).midicps,\pan,1.0.rand2, \amp,0.1,\lag,10,\mix,0.9)

// lo
Ndef(\dr1).set(\freq,23.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,2,\mix,0.9)
Ndef(\dr2).set(\freq,35.midicps,\pan,1.0.rand2, \amp, 0.02,\lag,2,\mix,0.9)





//////////////////////////////////////////// TEXTURE1
////////////////////////////////////////////
////


Ndef(\texture1).playN([0,1]);
Ndef(\texture1).playN([2,3]);
Ndef(\texture1).fadeTime = 8;
Ndef(\texture1).set(\lag, 14)
Ndef(\texture1).set(\lag, 1)

Ndef(\texture1).set(\freq,37.midicps, \ffreq,10000, \amp, 2, \rnd, 0.01)

Ndef(\texture1).xset(\freq,37.midicps, \ffreq,3000, \amp, 1.5, \rnd, 0.1)
Ndef(\texture1).set(\freq,23.midicps, \ffreq,1000, \amp, 1, \rnd, 0.1)
Ndef(\texture1).set(\freq,47.midicps, \ffreq,4200, \rnd, 0.001, \amp, 2)
Ndef(\texture1).set(\freq,23.midicps, \ffreq, 800, \amp, 0.3, \rnd, 0.1)




//////////////////////// ZEE

// ruis klank
s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(2000, 12000), \sustain, 40, \amp, 0.1, \out, [0,1].choose);
s.sendMsg("/s_new", "hatXLRev", -1, 0, 0, \freq, rrand(12000, 18000), \sustain, 10, \amp, 0.2, \out, [0,1].choose);


// zee
(
Ndef(\zee1,{ var aa, bb, cc;
        aa = Dust.kr(0.1);
        bb = Decay2.kr(aa, 5, 7);
        cc = Decay2.kr(aa * 2, 4, 4);
        Pan2.ar(HPF.ar(LPF.ar(BHiShelf.ar(WhiteNoise.ar(bb + 0.4),cc * 1200 + 700, 1.0, 12.0), bb * 1900 + 200), bb * 100 + 1000) * 5, 1.0.rand2)
});
Ndef(\zee2,{ var aa, bb, cc;
        aa = Dust.kr(0.1);
        bb = Decay2.kr(aa, 5, 7);
        cc = Decay2.kr(aa * 2, 4, 4);
        Pan2.ar(HPF.ar(LPF.ar(BHiShelf.ar(WhiteNoise.ar(bb + 0.4),cc * 1200 + 700, 1.0, 12.0), bb * 1900 + 200), bb * 100 + 1000) * 5, 1.0.rand2)
});
Ndef(\zee3,{ var aa, bb, cc;
        aa = Dust.kr(0.1);
        bb = Decay2.kr(aa, 5, 7);
        cc = Decay2.kr(aa * 2, 4, 4);
        Pan2.ar(HPF.ar(LPF.ar(BHiShelf.ar(WhiteNoise.ar(bb + 0.4),cc * 1200 + 700, 1.0, 12.0), bb * 1900 + 200), bb * 100 + 1000) * 5, 1.0.rand2)
})
)

Ndef(\zee1).play;
Ndef(\zee2).play;
Ndef(\zee3).play;

~freq=36
~freq=37
~freq=51
~freq=54

Ndef(\klankinger1).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger2).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send
Ndef(\klankinger3).xset(\i_freq, (~freq + [ -3, 9, 21, 24, 29, 33, 45, 45 ].choose).midicps * exprand(1, 1.003)).send

Ndef(\klankinger1).end(10)
Ndef(\klankinger2).end(10)
Ndef(\klankinger3).end(10)


////////////////////////////////////////////////////////// WUXIA

out=0
Synth(\wuxia7, [\amp, 0.005, \start, 100, \end, 2000, \lenght, 22]);
Synth(\wuxia7, [\amp, 0.005, \start, 78.midicps, \end, 40.midicps, \lenght, 32, \out,[0,1].choose]);
Synth(\wuxia7, [\amp, 0.005, \start, 36.midicps, \end, 84.midicps, \lenght, 122, \out,[0,1].choose]);


// long
Synth(\wuxia9, [\amp, 0.005, \start, 36.midicps.reciprocal, \end, 84.midicps.reciprocal, \lenght, 12,\out,[0,1].choose]);
Synth(\wuxia9, [\amp, 0.01, \start, 56.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,22, \fb, 3,\out,[0,1].choose]);
Synth(\wuxia9, [\amp, 0.005, \start, 56.midicps.reciprocal, \end, 212.midicps.reciprocal, \lenght,12, \fb, 6,\out,[0,1].choose]);
Synth(\wuxia9, [\amp, 0.005, \start, 56.midicps.reciprocal, \end, 12.midicps.reciprocal, \lenght,32, \fb, 6,\out,[0,1].choose]);


// CmdPeriod.run; Synth(\wuxia5, [\amp, 0.1, \time, 3]);

/////////
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



///////////////////////

(
w = {	|period=0|
	var change, rate, sig, carrierFreq, cfRamp, carrierLvl, clRamp,
	modulatorRatio, mrRamp, modulatorIndex, miRamp, outputAmplitude, oaRamp;

	period = period * 600 + 100;

	// Calculation of a recursive working metronome (Impulse.kr) that generates its
	// changing frequency out of its own impulses.
	change = Impulse.kr(LocalIn.kr(1,10));
	rate = CoinGate.kr(1/3, change);
	rate = (TChoose.kr(rate, period/((0..1) + 1))/1000).reciprocal;
	LocalOut.kr(rate);

	# carrierFreq, cfRamp = TIRand.kr(0, [1000, 1], change);
	carrierFreq = Ramp.kr( carrierFreq / 1000, (cfRamp * period) / 1000 ) * 0.6;

	# carrierLvl, clRamp = TIRand.kr(0, [9000, 1], CoinGate.kr(1/3, change));
	carrierLvl = Ramp.kr( carrierLvl, (clRamp * period) / 1000) + 100;

	# modulatorRatio, mrRamp = TIRand.kr([800,1], CoinGate.kr(1/4, change));
	modulatorRatio = Ramp.kr(modulatorRatio, (mrRamp * period) / 1000) + 20;

	# modulatorIndex, miRamp = TIRand.kr(0, [100, 1], CoinGate.kr(1/4, change));
	modulatorIndex = Ramp.kr(modulatorIndex / 200, (miRamp * period) / 1000) + 0.2;

	# outputAmplitude, oaRamp = TIRand.kr(0!2, 1!2, CoinGate.kr(1/2, change));
	outputAmplitude = Ramp.kr(outputAmplitude, (oaRamp * period + 3) / 1000);

	// jointed FM Synthesizer
	sig = LFSaw.ar(carrierFreq, 1, 0.5, 0.5) * carrierLvl;
	sig = sig + SinOsc.ar(carrierFreq * modulatorRatio) * modulatorIndex;
	sig = cos(sig * 2pi) * outputAmplitude;

	// One pole filters:
	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
	sig = sig!2 * 0.06;
}.play;
w.set(\period, 0);
)

// period controls the talk-speed. range: 0-1. 0 matches to fast, 1 to slow:
w.set(\period, 1);
w.set(\period, 0);
w.set(\period, 0.5);
w.set(\period, 0.7);
w.set(\period, 0.3);

// To stop:
w.free;
