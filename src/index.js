import { Main } from './Main.elm';

const app = Main.embed(document.getElementById('root'));

if (window.localStorage) {
  const lsKey = 'elm-opentdb-results';
  app.ports.results.subscribe(res => {
    let resultsJSON = window.localStorage.getItem(lsKey);
    let results = [];
    if (resultsJSON !== null) {
      results = JSON.parse(resultsJSON);
    }
    window.localStorage.setItem(lsKey, JSON.stringify([ ...results, res]));
  });
}
