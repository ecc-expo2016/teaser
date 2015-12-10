'use strict';

const modal = {
  init() {
    this.modal = document.getElementById('modal');
    this.mask = document.getElementById('modal-mask');
    this.openBtn = document.getElementById('modal-open');
    this.closeBtn = document.getElementById('modal-close');
    this.isShown = false;
    this.bindEvents();
  },
  bindEvents() {
    this.openBtn.addEventListener('click', this.open.bind(this));
    this.closeBtn.addEventListener('click', this.close.bind(this));
    this.mask.addEventListener('click', this.close.bind(this));
    document.addEventListener('keydown', this.handleKeyDown.bind(this));
  },
  handleKeyDown(e) {
    if (!this.isShown) { return; }

    if (e.key === 'Escape' || e.keyCode === 27) {
      this.close();
    }
  },
  open() {
    if (this.isShown) { return; }

    this.modal.classList.remove('modal--close');
    this.modal.classList.add('modal--open');
    this.mask.classList.remove('modal__mask--close');

    this.isShown = true;
  },
  close() {
    if (!this.isShown) { return; }

    this.modal.classList.remove('modal--open');
    this.modal.classList.add('modal--close');
    this.mask.classList.add('modal__mask--close');

    this.isShown = false;
  }
};

export default modal;
