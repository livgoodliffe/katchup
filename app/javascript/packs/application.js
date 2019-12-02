import makeMap from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';
import catchupListeners from '../catchup';
import flashFadeOut from '../flash_fade_out';
import { reviewStarsHandler, reviewImageHandler } from '../review';
import feedAnimations from '../feed/index';
import listsAnimations from '../lists/index';
import { friendChannel, catchupChannel } from '../channels';
import scrollInfinitely from '../plugins/infinite_scroller'; // <-- Change to vanilla JS in packs

import '../navbar/index';

makeMap();
searchListener();
geoLocation();
catchupListeners();
flashFadeOut();
reviewStarsHandler();
reviewImageHandler();
feedAnimations();
listsAnimations();
scrollInfinitely();
// friendChannel();
// catchupChannel();
