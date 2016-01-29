// ====== Вспомогательные функции взятые из следилки за сервером ======

var END_OF_LINE = "\r\n";

function GetTempDir()
{
	return FSO().GetSpecialFolder(2);
}

// для FSO.OpenTextFile и FSO::File.OpenAsTextStream
var FOR_READING = 1;
var FOR_WRITING = 2;
var FOR_APPENDING = 8;

var gbl_FSO_Cache;
// Функция-фабрика экземпляра синглтона FileSystemObject
function FSO()
{
	if (typeof(gbl_FSO_Cache) != "object") {
		gbl_FSO_Cache = new ActiveXObject("Scripting.FileSystemObject");
	}
	return gbl_FSO_Cache;
}

var gbl_WshShell_Cache = null;
// Функция-фабрика экземпляра синглтона WshShell
function WshShell()
{
	if (gbl_WshShell_Cache == null)	 {
		gbl_WshShell_Cache = new ActiveXObject("WScript.Shell");
	}
	return gbl_WshShell_Cache;
}

// для ExecEx и т.п.
var WSH_RUNNING = 0;
var WSH_FINISHED = 1;

// Создает регулярное выражение для фильтрации (и только для него)
function MakeFltrRegExp(sRegEx)
{
  sRegEx = sRegEx.replace(/^\s*([\s\S]*?)\s*$/gm, "$1").replace(/\r|\n/gm, "");
  if (sRegEx == "")
    return null;
  else
    return new RegExp(sRegEx, "g");
}



// Класс для хранения опций для DSParser. Сохраняет данные в реестре.
function ClassDSParserOptions()
{
  this.opt_IsShowAnalysisMessages;
  this.opt_AnFltrIncl;
  this.opt_AnFltrExcl;
  
  this.opt_IsShowUseMesages;
  this.opt_UseThreshold;
  this.opt_UseFltrIncl;
  this.opt_UseFltrExcl;
  
  this.opt_AdditionalMDSFiles;
  this.opt_AdditionalUnitFiles;
  
  this.opt_PathToDSParser;
  
  // В этом ключе храним наши значения
  var regRoot = "HKCU\\Software\\Garant\\QC\\DSParserOptions\\";
  
  // Читает из реестра значение
  function RegRead(key, defaultValue)
  {
    try {
      return WshShell().RegRead(regRoot + key);
    } catch(ex) {
      return defaultValue;
    }
  }
  
  // Пишет в реестр значение
  function RegWrite(key, value)
  {
    WshShell().RegWrite(regRoot + key, value);
  }
  
  // СОхраняет значения опций в постоянном хранилище
  this.Save = function()
  {
    RegWrite("opt_IsShowAnalysisMessages", this.opt_IsShowAnalysisMessages);
    RegWrite("opt_AnFltrIncl", this.opt_AnFltrIncl);
    RegWrite("opt_AnFltrExcl", this.opt_AnFltrExcl);
    RegWrite("opt_IsShowUseMesages", this.opt_IsShowUseMesages);
    RegWrite("opt_UseThreshold", this.opt_UseThreshold);
    RegWrite("opt_UseFltrIncl", this.opt_UseFltrIncl);
    RegWrite("opt_UseFltrExcl", this.opt_UseFltrExcl);
    RegWrite("opt_AdditionalMDSFiles", this.opt_AdditionalMDSFiles);
    RegWrite("opt_AdditionalUnitFiles", this.opt_AdditionalUnitFiles);
    RegWrite("opt_PathToDSParser", this.opt_PathToDSParser);    
  }
  
  // Загружает значения опций из постоянного хранилища
  this.Load = function()
  {    
    this.opt_IsShowAnalysisMessages = aqConvert.VarToBool(RegRead("opt_IsShowAnalysisMessages", true));      
    this.opt_AnFltrIncl = RegRead("opt_AnFltrIncl", "");
    this.opt_AnFltrExcl = RegRead("opt_AnFltrExcl", "");
    this.opt_IsShowUseMesages = aqConvert.VarToBool(RegRead("opt_IsShowUseMesages", false));
    this.opt_UseThreshold = aqConvert.VarToInt(RegRead("opt_UseThreshold", 0));
    this.opt_UseFltrIncl = RegRead("opt_UseFltrIncl", "");
    this.opt_UseFltrExcl = RegRead("opt_UseFltrExcl", "");
    this.opt_AdditionalMDSFiles = RegRead("opt_AdditionalMDSFiles", "");
    this.opt_AdditionalUnitFiles = RegRead("opt_AdditionalUnitFiles", "");
    this.opt_PathToDSParser = RegRead("opt_PathToDSParser", "");        
  } 
}

