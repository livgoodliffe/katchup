// require 'jquery_ujs'
// require 'jquery'


import makeMap from '../plugins/init_mapbox';
import searchListener from '../search';
import geoLocation from '../geolocation';
import catchupListeners from '../catchup';
import flashFadeOut from '../flash_fade_out';
import reviewStars from '../review_stars';
import feedAnimations from '../feed/index';
import listsAnimations from '../lists/index';
import paginateFeed from '../feed/pagination';



makeMap();
searchListener();
geoLocation();
catchupListeners();
flashFadeOut();
reviewStars();
feedAnimations();
listsAnimations();
paginateFeed();
