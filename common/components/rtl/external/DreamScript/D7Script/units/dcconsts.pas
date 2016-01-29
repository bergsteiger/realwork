{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcconsts;

interface

{$I dc.inc}

{$IFDEF WIN32}
const
  SlashString = '\';
{$ELSE}
const
  SlashString = '/';
{$ENDIF}    

{$IFDEF D3}
resourcestring
{$ELSE}
const
{$ENDIF}

{$IFDEF RUSSIAN_LANGUAGE}
  {$I dclang_rus.inc} {English}
{$ELSE}
  {$IFDEF GERMAN_LANGUAGE}
    {$I dclang_ger.inc}  {German}
  {$ELSE}
    {$IFDEF SPANISH_LANGUAGE}
      {$I dclang_spa.inc}  {Spanish}
    {$ELSE}
      {$I dclang_eng.inc}  {Russian}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}


{-------------------------------------------------------------------------}
{ Don't nationalize this section }
const

  SCopyrightDream  = 'Copyright (c) 1997-2001 Altium Ltd.';
  STrueText = 'True';
  SFalseText = 'False';

  //---------------------- FileNames --------------------

  SUnitDFM = 'unit.dfm';
  SUnitPas = 'unit.pas';
  SUnitVbs = 'unit.vbs';
  SUnitJs = 'unit.js';
  SFileTxt = 'file.txt';
  SUnitPerl = 'unit.pl';
  SUnitPython = 'unit.py';
  StextSql = 'untitled.sql';
  StextHTML = 'index.html';
  SFileWorkSpace = 'worksp.iws';
  SFileProject = 'project.ipr';

  SLangVBScript = 'VBScript';
  SLangJavaScript = 'JavaScript';
  SLangJavaScriptEncode = 'JavaScriptEncode';
  SLangVBScriptEncode = 'VBScriptEncode';
  SLangPythonScript = 'PythonScript';
  SLangPerlScript = 'PerlScript';
  SLangEnableScript = 'EnableScript';
  SLangDelphiScript = 'DelphiScript';

  SLangDelphi = 'Delphi';
  SLangCpb = 'C++ Builder';
  SLangNone = 'None';
  SLangCustom = 'Custom';
  SLangClipper = 'Clipper';

  SExtPy = 'py';
  SExtBas = 'bas';

  //--------------------- Extensions --------------

  SExtDFM = 'dfm';
  SExtPas = 'pas';
  SExtJS = 'js';
  SExtPL = 'pl';
  SExtCGI = 'cgi';
  SExtVBS = 'vbs';
  SExtSQL = 'sql';
  SExtHTM = 'htm';
  SExtHTML = 'html';
  SExtTXT = 'txt';
  SExtCpp = 'cpp';
  SExtJsEncode = 'jse';
  SExtVbsEncode = 'vbe';
  SExtPython = 'py';
  SExtWorkSpace = '.iws';

  // ------------------- Registry Keys ---------------

  SVarWSpaceFileName = 'WorkSpace\FileName';
  SVarWSpaceFilerID = 'WorkSpace\FilerID';
  SVarWSpaceRecent = 'WorkSpace\RecentInfos';
  SDreamControlsVersion = '4.12';
  SDreamRegKey = 'Software\Altium (Dream VCL)\';
  SDefaultRegKey = SDreamRegKey + 'Instant Report\Version ' + SDreamControlsVersion;
  SFormRegPrefix = 'Forms\';

  //--------------------- Registration variable names --------------

  SParKeyboardInitName = 'KeyboardClass.InitName';
  SParKeyboardInitProc = 'KeyboardClass.InitProc';
  SParKeyboardID = 'KeyboardClass.ID';

  SParTextStylesInitName = 'TextStylesClass.InitName';
  SParTextStylesInitProc = 'TextStylesClass.InitProc';
  SParTextStylesID = 'TextStylesClass.ID';

  SParFillProjectProc = 'FillProject.Proc';
  SParFillProjectProcAddr = 'FillProject.ProcAddr';

  SAssignVerbProc = 'AssignVerb.VerbProc';
  SAssignIdent = 'AssignVerb';

  SVerbGetState = 'Verb.GetState';
  SVarVerbExecute = 'Verb.Execute';
  SVerbName = 'Verb.Name';

  SOpenExtension = 'Open.Extension';
  SOpenDescription = 'Open.Description';

  SCodeDesExtension = 'CodeDes.Extension';
  SCodeDesForUnit = 'CodeDes.ForUnit';

  SSaveIDEObjectClass = 'Save.IDEObjectClass';
  SSaveExtension = 'Save.Extension';
  SSaveDescription = 'Save.Description';

  SNewFileName = 'New.FileName';
  SNewResName = 'New.ResName';
  SNewPageCaption = 'New.PageCaption';
  SNewCaption = 'New.Caption';

  SParRegisterAction = 'RegisterAction';
  SParCategoryName = 'CategoryName';
  SParResourceClass = 'ResourceClass';
  SVerbFileNew = 'File.New';

  SOptionFormID = 'OptionFormID';
  SOptionFormOrder = 'OptionFormOrderID';

  SCodeTemplateLang = 'CodeTemplates.Lang';
  SCodeTemplatesProc = 'CodeTemplates.Proc';

  //--------------------- Verb names -------------------------------

  SViewProjectMan = 'View.ProjectManager';
  SVerbNameUsesRetriever = 'Tools.UsesRetriever';
  SPropInstanceName = 'InstanceName';
  SVerbHidden = 'Hidden';

  //------------------------Designer-------------------------------

  cFormWidth = 500;
  cFormHeight = 350;

  SDreamActions = 'DreamActions';

  SPalDream = 'Dream Company';
  SPalDreamTree = 'Dream Tree';
  SPalDreamMemo = 'Dream Memo';
  SPalDreamEdit = 'Dream Edit';

  SPalDreamInfoTree = 'Dream InfoTree';
  SPalDreamInfoCtrls = 'Dream InfoCtrls';
  SPalDreamInfoSets = 'Dream InfoSets';
  SPalDream2000 = 'Dream 2000';
  SPalDreamDes = 'Dream Designer';

  {=========================================================================}

  SCheckImages = '__CheckImages';

  STxtStWhiteSp = 'Whitespace';
  STxtStStr = 'String';
  STxtStComment = 'Comment';
  STxtStIdent = 'Identifier';
  STxtStInteger = 'Integer';
  STxtStFloat = 'Float';
  STxtStResWords = 'Reserved words';
  STxtStDelims = 'Delimiters';
  STxtStDefines = 'Defines';
  STxtStAsm = 'Assembler';
  STxtStHtmlTag = 'Html tags';
  STxtStHtmlParams = 'Html params';
  STxtStBreakPnt = 'BreakPoint';
  STxtStErrorLn = 'Error line';
  STxtStMarkedBlock = 'Marked Block';
  STxtStSearchMatch = 'Search Match';
  STxtStUrl = 'Url';
  STxtStEmphasis = 'Emphasis';
  STxtStSystemVariable = 'System Variable';
  STxtStScriptWhiteSp = 'Script Whitespace';
  STxtStScriptDelimiters = 'Script Delimiters';
  STxtStScriptComment = 'Script Comment';
  STxtStScriptString = 'Script String';
  STxtStScriptNumber = 'Script Number';
  STxtStScriptResWord = 'Script ResWord';

  //----------------Hot spots------------------

  sUrlMailTo = 'MAILTO:';
  sUrlWWW = 'WWW.';
  sUrlHttp = 'HTTP://';
  sUrlFtp = 'FTP://';
  sUrlGopher = 'GOPHER://';

  SBeginSkip = '//BeginSkipConst';
  SEndSkip = '//EndSkipConst';
  SPasExt = '*.pas';
  sResourcedComment = 'don''t resource';
  sDirectory = 'Directory :  ';
  SNotprocessedfiles = 'Not processed files:';

  SAutoExpand = 'AUTOEXPAND';
  SAutoCollapse = 'AUTOCOLLAPSE';
  SAlwaysExpand = 'ALWAYSEXPAND';
  SNeverExpand = 'NEVEREXPAND';
  SNeverShow = 'NEVERSHOW';
  SAlReadOnly = 'READONLY';

  SFieldUnknown = '<Unknown>';

  sDCNotAvailable = '(Not available)';
  SDCCannotCreateName = 'Cannot create a method for an unnamed component';

implementation

end.
