(function(c){var b=c.setTimeout,d=c.document,a=0;c.jXHR=function(){var e,g,n,h,m=null;function l(){try{h.parentNode.removeChild(h)}catch(o){}}function k(){g=false;e="";l();h=null;i(0)}function f(p){try{m.onerror.call(m,p,e)}catch(o){throw new Error(p)}}function j(){if((this.readyState&&this.readyState!=="complete"&&this.readyState!=="loaded")||g){return}this.onload=this.onreadystatechange=null;g=true;if(m.readyState!==4){f("Script failed to load ["+e+"].")}l()}function i(o,p){p=p||[];m.readyState=o;if(typeof m.onreadystatechange==="function"){m.onreadystatechange.apply(m,p)}}m={onerror:null,onreadystatechange:null,readyState:0,open:function(p,o){k();internal_callback="cb"+(a++);(function(q){c.jXHR[q]=function(){try{i.call(m,4,arguments)}catch(r){m.readyState=-1;f("Script failed to run ["+e+"].")}c.jXHR[q]=null}})(internal_callback);e=o.replace(/=\?/,"=jXHR."+internal_callback);i(1)},send:function(){b(function(){h=d.createElement("script");h.setAttribute("type","text/javascript");h.onload=h.onreadystatechange=function(){j.call(h)};h.setAttribute("src",e);d.getElementsByTagName("head")[0].appendChild(h)},0);i(2)},setRequestHeader:function(){},getResponseHeader:function(){return""},getAllResponseHeaders:function(){return[]}};k();return m}})(window);
var persCount = 0;
window.onload = function(){
/*   var c = document.getElementById('c');
   if (c.getContext){
               var ctx = c.getContext('2d');
               ctx.fillRect(25,25,100,100);
               ctx.clearRect(45,45,60,60);
               ctx.strokeRect(50,50,50,50);
   }
   for(var i = 0; i<10;i++){
       var t = i * 1000;
   }*/
    setInterval(checkCheckins, 5000);
};

function checkCheckins(){
        var x1 = new jXHR();
        x1.onerror = function(msg, url){alert(msg);};
        x1.onreadystatechange = function(data){
              if (x1.readyState === 4) {
//                  persCount = data.response.hereNow.count;
                  //document.getElementById('count').
            }
        };
        var url = 'https://api.foursquare.com/v2/venues/4af565bbf964a52005f921e3/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R';
        x1.open("GET",url + '&callback=?');
        x1.send();
}
