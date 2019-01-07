var elements = [$(".intro1"), $(".username"), $(".password"), $(".submit"), $("#info .row")];

TweenMax.set([$(".wrapper"), elements], { "scale": 0, "opacity": 0 });
TweenMax.set(elements, { "scale": 0, "opacity": 0 });
TweenMax.set([$(".loading"), $(".success"), $(".failure")], { "scale": 0, "display": "none", "opacity": 0 });

$(document).ready(function () {
	TweenMax.to($(".wrapper"), 1.5, { "opacity": 1, "scale": "1", ease: Power4.easeInOut, delay: 0.75 });
	TweenMax.staggerTo(elements, 1, { "opacity": 1, "scale": "1", ease: Expo.easeOut, delay: 1.75 }, 0.1);
});
