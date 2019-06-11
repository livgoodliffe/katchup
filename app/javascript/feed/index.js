import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';
import pageState from '../page_state';

export default () => {
  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#search-search form');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  // const state = pageState(['search', 'feed', 'map'], 'feed');

  const bringInSearch = (callback) => {
    animateCSS(searchPage, 'slideInRight', callback, alwaysVisible);
  };

  const takeOutSearch = (callback) => {
    animateCSS(searchPage, 'slideOutRight', callback, willHideAfterwards);
  };

  const bringInArrow = (callback) => {
    animateCSS(back, 'slideInLeft', callback, alwaysVisible);
  };

  const takeOutArrow = (callback) => {
    animateCSS(back, 'slideOutLeft', callback, willHideAfterwards);
  };

  if (searchSelect) {
    searchSelect.addEventListener('click', () => {
      // if (state.currentState() === 'feed') {
        feed.classList.add('hidden');
        bringInSearch();
        bringInArrow();
        // state.setState('search');
    });
  };

  if (back) {
    back.addEventListener('click', () => {
      // if (state.currentState() === 'search') {
        feed.classList.remove('hidden');
        takeOutSearch();
        takeOutArrow();
        // state.setState('feed');
    });
  };
};
