#!/usr/bin/python

import sys, os

ssizes = set([20000, 40000, 60000, 80000, 100000])

for ss in ssizes:
	cmd = "grep logistic_P ssize."+str(ss)+".5percent/sim* > allP.5percent."+str(ss)
	print cmd
	os.system(cmd)
	cmd = "grep logistic_P ssize."+str(ss)+".15percent/sim* > allP.15percent."+str(ss)
	print cmd
	os.system(cmd)
	cmd = "grep logistic_P ssize."+str(ss)+"/sim* > allP."+str(ss)
	print cmd
	os.system(cmd) 

