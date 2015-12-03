'use strict';
import Symbol from './symbol';

const share = {
  init() {
    this.title = 'ECC EXPO 2016';
    this.href = 'http://expo-ecc.com/';

    const twitterBtn = document.getElementById('twitter');
    twitterBtn.addEventListener('click', this.twitter.bind(this));

    const facebookBtn = document.getElementById('facebook');
    facebookBtn.addEventListener('click', this.facebook.bind(this));
  },
  twitter() {
    const twitterId = 'EccCcad';
    const url = 'https://twitter.com/intent/tweet?' +
      `related=${twitterId}&text=${this.title}&url=${this.href}&via=${twitterId}`;
    const width = 550;
    const height = 280;
    const top = Math.round((window.screen.height - height) / 2);
    const left = Math.round((window.screen.width - width) / 2);
    const opts = { width, height, top, left };
    const features = Object.keys(opts).map(key =>
      `${key}=${opts[key]}`).join(',');
    window.open(url, null, features);
  },
  facebook() {
    FB.ui({
      method: 'share',
      href: this.href
    });
  }
};

share.init();

window.addEventListener('load', () => {
  new Symbol(document.getElementById('symbol'));
});
