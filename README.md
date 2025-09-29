# SysML-Sandbox
A SysMLv2 sandbox based on Eve Online.
Eve Online sets the backstage for experimenting with SysMLv2 with support of AI (Large Language Models) given the extensive freely open documentation available and the possibility to experience first hand the systems to be modelled.
The repository is meant for educational purposes and is an open invitation for anyone to use the available SysMLv2-Packages and to extend it via Pull Requests.
Experience in the game, even limited to a basic tutorial, is needed to understand the models. The game is Free-to-Play at eveonline.com.

# File structure
Files are meant to hold configuration items. In every file there may be one or more packages that are versioned together.
As the project grows, more contextual configuration items will be required.
## Libraries
- Celestials and Structures: Man-mande structrues in space
- COTS: Comercial-off-the-shelf elemets. All what you can buy in the market hubs: modules, ammo, etc.
- Natural Ennvironment: Elemenbts of nature like planets, moons, asteroid fields, suns, but also interaction elements like radiation (of any kind).
- Pilot Pods and Spaceships: Standards for pilot pods and conectivity with imperial standard ships.
- Standard Ports and Interfaces: Imperial standard interfaces.
- RollupAnalysis: Analysis library.
## Operational
The operational enviroment in space: What you see when you play the game.
The Mining Frigate is defined within the operational environemnt.

# The initial work: the Mining Frigate
The initial effort in this repository defines a mining frigate in the context of a mining corporation in the online game Eve-Online.
The model has been generated with the support of an LLM following a series of questions that are aimed to identify the operational motivation of the system of interest (the mining frigate) and ultimately define their problem space. The model is only based on those responses and further elaborated to represent the system model of a mining frigate class Venture following OOSEM.
## Recusrive aproach
The Frigate is defined following a recursive approach that uses Blackbox, Graybox, and Whitebox concepts to decompose the system structurally and functionally.

# Further work: here is where you may like to contribute
...for instance with a transport ship.
 
## Initiated by
Hugo Ormo is an engineer who studied at ETSEIB in Barcelona. He works as a consultant at a global IT consulting company, focusing on the transformation of enterprises toward systems engineering and MBSE. He is a certified GfSE Level A, approved trainer by the GfSE and has been preparing candidates for the GfSE certification levels B and C since 2022. Voluntarily, he leads the UAF working group of GfSE and is a member of the UAF working group of OMG.
