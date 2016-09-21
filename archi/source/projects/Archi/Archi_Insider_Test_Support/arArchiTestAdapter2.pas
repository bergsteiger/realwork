unit arArchiTestAdapter2;

{$Include w:\archi\source\projects\Archi\ProjectDefine.inc}

interface

uses
 Controls,
 ObjList;

const
 arHyperLinkID = Ord(ddHyperLink);

{$If defined(InsiderTest) AND defined(nsTest)}
procedure ArMakeChangeDoc;
procedure ArInsertDocChanges;
procedure ArIniRecSetZoom(aZoom: Integer);
function ArIniRecGetZoom: Integer;
procedure ArShowMailWindow(aIndex: Integer);
procedure AcEndDragAndDrop(const aControl: TControl);
procedure AcSetExpiredStyle(anID: Integer);
procedure acCorrectRelatedText(aFileName: AnsiString);
procedure AcMakePreview;
procedure AcSaveDocAs(const aFileName: AnsiString);
procedure AcSaveTextAs(const aFileName: AnsiString);
procedure ArClearTemplateStorage;
procedure AcMainFormFormClose;
procedure AcClearConfig(aFileName: AnsiString);
{$IfEnd} //InsiderTest AND nsTest

implementation

uses
 Editwin,
 DragData,
 DocIntf,
 CustEditWin,
 SrchWin,

 Messages,

 Forms,
 Classes,
 SysUtils,

 Main,

 VMailWin,

 arDBUtils,

 l3Chars,
 l3FileUtils,
 l3LongintList,

 {$IFDEF nsTest}
 KTestRunner,
 {$ENDIF nsTest}

 arTemplateProcessor,

 ddRelPublish,
 ddAppConfig,

 evCommonUtils,

 IniShop,
 UsersMacro
 {$If Defined(AppClientSide) AND NOT Defined(Nemesis)}
 , ddClientBaseEngine
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(Nemesis)
 , daDataProviderParams;

{$If defined(InsiderTest) AND defined(nsTest)}
// unit methods

procedure acCorrectRelatedText(aFileName: AnsiString);
var
 l_Total      : Integer;
 l_Worked     : Integer;
 l_Missed     : Integer;
 l_MissedList : TStrings;
 l_LockedList : Tl3LongintList;
begin
 l_MissedList:= TStringList.Create;
 try
  l_LockedList:= Tl3LongintList.Make;
  try
   with TddRelPublishCorrector.Create do
   try
    Execute(aFileName, l_Total, l_worked, l_Missed, l_MissedList, l_LockedList, nil, nil);
   finally
    Free;
   end;
  finally
   FreeAndNil(l_LockedList);
  end;
 finally
  FreeAndNil(l_MissedList);
 end;
end;

procedure ArMakeChangeDoc;
//#UC START# *4E4B6340031F_4E4B5F29031C_var*
//#UC END# *4E4B6340031F_4E4B5F29031C_var*
begin
//#UC START# *4E4B6340031F_4E4B5F29031C_impl*
 Macros_MakeChangeDoc;
//#UC END# *4E4B6340031F_4E4B5F29031C_impl*
end;//ArMakeChangeDoc

procedure ArInsertDocChanges;
//#UC START# *4E4B637A01C7_4E4B5F29031C_var*
//#UC END# *4E4B637A01C7_4E4B5F29031C_var*
begin
//#UC START# *4E4B637A01C7_4E4B5F29031C_impl*
 Macros_InsertDocChanges;
//#UC END# *4E4B637A01C7_4E4B5F29031C_impl*
end;//ArInsertDocChanges

procedure ArIniRecSetZoom(aZoom: Integer);
//#UC START# *4E83092C0076_4E4B5F29031C_var*
//#UC END# *4E83092C0076_4E4B5F29031C_var*
begin
//#UC START# *4E83092C0076_4E4B5F29031C_impl*
 IniRec.Zoom := aZoom;
//#UC END# *4E83092C0076_4E4B5F29031C_impl*
end;//ArIniRecSetZoom

function ArIniRecGetZoom: Integer;
//#UC START# *4E83095902EB_4E4B5F29031C_var*
//#UC END# *4E83095902EB_4E4B5F29031C_var*
begin
//#UC START# *4E83095902EB_4E4B5F29031C_impl*
 Result := IniRec.Zoom;
//#UC END# *4E83095902EB_4E4B5F29031C_impl*
end;//ArIniRecGetZoom

procedure ArShowMailWindow(aIndex: Integer);
//#UC START# *4F0C276F03DC_4E4B5F29031C_var*
//#UC END# *4F0C276F03DC_4E4B5F29031C_var*
begin
//#UC START# *4F0C276F03DC_4E4B5F29031C_impl*
 with TViewMailWin.Create(Application.MainForm) do
  SetMessage(aIndex);
//#UC END# *4F0C276F03DC_4E4B5F29031C_impl*
end;//ArShowMailWindow

procedure AcEndDragAndDrop(const aControl: TControl);
//#UC START# *4F0C37850322_4E4B5F29031C_var*
var
 l_Message: TMessage;
//#UC END# *4F0C37850322_4E4B5F29031C_var*
begin
//#UC START# *4F0C37850322_4E4B5F29031C_impl*
{$IFDEF InsiderTest}
 with (aControl as TCustomEditorWindow) do
 begin
  TDragDataSupport.Instance.DragDataType := arHyperLinkID;
  TDragDataSupport.Instance.AnswerData := @DDHLink;
  DDHLink.Family := DocFamily;
  DDHLink.Doc := CurDocument.DocID;
  WMDropAccepted(l_Message);
  TDragDataSupport.Instance.Stop(True);
 end; // with (aControl as TCustomEditorWindow) do
{$ENDIF InsiderTest}
//#UC END# *4F0C37850322_4E4B5F29031C_impl*
end;//AcEndDragAndDrop
{$IfEnd} //InsiderTest AND nsTest

