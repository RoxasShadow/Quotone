(function(g,b){"object"===typeof exports?b(exports):"function"===typeof define&&define.amd?define(["exports"],b):b(g)})(this,function(g){function b(a){this._targetElement=a;this._options={wideAreaAttr:"data-widearea",exitOnEsc:!0,defaultColorScheme:"light",closeIconLabel:"Close WideArea",changeThemeIconLabel:"Toggle Color Scheme",fullScreenIconLabel:"WideArea Mode"};var k=this;a=this._targetElement.querySelectorAll("textarea["+this._options.wideAreaAttr+"='enable']");for(var d=a.length-1;0<=d;d--){var b=
a[d],c=document.createElement("div"),e=document.createElement("div");fullscreenIcon=document.createElement("a");c.className="widearea-wrapper";e.className="widearea-icons";fullscreenIcon.className="widearea-icon fullscreen";fullscreenIcon.title=this._options.fullScreenIconLabel;fullscreenIcon.href="javascript:void(0);";fullscreenIcon.onclick=function(){l.call(k,this)};c.appendChild(b.cloneNode());e.appendChild(fullscreenIcon);c.appendChild(e);b.parentNode.replaceChild(c,b)}}function l(a){var b=this;
a=a.parentNode.parentNode.querySelector("textarea");var d=a.cloneNode();d.className=("widearea-fullscreen "+a.className).trim();a.className=("widearea-fullscreened "+a.className).trim();var f=document.createElement("div");f.className="widearea-controlPanel";var c=document.createElement("a");c.href="javascript:void(0);";c.className="widearea-icon close";c.title=this._options.closeIconLabel;c.onclick=function(){j.call(b)};var e=document.createElement("a");e.href="javascript:void(0);";e.className="widearea-icon changeTheme";
e.title=this._options.changeThemeIconLabel;e.onclick=function(){m.call(b)};f.appendChild(c);f.appendChild(e);c=document.createElement("div");c.className="widearea-overlayLayer "+this._options.defaultColorScheme;c.appendChild(d);c.appendChild(f);document.body.appendChild(c);d.focus();d.value=a.value;this._onKeyDown=function(a){27===a.keyCode&&!0==b._options.exitOnEsc&&j.call(b)};window.addEventListener?window.addEventListener("keydown",b._onKeyDown,!0):document.attachEvent&&document.attachEvent("onkeydown",
b._onKeyDown)}function m(){var a=document.querySelector(".widearea-overlayLayer");a.className=/dark/gi.test(a.className)?a.className.replace("dark","light"):a.className.replace("light","dark")}function j(){var a=document.querySelector("textarea.widearea-fullscreened"),b=document.querySelector(".widearea-overlayLayer"),d=b.querySelector("textarea");a.focus();a.value=d.value;b.parentNode.removeChild(b);window.removeEventListener?window.removeEventListener("keydown",this._onKeyDown,!0):document.detachEvent&&
document.detachEvent("onkeydown",this._onKeyDown)}var h=function(a){if("string"===typeof a){if(a=document.querySelector(a))return new b(a);throw Error("There is no element with given selector.");}return new b(document.body)};h.version="0.1.0";h.fn=b.prototype={clone:function(){return new b(this)}};return g.wideArea=h});