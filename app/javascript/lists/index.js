
import { animateCSS, alwaysVisible, willHideAfterwards } from '../animate_css';

export default () => {
  const wishlist = document.querySelector('#want_to_try_list');
  const wishlistSelect = document.querySelector('#want_to_try_button');

  const favourites = document.querySelector('#been_there_list');
  const favoutiesSelect = document.querySelector('#been_there_button');

  if (wishlistSelect) {
    wishlistSelect.addEventListener('click', () => {
      favourites.classList.add('hidden');
      wishlist.classList.remove('hidden');
      wishlistSelect.classList.add('underline-active');
      favoutiesSelect.classList.remove('underline-active');
    });
  };

  if (favoutiesSelect) {
    favoutiesSelect.addEventListener('click', () => {
      favourites.classList.remove('hidden');
      wishlist.classList.add('hidden');
      wishlistSelect.classList.remove('underline-active');
      favoutiesSelect.classList.add('underline-active');

    });
  }
};
