#= We want to load up a bunch of data to run some ML stuff on. 
This stuff is saved in a .mat file. Loading this into Python is a pain in the ass
Lets do it using Julia, then write the fields of interest to a netCDF, since Julia has some pretty good facilities for that.
=#


using MATLAB
using NCDatasets
using DataStructures
using DataFrames


mf = MatFile("/Users/ct6g18/MATLAB/24_north/alldata_anthro.mat")
variable_names(mf)

alldata = get_variable(mf,"alldata")


df = DataFrame(alldata)

using CSV
CSV.write("/Users/ct6g18/Python/keras/ML_Carbon/24_north.csv",df)