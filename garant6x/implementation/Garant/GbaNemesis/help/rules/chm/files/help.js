
window.onerror=function(){return true};

function checkImagewidth(imgId){
var imageOncheck = new Image();
 imageOncheck.src = document.all(imgId).src;
 whoc=imageOncheck.width;
 if (whoc>350) {document.all(imgId).width=350}
}

function checkImage(imgId){
var image2gethw = new Image();
 image2gethw.src = document.all(imgId).src;
 wh=image2gethw.width;
 document.all(imgId).title='[»зображение показано в натуральную величину]';
 if (wh>350) {
	document.all(imgId).className='screenshotBorder';
	document.all(imgId).title='Ќажмите, чтобы открыть полноразмерную иллюстрацию в отдельном окне'
 }
}

function showImage(imgId,num){

// создаем промежуточный объект дл€ получени€ размеров картинки
 var image2gethw = new Image();
 image2gethw.src = document.all(imgId).src;

 ht=image2gethw.height+20;
 wh=image2gethw.width+20;
 if (wh>370) {
 var were= "<img src=\""+document.all(imgId).src+"\" alt=\""+document.all(imgId).alt+"\">";
 
 arg="top=20,left=50,width="+wh+",height="+ht+",resizable=no,scrollbars=no,directories=no,status=no,toolbar=no,menubar=no,location=no";
 image2open= window.open('', 'displaywindow', arg);

// CQ 28877
 image2open.document.clear();

 image2open.document.write("<html><head><title>–исунок "+num+" (полноразмерна€ иллюстраци€)");
 image2open.document.write("</title></head><body>");
 
// CQ 28877
 image2open.resizeTo(wh+15,ht+30);

//собственно вывод самой картинки а новое окно
 image2open.document.write(were);
 image2open.document.write("</body></html>");

// CQ 28877
 image2open.focus();

// закрываем документ, но не окно
  image2open.document.close();  
}
}

function switchList(e){
 var section = document.all(e.id);
 var show = document.all('show' + e.id);
 var hide = document.all('hide' + e.id);

 for (var i=1; i<section.length; i++) section[i].style.display = (e.state) ? 'block':'none';

 show.className = (!e.state) ? 'u':'uh';
 hide.className = ( e.state) ? 'u':'uh';

 e.state = !e.state;
}
