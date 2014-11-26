matdatasettbx
=============

Utility functions for manipulating Matlab Datasets. Datasets allow for manipulation of structured data as arrays with powerful data manipulation functionalities. Useful for keeping the code well organized and coherent, in particular in the context of scientific research.

Requirements:
- Matlab 2010b or later
- Statistical Toolbox for using dataset

The following is the description of the features

Fields
----------

The manipulation of dataset fields is not as easy as with structs so here we propose few functions:

dsisfield(ds,name) % checks if fields are present
dsrenamefield(ds,oldname,newname)  % renames the field
dsremovefields(ds,field1,...)  % removes the fields with the given name if present
dsremoveprefix(ds,fieldprefix) % removes all the fields with given prefix

Parameters
----------

dataset alllows to associate a UserData. In the approach proposed the UserData is a structure containing parameters and three functions allows to simply the manipulation:

dsisparam(ds,name)
dssetparam(ds,name,value)
dsgetparam(ds,name [,defaultvalue])  % if not specified raises an exception


Export
----------

Datasets are quite useful for manipulating data containing numbers, nonimnal variables and text. For this reason it should be easily exported


Future
======
* support for table (2013b+, see below)
* support for units manipulation in DimensionedVariable toolbox
* support for examples of processing from human data

datasets are deprecated since 2013b
===================================

Yes, table are the future since recent Matlab releases (2013b). The differences are higlighted below, but essentially the core important point is that table are present in core Matlab instead of being part of the Statistical toolbox. The plan is to make this toolbox compatible

http://www.mathworks.com/matlabcentral/answers/86779-whats-the-difference-between-a-table-new-in-r2013b-and-a-dataset-stats-toolbox

In comparison to dataset they provide:
- VariableUnits
- VariableDescriptions
- DimensionNames that specify the meaning of the 2D dimensions instead of simply Row and Variable 
- loading from csv: readtable with XLS CSV

Methods not in dataset
- rowfun
- varfun
- innerjoin
- outerjoin