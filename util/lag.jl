module Lag
	
	include("./trimr.jl")

	function lag(x::Float64 ,n=1:Int64 ,v=0::Float64)
	# Ceates a matrix or vector of lagged values

	# ##################################################################
	# Original comments and function signature from spatial-econometrics
	# ##################################################################    
	# function z = lag(x,n,v)
	# PURPOSE: creates a matrix or vector of lagged values
	# -------------------------------------------------------
	# USAGE: z = lag(x,n,v)
	# where: x = input matrix or vector, (nobs x k)
	#        n = order of lag
	#        v = (optional) initial values (default=0)
	# e.g.
	#     z = lag(x) creates a matrix (or vector) of x, lagged 1 observations
	#     z = lag(x,n) creates a matrix (or vector) of x, lagged n observations
	#     z = lag(x,n,v) creates a matrix (or vector) of x, lagged n observations,
	#         with initial values taking a value v.
	# ------------------------------------------------------
	# RETURNS: z = matrix (or vector) of lags (nobs x k)
	# ------------------------------------------------------
	# NOTES: if n <= 0, z = [] is returned. While you may find this
	#        preverse, it is sometimes useful.
	#-------------------------------------------------------
	# SEE ALSO: mlag() 
	#-------------------------------------------------------

	# written by:
	# James P. LeSage, Dept of Economics
	# University of Toledo
	# 2801 W. Bancroft St,
	# Toledo, OH 43606
	# jpl@jpl.econ.utoledo.edu

	# ######################################################
	# Porting to Julia information
	# ######################################################

	# Author:   Adrian Torrie
	# Email: adriantorrie@gmail.com
	# Linkedin: www.linkedin.com/in/adriantorrie/

	# ######################################################

	   # Error checking on args in
		if isempty(x) || isempty(n) || isempty(v)
			error("lag(): wrong # of input arguments")
		end

		if n < 1
			z = []
		else
			ncols = size(x ,2)
			zt = ones(n ,ncols) * v
			z = [zt ;trimr(x ,0 ,n)]
		end

		return z
	end
end