import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';

export default () => {
  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#search-search form');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const mapPage = document.querySelector('#map');
  const mapIcon = document.querySelector('#map-icon');

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
      takeOutFeed(bringInSearch.bind(null, bringInArrow));
    });
  }

  if (back) {
    back.addEventListener('click', () => {
      takeOutSearch(bringInFeed.bind(null, takeOutArrow));
    });
  }

  if (mapIcon) {
    mapIcon.addEventListener('click', () => {
      takeOutFeed(bringInMap.bind(null, bringInArrow));
    });
  }
};
