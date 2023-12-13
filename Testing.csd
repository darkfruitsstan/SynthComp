<Cabbage>
form             size(550,700), caption("Synth"), pluginId("zx3g")
  ; Synth 1 controls
  rslider bounds(20, 50, 120, 120) channel("lfofreq1") range(0, 10, 0, 1, 0.001)
  combobox bounds(20, 240, 120, 30) channel("wave1") text("Sine", "Square") value(1)
  rslider bounds(20, 280, 120, 120) channel("lfoamp1") range(0, 1, 0, 1, 0.001)
  vslider bounds(20, 440, 50, 150) channel("master1") range(0, 1, 0.5, 1, 0.001)
  checkbox bounds(20, 630, 20, 20) channel("activate1")

  ; Synth 2 controls
  rslider bounds(200, 50, 120, 120) channel("lfofreq2") range(0, 10, 0, 1, 0.001)
  combobox bounds(200, 240, 120, 30) channel("wave2") text("Sine", "Square") value(1)
  rslider bounds(200, 280, 120, 120) channel("lfoamp2") range(0, 1, 0, 1, 0.001)
  vslider bounds(200, 440, 50, 150) channel("master2") range(0, 1, 0.5, 1, 0.001)
  checkbox bounds(200, 630, 20, 20) channel("activate2")

  ; Synth 3 controls
  rslider bounds(380, 50, 120, 120) channel("lfofreq3") range(0, 10, 0, 1, 0.001)
  combobox bounds(380, 240, 120, 30) channel("wave3") text("Sine", "Square") value(1)
  rslider bounds(380, 280, 120, 120) channel("lfoamp3") range(0, 1, 0, 1, 0.001)
  vslider bounds(380, 440, 50, 150) channel("master3") range(0, 1, 0.5, 1, 0.001)
  checkbox bounds(380, 630, 20, 20) channel("activate3")
</Cabbage>


<CsoundSynthesizer>
  <CsOptions>
    -n -d -MA -m0d -+rtmidi=NULL --midi-key-cps=5 --midi-velocity-amp=4 ;this enables midi keyboard input
  </CsOptions>
  <CsInstruments>
    ; Initialize the global variables.
    ksmps = 32
    nchnls = 2
    0dbfs = 1

    giSq ftgen 2, 0, 16384, 10, 1, 0, 1/3, 0, 1/5, 0, 0, 1/8, 0, 1/10
    giSine ftgen 1, 0, 16384, 10, 1

    instr 1

      kActivate1 chnget "activate1"
      kActivate2 chnget "activate2"
      kActivate3 chnget "activate3"

      if kActivate1 == 1 then
        ; Synth 1
        chnset 0.5, "master1"

        kFed1 chnget "lfofreq1"
        kCramp1 chnget "lfoamp1"
        iWave1 chnget "wave1"
        kMaster1 chnget "master1"

        kfreq1 = p5 ;read midi key
        kamp1 = p4  ;read midi amp

        aSine1 poscil 0.8, 1000 ; a reference for balance

        kLfo1 poscil kCramp1, kFed1, iWave1 ; a squarewave lfo
        kLfo1 = (kLfo1+1)/2

        kEnv1 madsr 0.1, 0.1, 1, 0.01 ; a midi version of adsr

        a1 vco2 kamp1*kLfo1, kfreq1+kLfo1
        a2 vco2 kamp1*kLfo1, kfreq1*0.5
        a3 vco2 kamp1*kLfo1, kfreq1*3

        aMixL1 sum a1, a2, a3

        aFilL1 lpf18 aMixL1, 1000, 0.6, 0.5

        aOutL1 balance aFilL1, aSine1

        outs (aOutL1*kEnv1)*kMaster1, (aOutL1*kEnv1)*kMaster1
      endif

      if kActivate2 == 1 then
        ; Synth 2
        chnset 0.5, "master2"

        kFed2 chnget "lfofreq2"
        kCramp2 chnget "lfoamp2"
        iWave2 chnget "wave2"
        kMaster2 chnget "master2"

        kfreq2 = p5 ;read midi key
        kamp2 = p4  ;read midi amp

        aSine2 poscil 0.8, 1000 ; a reference for balance

        kLfo2 poscil kCramp2, kFed2, iWave2 ; a squarewave lfo
        kLfo2 = (kLfo2+1)/2

        kEnv2 madsr 0.1, 0.1, 1, 0.01 ; a midi version of adsr

        a4 vco2 kamp2*kLfo2, kfreq2+kLfo2
        a5 vco2 kamp2*kLfo2, kfreq2*0.5
        a6 vco2 kamp2*kLfo2, kfreq2*3

        aMixL2 sum a4, a5, a6

        aFilL2 lpf18 aMixL2, 1000, 0.6, 0.5

        aOutL2 balance aFilL2, aSine2

        outs (aOutL2*kEnv2)*kMaster2, (aOutL2*kEnv2)*kMaster2
      endif

      if kActivate3 == 1 then
        ; Synth 3
        chnset 0.5, "master3"

        kFed3 chnget "lfofreq3"
        kCramp3 chnget "lfoamp3"
        iWave3 chnget "wave3"
        kMaster3 chnget "master3"

        kfreq3 = p5 ;read midi key
        kamp3 = p4  ;read midi amp

        aSine3 poscil 0.8, 1000 ; a reference for balance

        kLfo3 poscil kCramp3, kFed3, iWave3 ; a squarewave lfo
        kLfo3 = (kLfo3+1)/2

        kEnv3 madsr 0.1, 0.1, 1, 0.01 ; a midi version of adsr

        a7 vco2 kamp3*kLfo3, kfreq3+kLfo3
        a8 vco2 kamp3*kLfo3, kfreq3*0.5
        a9 vco2 kamp3*kLfo3, kfreq3*3

        aMixL3 sum a7, a8, a9

        aFilL3 lpf18 aMixL3, 1000, 0.6, 0.5

        aOutL3 balance aFilL3, aSine3

        outs (aOutL3*kEnv3)*kMaster3, (aOutL3*kEnv3)*kMaster3
      endif

    endin
  </CsInstruments>
  <CsScore>
    f0 z ; this is a dummy event to keep csound running
  </CsScore>
</CsoundSynthesizer>
// this synth is made from the subexample on moodle. i've copied over the code twice to make 3 seperate, indivudally controllable synths. GUI wasn't a consideration for me here so its very basic.