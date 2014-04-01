function tdiff(x ,k)
# Return a matrix/vector that has been differenced k-periods

# ##################################################################
# Original comments and function signature from spatial-econometrics
# ##################################################################
# function dmat = tdiff(x,k)
# PURPOSE: produce matrix differences
# -----------------------------------------
# USAGE: dmat = tdiff(x,k)
# where:    x = input matrix (or vector) of length nobs
#           k = lagged difference order
# -----------------------------------------
# NOTE: uses trimr() and lag()
# -----------------------------------------
# RETURNS: dmat = matrix or vector, differenced by k-periods
#                 e.g. x(t) - x(t-k), of length nobs, 
#                 (first k observations are zero)
# -----------------------------------------
# SEE ALSO: trimr() modeled after Gauss trimr function
# -----------------------------------------

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

	# Error checking on inputs
	if isempty(x) && isempty(k)
		error("Wrong # of arguments to tdiff");
	end

	(nobs ,nvar) = size(x)

	if k == 0
		dmat = x
	elseif k ==1
		dmat = zeros(nobs ,nvar)
		dmat[2:nobs ,:] = x[2:nobs ,:] - x[1:nobs-1 ,:]
	else
		# Modified by Jushan Bai
		# NYU
		dmat = zeros(nobs ,nvar)
		dmat[k+1:nobs ,:] = x[k+1:nobs ,:] - x[1:nobs-k ,:]
	end

	return dmat
end