
window.onerror=function(){return true};

function showImage(imgId,num){

// ������� ������������� ������ ��� ��������� �������� ��������
 var image2gethw = new Image();
 image2gethw.src = document.all(imgId).src;

 ht=image2gethw.height+20;
 wh=image2gethw.width+20;
 var were= "<img src=\""+document.all(imgId).src+"\" alt=\""+document.all(imgId).alt+"\">";
 
 arg="top=20,left=50,width="+wh+",height="+ht+",resizable=no,scrollbars=no,directories=no,status=no,toolbar=no,menubar=no,location=no";
 image2open= window.open('', 'displaywindow', arg);
 image2open.document.write("<html><head><title>������� "+num+" (�������������� �����������)");
 image2open.document.write("</title></head><body>");
 
//���������� ����� ����� �������� � ����� ����
 image2open.document.write(were);
 image2open.document.write("</body></html>");

// ��������� ��������, �� �� ����
  image2open.document.close();  

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
