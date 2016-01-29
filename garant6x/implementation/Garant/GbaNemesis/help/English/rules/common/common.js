
var outFld   = '..\\..\\output';
var dataFld  = '..\\..\\data';

var dataFile = '..\\..\\data\\data_eng.xml';

var fso, folder;

// ====================================================
// удаляем и заново создаем выходной каталог

 var fso = new ActiveXObject("Scripting.FileSystemObject");
 if (!fso.FolderExists(outFld)) {
   var errMsg = 'Ошибка в файле ' + WScript.FullName + ':\n\n' + 'Выходной каталог ' + outFld + ' не существует. Создайте его.';
   WScript.Echo(errMsg);
   WScript.Quit();
 }
 folder = outFld + '\\' + fso.GetFolder('.').Name;
 try {fso.DeleteFolder(folder, true)} catch(e){};
 fso.CreateFolder(folder);
// WScript.Sleep(100);

// ====================================================
// складываем в него картинки и специфичные для данного преобразования файлы

 try {
  fso.CopyFolder(dataFld + '\\images\\*', folder, 1);
  fso.CopyFile('files\\*.*', folder, 1); 
 }
 catch(e){};

// ====================================================
// запись в файл

function writeHTML(filename, html){
 var f = fso.OpenTextFile(folder + '\\' + filename, 2, true);
 f.Write(html);
 f.close();
}