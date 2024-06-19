  
function initAutocomplete() {
    // Create the search box and link it to the UI element.
    const input = document.getElementById("search_location")
    if(input){
        new google.maps.places.SearchBox(input);
    }

}


window.onload = function() {
    initAutocomplete()
};
