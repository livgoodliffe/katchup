import 'bootstrap';

import makeMap from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';
import catchupListeners from '../catchup';
import flashFadeOut from '../flash_fade_out';
import reviewStars from '../review_stars';
import feedAnimations from '../feed';
import listsAnimations from '../lists';
import channels from '../channels';

makeMap();
searchListener();
geoLocation();
catchupListeners();
flashFadeOut();
reviewStars();
feedAnimations();
listsAnimations();
channels();
