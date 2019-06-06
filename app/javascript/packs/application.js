import 'bootstrap';

import initMapbox from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';
import catchupListeners from '../catchup';

initMapbox();
searchListener();
geoLocation();
catchupListeners();
