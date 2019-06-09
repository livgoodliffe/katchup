import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';
import pageState from '../page_state';

export default () => {
  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#search-search form');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const mapPage = document.querySelector('#map');
  const mapIcon = document.querySelector('#map-icon');

  // all states, followed by default
  const state = pageState(['search', 'feed', 'map'], 'feed');

  const bringInSearch = (callback) => {
    animateCSS(searchPage, 'fadeInLeft', callback, alwaysVisible);
  };

  const takeOutSearch = (callback) => {
    animateCSS(searchPage, 'fadeOutLeft', callback, willHideAfterwards);
  };

  const bringInFeed = (callback) => {
    animateCSS(feed, 'fadeInRight', callback, alwaysVisible);
  };

  const takeOutFeed = (callback) => {
    animateCSS(feed, 'fadeOutRight', callback, willHideAfterwards);
  };

  const bringInMap = (callback) => {
    animateCSS(mapPage, 'fadeInRight', callback, alwaysVisible);
  };

  const takeOutMap = (callback) => {
    animateCSS(mapPage, 'fadeOutRight', callback, willHideAfterwards);
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
        takeOutFeed(bringInSearch.bind(null, bringInArrow));
        state.setState('search');
      } else if (state.currentState() === 'map') {
        takeOutMap(bringInSearch);
        state.setState('search');
      }
    });
  }

  if (back) {
    back.addEventListener('click', () => {
      if (state.currentState() === 'search') {
        takeOutSearch(bringInFeed.bind(null, takeOutArrow));
        state.setState('feed');
      } else if (state.currentState() === 'map') {
        takeOutMap(bringInFeed.bind(null, takeOutArrow));
        state.setState('feed');
      }
    });
  }

  if (mapIcon) {
    mapIcon.addEventListener('click', () => {
      if (state.currentState() === 'search') {
        takeOutSearch(bringInMap.bind(null, bringInArrow));
        state.setState('map');
      } else if (state.currentState() === 'feed') {
        takeOutFeed(bringInMap.bind(null, bringInArrow));
        state.setState('map');
      }
    });
  }
};
