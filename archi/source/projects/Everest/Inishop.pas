unit IniShop;

{ $Id: Inishop.pas,v 1.26 2016/04/27 09:33:31 lukyanets Exp $ }

// $Log: Inishop.pas,v $
// Revision 1.26  2016/04/27 09:33:31  lukyanets
// «апоминаем текущий каталог сбоку
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.25  2016/04/26 12:46:13  lukyanets
// ¬ыключаем переключени€ текущего каталога
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.24  2011/05/21 06:20:52  dinishev
// Bug fix: не компилировалс€ Ёверест.
//
// Revision 1.23  2009/06/11 12:56:50  dinishev
// ѕереход на метку
//
// Revision 1.22  2009/06/05 08:14:38  dinishev
// CleanUp
//
// Revision 1.21  2004/12/23 11:47:07  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.20  2004/07/13 09:23:56  fireton
// - add: прикрутка автозамены в Ёверест
//
// Revision 1.19  2002/10/15 11:43:48  law
// - new action: acAdjustMargin.
//
// Revision 1.18  2002/09/18 12:37:21  law
// - new behavior: добавлена возможность просмотра документа как в Web.
//
// Revision 1.17  2002/04/23 15:46:44  law
// no message
//
// Revision 1.16  2001/04/11 11:58:18  law
// - new behavior: сделано добавление всех открывавшихс€ файлов в MRU, а не только 20-ти последних.
//
// Revision 1.15  2001/03/23 13:29:28  law
// Ёверест 1.0.0.91.
//
// Revision 1.14  2001/02/21 12:58:24  law
// - удалены ненужные панели и элементы.
//
// Revision 1.13  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

{$I evDefine.inc}

interface

uses
  Dialogs
  ;

type
  PIniRecord = ^TIniRecord;
 TIniRecord = record
                {System of windows}
                 MaxOnStart     : Boolean;
                 MaxEditor      : Boolean;
                {Text Editor}
                Zoom             : LongInt;
                 ShowSpecial    : Boolean;
                 PersistentBlocks : Boolean;
                 WebStyle       : Boolean;  
                 ShowHRuler1    : Boolean;
                 ShowHRuler2    : Boolean;
                 ShowVRuler1    : Boolean;
                 ShowVRuler2    : Boolean;
                 ShowSubPanel1  : Boolean;
                 ShowSubPanel2  : Boolean;
               SubPanelWidth1   : LongInt;
               SubPanelWidth2   : LongInt;
               {Jump}
               SrchSubID        : LongInt;
                 {Path}
               OpenIniPath      : string;
               SaveIniPath      : string;
               StylesIniName    : string;
                 {$IfDef evSpellChecker}
               DictIniName      : string;
                 {$EndIf evSpellChecker}
                 OpenDialog     : TOpenDialog;
                 SaveDialog     : TOpenDialog;
                 {$IfNDef evExternalProduct}
                 StrictNSRC     : Boolean;
                 {$EndIf  evExternalProduct}
                 AdjustMargin   : Boolean;

                 Preferences : record
                  View : record
                   ShowDocumentParts : Boolean;
                   PrintPreview      : Boolean;
                  end;// View
                 end;//Preferences

                 Confirmations  : record
                  AskDocumentSave : Boolean;
                 end;{Confirmations}

                 Dialogs : record
                  Border : record
                 Width  : LongInt;
                 Height : LongInt;
                  end;//Border
                 end;//Dialogs
                 {$IfNDef evExternalProduct}
                 Debug          : record
                  Paint : Boolean;
                 end;{Debug}
                 {$EndIf  evExternalProduct}
                 DontCheckThreeLetterWords: Boolean;
                 OrphoDotIsSeparator: Boolean
               end;

  var
   IniRec : PIniRecord = nil;

const
   PrefSectName         = 'Preferences';
   StatSectName         = 'Statistic';
   DocWinDefault        = 'DocWinDefault';

   FindHistorySectName  = 'DictFindHistory';
   DictFormPlaceName    = 'DictFormPlace';
   DictMDIFormPlaceName = 'DictMDIFormPlace';

   TextSearchSectName   = 'TextSearch';
   FindSectName         = 'FindList';
   ReplaceSectName      = 'ReplaceList';


 procedure SetIniRecord;
 procedure SaveIniRecord;

 function ExecuteSaveDialog(const aDialog: TSaveDialog): Boolean;
 function ExecuteOpenDialog(const aDialog: TOpenDialog): Boolean;

implementation

uses
    SysUtils,
    l3IniFile,

    vtDialogs
    ;

const
   ConfirmationsSectName = 'Confirmations';
   DebugSectName = 'Debug';
   MaxHistoryCount = 70;

