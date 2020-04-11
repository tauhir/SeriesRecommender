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
import 'slick-carousel/slick/slick';

//console.log("Hello from hello.js");
$(document).ready(function(){
	$('.my-carousel').slick({
		slidesToShow: 2,
		responsive: [{
		  breakpoint: 500,
		  settings: {
			slidesToShow: 1,
		  }
		}]
	  });
  });


function noImage(element) {
  //console.log("Hello from func");
  element.src=FooImage;
  element.classList.add('noImage');
}

/*
 replaces previously used showInfo and HideInfo functions
 takes element, determines its display property and switches the property
 == Parameters:
 	element::
 		element that called function
 	showState::
 		boolean value to set seriesList type
*/	
function InfoToggle(element, showState) {
	if (showState) {
		element.querySelector(".inner").style.display = "block";
	}
	else {
		element.querySelector(".inner").style.display = "none";
	}
}

/*
 checks if show is liked, disliked
 goes to search page, giving user ability to search for new show or displays similar below
 if in search, the search should be hidden
 if in recommends, the show should be hidden.
 == Parameters:
 	seriesId::
 		element that called function
 	state::
 		boolean value to set seriesList type
 	searchId::
		searchId of the seriesList to find the search object

*/	
const url ='http://'+ window.location.host + '/searches/opinion'
function showrating(seriesId, state,searchId,object) {
	console.log(seriesId, state,searchId);
	fetch(url, {
		headers: {"Content-type": "application/json; charset=UTF-8" },
		method: 'post',
		body: JSON.stringify({
			"seriesId":seriesId,
			"liked": state,
			"searchId":searchId
		})
	  })
	  .then(json)
	  .then(function (data) {
		  // /console.log(object);
		after_opinion(object,seriesId);

	  })
	  .catch(function (error) {
		console.log('Request failed', error);
	  });
	
	if (state) {
		//user likes the show so we should send them to the search page again but also display similar shows
		

	}
}

function after_opinion(data, seriesId) {

	var el = data;
	console.log(el);
	var parent = null;
	var id = el.id;
	while (el != null && el.id != "series" && el.id != "search" ) {
		el = el.parentNode
		id = el.id;
	}
	
	var tile = document.getElementById(seriesId+"_tile");
	if ( id == "search" ) {
		// we should now hide the card
		// @todo check to see if no search options left and let user know
		console.log(tile);
		tile.style.visibility = "collapse";
	}
}
function json(response) {
	console.log(response);
	return response.json()
  }


var small = true;
function toggleSidebar() {
if (small) {
	console.log("opening sidebar");
	document.getElementById("mySidebar").style.width = "250px";
	document.getElementById("main").style.marginLeft = "250px";
	document.getElementById("wholebar").style.display = "inline-block";
	document.getElementById("smallbar").style.display = "none";
	small = false;
} else {
	console.log("closing sidebar");
	document.getElementById("mySidebar").style.width = "85px";
	document.getElementById("main").style.marginLeft = "85px";
	document.getElementById("wholebar").style.display = "none";
	document.getElementById("smallbar").style.display = "inline-block";
	small = true;
}
}
  
// @TODO, why is window constantly needed? See this as starting point
//https://stackoverflow.com/questions/60048206/why-are-my-js-erb-views-not-working-when-using-webpacker-in-rails-6-with-bootstr
window.noImage = noImage;
window.InfoToggle = InfoToggle;
window.showrating = showrating;
window.toggleSidebar = toggleSidebar;
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


