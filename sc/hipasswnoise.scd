Ndef(\ji).clear
Ndef(\ji, {|msp=0.2, mdepth=0.3, ffreq=300| HPF.ar(WhiteNoise.ar(0.25), SinOsc.kr(msp*[1,LFNoise0.kr(0.3,0.5,1)], [0, 0.5pi], ffreq*mdepth, ffreq).max(10)) }).play
Ndef(\ji).set(\msp,0.2, \mdepth,0.3, \ffreq,300)
Ndef(\ji).set(\msp,0.02, \mdepth,0.9, \ffreq,6300)



Ndef(\ji).set(\msp,0.02, \mdepth,0.98, \ffreq,8300)

