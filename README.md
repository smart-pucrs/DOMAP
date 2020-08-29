# **DOMAP demo release**

The Distributed Online Multi-Agent Planning framework (DOMAP) provides multi-agent systems with capabilities to solve online multi-agent planning problems. It consists of three modular components: *goal allocation mechanism* - used to allocate goals to agents; *individual planner* -- used during each agent's individual planning stage; and *coordination mechanism* -- used before or after planning to avoid possible conflicts that can be generated while planning. DOMAP is implemented in the <a href="http://jacamo.sourceforge.net/" target="_blank"> JaCaMo </a> platform.

This is a demo version containing the experiments used in the AAMAS 2017 paper "A Modular Framework for Decentralised Multi-Agent Planning".
See HOWTO.pdf for instructions on how to run the demo.
You can get the code for the other 4 planners used in the experiments at <a href="http://agents.fel.cvut.cz/codmap/" target="_blank"> CoDMAP </a>.
The pddl model for our domain that we used in those planners is available at the "planners/benchmarks/unfactored/floods" folder.

Authors: Rafael C. Cardoso and Rafael H. Bordini