procedure AcSetExpiredStyle(anID: Integer);
//#UC START# *4F22AE6C0165_4E4B5F29031C_var*
//#UC END# *4F22AE6C0165_4E4B5F29031C_var*
begin
//#UC START# *4F22AE6C0165_4E4B5F29031C_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 with (MainForm.ActiveMDIChild as TCustomEditorWindow) do
  evSetExpiredStyle(CurEditor, anID);
//#UC END# *4F22AE6C0165_4E4B5F29031C_impl*
end;//AcSetExpiredStyle

{$If defined(InsiderTest) AND defined(nsTest)}
procedure AcMakePreview;
//#UC START# *530B2FD003B4_4E4B5F29031C_var*
//#UC END# *530B2FD003B4_4E4B5F29031C_var*
begin
//#UC START# *530B2FD003B4_4E4B5F29031C_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TCustomEditorWindow).MakePreview;
//#UC END# *530B2FD003B4_4E4B5F29031C_impl*
end;//AcMakePreview

procedure AcSaveDocAs(const aFileName: AnsiString);
//#UC START# *537075A70219_4E4B5F29031C_var*
//#UC END# *537075A70219_4E4B5F29031C_var*
begin
//#UC START# *537075A70219_4E4B5F29031C_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TSearchWin).DoSaveDocsList2File(aFileName);
//#UC END# *537075A70219_4E4B5F29031C_impl*
end;//AcSaveDocAs

procedure AcSaveTextAs(const aFileName: AnsiString);
//#UC START# *537D965101BA_4E4B5F29031C_var*

 function lp_Ext2FilterIndex: Integer;
 var
  l_Ext: TFileName;
 begin
  Result := ftDefault;
  l_Ext := ExtractFileExt(aFileName);
  if l_Ext = '.evd' then
   Result := ftEverest
  else
   if l_Ext = '.doc' then
    Result := ftANSIText
   else
    if l_Ext = '.txt' then
     Result := ftOEMText
    else
     if l_Ext = '.rtf' then
      Result := ftRTF;
 end;

var
 l_FilterIndex: Integer;
//#UC END# *537D965101BA_4E4B5F29031C_var*
begin
//#UC START# *537D965101BA_4E4B5F29031C_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 l_FilterIndex := lp_Ext2FilterIndex;
 (MainForm.ActiveMDIChild as TDocEditorWindow).SaveExtText(aFileName, l_FilterIndex);
//#UC END# *537D965101BA_4E4B5F29031C_impl*
end;//AcSaveTextAs

procedure ArClearTemplateStorage;
//#UC START# *53B648700029_4E4B5F29031C_var*
const
 csUserConfigDir = 'TestUserConfig';
var
 l_InputName : AnsiString;
 l_OutputName: AnsiString;
//#UC END# *53B648700029_4E4B5F29031C_var*
begin
//#UC START# *53B648700029_4E4B5F29031C_impl*
 l_OutputName := GetTemplateStorage.GetFileName;
 l_InputName := GetCVSTestSetPath + cc_Slash + csUserConfigDir + cc_Slash + c_TemplatesFN;
 CopyFile(l_InputName, l_OutputName);
 GetTemplateStorage.ClearStorate;
//#UC END# *53B648700029_4E4B5F29031C_impl*
end;//ArClearTemplateEtarlon

procedure AcMainFormFormClose;
//#UC START# *53EB19C20101_4E4B5F29031C_var*
var
 l_OnIdle      : TIdleEvent;
 l_OnMessage   : TMessageEvent;
 l_OnDragDrop  : TNotifyEvent;
 l_CloasAction : TCloseAction;
 l_OnFormChange: TNotifyEvent;
//#UC END# *53EB19C20101_4E4B5F29031C_var*
begin
//#UC START# *53EB19C20101_4E4B5F29031C_impl*
 Assert(MainForm <> nil);
 l_CloasAction := caFree;
 l_OnIdle := Application.OnIdle;
 l_OnMessage := Application.OnMessage;
 l_OnFormChange := Screen.OnActiveFormChange;
 l_OnDragDrop := TDragDataSupport.Instance.OnDragStop;
 try
  MainForm.FormClose(nil, l_CloasAction);
 finally
  Application.OnIdle := l_OnIdle;
  Application.OnMessage := l_OnMessage;
  Screen.OnActiveFormChange := l_OnFormChange;
  TDragDataSupport.Instance.OnDragStop := l_OnDragDrop;
 end;
//#UC END# *53EB19C20101_4E4B5F29031C_impl*
end;//AcMainFormFormClose

procedure AcClearConfig(aFileName: AnsiString);
//#UC START# *56A09EF601E1_4E4B5F29031C_var*
const
 csUserConfigFile = 'user.ini';
var
 l_Msg    : AnsiString;
 l_DirName: AnsiString;
//#UC END# *56A09EF601E1_4E4B5F29031C_var*
begin
//#UC START# *56A09EF601E1_4E4B5F29031C_impl*
 l_DirName := g_BaseEngine.DataParams.DocStoragePath;
 if not arUnackFileFromArchive(aFileName, l_DirName, l_Msg, csUserConfigFile) then
  Assert(False, l_Msg);
//#UC END# *56A09EF601E1_4E4B5F29031C_impl*
end;//AcClearConfig
{$IfEnd} //InsiderTest AND nsTest

end.