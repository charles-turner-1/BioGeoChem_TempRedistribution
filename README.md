# Biogeochemical predictor for temperature redistribution
An attempt to use some basic ML techniques to estimate excess temperature.
**WARNING:** This is going to be written in a mixture of Julia and Python. 

## The basic idea
- In https://os.copernicus.org/articles/18/523/2022/, we showed how by doing a bunch of feature engineering, you could pretty reliably extract a change in temperature due to redistribution from a natural DIC change. This was done with a model.
- I've recently been prodding at ML techniques, in particular predicting temperature from biogeochemistry observationally.

The aim of this repo is to show that you can predict a change in temperature from a change in a number of conserved/conservative tracers, which we can assume to change **only** due to redistribution.

### Implementation
1. We will train a ML model which predicts temperature from these tracers: `DIC - Canth = Cnat`, `PO`, `NO`, in addition to physical coordinates. This will be done on the initial cruise from a hydrographic section.
2. We will then predict the temperature in subsequent cruises using this model
2. This predicted temperature will have a mismatch from the actual temperature, because it hasn't allowed for the fact that changes aren't just the redistribution: ie, this model will predict the background + redistributed temperature.
3. We can then estimate the excess temperature as the extent of the misclassification.

## Notes
#### DIC - Canth
- Since we are working with observations, we don't have a real `DIC - Canth = Cnat` field. This means we need to subtract off various `Canth` estimates. 
- We have four `Canth` estimates, so we are going to have four features for `DIC - Canth`.

#### Generality
Since this is a simple predictor model, we don't need to grid everything. It does, however, essentially extent the Kr framework, and therefore requires an estimate of `Cnat`. This might make life difficult if we try to apply it to a bunch of sections, as people will need to manually calculate `Canth` in order to get at `Cnat`

#### Accuracy
I have absolutely no idea how accurate this is going to be. If there are systematic issues with the model, then it's obviously going to systematically mispredict excess temperature.