(function(c){var b=c.setTimeout,d=c.document,a=0;c.jXHR=function(){var e,g,n,h,m=null;function l(){try{h.parentNode.removeChild(h)}catch(o){}}function k(){g=false;e="";l();h=null;i(0)}function f(p){try{m.onerror.call(m,p,e)}catch(o){throw new Error(p)}}function j(){if((this.readyState&&this.readyState!=="complete"&&this.readyState!=="loaded")||g){return}this.onload=this.onreadystatechange=null;g=true;if(m.readyState!==4){f("Script failed to load ["+e+"].")}l()}function i(o,p){p=p||[];m.readyState=o;if(typeof m.onreadystatechange==="function"){m.onreadystatechange.apply(m,p)}}m={onerror:null,onreadystatechange:null,readyState:0,open:function(p,o){k();internal_callback="cb"+(a++);(function(q){c.jXHR[q]=function(){try{i.call(m,4,arguments)}catch(r){m.readyState=-1;f("Script failed to run ["+e+"].")}c.jXHR[q]=null}})(internal_callback);e=o.replace(/=\?/,"=jXHR."+internal_callback);i(1)},send:function(){b(function(){h=d.createElement("script");h.setAttribute("type","text/javascript");h.onload=h.onreadystatechange=function(){j.call(h)};h.setAttribute("src",e);d.getElementsByTagName("head")[0].appendChild(h)},0);i(2)},setRequestHeader:function(){},getResponseHeader:function(){return""},getAllResponseHeaders:function(){return[]}};k();return m}})(window);
var persCount = 0;
window.onload = function(){
		var places = [
						{
                            'name':'Njutbar',
							'url':'https://api.foursquare.com/v2/venues/738899/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':-1,
                            'slug':'njutbar',
                            'color':'0xFF78AB46'

						},
						{
                            'name':'Solde Kaffebar',
							'url': 'https://api.foursquare.com/v2/venues/241005/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':-1,
                            'slug':'solde',
                            'color':'0xFFCC1100'
						},
						{
                            'name':'Kaffebar Möllan',
							'url': 'https://api.foursquare.com/v2/venues/719567/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':-1,
                            'slug':'kaffebar',
                            'color':'0xFFFFCC00'
						},
						{
                            'name':'Lilla Kafferosteriet',
							'url': 'https://api.foursquare.com/v2/venues/2843821/herenow?oauth_token=Y5HZMBX20YYLNU5P34GCC40G3SFFTUMK40SBGLWCKEU4EE1R',
							'count':-1,
                            'slug': 'rost',
                            'color':'0xFF007FFF'
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
            window.updateCurve(obj.name,obj.count);
            document.getElementById(obj.slug+'_count').innerHTML = count + '';
        }

        this.init = function(){
                var html = '';;
            for(var  i=0, ii = self.places.length;i<ii;i++){
                var p = self.places[i];
                var color = p.color.substr(4)+ '';
                html += '<div id="'+p.slug+'">';
                html += '<span class="color" style="background-color:#'+color+'"></span>';
                html += '<h2>'+p.name+'</h2>';
                html += '<p id="'+p.slug+'_count" class="count">loading</p></div>';
                window.addCurve(p.name, p.count,p.color);
                f4call(i);
            }
            document.getElementById('content').innerHTML = html;

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
