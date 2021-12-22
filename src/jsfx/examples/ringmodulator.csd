<CsoundSynthesizer>

<CsOptions>
; -odac
-d
-+rtmidi=virtual -M0
</CsOptions>

<CsInstruments>

sr     = 44100
ksmps  = 64
nchnls = 2
0dbfs  = 1

gaOuts[] init 2

FLpanel "dioderingmod", 443, 360, 50, 50
FLcolor 150, 100, 150, 200, 100, 250
i__w, i__h, i__line = 300, 30, 60
iy, i__marginx = 30, 30
i_v1 FLvalue "", 50, 30, 333, iy
gkModFrequency, i_s1 FLslider "Mod Frequency (Hz)", 20.0, 3000.0, 0, 3, i_v1, i__w, i__h, i__marginx, iy
iy += i__line
i_v2 FLvalue "", 50, 30, 333, iy
gkDiode, i_s2 FLslider "Diode", 0.0, 1.0, 0, 3, i_v2, i__w, i__h, i__marginx, iy
iy += i__line
i_v3 FLvalue "", 50, 30, 333, iy
gkFeedback, i_s3 FLslider "Feedback", 0.0, 1.0, 0, 3, i_v3, i__w, i__h, i__marginx, iy
iy += i__line
i_v4 FLvalue "", 50, 30, 333, iy
gkNonlinearities, i_s4 FLslider "Non-Linearities", 0.0, 1.0, 0, 3, i_v4, i__w, i__h, i__marginx, iy
iy += i__line
i_v5 FLvalue "", 50, 30, 333, iy
gkOversample, i_s5 FLslider "Oversample (x2)", 0.0, 1.0, 0, 3, i_v5, i__w, i__h, i__marginx, iy
FLpanelEnd
FLrun
FLsetVal_i 440.0, i_s1           ; Mod Frequency (Hz)
FLsetVal_i 0.0, i_s2             ; Diode
FLsetVal_i 0.0, i_s3             ; Feedback
FLsetVal_i 0.1, i_s4             ; Non-Linearities
FLsetVal_i 0.0, i_s5             ; Oversample (x2); --- end ui

massign 1, 1
instr 1
  imidinote notnum
  ifreq mtof imidinote
  ivel1 ampmidi 127
  idb bpf ivel1, 0, -120, 64, -20, 90, -12, 127, 0
  iamp = ampdb(idb) * 0.5
  asig vco2 iamp, ifreq
  aenv adsr 0.01, 0.1, 0.9, 0.2
  asig *= aenv
  gaOuts[0] = gaOuts[0] + asig

endin

instr 100
  a1 = gaOuts[0]
  a2 diode_ringmod a1, gkModFrequency, gkDiode, gkFeedback, gkNonlinearities, gkOversample
  outs a2, a2
  gaOuts[0] = 0
endin

instr 200
  a1 = gaOuts[0]
  ih, a2 jsfx "ringmodulator.jsfx", a1, 2, gkDiode, 3, gkModFrequency/3000*100, 4, gkFeedback*100, 5, gkNonlinearities*100, 8, gkOversample 
  outs a2, a2
  gaOuts[0] = 0

endin

</CsInstruments>

<CsScore>
i 200 0 300

</CsScore>
</CsoundSynthesizer>
