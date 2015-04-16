To run the simulations (these are all configured for my cluster, so will have to be edited for yours):

>python sim_many.py

>python sim_many_wcor.py

>python sim_many_15percent.py  

>python sim_many_15percent_wcor.py  

>python sim_many_5percent.py

>python sim_many_5percent_wcor.py  

Then

>python get_all_P.py

>python get_all_P_wcor.py

>cd plotting

>R --vanilla < plot.R

>R --vanilla < plot_wcor.R

