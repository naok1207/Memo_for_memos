import '../stylesheets/markdown'
import hljs from 'highlight.js';
import 'highlight.js/styles/github.css';
document.addEventListener('DOMContentLoaded', (event) => {
  reflectHighlight();
});

function reflectHighlight() {
  document.querySelectorAll('pre code').forEach((block) => {
    hljs.highlightBlock(block);
  });
}

window.reflectHighlight = reflectHighlight

var memoBody = $('#memo-body');
if (memoBody.html() == '') {
  memoBody.html("Any Contents");
}
