import 'bootstrap';

import initMapbox from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';

initMapbox();
searchListener();
geoLocation();
