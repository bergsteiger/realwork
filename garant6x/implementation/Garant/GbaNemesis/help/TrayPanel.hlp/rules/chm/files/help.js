
window.onerror=function(){return true};

function showImage(imgId){
 window.open(document.all(imgId).src, '_blank', 'top=20,left=50,resizable=yes,scrollbars=yes,directories=no,status=no,toolbar=no,menubar=no,location=no');
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
