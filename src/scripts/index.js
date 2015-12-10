'use strict';
import modal from './modal';
import share from './share';
import Symbol from './symbol';

modal.init();
share.init();

window.addEventListener('load', () => {
  new Symbol(document.getElementById('symbol'));
});
