# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 19:37:46 2022

@author: bates
"""

#streamlit run C:\Users\bates\Time_Series_Streamlit_vF.py

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import streamlit as st
from pandas import read_csv
from pandas import datetime
from matplotlib import pyplot
from pandas import DataFrame


###############################################################################
########
########## Import Time Series Full Region
########
TS = read_csv('D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report/TS_Prediction_Full.CSV')

# Convert the file into a DataFrame
TS = pd.DataFrame(TS)

# Add new column with Locale
TS['Locale'] = 'Full Region'
print(TS.head())

########
########## Import Time Series Wards 1 & 2
########
TS_W12 = read_csv('D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report/TS_Prediction_W_1_2.CSV')

# Convert the file into a DataFrame
TS_W12 = pd.DataFrame(TS_W12)

# Add new column with Locale
TS_W12['Locale'] = 'Wards 1 & 2'
print(TS_W12.head())

########
########## Import Time Series Wards 3 & 4
########
TS_W34 = read_csv('D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report/TS_Prediction_W_3_4.CSV')

# Convert the file into a DataFrame
TS_W34 = pd.DataFrame(TS_W34)

# Add new column with Locale
TS_W34['Locale'] = 'Wards 3 & 4'
print(TS_W34.head())


########
########## Import Time Series Wards 5 & 6
########
TS_W56 = read_csv('D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report/TS_Prediction_W_5_6.CSV')

# Convert the file into a DataFrame
TS_W56 = pd.DataFrame(TS_W56)

# Add new column with Locale
TS_W56['Locale'] = 'Wards 5 & 6'
print(TS_W56.head())


########
########## Import Time Series Wards 7 & 8
########
TS_W78 = read_csv('D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report/TS_Prediction_W_7_8.CSV')

# Convert the file into a DataFrame
TS_W78 = pd.DataFrame(TS_W78)

# Add new column with Locale
TS_W78['Locale'] = 'Wards 7 & 8'
print(TS_W78.head())

###############################################################################


###############################################################################
# Merge all DataFrames

frames = [TS, TS_W12, TS_W34, TS_W56, TS_W78]

TS_Total = pd.concat(frames)

print(TS_Total.head())

# dataframe.size
size = TS_Total.size
print(size)  

# dataframe.shape
shape = TS_Total.shape
print(shape)  

# dataframe.ndim
df_ndim = TS_Total.ndim
print(df_ndim)
###############################################################################

# Generate output value based on date

st.title('Time Series')


################################################################################
selected_locale = st.selectbox('Pick a locale', ['Full Region','Wards 1 & 2','Wards 3 & 4', 
                                                 'Wards 5 & 6', 'Wards 7 & 8'])

selected_date = st.selectbox('Pick a future date for prediction', TS_Total.Date.drop_duplicates(), 0)


selected_date_price = TS_Total.loc[(TS_Total["Locale"] == selected_locale) & (TS_Total["Date"] == selected_date), 'Average Home Sale Price'].iloc[0]

st.write(f'Average Home Price: {selected_date_price}')
################################################################################

