var gbl_DSParserOptions = null;
function DSParserOptions()
{
  if (gbl_DSParserOptions == null)
  {
    gbl_DSParserOptions = new ClassDSParserOptions();
    gbl_DSParserOptions.Load();
  }
  return gbl_DSParserOptions;
}


// ======== Секция для кода контролирующего поведение формы настроек ========

function DSParserOptionsForm_cx_cb_EnableAnalysisOut_OnChange(Sender)
{
  throw "Don't use this stub!"; 
}

function DSParserOptionsForm_cx_cb_EnableUseOut_OnChange(Sender)
{
  throw "Don't use this stub!";   
}

function DSParserOptionsForm_cx_btn_Ok_OnClick(Sender)
{
  throw "Don't use this stub!";
}

function DSParserOptionsForm_cx_label_AddMDSFiles_OnClick(Sender)
{
   throw "Don't use this stub!";
}

function DSParserOptionsForm_cx_label_AddUnitFiles_OnClick(Sender)
{
 throw "Don't use this stub!";      
}

function DSParserOptionsForm_cx_label_SelectPathToDSParser_OnClick(Sender)
{
  throw "Don't use this stub!";
}


// Заворачивает метод-обработчик событий класса в функцию
function ReturnObjectEventHandler(method, obj)
{
  return function(Sender) 
  {
    method.apply(obj, [Sender])
  };
}