procedure SetIniRecord;
begin
 if UserConfig = nil then Exit;
 if IniRec = nil then
 begin
  New(IniRec);
  FillChar(IniRec^, SizeOf(TIniRecord), 0);
 end;

 with IniRec^ do
 begin
  UserConfig.Section := PrefSectName;

  MaxOnStart    := UserConfig.ReadParamBoolDef('MaxOnStart', False);
  MaxEditor     := UserConfig.ReadParamBoolDef('MaxEditor', MaxOnStart);
  Zoom          := UserConfig.ReadParamIntDef ('EdZoom', 100);
  ShowSpecial   := UserConfig.ReadParamBoolDef ('ShowSpecial', false);
  PersistentBlocks := UserConfig.ReadParamBoolDef ('PersistentBlocks', false);
  WebStyle := UserConfig.ReadParamBoolDef ('WebStyle', false);

  ShowHRuler1   := UserConfig.ReadParamBoolDef('ShowHRuler1', true);
  ShowHRuler2   := UserConfig.ReadParamBoolDef('ShowHRuler2', true);
  ShowVRuler1   := UserConfig.ReadParamBoolDef('ShowVRuler1', False);
  ShowVRuler2   := UserConfig.ReadParamBoolDef('ShowVRuler2', False);
  ShowSubPanel1 := UserConfig.ReadParamBoolDef('ShowSubPanel1', true);
  ShowSubPanel2 := UserConfig.ReadParamBoolDef('ShowSubPanel2', true);
  SubPanelWidth1:= UserConfig.ReadParamIntDef ('SubPanelWidth1', 24);
  SubPanelWidth2:= UserConfig.ReadParamIntDef ('SubPanelWidth2', 24);
  StylesIniName := UserConfig.ReadParamStrDef ('StylesIniName', '');
  {$IfDef evSpellChecker}
  DictIniName := UserConfig.ReadParamStrDef ('DictIniName', '');
  {$EndIf evSpellChecker}
  {$IfNDef evExternalProduct}
  StrictNSRC := UserConfig.ReadParamBoolDef('StrictNSRC', false);
  {$EndIf  evExternalProduct}
  AdjustMargin := UserConfig.ReadParamBoolDef('AdjustMargin', true);
  if (OpenDialog <> nil) then
   OpenDialog.InitialDir := UserConfig.ReadParamStrDef ('OpenIniPath', GetCurrentDir);
  if (SaveDialog <> nil) then
   SaveDialog.InitialDir := UserConfig.ReadParamStrDef ('SaveIniPath', GetCurrentDir);

  DontCheckThreeLetterWords := UserConfig.ReadParamBoolDef('DontCheckThreeLetterWords', False);
  OrphoDotIsSeparator := UserConfig.ReadParamBoolDef('OrphoDotIsSeparator', False);

  SrchSubID := UserConfig.ReadParamIntDef ('SrchSubID', -1);

  UserConfig.Section := 'Preferences\View';
  Preferences.View.ShowDocumentParts := UserConfig.ReadParamBoolDef ('ShowDocumentParts', false);
  Preferences.View.PrintPreview := UserConfig.ReadParamBoolDef ('PrintPreview', false);

  UserConfig.Section := 'OpenHistory';
  if (OpenDialog <> nil) then
   UserConfig.ReadParamList('OpenHistory', OpenDialog.HistoryList, MaxHistoryCount);
  UserConfig.Section := 'SaveHistory';
  if (SaveDialog <> nil) then
   UserConfig.ReadParamList('SaveHistory', SaveDialog.HistoryList, MaxHistoryCount);

  UserConfig.Section := ConfirmationsSectName;
  Confirmations.AskDocumentSave := UserConfig.ReadParamBoolDef('AskDocumentSave', true);

  UserConfig.Section := 'Dialogs\Border';
  Dialogs.Border.Height := UserConfig.ReadParamIntDef('Height', 0);
  Dialogs.Border.Width := UserConfig.ReadParamIntDef('Width', 0);

  {$IfNDef evExternalProduct}
  UserConfig.Section := DebugSectName;
  Debug.Paint := UserConfig.ReadParamBoolDef('Paint', false);
  {$EndIf  evExternalProduct}
 end;{with IniRec^}
end;

procedure SaveIniRecord;
var
 l_Path : string;
