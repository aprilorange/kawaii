!(function() {

  $ = document.getElementById.bind(document)
  $$ = document.querySelector.bind(document)
  $$$ = document.querySelectorAll.bind(document)

  function render(tpl, data) {
    var html = $(tpl + '-tpl').innerHTML
    return nunjucks.renderString(html, data)
  }

  function renderHeader(data) {
    $('header').innerHTML = render('header', data)
  }

  function HomeRouter() {
    renderHeader({
      tab: 'home'
    })
  }

  Q.reg('home', HomeRouter)

  Q.init({
    key: '/',
    index: 'home'
  })
})();