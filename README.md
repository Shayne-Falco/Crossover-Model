# Crossover Model
 
## A brief description of crossovers in <i>C. elegans</i>

Crossovers occur during meiosis as DNA from one chromosome will swap with its pair {Pazhayam2021}. 
The proper number and placement of crossovers is critically important and failures in crossover positioning can result in aneuploidy and infertility {Nagaoka2012}. 
In <i>C. elegans</i> the proper patterning of crossovers is observed as a one-and-only-one process where each chromosome pair has exactly one crossover.

<img width="914" alt="SC Schematic" src="https://github.com/Shayne-Falco/Crossover-Model/assets/96263317/0633f761-89f2-4bcf-a9e8-6344522f1aea">


## Turing type reaction-diffusion models
Turing models typically consist of two interacting components: an activator and an inhibitor. 
The activator promotes its own production, leading to local enhancement, while the inhibitor suppresses  activator production. 
This interplay between activation and inhibition creates a feedback loop that can lead to the spontaneous formation of spatial patterns.

![Example](https://github.com/Shayne-Falco/Crossover-Model/assets/96263317/e16da31d-361f-464f-9e2b-1358e2acdb81)


I set out to investigate if these meiotic crossovers are patterned by a reaction-diffusion mechanism that can be simulated using a Turing-type mathematical model. 
The construction of the mathematical model that will simulate the positioning of the one-and-only-one crossover using Turing-type dynamics.

## Initial Patterning by Double-strand Breaks

DSB hot spots were simulated by adding regions with the appropriate parameter values to the arms of the simulated SC. 
In these hot spots the removal of morphogen from the domain is reduced by half and the diffusion along the domain of the activator is reduced. 
These two changes were aimed at increasing the time it takes for the morphogen to leave these hot spots which would indirectly result in more activator being produced. 

![DSBPatterning](https://github.com/Shayne-Falco/Crossover-Model/assets/96263317/9796d76d-c655-4f4f-8079-f40445e14a0d)
