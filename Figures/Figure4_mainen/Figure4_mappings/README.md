# Extract Model from Parameter Mappings

**General Overview**

We begin with a template for allparams (from `ParamsTemplate.csv`, `data/AllParams.csv` here)

We are given mappings from the model attributes to values in `64MDL.csv` and the mappings from model attributes to indices in `ParamMappings.json`.  We use these to create and index map and assign values accordingly to allparams.

We then take the mapping from the parameter set we vary over in `params.csv` to their corresponding indices in allparams located in `params_to_allparams.json`, and apply this mapping to the template to fill in the remaining values.

Then we do minor error correction, and write the new `AllParams.csv`
