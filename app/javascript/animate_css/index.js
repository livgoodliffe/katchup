export const alwaysVisible = {
  start: 'unhidden',
  end: 'unhidden',
};

export const willHideAfterwards = {
  start: 'unhidden',
  end: 'hidden',
};

const setVisibility = (node, visibility) => {
  if (visibility === 'hidden') {
    node.classList.add('hidden');
  } else {
    node.classList.remove('hidden');
  }
};

export const animateCSS = (node, animationName, callback, visibility) => {
  node.classList.add('animated', animationName);
  setVisibility(node, visibility.start);

  const handleAnimationEnd = () => {
    setVisibility(node, visibility.end);
    node.classList.remove('animated', animationName);
    node.removeEventListener('animationend', handleAnimationEnd);
    if (typeof callback === 'function') callback();
  };
  node.addEventListener('animationend', handleAnimationEnd);
};
