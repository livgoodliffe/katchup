import $ from 'jquery';

export default () => {
  // const scrollBuffer = 600;

  // const documentHeight = () => {
  //   const body = document.body;
  //   const html = document.documentElement;

  //   return Math.max( body.scrollHeight, body.offsetHeight,
  //                          html.clientHeight, html.scrollHeight, html.offsetHeight );
  // }

  // const paginators = document.querySelectorAll('.pagination');

  // if (!paginators) {
  //   return;
  // }

  // const onWindowScroll = () => {
  //   paginators.forEach((paginator) => {
  //     const nextButton = paginator.querySelector('.next_page a');

  //     if (!nextButton) {
  //       return;
  //     }

  //     const url = nextButton.getAttribute('href');

  //     const loadPointOnPage = documentHeight() - document.body.clientHeight - scrollBuffer;

  //     if (window.scrollY > loadPointOnPage) {

  //       $.getScript(url);
  //       paginator.innerText = "Loading more products...";
  //     }
  //   });
  // }

  //   window.addEventListener('scroll', onWindowScroll);
  //   onWindowScroll();

}
