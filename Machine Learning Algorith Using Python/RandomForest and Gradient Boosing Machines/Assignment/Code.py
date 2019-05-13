import pandas as pd
import numpy as np
import os
import seaborn as sns
import matplotlib.pyplot as plt
import json
with open('amsterdam.json') as json_data:
    d = json.load(json_data)
    print(d)

#ds_bedroom=pd.DataFrame.from_dict(d['bedrooms'],orient='index')
#ds_bedroom.describe()
#ds_bedroom.isnull().sum()

ds=pd.DataFrame.from_dict(d,orient='columns')
ds.isnull().sum()
ds.describe()
ds.dtypes

ds.price=ds.price.str.replace('$','')
ds.price=ds.price.str.replace(',','')
ds.price=ds.price.astype('float64')
ds=ds[ds.price<=440]
ds.dropna(how='any',inplace=True)
ds.isna().sum()

from math import radians, cos, sin, asin, sqrt
def haversine(lon2, lat2):
    """
    Calculate the great circle distance between two points
    on the earth (specified in decimal degrees)
    """
    # convert decimal degrees to radians
    lon1, lat1, lon2, lat2 = map(radians, [4.899431, 52.379189, lon2, lat2])
    # haversine formula
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat/2)**2 + cos(lat1) * cos(lat2) * sin(dlon/2)**2
    c = 2 * asin(sqrt(a))
    km = 6367 * c
    return km

#km = haversine(9.1929273,48.7868873,2.29548478125,48.87407920312501)

ds['DistanceFromCC']=ds.apply(lambda row : haversine(row['longitude'],row['latitude']), axis = 1)

ds=ds.sort_values(by=['DistanceFromCC'])
second_booking_price=ds['price'][1]

ds_lessthan1kmcc=ds[ds.DistanceFromCC<=1]
ds_groupby_roomtype=ds_lessthan1kmcc.groupby(['room_type']).mean()
round(ds_groupby_roomtype[ds_groupby_roomtype.index=='Private room']['price'],1)

ds.value_counts
ds=pd.get_dummies(ds)

X = ds.drop("price", axis=1)
y = ds.loc[:, 'price'].values

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.7, random_state = 200)

round(X_train.accommodates.mean()-X_test.accommodates.mean(),3)

# Fitting Random Forest Regression to the dataset
from sklearn.ensemble import RandomForestRegressor
estimators = np.arange(30, 601, 10)
scores = []
for n in estimators:
    regressor = RandomForestRegressor(n_estimators = n, random_state = 200,oob_score=True, max_features='sqrt')
    regressor.fit(X_train, y_train)
    regressor.score(X_test,y_test)
    print(n)
    scores.append(regressor.score(X_test, y_test))
plt.title("Effect of n_estimators")
plt.xlabel("n_estimator")
plt.ylabel("score")
plt.plot(estimators, scores)



estimators[scores.index(max(scores))]
estimators[47]


feature_importance=dict(zip(X_train.columns, regressor.feature_importances_))
diff=[]
regressor = RandomForestRegressor(n_estimators = 500, random_state = 200,oob_score=True, max_features='sqrt')
regressor.fit(X_train, y_train)
y_pred=regressor.predict(X_test)
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import max_error
mean_absolute_error(y_test, y_pred)
max_error(y_test, y_pred)

from sklearn.metrics import explained_variance_score
explained_variance_score(y_test, y_pred,multioutput='variance_weighted')

from sklearn.metrics import r2_score
r2_score(y_test, y_pred)



aa=list(zip(y_pred,y_test,y_pred~y_test))
diff=(y_pred-y_test)<33.41


plt.title("Effect of n_estimators")
plt.xlabel("n_estimator")
plt.ylabel("score")
plt.plot(estimators, scores)

