import { Elm } from '../elm/Main.elm'

const app = Elm.Main.init({
  node: document.querySelector('main')
})

app.ports.setLayout.subscribe(function(data) {
  console.log('got data')
});