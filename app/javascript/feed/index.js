import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';

export default () => {

  const feed = document.querySelector('#feed-page');
  const searchSelect = document.querySelector('#spots-search');

  const searchPage = document.querySelector('#search-page');
  const back = document.querySelector('#search-back-button');

  const bringInSearch = (callback) => {
    animateCSS(searchPage, 'slideInRight', callback, alwaysVisible);
  };

  const takeOutSearch = (callback) => {
    animateCSS(searchPage, 'slideOutRight', callback, willHideAfterwards);
  };

  const bringInArrow = (callback) => {
    animateCSS(back, 'fadeIn', callback, alwaysVisible);
  };

  const takeOutArrow = (callback) => {
    animateCSS(back, 'fadeOut', callback, willHideAfterwards);
  };

  if (searchSelect) {
    searchSelect.addEventListener('click', () => {
        feed.classList.add('hidden');
        bringInSearch();
        bringInArrow();
    });
  };

  if (back) {
    back.addEventListener('click', () => {
        feed.classList.remove('hidden');
        takeOutSearch();
        takeOutArrow();
    });
  }
};
