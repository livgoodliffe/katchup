import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';
import pageState from '../page_state';

export default () => {
  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#search-search form');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const mapIcon = document.querySelector('#map-icon');
  const mapPage = document.querySelector('#map');

  // all states, followed by default
  const state = pageState(['search', 'feed', 'map'], 'feed');

  const bringInSearch = (callback) => {
    animateCSS(searchPage, 'slideInRight', callback, alwaysVisible);
  };

  const fadeInSearch = (callback) => {
    animateCSS(searchPage, 'fadeIn', callback, alwaysVisible);
  };

  const takeOutSearch = (callback) => {
    animateCSS(searchPage, 'slideOutRight', callback, willHideAfterwards);
  };

  const fadeOutSearch = (callback) => {
    animateCSS(searchPage, 'fadeOut', callback, willHideAfterwards);
  };

  const bringInFeed = (callback) => {
    animateCSS(feed, 'slideInLeft', callback, alwaysVisible);
  };

  const takeOutFeed = (callback) => {
    animateCSS(feed, 'slideOutLeft', callback, willHideAfterwards);
  };

  const bringInMap = (callback) => {
    animateCSS(mapPage, 'slideInRight', callback, alwaysVisible);
  };

  const fadeInMap = (callback) => {
    animateCSS(mapPage, 'fadeIn', callback, alwaysVisible);
  };

  const takeOutMap = (callback) => {
    animateCSS(mapPage, 'slideOutRight', callback, willHideAfterwards);
  };

  const fadeOutMap = (callback) => {
    animateCSS(mapPage, 'fadeOut', callback, willHideAfterwards);
  };
  const bringInArrow = (callback) => {
    animateCSS(back, 'slideInLeft', callback, alwaysVisible);
  };

  const takeOutArrow = (callback) => {
    animateCSS(back, 'slideOutLeft', callback, willHideAfterwards);
  };

  if (searchSelect) {
    searchSelect.addEventListener('click', () => {
      if (state.currentState() === 'feed') {
        takeOutFeed();
        bringInSearch();
        bringInArrow();
        state.setState('search');
      } else if (state.currentState() === 'map') {
        fadeOutMap(() => window.mapboxMap.zoomTo(8));
        fadeInSearch();
        state.setState('search');
      }
    });
  }

  if (back) {
    back.addEventListener('click', () => {
      if (state.currentState() === 'search') {
        takeOutSearch();
        bringInFeed();
        takeOutArrow();
        state.setState('feed');
      } else if (state.currentState() === 'map') {
        takeOutMap(() => window.mapboxMap.zoomTo(8));
        bringInFeed();
        takeOutArrow();
        state.setState('feed');
      }
    });
  }

  if (mapIcon) {
    mapIcon.addEventListener('click', () => {

      console.log("map clicked");

      if (state.currentState() === 'search') {
        fadeOutSearch();
        fadeInMap(() => window.mapboxMap.zoomTo(12, { duration: 2000 }));
        state.setState('map');
      } else if (state.currentState() === 'feed') {
        takeOutFeed();
        bringInMap(() => window.mapboxMap.zoomTo(12, { duration: 2000 }));
        bringInArrow();
        state.setState('map');
      }
    });
  }
};
