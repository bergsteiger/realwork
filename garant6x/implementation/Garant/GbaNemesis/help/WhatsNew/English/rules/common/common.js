
var outFld   = '..\\..\\output';
var dataFld  = '..\\..\\data';

var dataFile = '..\\..\\data\\data_eng.xml';

var fso, folder;

// ====================================================
// ������� � ������ ������� �������� �������

 var fso = new ActiveXObject("Scripting.FileSystemObject");
 if (!fso.FolderExists(outFld)) {
   var errMsg = '������ � ����� ' + WScript.FullName + ':\n\n' + '�������� ������� ' + outFld + ' �� ����������. �������� ���.';
   WScript.Echo(errMsg);
   WScript.Quit();
 }
 folder = outFld + '\\' + fso.GetFolder('.').Name;
 try {fso.DeleteFolder(folder, true)} catch(e){};
 fso.CreateFolder(folder);
// WScript.Sleep(100);

// ====================================================
// ���������� � ���� �������� � ����������� ��� ������� �������������� �����

 try {
  fso.CopyFolder(dataFld + '\\images\\*', folder, 1);
  fso.CopyFile('files\\*.*', folder, 1); 
 }
 catch(e){};

// ====================================================
// ������ � ����

function writeHTML(filename, html){
 var f = fso.OpenTextFile(folder + '\\' + filename, 2, true);
 f.Write(html);
 f.close();
}