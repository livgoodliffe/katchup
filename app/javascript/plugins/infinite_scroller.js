const scrollBuffer = 600;
const paginators = $('.pagination');

const getScript = (scriptUrl) => {
  var js_script = document.createElement('script');
  js_script.type = "text/javascript";
  js_script.src = scriptUrl;
  js_script.async = true;
  document.getElementsByTagName('head')[0].appendChild(js_script);
}

const paginators = document.querySelectorAll('.paginator');

if (!paginators) {
  return;
}

const onWindowScroll = () => {
  paginators.forEach((paginator) => {
    const url = paginator.querySelector('.next_page a').getAttribute('href');

    if (!url) {
      return;
    }

    const loadPointOnPage = document.body.clientHeight - window.innerHeight - scrollBuffer;

    if (window.scrollY > loadPointOnPage) {
      paginator.innerHtml = "Loading more products...";
      getScript(url);
    }
  });
}

  window.addEventListener('scroll', onWindowScroll);
  onWindowScroll();

