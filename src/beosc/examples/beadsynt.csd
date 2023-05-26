<CsoundSynthesizer>
<CsOptions>
-odac
</CsOptions>
<CsInstruments>

/*

This is the example file for beadsynt

beadsynt
========

Band-enhanced additive synthesis.
A port of Loris' band-enhanced resynthesis algorithms
(basen on Supercollider's BEOsc)

The band-enhanced family of opcodes (beosc, beadsynt) implement
sound modeling and synthesis that preserves the elegance and
malleability of a sinusoidal model, while accommodating sounds
with noisy (non-sinusoidal) components. Analysis is done offline,
with an enhanced McAulay-Quatieri (MQ) style analysis that extracts
bandwidth information in addition to the sinusoidal parameters for
each partial. To produce noisy components, we synthesize with sine
wave oscillators that have been modified to allow the introduction
of variable bandwidth.

Syntax
======

beadsynt exists in two forms, one using arrays, the other using f-tables

aout beadsynt kFreqs[], kAmps[], kBws[], inumosc=-1, iflags=1, kfreq=1, kbw=1, ifn=-1, iphs=-1
aout beadsynt ifreqft, iampft, ibwft, inumosc, iflags=1, kfreq=1, kbw=1, ifn=-1, iphs=-1

kFreqs[]: an array holding the frequencies of each partial
kAmps[]: an array holding the amplitudes of each partial
kBws[]: an array holding the bandwidths of each partial
ifreqft: a table holding the frequencies of each partial
iampft: a table holding the amplitudes of each partial
ibwft: a table holding the bandwidths of each partial
inumosc: the number of partials to resynthesize (-1 to synthesize all)
iflags: 0: uniform noise
        1: gaussian noise
       +2: use linear interpolation for the oscil (similar to oscili)
       +4: freq interpolation
kfreq: freq. scaling factor
kbw: bandwidth scaling factor
ifn: a table holding a sine wave (or -1 to use builtin sine)
iphs: initial phase of the oscillators.
      -1: randomize phase (default)
     0-1: initial phase
     >=1: table holding the phase for each oscillator (size>=inumosc)

NB: kFreqs, kAmps and kBws must all be the same size (this also holds true for
    ifreqft, iampfr and ibwft)

This example uses the analysis file fox.mtx which was produced with 
loristrck_pack, see https://github.com/gesellkammer/loristrck
The file is in fact a wav file, with the difference that the wav format is used 
as a binary exchange format, thus avoiding more brittle solutions.

*/

sr = 44100
ksmps = 128
nchnls = 2
0dbfs = 1.0

gispectrum ftgen 0, 0, 0, -1, "fox.mtx", 0, 0, 0

instr 1
  ifn = gispectrum
  iskip      tab_i 0, ifn
  inumrows   tab_i 1, ifn
  inumcols   tab_i 2, ifn
  it0 = tab_i(iskip, ifn)
  it1 = tab_i(iskip+inumcols, ifn)
  idt = it1 - it0
  inumpartials = (inumcols-1) / 3 
  imaxrow = inumrows - 2
  it = ksmps / sr
  igain init 1
  ispeed init 0.3
  idur = imaxrow * idt / ispeed
  kGains[] init inumpartials
  kfilter init 0
  ifreqscale init 1
  
  kt timeinsts
  kplayhead = phasor:k(ispeed/idur)*idur
  krow = kplayhead / idt
  ; each row has the format frametime, freq0, amp0, bandwidth0, freq1, amp1, bandwidth1, ...
  kF[] getrowlin krow, ifn, inumcols, iskip, 1, 0, 3
  kA[] getrowlin krow, ifn, inumcols, iskip, 2, 0, 3
  kB[] getrowlin krow, ifn, inumcols, iskip, 3, 0, 3

  ; println "Frame time: %f, kt: %f", tab:k(iskip+inumcols*floor(krow), ifn), kt

  if(kt > idur*0.6) then
    if metro(0) == 1 then
      println "Applying filter: bandpass between 1000-1500 Hz"
    endif
    kfilter = 1
  endif
  
  ifilterGain = 3    
  if (kfilter == 1) then
    kGains bpf kF, 990, 0.001, 1000, ifilterGain, 1500, ifilterGain, 1510, 0.01
    kA *= kGains
  endif 
   
  iflags = 4    ; +1 = gaussian noise, +2 = oscil interpolation, +4 = freq interpol
  aout beadsynt kF, kA, kB, -1, iflags, ifreqscale
   
  if(kt > idur) then
    event "e", 0, 0, 0
  endif
  aenv cosseg 0, 0.02, igain, idur-0.02-0.1, igain, 0.1, 0
  ; aout *= aenv
  outs aout, aout
endin

schedule 1, 0, -1

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