// Обеспечивает работу формы настроек и сохранение результата работы с ней
function DSParserOptionsFormController()
{
  var m_Form = UserForms.DSParserOptionsForm;
  
  // Массив контролов формы, в которые вводятся регулярные выражения
  var m_arrRegExMemos = [
    m_Form.cx_memo_AnFltrIncl,
    m_Form.cx_memo_AnFltrExcl,
    m_Form.cx_memo_UseFltrIncl,
    m_Form.cx_memo_UseFltrExcl
  ];
  
  // Проверяет что заданы валидные регулярные выражения
  // Если нет, то подсвечивает ошибочное выражение и говорит про ошибку.
  // true - все выражения правильные, false - есть неправильные
  var CheckRegExInMemos = function()
  {
    for (idx in m_arrRegExMemos)
      with (m_arrRegExMemos[idx])      
        if (Enabled)
          try {
            MakeFltrRegExp(Lines.Text);             
          } catch (oEx) { 
            var oldColor = Style.Font.Color; 
            Style.Font.Color = 255; //clRed        
            aqDlg.ShowError(oEx.description);
            Style.Font.Color = oldColor;          
            return false;
          }
    return true;
  } 
  
  // Обработчик нажатия на кнопку ОК
  var OnClick_btn_Ok = function(Sender)
  {
    // проверяем что указан правильный путь к dsparser.jar
    with (m_Form.cx_edit_PathToDSParser)
      if (!FSO().FileExists(Text))
      {
        var oldColor = Style.Font.Color;
        Style.Font.Color = 255;// clRed
        aqDlg.ShowError("Нужно указать правильный путь к DSParser.jar!");
        Style.Font.Color = oldColor;
      }
    //
    if (CheckRegExInMemos()) {
      m_Form.ModalResult = mrOk;
    }    
  }
  
  // Обработчик изменения значения чекбокса "выводить инофрмацию о неизвестных идентификаторах"
  var OnChange_cb_EnableAnalysisOut = function(Sender)    
  {
    with(m_Form)
    {
      var isChecked = cx_cb_EnableAnalysisOut.Checked;
      cx_memo_AnFltrIncl.Enabled = isChecked;
      cx_lbl_AnFltrIncl.Enabled = isChecked;    
      cx_memo_AnFltrExcl.Enabled = isChecked;
      cx_lbl_AnFltrExcl.Enabled = isChecked; 
    }
  }
 
  // Обработчик изменения значения чекбокса "выводить инофрмацию о используемости идентификаторов" 
  var OnChange_cb_EnableUseOut = function(Sender)
  {
    with (m_Form)
    {
      var isChecked = cx_cb_EnableUseOut.Checked;
      cx_memo_UseFltrIncl.Enabled = isChecked;
      cx_lbl_UseFltrIncl.Enabled = isChecked;    
      cx_memo_UseFltrExcl.Enabled = isChecked;
      cx_lbl_UseFltrExcl.Enabled = isChecked;
      cx_lbl_PreSpin.Enabled = isChecked;
      cx_spin_UseThreshold.Enabled = isChecked;
      cx_lbl_PostSpin.Enabled = isChecked;    
    }
  }
  
  // Обработчик клика по лейблу "Добавить" проект  
  var OnClick_cx_label_AddMDSFiles = function(Sender)
  {
    with (m_Form.AddMDSFilesDialog)
      if (Execute())
        m_Form.cx_memo_AdditionalMDSFiles.Lines.Add(FileName); 
    
  }
  
  // Обработчик клика по лейблу "Добавить" модуль
  var OnClick_cx_label_AddUnitFiles = function(Sender)
  {
    with (m_Form.AddUnitFilesDialog)
      if (Execute())
        m_Form.cx_memo_AdditionalUnitFiles.Lines.Add(FileName);
  }
  
  var OnClick_cx_label_SelectPathToDSParser = function(Sender)
  {
    with (m_Form.FindDSParserDialog)
      if (Execute())
        m_Form.cx_edit_PathToDSParser.Text = FileName;
  }
  
  // Инициализация формы и привязка обработчиков событий
  var Init = function()
  { 
    with(m_Form)
    {
      ResetForm();
      //
      cx_spin_UseThreshold.Properties.PropertyByName("AssignedValues").MinValue = true;
      //
      // перенацеливаем обработчики Event'ов на методы объекта
      DSParserOptionsForm_cx_cb_EnableAnalysisOut_OnChange =
        ReturnObjectEventHandler(OnChange_cb_EnableAnalysisOut, this);
      DSParserOptionsForm_cx_cb_EnableUseOut_OnChange =
        ReturnObjectEventHandler(OnChange_cb_EnableUseOut, this);
      DSParserOptionsForm_cx_btn_Ok_OnClick = 
        ReturnObjectEventHandler(OnClick_btn_Ok, this);   
      DSParserOptionsForm_cx_label_AddMDSFiles_OnClick=
        ReturnObjectEventHandler(OnClick_cx_label_AddMDSFiles, this);
      DSParserOptionsForm_cx_label_AddUnitFiles_OnClick =
        ReturnObjectEventHandler(OnClick_cx_label_AddUnitFiles, this);
      DSParserOptionsForm_cx_label_SelectPathToDSParser_OnClick = 
        ReturnObjectEventHandler(OnClick_cx_label_SelectPathToDSParser, this);
       
                       
      // устанавливаем значения полей формы в соответствии с текущими настройками
      with (DSParserOptions())
      {
        cx_cb_EnableAnalysisOut.Checked = opt_IsShowAnalysisMessages;
        cx_memo_AnFltrIncl.Lines.Text = opt_AnFltrIncl;    
        cx_memo_AnFltrExcl.Lines.Text = opt_AnFltrExcl; 
        cx_cb_EnableUseOut.Checked = opt_IsShowUseMesages;
        cx_memo_UseFltrIncl.Lines.Text = opt_UseFltrIncl;
        cx_memo_UseFltrExcl.Lines.Text = opt_UseFltrExcl;    
        cx_spin_UseThreshold.Value = opt_UseThreshold;
        cx_memo_AdditionalMDSFiles.Lines.Text = opt_AdditionalMDSFiles;
        cx_memo_AdditionalUnitFiles.Lines.Text = opt_AdditionalUnitFiles;
        cx_edit_PathToDSParser.Text = opt_PathToDSParser;    
      }
    }    
      
    // дергаем обработчики чекбоксов чтобы дизейбленность контролов встала в соответствии с их значением
    OnChange_cb_EnableAnalysisOut();
    OnChange_cb_EnableUseOut();
  }
  
  // Показывает форму и обрабатывает результат работы с ней
  this.ShowAndUse = function()
  {
    var mResult = m_Form.ShowModal();
    //
    if (mResult == mrOk)
      with (m_Form) with(DSParserOptions())
      {
        opt_IsShowAnalysisMessages = cx_cb_EnableAnalysisOut.Checked;
        opt_AnFltrIncl = cx_memo_AnFltrIncl.Lines.Text;    
        opt_AnFltrExcl = cx_memo_AnFltrExcl.Lines.Text;
        opt_IsShowUseMesages = cx_cb_EnableUseOut.Checked;
        opt_UseFltrIncl = cx_memo_UseFltrIncl.Lines.Text;
        opt_UseFltrExcl = cx_memo_UseFltrExcl.Lines.Text;    
        opt_UseThreshold = cx_spin_UseThreshold.Value;
        opt_AdditionalMDSFiles = cx_memo_AdditionalMDSFiles.Lines.Text;
        opt_AdditionalUnitFiles = cx_memo_AdditionalUnitFiles.Lines.Text;
        opt_PathToDSParser = cx_edit_PathToDSParser.Text;
        // сохраняем опции (в реестре)
        Save();    
      }
  } 
  
  Init();
}

