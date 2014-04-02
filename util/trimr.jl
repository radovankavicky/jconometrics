module Trimr

	function trimr(x ,n1 ,n2)
	# Return a matrix/vector stripped of the specified rows

	# ##################################################################
	# Original comments and function signature from spatial-econometrics
	# ################################################################## 
	# function z = trimr(x,n1,n2)
	# PURPOSE: return a matrix (or vector) x stripped of the specified rows.
	# -----------------------------------------------------
	# USAGE: z = trimr(x,n1,n2)
	# where: x = input matrix (or vector) (n x k)
	#       n1 = first n1 rows to strip
	#       n2 = last  n2 rows to strip
	# NOTE: modeled after Gauss trimr function
	# -----------------------------------------------------
	# RETURNS: z = x(n1+1:n-n2,:)
	# -----------------------------------------------------

	# written by:
	# James P. LeSage, Dept of Economics
	# University of Toledo
	# 2801 W. Bancroft St,
	# Toledo, OH 43606
	# jpl@jpl.econ.utoledo.edu

	# ######################################################
	# Porting to Julia information
	# ######################################################

	# Author:	Adrian Torrie
	# Email:	adriantorrie@gmail.com
	# Linkedin:	www.linkedin.com/in/adriantorrie/

	# ######################################################

		nobs = size(x, 1)
		
		if (n1 + n2) >= n
			error("Attempting to trim too much in trimr");
		end

		h1 = n1 + 1   
		h2 = nobs - n2
		z = x[h1:h2 ,:]

		return z
	end
end