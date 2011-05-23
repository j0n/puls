window.onload = function(){
   var c = document.getElementById('c');
   if (c.getContext){
               var ctx = c.getContext('2d');
               ctx.fillRect(25,25,100,100);
               ctx.clearRect(45,45,60,60);
               ctx.strokeRect(50,50,50,50);
   }
   for(var i = 0; i<10;i++){
       var t = i * 1000;
       
   }

};
