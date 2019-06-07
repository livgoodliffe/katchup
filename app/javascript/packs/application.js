import 'bootstrap';

import initMapbox from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';
import catchupListeners from '../catchup';
import flashFadeOut from '../flash_fade_out';

initMapbox();
searchListener();
geoLocation();
catchupListeners();
flashFadeOut();
