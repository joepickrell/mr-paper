#!/usr/bin/python

import sys, os

NSIM = 1000
outstem = sys.argv[1]

ssizes = set([20000, 40000, 60000, 80000, 100000])

for s in ssizes:
	cmd = "mkdir ssize."+str(s)+".15percent.wcor"
	os.system(cmd)
	for i in range(NSIM):
		cmd = "echo 'R --vanilla --args "+str(s)+" 100 0.85 0.0003 0.005 0.005 0.4 0.1 ssize."+str(s)+".15percent.wcor/"+outstem+"."+str(i)+".sim < run_single_sim.R' | qsub -V -cwd -o /dev/null -e /dev/null -q res.q"
		print cmd
		os.system(cmd)
