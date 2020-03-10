// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require.context('../packs/images', true);
window.jQuery = window.$ = require('jquery')
import 'bootstrap/dist/js/bootstrap';
import 'packs/stylesheets.scss'
import FooImage from 'packs/images/image.png'

//console.log("Hello from hello.js");

function noImage(element) {
  //console.log("Hello from func");
  element.src=FooImage;
}

//replaces previously used showInfo and HideInfo functions
// takes element, determines its display property and switches it
function InfoToggle(element, showState) {
	if (showState) {
		element.querySelector(".inner").style.display = "block";
	}
	else {
		element.querySelector(".inner").style.display = "none";
	}
}
// checks if show is liked, disliked
// goes to search page, giving user ability to search for new show or displays similar below
function showrating(seriesID, state) {

}
// @TODO, why is window constantly needed? See this as starting point
//https://stackoverflow.com/questions/60048206/why-are-my-js-erb-views-not-working-when-using-webpacker-in-rails-6-with-bootstr
window.noImage = noImage;
window.InfoToggle = InfoToggle;
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