begin
 if UserConfig = nil then Exit;
 if IniRec = nil then Exit;
 with IniRec^ do
 begin
  UserConfig.Section := PrefSectName;
  UserConfig.WriteParamBool('MaxOnStart' , MaxOnStart);
  UserConfig.WriteParamBool('MaxEditor' , MaxEditor);
  UserConfig.WriteParamInt ('EdZoom', Zoom);
  UserConfig.WriteParamBool ('ShowSpecial', ShowSpecial);
  UserConfig.WriteParamBool ('WebStyle', WebStyle);

  UserConfig.WriteParamBool('ShowHRuler1',   ShowHRuler1);
  UserConfig.WriteParamBool('ShowHRuler2',   ShowHRuler2);
  UserConfig.WriteParamBool('ShowVRuler1',   ShowVRuler1);
  UserConfig.WriteParamBool('ShowVRuler2',   ShowVRuler2);
  UserConfig.WriteParamBool('ShowSubPanel1', ShowSubPanel1);
  UserConfig.WriteParamInt ('SubPanelWidth1',SubPanelWidth1);
  UserConfig.WriteParamBool('ShowSubPanel2', ShowSubPanel2);
  UserConfig.WriteParamInt ('SubPanelWidth2',SubPanelWidth2);
  {$IfNDef evExternalProduct}
  UserConfig.WriteParamBool('StrictNSRC', StrictNSRC);
  {$EndIf  evExternalProduct}
  UserConfig.WriteParamBool('AdjustMargin', AdjustMargin);
  UserConfig.WriteParamBool('DontCheckThreeLetterWords', DontCheckThreeLetterWords);
  UserConfig.WriteParamBool('OrphoDotIsSeparator', OrphoDotIsSeparator);

  if (OpenDialog <> nil) then
  begin
   l_Path := ExtractFilePath(OpenDialog.FileName);
   if (l_Path = '') then
    l_Path := OpenDialog.InitialDir;
   UserConfig.WriteParamStr ('OpenIniPath', l_Path);
  end;{OpenDialog <> nil}
  if (SaveDialog <> nil) then
  begin
   l_Path := ExtractFilePath(SaveDialog.FileName);
   if (l_Path = '') then
    l_Path := SaveDialog.InitialDir;
    UserConfig.WriteParamStr ('SaveIniPath', ExtractFilePath(SaveDialog.FileName));
   end;{SaveDialog <> nil}
  UserConfig.WriteParamStr ('StylesIniName', StylesIniName);
  {$IfDef evSpellChecker}
  UserConfig.WriteParamStr ('DictIniName', DictIniName);
  {$EndIf evSpellChecker}

  UserConfig.WriteParamInt('SrchSubID', SrchSubID);

  UserConfig.Section := 'OpenHistory';
  if (OpenDialog <> nil) then
   UserConfig.WriteParamList('OpenHistory', OpenDialog.HistoryList, MaxHistoryCount);

  UserConfig.Section := 'SaveHistory';
  if (SaveDialog <> nil) then
   UserConfig.WriteParamList('SaveHistory', SaveDialog.HistoryList, MaxHistoryCount);

  UserConfig.Section := ConfirmationsSectName;
  UserConfig.WriteParamBool('AskDocumentSave', Confirmations.AskDocumentSave);

  UserConfig.Section := 'Dialogs\Border';
  UserConfig.WriteParamInt('Height', Dialogs.Border.Height);
  UserConfig.WriteParamInt('Width', Dialogs.Border.Width);

  UserConfig.Section := 'Preferences\View';
  UserConfig.WriteParamBool('ShowDocumentParts', Preferences.View.ShowDocumentParts);
  UserConfig.WriteParamBool('PrintPreview', Preferences.View.PrintPreview);

  {$IfNDef evExternalProduct}
  UserConfig.Section := DebugSectName;
  UserConfig.WriteParamBool('Paint', Debug.Paint);
  {$EndIf  evExternalProduct}
 end;{with IniRec^}
 Dispose(IniRec);
 IniRec := nil;
end;

function ExecuteOpenDialog(const aDialog: TOpenDialog): Boolean;
begin
 if aDialog.InitialDir = '' then
  aDialog.InitialDir := IniRec.OpenIniPath;
 Result := aDialog.Execute;
 if Result then
 begin
  IniRec.OpenIniPath := ExtractFileDir(aDialog.Files[aDialog.Files.Count - 1]);
  aDialog.InitialDir := '';
 end;
end;

function ExecuteSaveDialog(const aDialog: TSaveDialog): Boolean;
begin
 if aDialog.InitialDir = '' then
  aDialog.InitialDir := IniRec.SaveIniPath;
 Result := aDialog.Execute;
 if Result then
 begin
  IniRec.SaveIniPath := ExtractFileDir(aDialog.Files[aDialog.Files.Count - 1]);
  aDialog.InitialDir := '';
 end;
end;

function IniSaveOpenDialogExecutor(const aDlg : TOpenDialog; aFileDlgMode : TFileDlgMode): Boolean;
begin
 aDlg.Options := aDlg.Options + [ofNoChangeDir];
 case aFileDlgMode of
  fdmSave: Result := ExecuteSaveDialog(aDlg as TSaveDialog);
  fdmOpen: Result := ExecuteOpenDialog(aDlg);
 else
  Result := False;
  Assert(False);
 end;
end;

initialization
 vtSetSaveOpenDialogExecutor(IniSaveOpenDialogExecutor);

end.
