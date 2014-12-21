$(document).ready(function($) {

    var controller = new ScrollMagic({
        globalSceneOptions: {
            triggerHook: "onEnter",
            duration: $(window).height()*2
        }
    });

    new ScrollScene({triggerElement: ".js-parallax--author"})
        .setTween(TweenMax.from(".js-parallax--author > .parallax__bg", 1, {top: "-80%", ease: Linear.easeNone}))
        .addTo(controller);

    new ScrollScene({triggerElement: ".js-parallax--toolkit"})
        .setTween(TweenMax.from(".js-parallax--toolkit > .parallax__bg", 1, {top: "-110%", ease: Linear.easeNone}))
        .addTo(controller);

    new ScrollScene({triggerElement: ".js-parallax--header"})
        .setTween(TweenMax.from(".js-parallax--header > .parallax__bg", 1, {top: "-120%", ease: Linear.easeNone}))
        .addTo(controller);

});