// ====== Пускальщик парсера ======

function DSParserRunner(sDSParserPath)
{
  var m_sDSParserPath = sDSParserPath; 
  if (!FSO().FileExists(m_sDSParserPath)) throw new Error("DSParser.jar не найден!");
  //var m_sDSParserPath = "C:\\Program Files\\Automated QA\\TestComplete 6\\Bin\\Extensions\\ScriptExtensions\\DSParser\\dsparser.jar";
  var m_sOutAnalysisFile = FSO().BuildPath(GetTempDir(), FSO().GetTempName());
  var m_sOutUsedFile = FSO().BuildPath(GetTempDir(), FSO().GetTempName()); 
  var m_sStdErrFile = FSO().BuildPath(GetTempDir(), FSO().GetTempName());
  var m_sStdOutFile = FSO().BuildPath(GetTempDir(), FSO().GetTempName());
  
  var m_arrMdsFiles = new Array();
  var m_arrUnitFiles = new Array();
  var m_iUseThreshold = 0;
  
  var m_sRunErrors = ""; 
  var m_sAnalysisMessages = "";
  var m_sUsedMessages = ""; 
  var m_bIsRunOk;

  this.AddMDSFile = function (sPathToMdsFile)
  {
    m_arrMdsFiles.push(sPathToMdsFile);
  }
  
  this.AddUnitFile = function (sPathToUnitFile)
  {
    m_arrUnitFiles.push(sPathToUnitFile);
  }
  
  this.SetUseThreshold = function (value)
  {
    m_iUseThreshold = value; 
  }
    
  // Формирует строку параметров
  var GetParamString = function()
  {    
    var sResArr = new Array();
    function AddParam(param, value)
    {
      // убираем из value переводы строки и обрамляющие разделители
      value = value.toString().replace(/^\s*([\s\S]*?)\s*$/gm, "$1").replace(/\r|\n/gm, "");
      if (value != "") {
        sResArr.push("--" + param + "=\"" + value + "\"");
      }
    }
    for (var idx in m_arrMdsFiles)
      AddParam("mds-file", m_arrMdsFiles[idx]);
    for (var idx in m_arrUnitFiles)
      AddParam("unit-file", m_arrUnitFiles[idx]);
    AddParam("use-threshold", m_iUseThreshold);
    AddParam("out-analysis", m_sOutAnalysisFile);
    AddParam("out-used", m_sOutUsedFile);
    //
    return sResArr.join(" ");    
  }
  
  // запускает парсер с нужными параметрами
  var StartParser = function()
  {      
    // настраиваем экземпляр WshShell. Текущий каталог - тот где лежит парсер.
    var oWshShell = new ActiveXObject("WScript.Shell");
    var oDSParserFile = FSO().GetFile(m_sDSParserPath);
    oWshShell.CurrentDirectory = oDSParserFile.ParentFolder;
       
    // формируем командную строку
    var sCommandLine =
      "cmd /c java -jar " +
      "\"" + m_sDSParserPath + "\" " +
      GetParamString() + " " +
      "1>\"" + m_sStdOutFile + "\" " +
      "2>\"" + m_sStdErrFile + "\"";
      
    return oWshShell.Exec(sCommandLine);
  }
  
  //   Вернуть ошибки парсинга
  this.GetRunErrors = function()
  {
    return m_sRunErrors;
  }
  
  // Вытаскивает результаты работы парсера в поля объекта
  var SetResult = function()
  {
    var oTextFile;
    oTextFile = FSO().OpenTextFile(m_sOutAnalysisFile, FOR_READING);
    m_sAnalysisMessages = oTextFile.ReadAll();
    oTextFile.Close();
    FSO().DeleteFile(m_sOutAnalysisFile);
    oTextFile = FSO().OpenTextFile(m_sOutUsedFile, FOR_READING);
    m_sUsedMessages = oTextFile.ReadAll();
    oTextFile.Close();
    FSO().DeleteFile(m_sOutUsedFile);
  }
  
  this.IsRunOk = function()
  {
    return m_bIsRunOk;
  }
  
  // Запускает парсер и ждет его выполнения 
  this.Run = function(aHandler)
  {
    var oWshScriptExec = StartParser();
    while (!FSO().FileExists(m_sStdOutFile) || !FSO().FileExists(m_sStdErrFile))
      aqUtils.Delay(100);
    var oStdOut = FSO().OpenTextFile(m_sStdOutFile, FOR_READING);
    var oStdErr = FSO().OpenTextFile(m_sStdErrFile, FOR_READING);
    try
    {   
      while (oWshScriptExec.Status == WSH_RUNNING)
      {
        if (aHandler != null)
          while (!oStdOut.atEndOfStream)
            aHandler(oStdOut.ReadLine());         
        aqUtils.Delay(100);      
      }
        
      m_bIsRunOk = (oWshScriptExec.ExitCode == 0);
     
      if (m_bIsRunOk) 
        SetResult();     
      else
        m_sRunErrors = oStdErr.ReadAll();
    } finally {
      oStdOut.Close();
      FSO().DeleteFile(m_sStdOutFile); 
      oStdErr.Close();  
      FSO().DeleteFile(m_sStdErrFile);
    }
  }
  
  this.GetAnalysisMessages = function()
  {
    return m_sAnalysisMessages;
  }
  
  this.GetUsedMessages = function()
  {
    return m_sUsedMessages;
  }
}

