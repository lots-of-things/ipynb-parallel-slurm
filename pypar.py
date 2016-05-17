import argparse
from IPython.parallel import Client
import numpy as np
import os


def compute_pi(n_samples):
	s = 0
	for i in range(n_samples):
		x = random()
		y = random()
		if x * x + y * y <= 1:
			s += 1
	return 4. * s / n_samples


def main(profile):
	rc = Client(profile=profile)
	views = rc[:]
	with views.sync_imports():
		from random import random
	
	results = views.apply_sync(compute_pi, int(1e7))
	my_pi = np.sum(results) / len(results)
	filename = "result-job.txt"
	with open(filename, "w") as fp:
		fp.write("%.20f\n" % my_pi)


if __name__ == '__main__':
	parser = argparse.ArgumentParser()
	parser.add_argument("-p", "--profile", required=True,
		help="Name of IPython profile to use")

	args = parser.parse_args()

	main(args.profile)
