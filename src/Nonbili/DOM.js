exports.copyToClipboard = value => () => {
  const input = document.createElement("input");
  input.type = "text";
  input.value = value;
  input.style.position = "absolute";
  input.style.left = -10000;
  document.body.appendChild(input);
  input.select();
  document.execCommand("copy");
  document.body.removeChild(input);
};

exports.setStyleWidth = el => width => () => (el.style.width = width + "px");

exports.setStyleHeight = el => height => () =>
  (el.style.height = height + "px");
