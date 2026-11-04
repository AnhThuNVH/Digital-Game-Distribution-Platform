// Kho Game Độc Lập — small progressive enhancements. Every page works without this file.
(function () {
  'use strict';

  // Phone menu: a full-screen sheet.
  var sidebar = document.getElementById('sidebar');
  document.querySelectorAll('[data-menu-open]').forEach(function (button) {
    button.addEventListener('click', function () {
      sidebar.classList.add('open');
      button.setAttribute('aria-expanded', 'true');
      var first = sidebar.querySelector('a, button');
      if (first) first.focus();
    });
  });
  document.querySelectorAll('[data-menu-close]').forEach(function (button) {
    button.addEventListener('click', function () {
      sidebar.classList.remove('open');
      document.querySelectorAll('[data-menu-open]').forEach(function (b) { b.setAttribute('aria-expanded', 'false'); });
    });
  });
  document.addEventListener('keydown', function (event) {
    if (event.key !== 'Escape') return;
    if (sidebar) sidebar.classList.remove('open');
    document.querySelectorAll('details.account[open]').forEach(function (d) { d.removeAttribute('open'); });
  });

  // Close the account menu on an outside click.
  document.addEventListener('click', function (event) {
    document.querySelectorAll('details.account[open]').forEach(function (d) {
      if (!d.contains(event.target)) d.removeAttribute('open');
    });
  });

  // Destructive actions ask once.
  document.addEventListener('submit', function (event) {
    var form = event.target;
    var message = form.getAttribute('data-confirm');
    if (message && !window.confirm(message)) {
      event.preventDefault();
    }
  });

  // Filter selects submit their form on change.
  document.querySelectorAll('select[data-autosubmit]').forEach(function (select) {
    select.addEventListener('change', function () { select.form.submit(); });
  });

  // Game gallery: thumbnails swap the main image.
  document.querySelectorAll('[data-gallery]').forEach(function (gallery) {
    var main = gallery.querySelector('[data-gallery-main]');
    var credit = gallery.querySelector('[data-gallery-credit]');
    var source = gallery.querySelector('[data-gallery-source]');
    gallery.querySelectorAll('[data-gallery-thumb]').forEach(function (thumb) {
      thumb.addEventListener('click', function () {
        main.src = thumb.getAttribute('data-src');
        main.alt = thumb.getAttribute('data-alt') || '';
        if (credit) credit.textContent = thumb.getAttribute('data-credit') || '';
        if (source) {
          var url = thumb.getAttribute('data-credit-url') || '';
          source.href = url;
          source.hidden = url === '';
        }
        gallery.querySelectorAll('[data-gallery-thumb]').forEach(function (t) { t.setAttribute('aria-pressed', 'false'); });
        thumb.setAttribute('aria-pressed', 'true');
      });
    });
  });

  // Pricing fields follow the pricing model.
  document.querySelectorAll('[data-pricing]').forEach(function (select) {
    var update = function () {
      var paid = select.value === 'paid' || select.value === 'pay_what_you_want';
      document.querySelectorAll('[data-price-field]').forEach(function (field) {
        field.hidden = !paid;
      });
    };
    select.addEventListener('change', update);
    update();
  });

  // Broken remote images fall back to the game title.
  document.querySelectorAll('img[data-fallback]').forEach(function (img) {
    var swap = function () {
      var box = document.createElement('div');
      box.className = 'cover-fallback';
      box.textContent = img.getAttribute('data-fallback');
      img.replaceWith(box);
    };
    if (img.complete && img.naturalWidth === 0 && img.getAttribute('src')) {
      swap();
    } else {
      img.addEventListener('error', swap, { once: true });
    }
  });

  // Resend verification code: the button counts down and stays disabled.
  document.querySelectorAll('[data-resend]').forEach(function (button) {
    var remaining = parseInt(button.getAttribute('data-wait') || '0', 10);
    if (remaining <= 0) return;
    var tick = function () {
      if (remaining <= 0) {
        button.disabled = false;
        button.removeAttribute('data-wait');
        button.textContent = 'Gửi lại mã';
        return;
      }
      button.disabled = true;
      button.setAttribute('data-wait', String(remaining));
      button.textContent = 'Vui lòng đợi ' + remaining + ' giây…';
      remaining -= 1;
      window.setTimeout(tick, 1000);
    };
    tick();
  });

  // Requesting a code: one click only, then the button waits.
  document.querySelectorAll('[data-send-code]').forEach(function (button) {
    button.addEventListener('click', function () {
      button.disabled = true;
      button.textContent = 'Đang gửi…';
    });
  });
})();
