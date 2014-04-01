using Winston
# Bring in the data without the headers and only
# get the "dates" and "adjusted close" columns
#
# i.e.
#	actual data starts in row 2
# 	and we are only interested in columns 1 and 7
file_path = dirname(Base.source_path())
gld = readcsv("$file_path/gld.csv")[2: ,[1 ,7]]
gdx = readcsv("$file_path/gdx.csv")[2: ,[1 ,7]]

# Put the dates for each time series in their own vectors
gld_dates = gld[: ,1]
gdx_dates = gdx[: ,1]

# Put adjusted close for each time series in their own vectors
gld_adj_close = gld[: ,end]
gdx_adj_close = gdx[: ,end]

# Get a set of dates that exist in either of the time series
dates = union(gld_dates ,gdx_dates)

# Get the indices of the dates where they exist in each time series
dates_in_gld_index = findin(gld_dates ,dates)
dates_in_gdx_index = findin(gdx_dates ,dates)

# Get indices of the time series dates where they exist in the union of dates
gld_in_dates_index = findin(dates ,gld_dates)
gdx_in_dates_index = findin(dates ,gdx_dates)

# Create an empty matrix of adjusted close prices that is as long (rows)
# as the union of the dates, then fill it with the values from each
# time series vector of adjusted close prices
# 	- Official doco for nans() => nans(type, dims...)
# 	- My way of reading it to build a matrix => nans(<T>, Length, Width)
adj_close = nans(Float64, length(dates) ,2)
adj_close[gld_in_dates_index ,1] = gld_adj_close[dates_in_gld_index]
adj_close[gdx_in_dates_index ,2] = gdx_adj_close[dates_in_gdx_index]

# Only keep those rows where all data is available i.e. no bad data such as -> NaN
good_data = find(all(isfinite(adj_close) ,2))
dates = dates[good_data]
adj_close = adj_close[good_data, :]

# Create plot of prices together
p = FramedPlot(aspect_ratio=0.33)
add(p ,Curve(float64(flipud(good_data)) ,flipud(adj_close[: ,1]) ,color="red"))
add(p ,Curve(float64(flipud(good_data)) ,flipud(adj_close[: ,2]) ,color="blue"))
file(p,"gld-gdx-prices.png")

