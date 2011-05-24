(function(c){var b=c.setTimeout,d=c.document,a=0;c.jXHR=function(){var e,g,n,h,m=null;function l(){try{h.parentNode.removeChild(h)}catch(o){}}function k(){g=false;e="";l();h=null;i(0)}function f(p){try{m.onerror.call(m,p,e)}catch(o){throw new Error(p)}}function j(){if((this.readyState&&this.readyState!=="complete"&&this.readyState!=="loaded")||g){return}this.onload=this.onreadystatechange=null;g=true;if(m.readyState!==4){f("Script failed to load ["+e+"].")}l()}function i(o,p){p=p||[];m.readyState=o;if(typeof m.onreadystatechange==="function"){m.onreadystatechange.apply(m,p)}}m={onerror:null,onreadystatechange:null,readyState:0,open:function(p,o){k();internal_callback="cb"+(a++);(function(q){c.jXHR[q]=function(){try{i.call(m,4,arguments)}catch(r){m.readyState=-1;f("Script failed to run ["+e+"].")}c.jXHR[q]=null}})(internal_callback);e=o.replace(/=\?/,"=jXHR."+internal_callback);i(1)},send:function(){b(function(){h=d.createElement("script");h.setAttribute("type","text/javascript");h.onload=h.onreadystatechange=function(){j.call(h)};h.setAttribute("src",e);d.getElementsByTagName("head")[0].appendChild(h)},0);i(2)},setRequestHeader:function(){},getResponseHeader:function(){return""},getAllResponseHeaders:function(){return[]}};k();return m}})(window);
var persCount = 0;
window.onload = function(){
		var places = [
						{
                            'name':'solde',
							'url':'https://api.foursquare.com/v2/venues/241005/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':0,
                            'color':0x777FFF00

						},
						{
                            'name':'kaffebar',
							'url': 'https://api.foursquare.com/v2/venues/13781349/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':0,
                            'color':0xAAAA0099
						},
						{
                            'name':'triangel stationen',
							'url': 'https://api.foursquare.com/v2/venues/13690111/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':0,
                            'color':0xAA228429
						},
						{
                            'name':'Centralen',
							'url': 'https://api.foursquare.com/v2/venues/223593/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':0,
                            'color':0x99228429
						}
		];
        window.puls = new window.puls.View(places);
};
(function(){
    puls = {};	
    puls.View = function(data){
        this.places = data;
        this.lastChecked = 0;
        var self = this;
        check = function(){
           self.lastChecked = self.places.length != self.lastChecked+1 ? self.lastChecked+1 : 0; 
           f4call(self.lastChecked);
        }
        f4call = function(index){
            var x1 = new jXHR();
            var current = self.places[index];
            x1.onerror = function(msg, url){};
            x1.onreadystatechange = function(data){
                  if (x1.readyState === 4) {
                  console.log(current.name, data.response.hereNow.count);
                    if(current.count != data.response.hereNow.count){
                        update(current, data.response.hereNow.count);
                    }
                }
            };
            x1.open("GET",current.url + '&callback=?');
            x1.send();
        }

        update = function(obj, count){
            obj.count = count;
            window.updateCurve(obj.name,count);
        }

        this.init = function(){
            for(var  i=0, ii = self.places.length;i<ii;i++){
                var p = self.places[i];
                window.addCurve(p.name, p.count,p.color);
                //f4call(i);
            }
            setInterval(check, 10000);
        }
        this.addPlace = function(key, data){
           this.places[key] = data; 
        }
        this.getPlaces = function(){
            return self.places;
        }
    };
    window.puls = puls;
})();
