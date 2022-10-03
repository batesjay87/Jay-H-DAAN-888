{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Future Price Time Series Model"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "'D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report'"
      ],
      "text/latex": [
       "'D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report'"
      ],
      "text/markdown": [
       "'D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report'"
      ],
      "text/plain": [
       "[1] \"D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 43</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SSL</th><th scope=col>BATHRM</th><th scope=col>HF_BATHRM</th><th scope=col>HEAT</th><th scope=col>HEAT_D</th><th scope=col>AC</th><th scope=col>NUM_UNITS</th><th scope=col>ROOMS</th><th scope=col>BEDRM</th><th scope=col>AYB</th><th scope=col>⋯</th><th scope=col>KITCHENS</th><th scope=col>FIREPLACES</th><th scope=col>USECODE</th><th scope=col>LANDAREA</th><th scope=col>GIS_LAST_MOD_DTTM</th><th scope=col>OBJECTID</th><th scope=col>ASSESSMENT_NBHD</th><th scope=col>WARD</th><th scope=col>LATITUDE</th><th scope=col>LONGITUDE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>0150    0275</td><td>1</td><td>1</td><td> 7</td><td>Warm Cool    </td><td>Y</td><td>1</td><td>6</td><td>3</td><td>1900</td><td>⋯</td><td>1</td><td>0</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407639</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.04023</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>0150    0276</td><td>1</td><td>0</td><td> 7</td><td>Warm Cool    </td><td>Y</td><td>1</td><td>6</td><td>3</td><td>1900</td><td>⋯</td><td>1</td><td>0</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407640</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.04017</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>0150    0277</td><td>1</td><td>0</td><td>13</td><td>Hot Water Rad</td><td>N</td><td>1</td><td>6</td><td>3</td><td>1900</td><td>⋯</td><td>1</td><td>0</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407641</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.04012</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>0150    0278</td><td>2</td><td>1</td><td> 7</td><td>Warm Cool    </td><td>Y</td><td>1</td><td>6</td><td>2</td><td>1900</td><td>⋯</td><td>1</td><td>1</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407642</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.04006</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>0150    0279</td><td>1</td><td>1</td><td> 7</td><td>Warm Cool    </td><td>Y</td><td>1</td><td>6</td><td>3</td><td>1900</td><td>⋯</td><td>1</td><td>1</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407643</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.04000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>0150    0280</td><td>1</td><td>1</td><td> 7</td><td>Warm Cool    </td><td>Y</td><td>1</td><td>6</td><td>3</td><td>1910</td><td>⋯</td><td>1</td><td>1</td><td>11</td><td>960</td><td>2022/08/31 05:17:11+00</td><td>74407644</td><td>Old City 2</td><td>Ward 1</td><td>38.91745</td><td>-77.03995</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 43\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & SSL & BATHRM & HF\\_BATHRM & HEAT & HEAT\\_D & AC & NUM\\_UNITS & ROOMS & BEDRM & AYB & ⋯ & KITCHENS & FIREPLACES & USECODE & LANDAREA & GIS\\_LAST\\_MOD\\_DTTM & OBJECTID & ASSESSMENT\\_NBHD & WARD & LATITUDE & LONGITUDE\\\\\n",
       "  & <chr> & <int> & <int> & <int> & <chr> & <chr> & <int> & <int> & <int> & <int> & ⋯ & <int> & <int> & <int> & <int> & <chr> & <int> & <chr> & <chr> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 0150    0275 & 1 & 1 &  7 & Warm Cool     & Y & 1 & 6 & 3 & 1900 & ⋯ & 1 & 0 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407639 & Old City 2 & Ward 1 & 38.91745 & -77.04023\\\\\n",
       "\t2 & 0150    0276 & 1 & 0 &  7 & Warm Cool     & Y & 1 & 6 & 3 & 1900 & ⋯ & 1 & 0 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407640 & Old City 2 & Ward 1 & 38.91745 & -77.04017\\\\\n",
       "\t3 & 0150    0277 & 1 & 0 & 13 & Hot Water Rad & N & 1 & 6 & 3 & 1900 & ⋯ & 1 & 0 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407641 & Old City 2 & Ward 1 & 38.91745 & -77.04012\\\\\n",
       "\t4 & 0150    0278 & 2 & 1 &  7 & Warm Cool     & Y & 1 & 6 & 2 & 1900 & ⋯ & 1 & 1 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407642 & Old City 2 & Ward 1 & 38.91745 & -77.04006\\\\\n",
       "\t5 & 0150    0279 & 1 & 1 &  7 & Warm Cool     & Y & 1 & 6 & 3 & 1900 & ⋯ & 1 & 1 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407643 & Old City 2 & Ward 1 & 38.91745 & -77.04000\\\\\n",
       "\t6 & 0150    0280 & 1 & 1 &  7 & Warm Cool     & Y & 1 & 6 & 3 & 1910 & ⋯ & 1 & 1 & 11 & 960 & 2022/08/31 05:17:11+00 & 74407644 & Old City 2 & Ward 1 & 38.91745 & -77.03995\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 43\n",
       "\n",
       "| <!--/--> | SSL &lt;chr&gt; | BATHRM &lt;int&gt; | HF_BATHRM &lt;int&gt; | HEAT &lt;int&gt; | HEAT_D &lt;chr&gt; | AC &lt;chr&gt; | NUM_UNITS &lt;int&gt; | ROOMS &lt;int&gt; | BEDRM &lt;int&gt; | AYB &lt;int&gt; | ⋯ ⋯ | KITCHENS &lt;int&gt; | FIREPLACES &lt;int&gt; | USECODE &lt;int&gt; | LANDAREA &lt;int&gt; | GIS_LAST_MOD_DTTM &lt;chr&gt; | OBJECTID &lt;int&gt; | ASSESSMENT_NBHD &lt;chr&gt; | WARD &lt;chr&gt; | LATITUDE &lt;dbl&gt; | LONGITUDE &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | 0150    0275 | 1 | 1 |  7 | Warm Cool     | Y | 1 | 6 | 3 | 1900 | ⋯ | 1 | 0 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407639 | Old City 2 | Ward 1 | 38.91745 | -77.04023 |\n",
       "| 2 | 0150    0276 | 1 | 0 |  7 | Warm Cool     | Y | 1 | 6 | 3 | 1900 | ⋯ | 1 | 0 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407640 | Old City 2 | Ward 1 | 38.91745 | -77.04017 |\n",
       "| 3 | 0150    0277 | 1 | 0 | 13 | Hot Water Rad | N | 1 | 6 | 3 | 1900 | ⋯ | 1 | 0 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407641 | Old City 2 | Ward 1 | 38.91745 | -77.04012 |\n",
       "| 4 | 0150    0278 | 2 | 1 |  7 | Warm Cool     | Y | 1 | 6 | 2 | 1900 | ⋯ | 1 | 1 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407642 | Old City 2 | Ward 1 | 38.91745 | -77.04006 |\n",
       "| 5 | 0150    0279 | 1 | 1 |  7 | Warm Cool     | Y | 1 | 6 | 3 | 1900 | ⋯ | 1 | 1 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407643 | Old City 2 | Ward 1 | 38.91745 | -77.04000 |\n",
       "| 6 | 0150    0280 | 1 | 1 |  7 | Warm Cool     | Y | 1 | 6 | 3 | 1910 | ⋯ | 1 | 1 | 11 | 960 | 2022/08/31 05:17:11+00 | 74407644 | Old City 2 | Ward 1 | 38.91745 | -77.03995 |\n",
       "\n"
      ],
      "text/plain": [
       "  SSL          BATHRM HF_BATHRM HEAT HEAT_D        AC NUM_UNITS ROOMS BEDRM\n",
       "1 0150    0275 1      1          7   Warm Cool     Y  1         6     3    \n",
       "2 0150    0276 1      0          7   Warm Cool     Y  1         6     3    \n",
       "3 0150    0277 1      0         13   Hot Water Rad N  1         6     3    \n",
       "4 0150    0278 2      1          7   Warm Cool     Y  1         6     2    \n",
       "5 0150    0279 1      1          7   Warm Cool     Y  1         6     3    \n",
       "6 0150    0280 1      1          7   Warm Cool     Y  1         6     3    \n",
       "  AYB  ⋯ KITCHENS FIREPLACES USECODE LANDAREA GIS_LAST_MOD_DTTM      OBJECTID\n",
       "1 1900 ⋯ 1        0          11      960      2022/08/31 05:17:11+00 74407639\n",
       "2 1900 ⋯ 1        0          11      960      2022/08/31 05:17:11+00 74407640\n",
       "3 1900 ⋯ 1        0          11      960      2022/08/31 05:17:11+00 74407641\n",
       "4 1900 ⋯ 1        1          11      960      2022/08/31 05:17:11+00 74407642\n",
       "5 1900 ⋯ 1        1          11      960      2022/08/31 05:17:11+00 74407643\n",
       "6 1910 ⋯ 1        1          11      960      2022/08/31 05:17:11+00 74407644\n",
       "  ASSESSMENT_NBHD WARD   LATITUDE LONGITUDE\n",
       "1 Old City 2      Ward 1 38.91745 -77.04023\n",
       "2 Old City 2      Ward 1 38.91745 -77.04017\n",
       "3 Old City 2      Ward 1 38.91745 -77.04012\n",
       "4 Old City 2      Ward 1 38.91745 -77.04006\n",
       "5 Old City 2      Ward 1 38.91745 -77.04000\n",
       "6 Old City 2      Ward 1 38.91745 -77.03995"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 43</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SSL</th><th scope=col>BATHRM</th><th scope=col>HF_BATHRM</th><th scope=col>HEAT</th><th scope=col>HEAT_D</th><th scope=col>AC</th><th scope=col>NUM_UNITS</th><th scope=col>ROOMS</th><th scope=col>BEDRM</th><th scope=col>AYB</th><th scope=col>⋯</th><th scope=col>KITCHENS</th><th scope=col>FIREPLACES</th><th scope=col>USECODE</th><th scope=col>LANDAREA</th><th scope=col>GIS_LAST_MOD_DTTM</th><th scope=col>OBJECTID</th><th scope=col>ASSESSMENT_NBHD</th><th scope=col>WARD</th><th scope=col>LATITUDE</th><th scope=col>LONGITUDE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>⋯</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>108398</th><td>PAR 01550236</td><td>2</td><td>0</td><td>13</td><td>Hot Water Rad</td><td>N</td><td>1</td><td> 6</td><td>2</td><td>1934</td><td>⋯</td><td>1</td><td>1</td><td>12</td><td>4571</td><td>2022/08/31 05:17:11+00</td><td>74624612</td><td>Woodridge</td><td>Ward 5</td><td>38.92890</td><td>-76.97456</td></tr>\n",
       "\t<tr><th scope=row>108399</th><td>PAR 01550251</td><td>2</td><td>0</td><td> 1</td><td>Forced Air   </td><td>Y</td><td>1</td><td> 6</td><td>3</td><td>1935</td><td>⋯</td><td>1</td><td>0</td><td>12</td><td>3000</td><td>2022/08/31 05:17:11+00</td><td>74624613</td><td>Woodridge</td><td>Ward 5</td><td>38.92700</td><td>-76.97157</td></tr>\n",
       "\t<tr><th scope=row>108400</th><td>PAR 01550252</td><td>1</td><td>0</td><td>13</td><td>Hot Water Rad</td><td>N</td><td>1</td><td> 5</td><td>2</td><td>1935</td><td>⋯</td><td>1</td><td>0</td><td>12</td><td>3000</td><td>2022/08/31 05:17:11+00</td><td>74624614</td><td>Woodridge</td><td>Ward 5</td><td>38.92706</td><td>-76.97145</td></tr>\n",
       "\t<tr><th scope=row>108401</th><td>PAR 01550254</td><td>3</td><td>0</td><td>13</td><td>Hot Water Rad</td><td>N</td><td>1</td><td> 5</td><td>3</td><td>1922</td><td>⋯</td><td>1</td><td>0</td><td>12</td><td>7829</td><td>2022/08/31 05:17:11+00</td><td>74624615</td><td>Woodridge</td><td>Ward 5</td><td>38.92790</td><td>-76.97388</td></tr>\n",
       "\t<tr><th scope=row>108402</th><td>PAR 01550255</td><td>3</td><td>1</td><td> 1</td><td>Forced Air   </td><td>Y</td><td>1</td><td>10</td><td>4</td><td>1925</td><td>⋯</td><td>1</td><td>0</td><td>13</td><td>4001</td><td>2022/08/31 05:17:11+00</td><td>74624616</td><td>Woodridge</td><td>Ward 5</td><td>38.92924</td><td>-76.97320</td></tr>\n",
       "\t<tr><th scope=row>108403</th><td>PAR 01550259</td><td>1</td><td>0</td><td>13</td><td>Hot Water Rad</td><td>N</td><td>1</td><td> 6</td><td>3</td><td>1940</td><td>⋯</td><td>1</td><td>0</td><td>11</td><td>1399</td><td>2022/08/31 05:17:11+00</td><td>74624617</td><td>Woodridge</td><td>Ward 5</td><td>38.92924</td><td>-76.97465</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 43\n",
       "\\begin{tabular}{r|lllllllllllllllllllll}\n",
       "  & SSL & BATHRM & HF\\_BATHRM & HEAT & HEAT\\_D & AC & NUM\\_UNITS & ROOMS & BEDRM & AYB & ⋯ & KITCHENS & FIREPLACES & USECODE & LANDAREA & GIS\\_LAST\\_MOD\\_DTTM & OBJECTID & ASSESSMENT\\_NBHD & WARD & LATITUDE & LONGITUDE\\\\\n",
       "  & <chr> & <int> & <int> & <int> & <chr> & <chr> & <int> & <int> & <int> & <int> & ⋯ & <int> & <int> & <int> & <int> & <chr> & <int> & <chr> & <chr> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t108398 & PAR 01550236 & 2 & 0 & 13 & Hot Water Rad & N & 1 &  6 & 2 & 1934 & ⋯ & 1 & 1 & 12 & 4571 & 2022/08/31 05:17:11+00 & 74624612 & Woodridge & Ward 5 & 38.92890 & -76.97456\\\\\n",
       "\t108399 & PAR 01550251 & 2 & 0 &  1 & Forced Air    & Y & 1 &  6 & 3 & 1935 & ⋯ & 1 & 0 & 12 & 3000 & 2022/08/31 05:17:11+00 & 74624613 & Woodridge & Ward 5 & 38.92700 & -76.97157\\\\\n",
       "\t108400 & PAR 01550252 & 1 & 0 & 13 & Hot Water Rad & N & 1 &  5 & 2 & 1935 & ⋯ & 1 & 0 & 12 & 3000 & 2022/08/31 05:17:11+00 & 74624614 & Woodridge & Ward 5 & 38.92706 & -76.97145\\\\\n",
       "\t108401 & PAR 01550254 & 3 & 0 & 13 & Hot Water Rad & N & 1 &  5 & 3 & 1922 & ⋯ & 1 & 0 & 12 & 7829 & 2022/08/31 05:17:11+00 & 74624615 & Woodridge & Ward 5 & 38.92790 & -76.97388\\\\\n",
       "\t108402 & PAR 01550255 & 3 & 1 &  1 & Forced Air    & Y & 1 & 10 & 4 & 1925 & ⋯ & 1 & 0 & 13 & 4001 & 2022/08/31 05:17:11+00 & 74624616 & Woodridge & Ward 5 & 38.92924 & -76.97320\\\\\n",
       "\t108403 & PAR 01550259 & 1 & 0 & 13 & Hot Water Rad & N & 1 &  6 & 3 & 1940 & ⋯ & 1 & 0 & 11 & 1399 & 2022/08/31 05:17:11+00 & 74624617 & Woodridge & Ward 5 & 38.92924 & -76.97465\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 43\n",
       "\n",
       "| <!--/--> | SSL &lt;chr&gt; | BATHRM &lt;int&gt; | HF_BATHRM &lt;int&gt; | HEAT &lt;int&gt; | HEAT_D &lt;chr&gt; | AC &lt;chr&gt; | NUM_UNITS &lt;int&gt; | ROOMS &lt;int&gt; | BEDRM &lt;int&gt; | AYB &lt;int&gt; | ⋯ ⋯ | KITCHENS &lt;int&gt; | FIREPLACES &lt;int&gt; | USECODE &lt;int&gt; | LANDAREA &lt;int&gt; | GIS_LAST_MOD_DTTM &lt;chr&gt; | OBJECTID &lt;int&gt; | ASSESSMENT_NBHD &lt;chr&gt; | WARD &lt;chr&gt; | LATITUDE &lt;dbl&gt; | LONGITUDE &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 108398 | PAR 01550236 | 2 | 0 | 13 | Hot Water Rad | N | 1 |  6 | 2 | 1934 | ⋯ | 1 | 1 | 12 | 4571 | 2022/08/31 05:17:11+00 | 74624612 | Woodridge | Ward 5 | 38.92890 | -76.97456 |\n",
       "| 108399 | PAR 01550251 | 2 | 0 |  1 | Forced Air    | Y | 1 |  6 | 3 | 1935 | ⋯ | 1 | 0 | 12 | 3000 | 2022/08/31 05:17:11+00 | 74624613 | Woodridge | Ward 5 | 38.92700 | -76.97157 |\n",
       "| 108400 | PAR 01550252 | 1 | 0 | 13 | Hot Water Rad | N | 1 |  5 | 2 | 1935 | ⋯ | 1 | 0 | 12 | 3000 | 2022/08/31 05:17:11+00 | 74624614 | Woodridge | Ward 5 | 38.92706 | -76.97145 |\n",
       "| 108401 | PAR 01550254 | 3 | 0 | 13 | Hot Water Rad | N | 1 |  5 | 3 | 1922 | ⋯ | 1 | 0 | 12 | 7829 | 2022/08/31 05:17:11+00 | 74624615 | Woodridge | Ward 5 | 38.92790 | -76.97388 |\n",
       "| 108402 | PAR 01550255 | 3 | 1 |  1 | Forced Air    | Y | 1 | 10 | 4 | 1925 | ⋯ | 1 | 0 | 13 | 4001 | 2022/08/31 05:17:11+00 | 74624616 | Woodridge | Ward 5 | 38.92924 | -76.97320 |\n",
       "| 108403 | PAR 01550259 | 1 | 0 | 13 | Hot Water Rad | N | 1 |  6 | 3 | 1940 | ⋯ | 1 | 0 | 11 | 1399 | 2022/08/31 05:17:11+00 | 74624617 | Woodridge | Ward 5 | 38.92924 | -76.97465 |\n",
       "\n"
      ],
      "text/plain": [
       "       SSL          BATHRM HF_BATHRM HEAT HEAT_D        AC NUM_UNITS ROOMS\n",
       "108398 PAR 01550236 2      0         13   Hot Water Rad N  1          6   \n",
       "108399 PAR 01550251 2      0          1   Forced Air    Y  1          6   \n",
       "108400 PAR 01550252 1      0         13   Hot Water Rad N  1          5   \n",
       "108401 PAR 01550254 3      0         13   Hot Water Rad N  1          5   \n",
       "108402 PAR 01550255 3      1          1   Forced Air    Y  1         10   \n",
       "108403 PAR 01550259 1      0         13   Hot Water Rad N  1          6   \n",
       "       BEDRM AYB  ⋯ KITCHENS FIREPLACES USECODE LANDAREA GIS_LAST_MOD_DTTM     \n",
       "108398 2     1934 ⋯ 1        1          12      4571     2022/08/31 05:17:11+00\n",
       "108399 3     1935 ⋯ 1        0          12      3000     2022/08/31 05:17:11+00\n",
       "108400 2     1935 ⋯ 1        0          12      3000     2022/08/31 05:17:11+00\n",
       "108401 3     1922 ⋯ 1        0          12      7829     2022/08/31 05:17:11+00\n",
       "108402 4     1925 ⋯ 1        0          13      4001     2022/08/31 05:17:11+00\n",
       "108403 3     1940 ⋯ 1        0          11      1399     2022/08/31 05:17:11+00\n",
       "       OBJECTID ASSESSMENT_NBHD WARD   LATITUDE LONGITUDE\n",
       "108398 74624612 Woodridge       Ward 5 38.92890 -76.97456\n",
       "108399 74624613 Woodridge       Ward 5 38.92700 -76.97157\n",
       "108400 74624614 Woodridge       Ward 5 38.92706 -76.97145\n",
       "108401 74624615 Woodridge       Ward 5 38.92790 -76.97388\n",
       "108402 74624616 Woodridge       Ward 5 38.92924 -76.97320\n",
       "108403 74624617 Woodridge       Ward 5 38.92924 -76.97465"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "     SSL                BATHRM         HF_BATHRM            HEAT      \n",
       " Length:108403      Min.   : 0.000   Min.   : 0.0000   Min.   : 0.00  \n",
       " Class :character   1st Qu.: 1.000   1st Qu.: 0.0000   1st Qu.: 1.00  \n",
       " Mode  :character   Median : 2.000   Median : 1.0000   Median : 7.00  \n",
       "                    Mean   : 2.124   Mean   : 0.6298   Mean   : 7.27  \n",
       "                    3rd Qu.: 3.000   3rd Qu.: 1.0000   3rd Qu.:13.00  \n",
       "                    Max.   :30.000   Max.   :12.0000   Max.   :13.00  \n",
       "                    NA's   :1371     NA's   :1371      NA's   :1371   \n",
       "    HEAT_D               AC              NUM_UNITS          ROOMS        \n",
       " Length:108403      Length:108403      Min.   : 0.000   Min.   :  0.000  \n",
       " Class :character   Class :character   1st Qu.: 1.000   1st Qu.:  6.000  \n",
       " Mode  :character   Mode  :character   Median : 1.000   Median :  7.000  \n",
       "                                       Mean   : 1.196   Mean   :  7.397  \n",
       "                                       3rd Qu.: 1.000   3rd Qu.:  8.000  \n",
       "                                       Max.   :12.000   Max.   :101.000  \n",
       "                                       NA's   :1371     NA's   :1443     \n",
       "     BEDRM             AYB          YR_RMDL           EYB      \n",
       " Min.   : 0.000   Min.   :   0   Min.   :  202   Min.   :   0  \n",
       " 1st Qu.: 3.000   1st Qu.:1915   1st Qu.: 2000   1st Qu.:1960  \n",
       " Median : 3.000   Median :1930   Median : 2008   Median :1968  \n",
       " Mean   : 3.422   Mean   :1932   Mean   : 2006   Mean   :1946  \n",
       " 3rd Qu.: 4.000   3rd Qu.:1948   3rd Qu.: 2015   3rd Qu.:1975  \n",
       " Max.   :24.000   Max.   :2023   Max.   :20212   Max.   :2022  \n",
       " NA's   :1388     NA's   :21     NA's   :53877                 \n",
       "    STORIES          SALEDATE             PRICE           QUALIFIED        \n",
       " Min.   :  0.000   Length:108403      Min.   :       0   Length:108403     \n",
       " 1st Qu.:  2.000   Class :character   1st Qu.:       0   Class :character  \n",
       " Median :  2.000   Mode  :character   Median :  294000   Mode  :character  \n",
       " Mean   :  2.084                      Mean   :  465255                     \n",
       " 3rd Qu.:  2.000                      3rd Qu.:  715000                     \n",
       " Max.   :275.000                      Max.   :25100000                     \n",
       " NA's   :1459                         NA's   :14181                        \n",
       "    SALE_NUM           GBA           BLDG_NUM         STYLE       \n",
       " Min.   : 1.000   Min.   :    0   Min.   :1.000   Min.   : 0.000  \n",
       " 1st Qu.: 1.000   1st Qu.: 1188   1st Qu.:1.000   1st Qu.: 4.000  \n",
       " Median : 1.000   Median : 1488   Median :1.000   Median : 4.000  \n",
       " Mean   : 2.148   Mean   : 1710   Mean   :1.001   Mean   : 4.356  \n",
       " 3rd Qu.: 3.000   3rd Qu.: 1980   3rd Qu.:1.000   3rd Qu.: 4.000  \n",
       " Max.   :17.000   Max.   :45384   Max.   :5.000   Max.   :99.000  \n",
       "                                                  NA's   :1372    \n",
       "   STYLE_D              STRUCT         STRUCT_D             GRADE       \n",
       " Length:108403      Min.   : 0.000   Length:108403      Min.   : 0.000  \n",
       " Class :character   1st Qu.: 1.000   Class :character   1st Qu.: 3.000  \n",
       " Mode  :character   Median : 7.000   Mode  :character   Median : 4.000  \n",
       "                    Mean   : 5.013                      Mean   : 4.285  \n",
       "                    3rd Qu.: 7.000                      3rd Qu.: 5.000  \n",
       "                    Max.   :13.000                      Max.   :12.000  \n",
       "                    NA's   :1371                        NA's   :1371    \n",
       "   GRADE_D              CNDTN         CNDTN_D             EXTWALL     \n",
       " Length:108403      Min.   :0.000   Length:108403      Min.   : 0.00  \n",
       " Class :character   1st Qu.:3.000   Class :character   1st Qu.:14.00  \n",
       " Mode  :character   Median :4.000   Mode  :character   Median :14.00  \n",
       "                    Mean   :3.624                      Mean   :13.37  \n",
       "                    3rd Qu.:4.000                      3rd Qu.:14.00  \n",
       "                    Max.   :6.000                      Max.   :24.00  \n",
       "                    NA's   :1371                       NA's   :1371   \n",
       "  EXTWALL_D              ROOF           ROOF_D             INTWALL      \n",
       " Length:108403      Min.   : 0.000   Length:108403      Min.   : 0.000  \n",
       " Class :character   1st Qu.: 1.000   Class :character   1st Qu.: 6.000  \n",
       " Mode  :character   Median : 2.000   Mode  :character   Median : 6.000  \n",
       "                    Mean   : 3.966                      Mean   : 6.161  \n",
       "                    3rd Qu.: 6.000                      3rd Qu.: 6.000  \n",
       "                    Max.   :15.000                      Max.   :11.000  \n",
       "                    NA's   :1371                        NA's   :1371    \n",
       "  INTWALL_D            KITCHENS        FIREPLACES         USECODE      \n",
       " Length:108403      Min.   : 0.000   Min.   : 0.0000   Min.   :  0.00  \n",
       " Class :character   1st Qu.: 1.000   1st Qu.: 0.0000   1st Qu.: 11.00  \n",
       " Mode  :character   Median : 1.000   Median : 0.0000   Median : 12.00  \n",
       "                    Mean   : 1.226   Mean   : 0.6268   Mean   : 13.15  \n",
       "                    3rd Qu.: 1.000   3rd Qu.: 1.0000   3rd Qu.: 13.00  \n",
       "                    Max.   :44.000   Max.   :13.0000   Max.   :995.00  \n",
       "                    NA's   :1372     NA's   :1374                      \n",
       "    LANDAREA      GIS_LAST_MOD_DTTM     OBJECTID        ASSESSMENT_NBHD   \n",
       " Min.   :     0   Length:108403      Min.   :74407639   Length:108403     \n",
       " 1st Qu.:  1572   Class :character   1st Qu.:74543316   Class :character  \n",
       " Median :  2327   Mode  :character   Median :74570416   Mode  :character  \n",
       " Mean   :  3389                      Mean   :74570406                     \n",
       " 3rd Qu.:  4160                      3rd Qu.:74597516                     \n",
       " Max.   :942632                      Max.   :74624617                     \n",
       "                                                                          \n",
       "     WARD              LATITUDE       LONGITUDE     \n",
       " Length:108403      Min.   :38.82   Min.   :-77.11  \n",
       " Class :character   1st Qu.:38.89   1st Qu.:-77.04  \n",
       " Mode  :character   Median :38.92   Median :-77.01  \n",
       "                    Mean   :38.92   Mean   :-77.01  \n",
       "                    3rd Qu.:38.94   3rd Qu.:-76.98  \n",
       "                    Max.   :39.00   Max.   :-76.91  \n",
       "                    NA's   :2103    NA's   :2103    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t108403 obs. of  43 variables:\n",
      " $ SSL              : chr  \"0150    0275\" \"0150    0276\" \"0150    0277\" \"0150    0278\" ...\n",
      " $ BATHRM           : int  1 1 1 2 1 1 2 1 1 1 ...\n",
      " $ HF_BATHRM        : int  1 0 0 1 1 1 1 1 1 1 ...\n",
      " $ HEAT             : int  7 7 13 7 7 7 7 7 7 7 ...\n",
      " $ HEAT_D           : chr  \"Warm Cool\" \"Warm Cool\" \"Hot Water Rad\" \"Warm Cool\" ...\n",
      " $ AC               : chr  \"Y\" \"Y\" \"N\" \"Y\" ...\n",
      " $ NUM_UNITS        : int  1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ ROOMS            : int  6 6 6 6 6 6 6 6 6 6 ...\n",
      " $ BEDRM            : int  3 3 3 2 3 3 2 3 3 3 ...\n",
      " $ AYB              : int  1900 1900 1900 1900 1900 1910 1900 1900 1900 1900 ...\n",
      " $ YR_RMDL          : int  2004 NA NA 2016 NA NA 2001 NA 2003 2015 ...\n",
      " $ EYB              : int  1971 1961 1961 1971 1961 1968 1971 1971 1971 1961 ...\n",
      " $ STORIES          : num  2 2 2 2 2 2 2 2 2 2 ...\n",
      " $ SALEDATE         : chr  \"2013/07/22 00:00:00+00\" \"1900/01/01 00:00:00+00\" \"1996/02/12 00:00:00+00\" \"2022/04/06 00:00:00+00\" ...\n",
      " $ PRICE            : int  755000 NA 118000 1110000 0 251000 930388 606500 0 162000 ...\n",
      " $ QUALIFIED        : chr  \"Q\" \"U\" \"U\" \"Q\" ...\n",
      " $ SALE_NUM         : int  1 1 1 5 3 1 5 1 3 1 ...\n",
      " $ GBA              : int  1286 1286 1286 1304 1286 1286 1286 1286 1344 1286 ...\n",
      " $ BLDG_NUM         : int  1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ STYLE            : int  4 4 4 4 4 4 4 4 4 4 ...\n",
      " $ STYLE_D          : chr  \"2 Story\" \"2 Story\" \"2 Story\" \"2 Story\" ...\n",
      " $ STRUCT           : int  7 7 7 7 7 7 7 7 7 7 ...\n",
      " $ STRUCT_D         : chr  \"Row Inside\" \"Row Inside\" \"Row Inside\" \"Row Inside\" ...\n",
      " $ GRADE            : int  4 4 4 4 4 4 4 4 4 4 ...\n",
      " $ GRADE_D          : chr  \"Above Average\" \"Above Average\" \"Above Average\" \"Above Average\" ...\n",
      " $ CNDTN            : int  4 3 3 4 3 4 3 3 4 3 ...\n",
      " $ CNDTN_D          : chr  \"Good\" \"Average\" \"Average\" \"Good\" ...\n",
      " $ EXTWALL          : int  14 14 14 14 14 14 14 14 14 14 ...\n",
      " $ EXTWALL_D        : chr  \"Common Brick\" \"Common Brick\" \"Common Brick\" \"Common Brick\" ...\n",
      " $ ROOF             : int  2 2 2 2 2 2 2 2 2 2 ...\n",
      " $ ROOF_D           : chr  \"Built Up\" \"Built Up\" \"Built Up\" \"Built Up\" ...\n",
      " $ INTWALL          : int  6 6 6 6 6 6 6 6 6 6 ...\n",
      " $ INTWALL_D        : chr  \"Hardwood\" \"Hardwood\" \"Hardwood\" \"Hardwood\" ...\n",
      " $ KITCHENS         : int  1 1 1 1 1 1 1 1 1 1 ...\n",
      " $ FIREPLACES       : int  0 0 0 1 1 1 1 1 0 1 ...\n",
      " $ USECODE          : int  11 11 11 11 11 11 11 11 11 11 ...\n",
      " $ LANDAREA         : int  960 960 960 960 960 960 960 960 960 960 ...\n",
      " $ GIS_LAST_MOD_DTTM: chr  \"2022/08/31 05:17:11+00\" \"2022/08/31 05:17:11+00\" \"2022/08/31 05:17:11+00\" \"2022/08/31 05:17:11+00\" ...\n",
      " $ OBJECTID         : int  74407639 74407640 74407641 74407642 74407643 74407644 74407645 74407646 74407647 74407648 ...\n",
      " $ ASSESSMENT_NBHD  : chr  \"Old City 2\" \"Old City 2\" \"Old City 2\" \"Old City 2\" ...\n",
      " $ WARD             : chr  \"Ward 1\" \"Ward 1\" \"Ward 1\" \"Ward 1\" ...\n",
      " $ LATITUDE         : num  38.9 38.9 38.9 38.9 38.9 ...\n",
      " $ LONGITUDE        : num  -77 -77 -77 -77 -77 ...\n"
     ]
    }
   ],
   "source": [
    "setwd(\"D:/Penn State/DAAN/DAAN 888 Analytics Design Implementation/Report\")  #set my working directory\n",
    "getwd()\n",
    "\n",
    "HOUSE.df <- read.csv(\"ResidentialSalesWithLocation_CSV.csv\", header = TRUE)  #import data into R\n",
    "\n",
    "######################### Verify the data ##########################\n",
    "head(HOUSE.df)   #Verify the first five rows of the dataframe\n",
    "\n",
    "tail(HOUSE.df)   #Verify the last five rows of the dataframe\n",
    "\n",
    "summary(HOUSE.df)   #To check the variables and counts\n",
    "\n",
    "str(HOUSE.df)   #To check the data structure of the loaded dataset\n",
    "####################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SALEDATE</th><th scope=col>PRICE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2013/07/22 00:00:00+00</td><td> 755000</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1900/01/01 00:00:00+00</td><td>     NA</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1996/02/12 00:00:00+00</td><td> 118000</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022/04/06 00:00:00+00</td><td>1110000</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>2017/03/24 00:00:00+00</td><td>      0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2000/06/30 00:00:00+00</td><td> 251000</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & SALEDATE & PRICE\\\\\n",
       "  & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2013/07/22 00:00:00+00 &  755000\\\\\n",
       "\t2 & 1900/01/01 00:00:00+00 &      NA\\\\\n",
       "\t3 & 1996/02/12 00:00:00+00 &  118000\\\\\n",
       "\t4 & 2022/04/06 00:00:00+00 & 1110000\\\\\n",
       "\t5 & 2017/03/24 00:00:00+00 &       0\\\\\n",
       "\t6 & 2000/06/30 00:00:00+00 &  251000\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | SALEDATE &lt;chr&gt; | PRICE &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 2013/07/22 00:00:00+00 |  755000 |\n",
       "| 2 | 1900/01/01 00:00:00+00 |      NA |\n",
       "| 3 | 1996/02/12 00:00:00+00 |  118000 |\n",
       "| 4 | 2022/04/06 00:00:00+00 | 1110000 |\n",
       "| 5 | 2017/03/24 00:00:00+00 |       0 |\n",
       "| 6 | 2000/06/30 00:00:00+00 |  251000 |\n",
       "\n"
      ],
      "text/plain": [
       "  SALEDATE               PRICE  \n",
       "1 2013/07/22 00:00:00+00  755000\n",
       "2 1900/01/01 00:00:00+00      NA\n",
       "3 1996/02/12 00:00:00+00  118000\n",
       "4 2022/04/06 00:00:00+00 1110000\n",
       "5 2017/03/24 00:00:00+00       0\n",
       "6 2000/06/30 00:00:00+00  251000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "   SALEDATE             PRICE         \n",
       " Length:108403      Min.   :       0  \n",
       " Class :character   1st Qu.:       0  \n",
       " Mode  :character   Median :  294000  \n",
       "                    Mean   :  465255  \n",
       "                    3rd Qu.:  715000  \n",
       "                    Max.   :25100000  \n",
       "                    NA's   :14181     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t108403 obs. of  2 variables:\n",
      " $ SALEDATE: chr  \"2013/07/22 00:00:00+00\" \"1900/01/01 00:00:00+00\" \"1996/02/12 00:00:00+00\" \"2022/04/06 00:00:00+00\" ...\n",
      " $ PRICE   : int  755000 NA 118000 1110000 0 251000 930388 606500 0 162000 ...\n"
     ]
    }
   ],
   "source": [
    "################################################################################\n",
    "# Create a new data set for the total population\n",
    "# Only two features, \"SALEDATE\" and \"PRICE\"\n",
    "\n",
    "HOUSE_TS1.df <- subset(HOUSE.df, select = c(SALEDATE, PRICE))\n",
    "\n",
    "head(HOUSE_TS1.df)     #Verify the first five rows of the dataframe\n",
    "\n",
    "summary(HOUSE_TS1.df)     #To check the variables and counts\n",
    "\n",
    "str(HOUSE_TS1.df)   #To check the data structure of the loaded dataset\n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   SALEDATE             PRICE         \n",
       " Length:62008       Min.   :       1  \n",
       " Class :character   1st Qu.:  300000  \n",
       " Mode  :character   Median :  557985  \n",
       "                    Mean   :  706961  \n",
       "                    3rd Qu.:  894000  \n",
       "                    Max.   :25100000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "################################################################################\n",
    "# Remove 0s and NA's from the \"PRICE\" variable\n",
    "HOUSE_TS1.df[HOUSE_TS1.df==0] <- NA     # Set all 0s to NA\n",
    "\n",
    "HOUSE_TS1.df <- na.omit(HOUSE_TS1.df)     # Removes all NA's from the dataframe\n",
    "\n",
    "summary(HOUSE_TS1.df)     #To check the variables and counts\n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'ggplot2' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'dplyr' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: 'dplyr'\n",
      "\n",
      "\n",
      "The following objects are masked from 'package:stats':\n",
      "\n",
      "    filter, lag\n",
      "\n",
      "\n",
      "The following objects are masked from 'package:base':\n",
      "\n",
      "    intersect, setdiff, setequal, union\n",
      "\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAANlBMVEUAAAAzMzNNTU1oaGh8\nfHyMjIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enr6+vw8PD////agy6EAAAACXBIWXMA\nABJ0AAASdAHeZh94AAAS50lEQVR4nO3da1cUBwJF0aZ9JOMjE/7/nx11jBIFE7DkwO29Pxgj\nLlfXlZNqqpvK6Rr4aaf6AcACIcEBhAQHEBIcQEhwACHBAYQEBxASHODwkP5Lwe4JIa2xe0JI\na+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2x\ne0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4J\nIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0\nxu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7\nJ4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhDTm6uqqfggXSUhbrq6U\nlBDSlKsrJTWENEVIFSFNEVJFSFOEVPmFIfH4PodUP4yL5ow0wBmpIqQtOooIaYyOGkJaY/eE\nkNbYPSGkNXZPCGmN3RNCWmP3hJDW2D0hpDV2Twhpjd0TQlpj94SQ1tg9IaQ1dk8IaY3dE0Ja\nY/eEkNbYPSGkNXZPCGmN3RNCWmP3hJDW2D0hpDV2Twhpjd0TQlpj94SQxriLUENIW9zXLiKk\nKe60WhHSFCFVhDRFSBUhbdFRREhjdNQQ0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGt\nsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbu\nCSGtsXtCSGPcs6EhpC3uIhQR0hT3tasIaYqQKkKaIqSKkLboKCKkMTpqCGmN3RNCWmP3hJDW\n2D0hpDV2Twhpjd0TQlpj94SQ1tg9IaQ1dk8IaY3dE0JaY/eEkNbYPSGkNXZPCGmN3RNCWmP3\nhJDW2D0hpDV2Twhpjd0TQlpj94SQ1tg9IaQ1dk8IaYybnzSEtMXtuCJCmuIGkRUhTRFSRUhT\nhFQR0hYdRYQ0RkcNIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7\nQkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkh\nrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG\n7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsn\nhLTG7gkhrbF7Qkhr7J4Q0hq7J+4T0vmDH33gfP7b76gP7ULZPXGPkM5ffvjRB4QUs3vi50I6\nf/eBGx+vD+1C2T1xj5C+hPL1CZyQnh67Jx4Q0o1uvgvpc0dXH/2rPw/G/KuQztdfuzn/dXHh\n+5A+qf8bcaHsnnhISF8vzt11RhJSx+6J+4X07fWGb0P626WI+tAulN0T9wrpu7OOkJ4euyfu\nE9LNC3Pnb39dSE+E3RP3COnL10bfvcPhm6+ZhFSye+IeId1XfWgXyu4JIa2xe0JIa+yeENIa\nuyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+ye\nENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JI\na+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2x\ne0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhDTm6uqqfggXSUhbrq6UlBDSlKsrJTWE\nNEVIFSFNEVJFSFt0FBHSGB01hDRGSA0hbfHULiKkKS42VIQ0RUgVIU0RUkVIW3QUEdIYHTWE\ntMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7QkhjXP5uCGmLF2QjQpriLUIVIU0RUkVIU4RU\nEdIWHUWENEZHDSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JI\na+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGN9G0RDSFt/YFxHSFN9qXhHSFCFVhDRFSBUhbdFR\nREhbhBQR0hRP7SpCmiKkipCmCKkipC06ighpjI4aQtrijBQR0hRfI1WENEVIFSFNEVJFSFt0\nFBHSGB01hLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtC\nSGvsnhDSGrsnhLTG7gkhrbF7Qkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGt\nsXtCSGPcjqshpC1uEBkR0hS3LK78wpB4fJ9Dqh/GRXNGGuCMVBHSFh1FhDRGRw0hrbF7Qkhr\n7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhLTG7gkhrbF7\nQkhr7J4Q0hq7J4S0xu4JIa2xe0JIa+yeENIauyeEtMbuCSGtsXtCSGPcRaghpC3uaxcR0hR3\nWq0IaYqQKreHdDrd9lMhPXlCqvwgpP8nJKRnRUcRIY3RUUNIa+yeENIauyeEtMbuCSGtsXtC\nSGvsnrgrpBuE9KzYPSGkNXZP3B7SIepDu1B2Twhpjd0Td4X0n/PHH9+9fi+kZ8buiTtCenk6\nfUrofPpNSM+Ktwg1bg/pzen89tNP3p1Pb4T0jHjTauT2kF6e3n7+2dvTSyE9H76NonJ7SL4f\n6ZkSUuWfQzoL6fkQUuX2kF6e/vj8sz9Or4X0jOgocntI//mSz+svXy0J6VnQUeP2kK7Pp1fv\nPvzj3avTi4d2JKSG3RN3hPTH+fMb7c5/fNuHkJ42uyfuCOn6+s2rDxm9evCLSEKq2D1xZ0g/\nrz60y+RrpIaQtrhqFxHSFK8jVW4PyTf2PVNCqghpipAqt4d0iPrQLpKOIv8c0u9Cek501Lgj\npHcvTi8+vrXh+v0LT+2eF7snbg/p3acvjt5/OB2dHv4eofrQLpTdE7eH9Or02/Vvp9cfv+P8\nwc/s/IU27J64PaTT6c/rP0+nl6cXbn7y3Ng9cVdIn374iTufCCniYkPjhyE9+FuRhFRx+Tvy\nw5B+qiMhBbwgWxHSFCFVhDRFSJW7QvJeu+dJRxEhjdFR4/aQDlEf2oWye0JIa+yeuCOk9y9P\np9cPv4GQkDKe2jVuD+n96a93rQrpeXGxIXJ7SK8/vjno9cPvViykiMvfldtD+nSp7s+H3z9f\nSBEhVX4Q0s++Ilsf2iUSUkVIW3QUEdIYHTWENEZIjbtC8hah58lTu4iQprjYULk9pEPUh3aJ\nhFQR0hQhVYS0RUcRIY3RUUNIa+yeENIauyeEtMbuCSGtsXtCSGvsnhDSGrsnhDTG5e+GkLZ4\nQTYipCneIlQR0hQhVYQ0RUgVIU0RUkVIW3QUEdIYHTWEtMbuCSGtsXtCSGvsnhDSGF8jNYS0\nxVW7iJCmeB2pIqQpQqoIaYqQKkKaIqSKkKYIqSKkKUKqCGmKkCpCmiKkipCmCKkipC06ighp\njI4aQlpj94SQ1tg9IaQ1dk8IaY3dE0JaY/eEkNbYPSGkNXZPCGmN3RNCWmP3hJDW2D0hpDV2\nTwhpjd0TQlpj94SQ1tg9IaQ1dk8IaY3dE/cL6XzHL3/w+R/nr7+lPrQLZffEvUI63x7S+WZj\nQmr5DtnGfUI6f3dGOn8X0o3fUR/aRXLPhsh9QvoSzpcncEJ6YtxFqPKAkG50811Inzv69Lf5\nL/48DvY5pPphXLR7h3T+6+LC9yF9Uv834hI5I1UeEtLXi3N3nZGEVNFR5KFnpBv//t0TPiGF\ndNQQ0hq7Jx4a0vkff9VfaMPuiQeEdP239y/87ReE1LN74n4h3Ut9aBfK7gkhjXGxoSGkLS5/\nR4Q0xQuyFSFNEVJFSFOEVBHSFCFVhDRFSBUhTRFSRUhThFQR0hQhVYS0RUcRIY3RUUNIa+ye\nENIauyeENMZTu4aQtrjYEBHSFJe/K0KaIqSKkKYIqSKkKUKqCGmKkCpCmiKkipC26CgipC1C\nighpiqd2FSFNEVJFSFOEVBHSFCFVhDRFSBUhTRFSRUhThFQR0hQhVYS0RUcRIU1xRqoIaYqQ\nKkKaIqSKkKYIqSKkKUKqCGmLjiJCGqOjhpDW2D0hpDHOSA0hbfE1UkRIU1y1qwhpipAqQpoi\npIqQtugoIqQpzkgVIU0RUkVIU4RUEdIWHUWENMUZqSKkKUKqCGmKkCpCmiKkipCmCKkipClC\nqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkLaoqOIkKY4I1WENEVIFSFNEVJFSFOEVBHSFCFV\nhDRFSBUhTRFSRUhThFQR0hQhVYQ0RUgVIU0RUkVIU4RUEdIUIVWENEVIFSFNEVJFSFOEVBHS\nFCFVhDRFSBUhTRFSRUhThFQR0hQhVYQ0RUgVIU0RUkVIU4RUEdIUIVWENEVIFSFNEVJFSFOE\nVBHSFCFVhDRFSBUhTRFSRUhThFQR0hQhVYQ0RUgVIU0RUkVIU4RUEdIUIVWENEVIFSFNEVJF\nSFOEVBHSFCFVhDRFSBUhTRFSRUhThFQR0hQhVYQ0RUgVIU0RUkVIU4RUEdIUIVWENEVIFSFN\nEVJFSFOEVBHSFCFVhDRFSBUhTRFSRUhThFQR0hQhVYQ0RUgVIU0RUkVIU4RUEdIUIVWENEVI\nFSFNEVJFSFOEVBHSFCFVfmFIPL7PIdUP46I5Iw1wRqoIaYqQKkKaIqSKkKYIqSKkKUKqCGmK\nkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkKaIqSKkKYIqSKkKUKq\nCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkKaIqSKkKYIqSKk\nKUKqCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkKaIqSKkKYI\nqSKkKUKqCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkKaIqSK\nkKYIqSKkKUKqCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQKkKa\nIqSKkKYIqSKkKUKqCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoIaYqQ\nKkKaIqSKkKYIqSKkKUKqCGmKkCpCmiKkipCmCKkipClCqghpipAqQpoipIqQpgipIqQpQqoI\naYqQKkKaIqSKkKYIqSKkLTqKCGmMjhpCWqOjhJDWCCkhpDVCSghpjZASQlojpISQ1ggpIaQ1\nQkoIaY2QEkJaI6SEkNYIKSGkNUJKCGmNkBJCWiOkhJDWCCkhpDVCSghpjZASQlojpISQ1ggp\nIaQ1QkoIaY2QEhcS0hWL6k+rGy4lpKMPjidASI9OSIuE9OiEtEhIj05Ii4T06IS0SEiPTkiL\nhPTohLRISI+ufsGDX6L+tLpBSDxf9afVDULi+ao/rW64lJCOPjieACE9OiEtEtKjE9IiIT06\nIS0S0qMT0iIhPbr68hK/RP1pdcOFhHRBntJn1wUR0hohJYS0RkgJIa0RUuI+IZ0/+OEH/v4b\n6kO7UEJK3COk85cf7vjAN7+hPrQLJaTEz4V0FtKTI6TEQ0L6+gxOSE+PkBIPCOlGL3eF9OnV\nsn/682DRvUM6/58z0tNi98RDQjp/eW7nqd3TY/fEQ89IN35JSE+K3RNCWmP3xENDOv/zB+pD\nu1B2T9wjpDvewHDnB+pDu1B2T9wnpHuqD+1C2T0hpDV2Twhpjd0TQlpj94SQ1tg9IaQ1dk8I\naY3dE0JaY/eEkNbYPSGkNXZPCGmN3RNCWmP3hJDW2D0hpDV2Twhpjd0TQlpj94SQ1tg9IaQ1\ndk8IaY3dE0JaY/eEkNbYPSGkNXZPCGmN3RNCWmP3hJDW2D0hpDV2Twhpjd0TQlpj98QvDImE\n/+VoTEgbhBQT0gYhxYS0QUgxIcEBhAQHEBIcQEhwACHBAYQEBxASHEBIcAAhwQGEBAcQEhxA\nSHAAIcEBhAQHEBIcQEhwACHBAYQEBxASHEBIcAAhwQGEBAcQEhxASHAAIcEBhAQHEBIcQEhw\nACHBAYT0/L06vb++fn96WT+Oiyak5+/P04vr65cfayIjpAG/n96+Of1WP4rLJqQF5w/qx3Dh\nhLTgzen0pn4MF05IC4SUE9KC84sXntq1hDTg99Pbt6ff60dx2YT0/H26/P3i9Gf9OC6akJ6/\nzy/Ivqofx0UTEhxASHAAIcEBhAQHEBIcQEhwACHBAYQEBxASHEBIcAAhwQGEBAf4H3SXeNZi\n4KmcAAAAAElFTkSuQmCC",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "################################################################################\n",
    "# Boxplot of the \"PRICE\" variable\n",
    "# Install packages\n",
    "install.packages(\"ggplot2\")\n",
    "install.packages(\"dplyr\")\n",
    "library(\"ggplot2\")\n",
    "library(\"dplyr\")\n",
    "\n",
    "# Create boxplot of the \"PRICE\" variable \n",
    "ggplot(data = HOUSE_TS1.df, aes(x = \"\", y = PRICE)) + \n",
    "  geom_boxplot() +\n",
    "  coord_cartesian(ylim = c(0, 26000000)) # Set the y axis scale\n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'lubridate' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'linelist' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'aweek' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'zoo' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'tidyverse' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into 'C:/Users/bates/AppData/Local/R/win-library/4.2'\n",
      "(as 'lib' is unspecified)\n",
      "\n"
     ]
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "package 'rio' successfully unpacked and MD5 sums checked\n",
      "\n",
      "The downloaded binary packages are in\n",
      "\tC:\\Users\\bates\\AppData\\Local\\Temp\\RtmpeeD5B5\\downloaded_packages\n"
     ]
    },
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\n",
      "Attaching package: 'lubridate'\n",
      "\n",
      "\n",
      "The following objects are masked from 'package:base':\n",
      "\n",
      "    date, intersect, setdiff, union\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: 'zoo'\n",
      "\n",
      "\n",
      "The following objects are masked from 'package:base':\n",
      "\n",
      "    as.Date, as.Date.numeric\n",
      "\n",
      "\n",
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.1\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mlubridate\u001b[39m::\u001b[32mas.difftime()\u001b[39m masks \u001b[34mbase\u001b[39m::as.difftime()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mlubridate\u001b[39m::\u001b[32mdate()\u001b[39m        masks \u001b[34mbase\u001b[39m::date()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m          masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mlubridate\u001b[39m::\u001b[32mintersect()\u001b[39m   masks \u001b[34mbase\u001b[39m::intersect()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m             masks \u001b[34mstats\u001b[39m::lag()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mlubridate\u001b[39m::\u001b[32msetdiff()\u001b[39m     masks \u001b[34mbase\u001b[39m::setdiff()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mlubridate\u001b[39m::\u001b[32munion()\u001b[39m       masks \u001b[34mbase\u001b[39m::union()\n"
     ]
    }
   ],
   "source": [
    "################################################################################\n",
    "# Install packages to work with dates\n",
    "install.packages(\"lubridate\")  # general package for handling and converting dates)\n",
    "install.packages(\"linelist\")   # has function to \"guess\" messy dates\n",
    "install.packages(\"aweek\")      # another option for converting dates to weeks, and weeks to dates\n",
    "install.packages(\"zoo\")        # additional date/time functions\n",
    "install.packages(\"tidyverse\")  # data management and visualization  \n",
    "install.packages(\"rio\")        # data import/export\n",
    "library(\"lubridate\")  \n",
    "library(\"linelist\")   \n",
    "library(\"aweek\")      \n",
    "library(\"zoo\")        \n",
    "library(\"tidyverse\")    \n",
    "library(\"rio\")   \n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "'character'"
      ],
      "text/latex": [
       "'character'"
      ],
      "text/markdown": [
       "'character'"
      ],
      "text/plain": [
       "[1] \"character\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SALEDATE</th><th scope=col>PRICE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2013-07-22</td><td> 755000</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1996-02-12</td><td> 118000</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022-04-06</td><td>1110000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2000-06-30</td><td> 251000</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>2021-11-22</td><td> 930388</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>2006-02-06</td><td> 606500</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & SALEDATE & PRICE\\\\\n",
       "  & <date> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2013-07-22 &  755000\\\\\n",
       "\t3 & 1996-02-12 &  118000\\\\\n",
       "\t4 & 2022-04-06 & 1110000\\\\\n",
       "\t6 & 2000-06-30 &  251000\\\\\n",
       "\t7 & 2021-11-22 &  930388\\\\\n",
       "\t8 & 2006-02-06 &  606500\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | SALEDATE &lt;date&gt; | PRICE &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 2013-07-22 |  755000 |\n",
       "| 3 | 1996-02-12 |  118000 |\n",
       "| 4 | 2022-04-06 | 1110000 |\n",
       "| 6 | 2000-06-30 |  251000 |\n",
       "| 7 | 2021-11-22 |  930388 |\n",
       "| 8 | 2006-02-06 |  606500 |\n",
       "\n"
      ],
      "text/plain": [
       "  SALEDATE   PRICE  \n",
       "1 2013-07-22  755000\n",
       "3 1996-02-12  118000\n",
       "4 2022-04-06 1110000\n",
       "6 2000-06-30  251000\n",
       "7 2021-11-22  930388\n",
       "8 2006-02-06  606500"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "'Date'"
      ],
      "text/latex": [
       "'Date'"
      ],
      "text/markdown": [
       "'Date'"
      ],
      "text/plain": [
       "[1] \"Date\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SALEDATE</th><th scope=col>PRICE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>2013-07</td><td> 755000</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1996-02</td><td> 118000</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>2022-04</td><td>1110000</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>2000-06</td><td> 251000</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>2021-11</td><td> 930388</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>2006-02</td><td> 606500</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & SALEDATE & PRICE\\\\\n",
       "  & <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t1 & 2013-07 &  755000\\\\\n",
       "\t3 & 1996-02 &  118000\\\\\n",
       "\t4 & 2022-04 & 1110000\\\\\n",
       "\t6 & 2000-06 &  251000\\\\\n",
       "\t7 & 2021-11 &  930388\\\\\n",
       "\t8 & 2006-02 &  606500\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 2\n",
       "\n",
       "| <!--/--> | SALEDATE &lt;chr&gt; | PRICE &lt;int&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 2013-07 |  755000 |\n",
       "| 3 | 1996-02 |  118000 |\n",
       "| 4 | 2022-04 | 1110000 |\n",
       "| 6 | 2000-06 |  251000 |\n",
       "| 7 | 2021-11 |  930388 |\n",
       "| 8 | 2006-02 |  606500 |\n",
       "\n"
      ],
      "text/plain": [
       "  SALEDATE PRICE  \n",
       "1 2013-07   755000\n",
       "3 1996-02   118000\n",
       "4 2022-04  1110000\n",
       "6 2000-06   251000\n",
       "7 2021-11   930388\n",
       "8 2006-02   606500"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "################################################################################\n",
    "# Clean up Date attribute\n",
    "class(HOUSE_TS1.df$SALEDATE)   #Check the class of the \"SALEDATE\" field\n",
    "\n",
    "# Because \"SALEDATE\" is class character, we must convert it to class Date\n",
    "# Tell R how to identify the date parts of the \"SALEDATE\" field\n",
    "# The format = argument specifies the date components and \n",
    "# drops the time component in the \"SALEDATE'\n",
    "HOUSE_TS1.df$SALEDATE <- as.Date(HOUSE_TS1.df$SALEDATE, format = \"%Y/%m/%d\")\n",
    "\n",
    "head(HOUSE_TS1.df)   # Verify the time component was dropped\n",
    "\n",
    "class(HOUSE_TS1.df$SALEDATE)   # Check the class of the \"SALEDATE\" field \n",
    "\n",
    "# Drop the 'day' from the date\n",
    "HOUSE_TS2.df <- HOUSE_TS1.df\n",
    "HOUSE_TS2.df$SALEDATE <- format(HOUSE_TS2.df$SALEDATE, format = \"%Y-%m\")\n",
    "\n",
    "head(HOUSE_TS2.df)   # Verify the day component was dropped\n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   SALEDATE             PRICE         \n",
       " Length:62008       Min.   :       1  \n",
       " Class :character   1st Qu.:  300000  \n",
       " Mode  :character   Median :  557985  \n",
       "                    Mean   :  706961  \n",
       "                    3rd Qu.:  894000  \n",
       "                    Max.   :25100000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "   SALEDATE             PRICE        \n",
       " Length:385         Min.   :  40000  \n",
       " Class :character   1st Qu.: 245945  \n",
       " Mode  :character   Median : 537826  \n",
       "                    Mean   : 527439  \n",
       "                    3rd Qu.: 736351  \n",
       "                    Max.   :2650000  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 20 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SALEDATE</th><th scope=col>PRICE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>1900-01</td><td>  48000.0</td></tr>\n",
       "\t<tr><th scope=row>2</th><td>1979-07</td><td>  99500.0</td></tr>\n",
       "\t<tr><th scope=row>3</th><td>1982-09</td><td>  40000.0</td></tr>\n",
       "\t<tr><th scope=row>4</th><td>1984-07</td><td>  40000.0</td></tr>\n",
       "\t<tr><th scope=row>5</th><td>1986-05</td><td>  87500.0</td></tr>\n",
       "\t<tr><th scope=row>6</th><td>1986-08</td><td> 850000.0</td></tr>\n",
       "\t<tr><th scope=row>7</th><td>1987-06</td><td> 535000.0</td></tr>\n",
       "\t<tr><th scope=row>8</th><td>1987-09</td><td> 785000.0</td></tr>\n",
       "\t<tr><th scope=row>9</th><td>1988-08</td><td> 322000.0</td></tr>\n",
       "\t<tr><th scope=row>10</th><td>1988-12</td><td> 140000.0</td></tr>\n",
       "\t<tr><th scope=row>11</th><td>1989-04</td><td> 170000.0</td></tr>\n",
       "\t<tr><th scope=row>12</th><td>1990-09</td><td> 110000.0</td></tr>\n",
       "\t<tr><th scope=row>13</th><td>1990-12</td><td> 127000.0</td></tr>\n",
       "\t<tr><th scope=row>14</th><td>1991-01</td><td> 103000.0</td></tr>\n",
       "\t<tr><th scope=row>15</th><td>1991-03</td><td> 189900.0</td></tr>\n",
       "\t<tr><th scope=row>16</th><td>1991-08</td><td>2650000.0</td></tr>\n",
       "\t<tr><th scope=row>17</th><td>1991-11</td><td> 175000.0</td></tr>\n",
       "\t<tr><th scope=row>18</th><td>1992-01</td><td> 183729.7</td></tr>\n",
       "\t<tr><th scope=row>19</th><td>1992-02</td><td> 243833.3</td></tr>\n",
       "\t<tr><th scope=row>20</th><td>1992-03</td><td> 246183.4</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 20 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & SALEDATE & PRICE\\\\\n",
       "  & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t1 & 1900-01 &   48000.0\\\\\n",
       "\t2 & 1979-07 &   99500.0\\\\\n",
       "\t3 & 1982-09 &   40000.0\\\\\n",
       "\t4 & 1984-07 &   40000.0\\\\\n",
       "\t5 & 1986-05 &   87500.0\\\\\n",
       "\t6 & 1986-08 &  850000.0\\\\\n",
       "\t7 & 1987-06 &  535000.0\\\\\n",
       "\t8 & 1987-09 &  785000.0\\\\\n",
       "\t9 & 1988-08 &  322000.0\\\\\n",
       "\t10 & 1988-12 &  140000.0\\\\\n",
       "\t11 & 1989-04 &  170000.0\\\\\n",
       "\t12 & 1990-09 &  110000.0\\\\\n",
       "\t13 & 1990-12 &  127000.0\\\\\n",
       "\t14 & 1991-01 &  103000.0\\\\\n",
       "\t15 & 1991-03 &  189900.0\\\\\n",
       "\t16 & 1991-08 & 2650000.0\\\\\n",
       "\t17 & 1991-11 &  175000.0\\\\\n",
       "\t18 & 1992-01 &  183729.7\\\\\n",
       "\t19 & 1992-02 &  243833.3\\\\\n",
       "\t20 & 1992-03 &  246183.4\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 20 × 2\n",
       "\n",
       "| <!--/--> | SALEDATE &lt;chr&gt; | PRICE &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 1 | 1900-01 |   48000.0 |\n",
       "| 2 | 1979-07 |   99500.0 |\n",
       "| 3 | 1982-09 |   40000.0 |\n",
       "| 4 | 1984-07 |   40000.0 |\n",
       "| 5 | 1986-05 |   87500.0 |\n",
       "| 6 | 1986-08 |  850000.0 |\n",
       "| 7 | 1987-06 |  535000.0 |\n",
       "| 8 | 1987-09 |  785000.0 |\n",
       "| 9 | 1988-08 |  322000.0 |\n",
       "| 10 | 1988-12 |  140000.0 |\n",
       "| 11 | 1989-04 |  170000.0 |\n",
       "| 12 | 1990-09 |  110000.0 |\n",
       "| 13 | 1990-12 |  127000.0 |\n",
       "| 14 | 1991-01 |  103000.0 |\n",
       "| 15 | 1991-03 |  189900.0 |\n",
       "| 16 | 1991-08 | 2650000.0 |\n",
       "| 17 | 1991-11 |  175000.0 |\n",
       "| 18 | 1992-01 |  183729.7 |\n",
       "| 19 | 1992-02 |  243833.3 |\n",
       "| 20 | 1992-03 |  246183.4 |\n",
       "\n"
      ],
      "text/plain": [
       "   SALEDATE PRICE    \n",
       "1  1900-01    48000.0\n",
       "2  1979-07    99500.0\n",
       "3  1982-09    40000.0\n",
       "4  1984-07    40000.0\n",
       "5  1986-05    87500.0\n",
       "6  1986-08   850000.0\n",
       "7  1987-06   535000.0\n",
       "8  1987-09   785000.0\n",
       "9  1988-08   322000.0\n",
       "10 1988-12   140000.0\n",
       "11 1989-04   170000.0\n",
       "12 1990-09   110000.0\n",
       "13 1990-12   127000.0\n",
       "14 1991-01   103000.0\n",
       "15 1991-03   189900.0\n",
       "16 1991-08  2650000.0\n",
       "17 1991-11   175000.0\n",
       "18 1992-01   183729.7\n",
       "19 1992-02   243833.3\n",
       "20 1992-03   246183.4"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 20 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>SALEDATE</th><th scope=col>PRICE</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>366</th><td>2021-01</td><td> 991249.8</td></tr>\n",
       "\t<tr><th scope=row>367</th><td>2021-02</td><td> 960506.2</td></tr>\n",
       "\t<tr><th scope=row>368</th><td>2021-03</td><td> 932663.5</td></tr>\n",
       "\t<tr><th scope=row>369</th><td>2021-04</td><td>1019248.6</td></tr>\n",
       "\t<tr><th scope=row>370</th><td>2021-05</td><td>1114840.0</td></tr>\n",
       "\t<tr><th scope=row>371</th><td>2021-06</td><td>1164707.6</td></tr>\n",
       "\t<tr><th scope=row>372</th><td>2021-07</td><td>1209038.3</td></tr>\n",
       "\t<tr><th scope=row>373</th><td>2021-08</td><td>1044902.5</td></tr>\n",
       "\t<tr><th scope=row>374</th><td>2021-09</td><td> 964044.0</td></tr>\n",
       "\t<tr><th scope=row>375</th><td>2021-10</td><td>1049929.4</td></tr>\n",
       "\t<tr><th scope=row>376</th><td>2021-11</td><td>1071633.6</td></tr>\n",
       "\t<tr><th scope=row>377</th><td>2021-12</td><td>1037921.5</td></tr>\n",
       "\t<tr><th scope=row>378</th><td>2022-01</td><td> 988845.2</td></tr>\n",
       "\t<tr><th scope=row>379</th><td>2022-02</td><td> 961839.7</td></tr>\n",
       "\t<tr><th scope=row>380</th><td>2022-03</td><td>1088226.9</td></tr>\n",
       "\t<tr><th scope=row>381</th><td>2022-04</td><td>1134815.5</td></tr>\n",
       "\t<tr><th scope=row>382</th><td>2022-05</td><td>1309016.5</td></tr>\n",
       "\t<tr><th scope=row>383</th><td>2022-06</td><td>1145348.6</td></tr>\n",
       "\t<tr><th scope=row>384</th><td>2022-07</td><td>1057256.7</td></tr>\n",
       "\t<tr><th scope=row>385</th><td>2022-08</td><td>1138907.9</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 20 × 2\n",
       "\\begin{tabular}{r|ll}\n",
       "  & SALEDATE & PRICE\\\\\n",
       "  & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t366 & 2021-01 &  991249.8\\\\\n",
       "\t367 & 2021-02 &  960506.2\\\\\n",
       "\t368 & 2021-03 &  932663.5\\\\\n",
       "\t369 & 2021-04 & 1019248.6\\\\\n",
       "\t370 & 2021-05 & 1114840.0\\\\\n",
       "\t371 & 2021-06 & 1164707.6\\\\\n",
       "\t372 & 2021-07 & 1209038.3\\\\\n",
       "\t373 & 2021-08 & 1044902.5\\\\\n",
       "\t374 & 2021-09 &  964044.0\\\\\n",
       "\t375 & 2021-10 & 1049929.4\\\\\n",
       "\t376 & 2021-11 & 1071633.6\\\\\n",
       "\t377 & 2021-12 & 1037921.5\\\\\n",
       "\t378 & 2022-01 &  988845.2\\\\\n",
       "\t379 & 2022-02 &  961839.7\\\\\n",
       "\t380 & 2022-03 & 1088226.9\\\\\n",
       "\t381 & 2022-04 & 1134815.5\\\\\n",
       "\t382 & 2022-05 & 1309016.5\\\\\n",
       "\t383 & 2022-06 & 1145348.6\\\\\n",
       "\t384 & 2022-07 & 1057256.7\\\\\n",
       "\t385 & 2022-08 & 1138907.9\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 20 × 2\n",
       "\n",
       "| <!--/--> | SALEDATE &lt;chr&gt; | PRICE &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| 366 | 2021-01 |  991249.8 |\n",
       "| 367 | 2021-02 |  960506.2 |\n",
       "| 368 | 2021-03 |  932663.5 |\n",
       "| 369 | 2021-04 | 1019248.6 |\n",
       "| 370 | 2021-05 | 1114840.0 |\n",
       "| 371 | 2021-06 | 1164707.6 |\n",
       "| 372 | 2021-07 | 1209038.3 |\n",
       "| 373 | 2021-08 | 1044902.5 |\n",
       "| 374 | 2021-09 |  964044.0 |\n",
       "| 375 | 2021-10 | 1049929.4 |\n",
       "| 376 | 2021-11 | 1071633.6 |\n",
       "| 377 | 2021-12 | 1037921.5 |\n",
       "| 378 | 2022-01 |  988845.2 |\n",
       "| 379 | 2022-02 |  961839.7 |\n",
       "| 380 | 2022-03 | 1088226.9 |\n",
       "| 381 | 2022-04 | 1134815.5 |\n",
       "| 382 | 2022-05 | 1309016.5 |\n",
       "| 383 | 2022-06 | 1145348.6 |\n",
       "| 384 | 2022-07 | 1057256.7 |\n",
       "| 385 | 2022-08 | 1138907.9 |\n",
       "\n"
      ],
      "text/plain": [
       "    SALEDATE PRICE    \n",
       "366 2021-01   991249.8\n",
       "367 2021-02   960506.2\n",
       "368 2021-03   932663.5\n",
       "369 2021-04  1019248.6\n",
       "370 2021-05  1114840.0\n",
       "371 2021-06  1164707.6\n",
       "372 2021-07  1209038.3\n",
       "373 2021-08  1044902.5\n",
       "374 2021-09   964044.0\n",
       "375 2021-10  1049929.4\n",
       "376 2021-11  1071633.6\n",
       "377 2021-12  1037921.5\n",
       "378 2022-01   988845.2\n",
       "379 2022-02   961839.7\n",
       "380 2022-03  1088226.9\n",
       "381 2022-04  1134815.5\n",
       "382 2022-05  1309016.5\n",
       "383 2022-06  1145348.6\n",
       "384 2022-07  1057256.7\n",
       "385 2022-08  1138907.9"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "   SALEDATE             PRICE        \n",
       " Length:151         Min.   : 465351  \n",
       " Class :character   1st Qu.: 665168  \n",
       " Mode  :character   Median : 791885  \n",
       "                    Mean   : 793526  \n",
       "                    3rd Qu.: 898471  \n",
       "                    Max.   :1309017  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t151 obs. of  2 variables:\n",
      " $ SALEDATE: chr  \"2010-02\" \"2010-03\" \"2010-04\" \"2010-05\" ...\n",
      " $ PRICE   : num  595215 488517 537826 542971 643488 ...\n"
     ]
    }
   ],
   "source": [
    "################################################################################\n",
    "# Calculate the mean \"Price\" by \"SALEDATE\" (year and month)\n",
    "HOUSE_TS3.df <- HOUSE_TS2.df\n",
    "HOUSE_TS3.df <- aggregate(PRICE~SALEDATE,HOUSE_TS2.df,mean)\n",
    "\n",
    "summary(HOUSE_TS2.df)   #To check the variables and counts before the aggregation\n",
    "\n",
    "summary(HOUSE_TS3.df)   #To check the variables and counts after the aggregation\n",
    "\n",
    "head(HOUSE_TS3.df, 20)\n",
    "\n",
    "tail(HOUSE_TS3.df, 20)\n",
    "\n",
    "# Filter the dataframe for only sales after 2010-01\n",
    "HOUSE_TS4.df <- HOUSE_TS3.df\n",
    "HOUSE_TS4.df <- HOUSE_TS4.df %>% filter(SALEDATE > '2010-01')\n",
    "\n",
    "summary(HOUSE_TS4.df)   #To check the variables and counts\n",
    "\n",
    "str(HOUSE_TS4.df)   #To check the data structure   \n",
    "################################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A Time Series: 13 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>Jan</th><th scope=col>Feb</th><th scope=col>Mar</th><th scope=col>Apr</th><th scope=col>May</th><th scope=col>Jun</th><th scope=col>Jul</th><th scope=col>Aug</th><th scope=col>Sep</th><th scope=col>Oct</th><th scope=col>Nov</th><th scope=col>Dec</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>2010</th><td> 595215.3</td><td> 488517.5</td><td> 537825.9</td><td> 542970.6</td><td> 643488.2</td><td> 599364.5</td><td> 591808.9</td><td> 465350.5</td><td> 576169.1</td><td> 688463.2</td><td> 687697.8</td><td> 542757.8</td></tr>\n",
       "\t<tr><th scope=row>2011</th><td> 532661.0</td><td> 555703.6</td><td> 564982.7</td><td> 582055.1</td><td> 583731.9</td><td> 792090.7</td><td> 654924.3</td><td> 561652.5</td><td> 523012.3</td><td> 556310.6</td><td> 595629.8</td><td> 537853.3</td></tr>\n",
       "\t<tr><th scope=row>2012</th><td> 608940.3</td><td> 596914.4</td><td> 546667.5</td><td> 736617.2</td><td> 666124.4</td><td> 625026.2</td><td> 676362.4</td><td> 612457.6</td><td> 664211.7</td><td> 640776.1</td><td> 637844.2</td><td> 701649.3</td></tr>\n",
       "\t<tr><th scope=row>2013</th><td> 598139.5</td><td> 640635.9</td><td> 677421.4</td><td> 697719.6</td><td> 759096.3</td><td> 909713.5</td><td> 703899.2</td><td> 973241.2</td><td> 761342.1</td><td> 620723.6</td><td> 613852.6</td><td> 602145.6</td></tr>\n",
       "\t<tr><th scope=row>2014</th><td> 662744.9</td><td> 583706.0</td><td> 729343.3</td><td> 754645.3</td><td> 803609.7</td><td> 821932.3</td><td> 792719.6</td><td> 693807.1</td><td> 695918.8</td><td> 684731.3</td><td> 670583.9</td><td> 700451.1</td></tr>\n",
       "\t<tr><th scope=row>2015</th><td> 724380.8</td><td> 633812.2</td><td> 711374.5</td><td> 829167.6</td><td> 784320.9</td><td> 748354.9</td><td> 756925.8</td><td> 790718.6</td><td> 822803.3</td><td> 787420.5</td><td> 838821.1</td><td> 736350.9</td></tr>\n",
       "\t<tr><th scope=row>2016</th><td> 703861.6</td><td> 651072.1</td><td> 720171.4</td><td> 790311.8</td><td> 838644.8</td><td> 834619.8</td><td> 891179.7</td><td> 778843.7</td><td>1053742.0</td><td> 778174.9</td><td> 734638.4</td><td> 748386.2</td></tr>\n",
       "\t<tr><th scope=row>2017</th><td> 876717.4</td><td> 828342.3</td><td> 811436.1</td><td> 886845.9</td><td> 904337.6</td><td> 893951.0</td><td> 800962.6</td><td> 732815.8</td><td> 796029.6</td><td> 736735.3</td><td> 800139.5</td><td> 802549.5</td></tr>\n",
       "\t<tr><th scope=row>2018</th><td> 935284.0</td><td> 791885.4</td><td> 954471.2</td><td> 873900.3</td><td> 816293.9</td><td> 852345.9</td><td> 864262.2</td><td> 764621.6</td><td> 822613.3</td><td> 881527.5</td><td> 846599.1</td><td> 850500.8</td></tr>\n",
       "\t<tr><th scope=row>2019</th><td> 856820.3</td><td> 849466.2</td><td> 843066.4</td><td> 905470.0</td><td> 930188.2</td><td> 914024.4</td><td> 835028.3</td><td> 803078.1</td><td> 879499.8</td><td> 927483.3</td><td> 873666.3</td><td> 840044.5</td></tr>\n",
       "\t<tr><th scope=row>2020</th><td> 787652.3</td><td> 890873.9</td><td> 940170.7</td><td> 873180.9</td><td> 936630.6</td><td> 946719.1</td><td> 966476.1</td><td> 947272.1</td><td> 902989.9</td><td>1126750.6</td><td> 981757.1</td><td> 991249.8</td></tr>\n",
       "\t<tr><th scope=row>2021</th><td> 960506.2</td><td> 932663.5</td><td>1019248.6</td><td>1114840.0</td><td>1164707.6</td><td>1209038.3</td><td>1044902.5</td><td> 964044.0</td><td>1049929.4</td><td>1071633.6</td><td>1037921.5</td><td> 988845.2</td></tr>\n",
       "\t<tr><th scope=row>2022</th><td> 961839.7</td><td>1088226.9</td><td>1134815.5</td><td>1309016.5</td><td>1145348.6</td><td>1057256.7</td><td>1138907.9</td><td>         </td><td>         </td><td>         </td><td>         </td><td>         </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A Time Series: 13 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & Jan & Feb & Mar & Apr & May & Jun & Jul & Aug & Sep & Oct & Nov & Dec\\\\\n",
       "\\hline\n",
       "\t2010 &  595215.3 &  488517.5 &  537825.9 &  542970.6 &  643488.2 &  599364.5 &  591808.9 &  465350.5 &  576169.1 &  688463.2 &  687697.8 &  542757.8\\\\\n",
       "\t2011 &  532661.0 &  555703.6 &  564982.7 &  582055.1 &  583731.9 &  792090.7 &  654924.3 &  561652.5 &  523012.3 &  556310.6 &  595629.8 &  537853.3\\\\\n",
       "\t2012 &  608940.3 &  596914.4 &  546667.5 &  736617.2 &  666124.4 &  625026.2 &  676362.4 &  612457.6 &  664211.7 &  640776.1 &  637844.2 &  701649.3\\\\\n",
       "\t2013 &  598139.5 &  640635.9 &  677421.4 &  697719.6 &  759096.3 &  909713.5 &  703899.2 &  973241.2 &  761342.1 &  620723.6 &  613852.6 &  602145.6\\\\\n",
       "\t2014 &  662744.9 &  583706.0 &  729343.3 &  754645.3 &  803609.7 &  821932.3 &  792719.6 &  693807.1 &  695918.8 &  684731.3 &  670583.9 &  700451.1\\\\\n",
       "\t2015 &  724380.8 &  633812.2 &  711374.5 &  829167.6 &  784320.9 &  748354.9 &  756925.8 &  790718.6 &  822803.3 &  787420.5 &  838821.1 &  736350.9\\\\\n",
       "\t2016 &  703861.6 &  651072.1 &  720171.4 &  790311.8 &  838644.8 &  834619.8 &  891179.7 &  778843.7 & 1053742.0 &  778174.9 &  734638.4 &  748386.2\\\\\n",
       "\t2017 &  876717.4 &  828342.3 &  811436.1 &  886845.9 &  904337.6 &  893951.0 &  800962.6 &  732815.8 &  796029.6 &  736735.3 &  800139.5 &  802549.5\\\\\n",
       "\t2018 &  935284.0 &  791885.4 &  954471.2 &  873900.3 &  816293.9 &  852345.9 &  864262.2 &  764621.6 &  822613.3 &  881527.5 &  846599.1 &  850500.8\\\\\n",
       "\t2019 &  856820.3 &  849466.2 &  843066.4 &  905470.0 &  930188.2 &  914024.4 &  835028.3 &  803078.1 &  879499.8 &  927483.3 &  873666.3 &  840044.5\\\\\n",
       "\t2020 &  787652.3 &  890873.9 &  940170.7 &  873180.9 &  936630.6 &  946719.1 &  966476.1 &  947272.1 &  902989.9 & 1126750.6 &  981757.1 &  991249.8\\\\\n",
       "\t2021 &  960506.2 &  932663.5 & 1019248.6 & 1114840.0 & 1164707.6 & 1209038.3 & 1044902.5 &  964044.0 & 1049929.4 & 1071633.6 & 1037921.5 &  988845.2\\\\\n",
       "\t2022 &  961839.7 & 1088226.9 & 1134815.5 & 1309016.5 & 1145348.6 & 1057256.7 & 1138907.9 &           &           &           &           &          \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A Time Series: 13 × 12\n",
       "\n",
       "| <!--/--> | Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 2010 |  595215.3 |  488517.5 |  537825.9 |  542970.6 |  643488.2 |  599364.5 |  591808.9 |  465350.5 |  576169.1 |  688463.2 |  687697.8 |  542757.8 |\n",
       "| 2011 |  532661.0 |  555703.6 |  564982.7 |  582055.1 |  583731.9 |  792090.7 |  654924.3 |  561652.5 |  523012.3 |  556310.6 |  595629.8 |  537853.3 |\n",
       "| 2012 |  608940.3 |  596914.4 |  546667.5 |  736617.2 |  666124.4 |  625026.2 |  676362.4 |  612457.6 |  664211.7 |  640776.1 |  637844.2 |  701649.3 |\n",
       "| 2013 |  598139.5 |  640635.9 |  677421.4 |  697719.6 |  759096.3 |  909713.5 |  703899.2 |  973241.2 |  761342.1 |  620723.6 |  613852.6 |  602145.6 |\n",
       "| 2014 |  662744.9 |  583706.0 |  729343.3 |  754645.3 |  803609.7 |  821932.3 |  792719.6 |  693807.1 |  695918.8 |  684731.3 |  670583.9 |  700451.1 |\n",
       "| 2015 |  724380.8 |  633812.2 |  711374.5 |  829167.6 |  784320.9 |  748354.9 |  756925.8 |  790718.6 |  822803.3 |  787420.5 |  838821.1 |  736350.9 |\n",
       "| 2016 |  703861.6 |  651072.1 |  720171.4 |  790311.8 |  838644.8 |  834619.8 |  891179.7 |  778843.7 | 1053742.0 |  778174.9 |  734638.4 |  748386.2 |\n",
       "| 2017 |  876717.4 |  828342.3 |  811436.1 |  886845.9 |  904337.6 |  893951.0 |  800962.6 |  732815.8 |  796029.6 |  736735.3 |  800139.5 |  802549.5 |\n",
       "| 2018 |  935284.0 |  791885.4 |  954471.2 |  873900.3 |  816293.9 |  852345.9 |  864262.2 |  764621.6 |  822613.3 |  881527.5 |  846599.1 |  850500.8 |\n",
       "| 2019 |  856820.3 |  849466.2 |  843066.4 |  905470.0 |  930188.2 |  914024.4 |  835028.3 |  803078.1 |  879499.8 |  927483.3 |  873666.3 |  840044.5 |\n",
       "| 2020 |  787652.3 |  890873.9 |  940170.7 |  873180.9 |  936630.6 |  946719.1 |  966476.1 |  947272.1 |  902989.9 | 1126750.6 |  981757.1 |  991249.8 |\n",
       "| 2021 |  960506.2 |  932663.5 | 1019248.6 | 1114840.0 | 1164707.6 | 1209038.3 | 1044902.5 |  964044.0 | 1049929.4 | 1071633.6 | 1037921.5 |  988845.2 |\n",
       "| 2022 |  961839.7 | 1088226.9 | 1134815.5 | 1309016.5 | 1145348.6 | 1057256.7 | 1138907.9 | <!----> | <!----> | <!----> | <!----> | <!----> |\n",
       "\n"
      ],
      "text/plain": [
       "     Jan       Feb       Mar       Apr       May       Jun       Jul      \n",
       "2010  595215.3  488517.5  537825.9  542970.6  643488.2  599364.5  591808.9\n",
       "2011  532661.0  555703.6  564982.7  582055.1  583731.9  792090.7  654924.3\n",
       "2012  608940.3  596914.4  546667.5  736617.2  666124.4  625026.2  676362.4\n",
       "2013  598139.5  640635.9  677421.4  697719.6  759096.3  909713.5  703899.2\n",
       "2014  662744.9  583706.0  729343.3  754645.3  803609.7  821932.3  792719.6\n",
       "2015  724380.8  633812.2  711374.5  829167.6  784320.9  748354.9  756925.8\n",
       "2016  703861.6  651072.1  720171.4  790311.8  838644.8  834619.8  891179.7\n",
       "2017  876717.4  828342.3  811436.1  886845.9  904337.6  893951.0  800962.6\n",
       "2018  935284.0  791885.4  954471.2  873900.3  816293.9  852345.9  864262.2\n",
       "2019  856820.3  849466.2  843066.4  905470.0  930188.2  914024.4  835028.3\n",
       "2020  787652.3  890873.9  940170.7  873180.9  936630.6  946719.1  966476.1\n",
       "2021  960506.2  932663.5 1019248.6 1114840.0 1164707.6 1209038.3 1044902.5\n",
       "2022  961839.7 1088226.9 1134815.5 1309016.5 1145348.6 1057256.7 1138907.9\n",
       "     Aug       Sep       Oct       Nov       Dec      \n",
       "2010  465350.5  576169.1  688463.2  687697.8  542757.8\n",
       "2011  561652.5  523012.3  556310.6  595629.8  537853.3\n",
       "2012  612457.6  664211.7  640776.1  637844.2  701649.3\n",
       "2013  973241.2  761342.1  620723.6  613852.6  602145.6\n",
       "2014  693807.1  695918.8  684731.3  670583.9  700451.1\n",
       "2015  790718.6  822803.3  787420.5  838821.1  736350.9\n",
       "2016  778843.7 1053742.0  778174.9  734638.4  748386.2\n",
       "2017  732815.8  796029.6  736735.3  800139.5  802549.5\n",
       "2018  764621.6  822613.3  881527.5  846599.1  850500.8\n",
       "2019  803078.1  879499.8  927483.3  873666.3  840044.5\n",
       "2020  947272.1  902989.9 1126750.6  981757.1  991249.8\n",
       "2021  964044.0 1049929.4 1071633.6 1037921.5  988845.2\n",
       "2022                                                  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "####################################################################\n",
    "# Set time series (ts) for 'PRICE' variable\n",
    "\n",
    "# Choose the 'PRICE' column and convert it to ts object\n",
    "\n",
    "H_TS <- ts(HOUSE_TS4.df$PRICE, start=c(2010, 1), freq=12)\n",
    "\n",
    "# Let us see the ts object\n",
    "\n",
    "H_TS\n",
    "#####################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAA0gAAANICAMAAADKOT/pAAAAMFBMVEUAAABNTU1oaGh8fHyM\njIyampqnp6eysrK9vb3Hx8fQ0NDZ2dnh4eHp6enw8PD////QFLu4AAAACXBIWXMAABJ0AAAS\ndAHeZh94AAAgAElEQVR4nO2diXajOBAA5RxONnHM///tjm8QOqElWqLqvc1ikNQgUwOINpgB\nAFZjtl4BgB5AJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARA\nJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQC\nEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAAB\nEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACR\nAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlA\nAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARA\nJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAARAJAABEAlAAEQCEACRAASoIJIBaIwFe7m8\nOBuEAJAEkQAEQCQAARAJQABEAhAAkQAEQCQAARAJQABEAhAAkQAEQCQAARAJQABEAhAAkQAE\nQCQAARAJQABEAhAAkQAEQCQAARAJQABEAhAAkQAEQCSAIGk7IyIBBEEkAAEQCUAARAIQAJEA\nBEAkAAEQCUAARAIQAJEABEAkAAEQCUAARAJYT+JLLREJIAQiAQhg0vZGRAIIgUgAAiASgACI\nBCAAIgEIgEgAAiASgACIBCAAIgEIgEgAAiASgACIBCAAIgEIgEgAAiASgACIBCAAIgEIgEgA\nAiASgACIBCAAIgEIgEgA6zGJe2NVkX6/PsyFj+NvqRAAoigU6fxmXrwXCQEgjEKRjubw3+k6\n9fdzMMcSIQCEUSjSwZye0ydzKBECQBiFIk0eohx+ojIigRIUisQRCdrDDGm7Y91rpJ+/6xTX\nSNAKCkUa3kejdm/nIiEAZNEo0vB7vN5HOnx8cR8J2kClSJpCAKSASAACqBSJFCFoDYUikSIE\n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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#####################################################################\n",
    "# Let us fit a regression line on the dataset\n",
    "\n",
    "plot(H_TS)\n",
    "\n",
    "abline(reg=lm(H_TS~time(H_TS)))\n",
    "#####################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "image/png": "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",
      "text/plain": [
       "plot without title"
      ]
     },
     "metadata": {
      "image/png": {
       "height": 420,
       "width": 420
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "#####################################################################\n",
    "# Plot the decomposition of the time series\n",
    "\n",
    "decomp = stl(H_TS, s.window = \"periodic\")\n",
    "\n",
    "plot(decomp)\n",
    "\n",
    "#####################################################################"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.2.1"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
