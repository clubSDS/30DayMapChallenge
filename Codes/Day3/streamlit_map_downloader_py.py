# import requests 
# import pandas as pd
# import streamlit as st 

# container = st.container()

# with st.sidebar:
#     south_input = st.text_input('South Cordinates','South Cordinates' )
#     north_input = st.text_input('North Cordinates','North Cordinates')
#     east_input = st.text_input('East Cordinates','East Cordinates')
#     west_input = st.text_input('West Cordinates','West  Cordinates')

#     if st.button('Show Bounds'):
#         south =  float(south_input)
#         north =  float(north_input)
#         east =  float(east_input)
#         west =  float(west_input)

#         x_bounds = [south, south, north, north]
#         y_bounds = [east, west, east, west]

#         df= pd.DataFrame(data = {'lat': x_bounds, 'lon': y_bounds})

#         container.map(df)
    
#     if st.button('Download DEM'):
#         url = f'https://portal.opentopography.org/API/globaldem?demtype=SRTMGL3&south='+south_input+'&north='+north_input+'&west='+west_input+'&east='+east_input+'&outputFormat=GTiff&API_Key=d6334754fcbab659278edb09df3a0456'
#         response = requests.get(url)
#         open("C:\\Users\\User\\Downloads\\raster.tiff", 'wb').write(response.content)
#         st.write('Downloaded Sucessfully')

import requests 
import pandas as pd
import streamlit as st 

container = st.container()

with st.sidebar:
    south_input = st.text_input('South Cordinates', '60.1150')
    north_input = st.text_input('North Cordinates', '60.2974')
    east_input = st.text_input('East Cordinates', '25.2548')
    west_input = st.text_input('West Cordinates', '24.7820')

    if st.button('Show Bounds'):
        south =  float(south_input)
        north =  float(north_input)
        east =  float(east_input)
        west =  float(west_input)

        x_bounds = [south, south, north, north]
        y_bounds = [east, west, east, west]

        df = pd.DataFrame(data={'lat': x_bounds, 'lon': y_bounds})
        container.map(df)
    
    if st.button('Download DEM'):
        url = f'https://portal.opentopography.org/API/globaldem?demtype=AW3D30&south={south_input}&north={north_input}&west={west_input}&east={east_input}&outputFormat=GTiff&API_Key=d6334754fcbab659278edb09df3a0456'
        response = requests.get(url)
        if response.status_code == 200:
            with open("C:\\Users\\User\\Downloads\\raster.tiff", 'wb') as f:
                f.write(response.content)
            st.write('Downloaded Successfully')
        else:
            st.write("Download failed. Status code:", response.status_code)
