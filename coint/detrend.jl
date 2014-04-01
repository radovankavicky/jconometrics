function detrend(y ,p)
# Detrend a matrix y of time-series using regression
# of y against a polynomial time trend of order p

# ##################################################################
# Original comments and function signature from spatial-econometrics
# ################################################################## 
# function resid = detrend(y,p) 
# PURPOSE: detrend a matrix y of time-series using regression
#          of y against a polynomial time trend of order p
# -----------------------------------------------------------          
# USAGE: resid = detrend(y,p)
# where:     y = input matrix (or vector) of time-series (nobs x nvar)
#            p = 0, subtracts mean
#            p = 1, constant plus trend model
#            p > 1, higher order polynomial model
#            p = -1, returns y
# -----------------------------------------------------------           
# RETURNS: resid = residuals from the detrending regression
# -----------------------------------------------------------

# written by:
# James P. LeSage, Dept of Economics
# University of Toledo
# 2801 W. Bancroft St,
# Toledo, OH 43606
# jlesage@spatial-econometrics.com

# ######################################################
# Porting to Julia information
# ######################################################

# Author:	Adrian Torrie
# Email:	adriantorrie@gmail.com
# Linkedin:	www.linkedin.com/in/adriantorrie/

# ######################################################

	# Error checking on input arguments
	if isempty(y) && isempty(p)
		error("Wrong number of arguments to detrend")
	end

	# No computation necessary, just return the y argument back to 
	# the caller
	if p == -1
		resid = y;
		return resid
	end

	(nobs ,junk) = size(y)
	u = ones(nobs ,1)

	if p > 0
		timep = zeros(nobs,p)
		t = 1:nobs
		tp = (t') / nobs
		m = 1

		while m <= p
			timep[: ,m] = tp .^ m
			m = m + 1
		end

		xmat = [u timep]
	else
		xmat = u
	end
	   
	   xpxi = inv(xmat' * xmat)
	   beta = xpxi * (xmat' * y)
	   resid = y - xmat * beta

	return resid
end