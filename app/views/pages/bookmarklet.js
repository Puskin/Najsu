function parseVideoURL(url) {
    
    function getParm(url, base) {
        var re = new RegExp("(\\?|&)" + base + "\\=([^&]*)(&|$)");
        var matches = url.match(re);
        if (matches) {
            return(matches[2]);
        } else {
            return("");
        }
    }
    
    var retVal = {};
    var matches;
    
    if (url.indexOf("youtube.com/watch") != -1) {
        retVal.provider = 1; /*"youtube"*/
        retVal.id = getParm(url, "v");
        retVal.title = document.title.substring(0, document.title.length-10);
    } else if (matches = url.match(/vimeo.com\/(\d+)/)) {
        retVal.provider = 2; /*"vimeo"*/
        retVal.id = matches[1];
        retVal.title = document.title.substring(0, document.title.length-9);
    }
    return(retVal);
}

var url = window.location.href;
var video = parseVideoURL(url);


if(url.indexOf("youtube.com") != -1 || url.indexOf("vimeo.com") != -1) {
    var clean_title = video.title.replace(/[^a-zA-Z0-9 !-]/g, ""); /* leave only digits some chars gotta perfect it */
    window.open('http://www.najsu.pl/submit?resource_id='+video.id+'&resource_title='+clean_title+'&resource_source='+video.provider,'Najsu','status=no,directories=no,location=no,resizable=no,menubar=no,width=200,height=110,toolbar=no');    
}