// ======== Код увязывающий все в одно целое  ========

function ParserProcessor()
{
  var m_Options = DSParserOptions();
  
  var m_DSParserRunner;
  
  
  // Инициализирует парсер нужными значениями
  var InitParser = function()
  {
    m_DSParserRunner = new DSParserRunner(m_Options.opt_PathToDSParser);
    m_DSParserRunner.AddMDSFile(Project.FileName);
    m_DSParserRunner.SetUseThreshold(m_Options.opt_UseThreshold);
    // добавляем дополнительные проекты     
    var arrMDSFiles = m_Options.opt_AdditionalMDSFiles.split(END_OF_LINE);
    if (arrMDSFiles.length > 0)
      for (var idx in arrMDSFiles)
        m_DSParserRunner.AddMDSFile(arrMDSFiles[idx]);
    // добавляем дополнительные модули
    var arrUnitFiles = m_Options.opt_AdditionalUnitFiles.split(END_OF_LINE);
    if (arrUnitFiles.length > 0)
      for (var idx in arrUnitFiles)
        m_DSParserRunner.AddUnitFile(arrUnitFiles[idx]);        
  }
  
  // Выполняет парсинг
  var Parse = function()
  {
    try {
      Indicator.Show(); 
      m_DSParserRunner.Run();// function(str) { Indicator.Clear(); Indicator.PushText(str)} );
    } finally {
      Indicator.Hide();
    }       
  }
  
  // Фильтрует переданный текст, оставляя только те строки которые соответствуют первому
  // регулярному выражению и удаляя те, которые соответствуют второму 
  var FilterStr = function(str, sInclFilter, sExclFilter)
  {
    if (MakeFltrRegExp(sInclFilter) != null)
      str = str.replace(
        MakeFltrRegExp("(" + sInclFilter + ")|(.*[\\r\\n]*)"),
        "$1" );
    if (MakeFltrRegExp(sExclFilter) != null)
      str = str.replace(
        MakeFltrRegExp(sExclFilter + "[\\r\\n]*"),
        "");
    return str;
  }
  
  // Показывает результаты анализа корректности использования идентификаторов
  var ShowAnalysisResult = function()
  {
    var sAnResult = m_DSParserRunner.GetAnalysisMessages();
    sAnResult = FilterStr(sAnResult, m_Options.opt_AnFltrIncl, m_Options.opt_AnFltrExcl);
    with (UserForms.DSAnResultForm)
    {
      ResetForm();
      cx_memo_AnResult.Lines.Text = sAnResult;
      Show();
    }
  }
  
  // Показывает инфомарцию по использованию идентификаторов
  var ShowUsedResult = function()
  {
      var sUsedResult = m_DSParserRunner.GetUsedMessages();
      sAnResult = FilterStr(sUsedResult, m_Options.opt_UseFltrIncl, m_Options.opt_UseFltrExcl);
      with (UserForms.DSUsedResultForm)
      {
        ResetForm();
        cx_memo_UsedResult.Lines.Text = sAnResult;
        Show();
      }
  }  
  
  // Выводит результаты в зависимости от успешности работы парсера
  var EmitResult = function()
  {
    if (m_DSParserRunner.IsRunOk())
    {
      if (m_Options.opt_IsShowAnalysisMessages)
        ShowAnalysisResult();
      if (m_Options.opt_IsShowUseMesages)
        ShowUsedResult();
    }
    else
    {
      //aqDlg.ShowError("Парсинг завершился с ошибкой!");
      with (UserForms.DSParserErrorsForm) 
      {
        ResetForm();
        cx_Memo_ParseErrors.Lines.Text = m_DSParserRunner.GetRunErrors();
        //cxListBox1.Items.Text = m_DSParserRunner.GetRunErrors();
        Show();
      }
    }
  }
  
  // Сделать все как надо
  this.Do = function()
  {
    InitParser();
    Parse();
    EmitResult();
  }
}


// ====== Обработчики нажатий кнопок на тулбаре ======
function ShowOptions()
{   
  try {
    var o_DSPOFC = new DSParserOptionsFormController();
    o_DSPOFC.ShowAndUse();
  } catch(oEx) {
    aqDlg.ShowError("Вылетело исключение: " + oEx.description);
  }
} 

function RunParser()
{  
  try {
    var o_PP = new ParserProcessor();
    o_PP.Do();
  } catch(oEx) {
    aqDlg.ShowError("Вылетело исключение: " + oEx.description);
  }
}