unit arArchiTestsAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/arArchiTestsAdapter.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::arArchiTestsAdapter
//
// Обертки для вызова функциональности из Арчи
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  SysUtils,
  dt_Types,
  evCustomEditorWindow,
  l3ProtoObject
  {$If defined(AppClientSide)}
  ,
  Main
  {$IfEnd} //AppClientSide
  
  ;

type
 TarSkipDialog = (
   ar_AsUsual // Показывать диалог и проверять его результат.
 , ar_OpenDocument // Если есть залоченный - все равно открывать.
 , ar_NotOpen // Если есть залоченный - не открывать.
 );//TarSkipDialog

 TarTestConfig = class(Tl3ProtoObject)
  {* Хранилище всяких флагов, настроек и т.п. чтобы в одном месте было. }
 private
 // private fields
   f_SkipLockDialog : TarSkipDialog;
    {* Поле для свойства SkipLockDialog}
 protected
 // property methods
   procedure pm_SetSkipLockDialog(aValue: TarSkipDialog);
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property SkipLockDialog: TarSkipDialog
     read f_SkipLockDialog
     write pm_SetSkipLockDialog;
 public
 // singleton factory method
   class function Instance: TarTestConfig;
    {- возвращает экземпляр синглетона. }
 end;//TarTestConfig
function ArOpenDocumentByNumber(aDocID: TDocID;
  aSubID: TDocID;
  aRenum: Boolean): Boolean;
   {* Открыть документ по номеру. }
function ArGetDocumentEditor: TevCustomEditorWindow;
   {* Получить редактор для текста документа. }
function ArOpenByNumberAsString(const aDocID: AnsiString;
  aRenum: Boolean): Boolean;
   {* Открыть документ по номеру }
function ArCloseActiveDocument: Boolean;
procedure ArSubNameEdit(aSubID: TSubID);
   {* Редакторование саба. }
procedure ArDeleteSub(aSubID: TSubID);
   {* Удалить саб. }
procedure ArCreateNewDocument(const aParams: TNewDocParams);
procedure ArCreateNewDocumentByFileName(const aFileName: TFileName;
  aDocType: TDocType);
procedure AcOpenInsDWin;
procedure AcDeInitDB;
procedure AcInitDB;
procedure ArAddBlock;
procedure AcSetActivePage(anIndex: Integer);
procedure AcCreateStructure;
procedure ArSetContentsSub(aBlockID: Integer);
procedure ArGotoSub(aIndex: Integer);
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(AppClientSide)}
  ,
  Editwin
  {$IfEnd} //AppClientSide
  
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  daTypes
  {$If not defined(Nemesis)}
  ,
  DictsSup
  {$IfEnd} //not Nemesis
  
  {$If defined(AppClientSide) AND not defined(Nemesis)}
  ,
  ddClientBaseEngine
  {$IfEnd} //AppClientSide AND not Nemesis
  ,
  m3StorageHolderList
  {$If defined(AppClientSide)}
  ,
  archiHTInit
  {$IfEnd} //AppClientSide
  
  {$If not defined(Nemesis)}
  ,
  dt_Mail
  {$IfEnd} //not Nemesis
  ,
  l3Base {a}
  ;

// unit methods

function ArOpenDocumentByNumber(aDocID: TDocID;
  aSubID: TDocID;
  aRenum: Boolean): Boolean;
//#UC START# *4DE608AF027D_4DE60853015A_var*
//#UC END# *4DE608AF027D_4DE60853015A_var*
begin
//#UC START# *4DE608AF027D_4DE60853015A_impl*
 Assert(MainForm <> nil);
 MainForm.OpenDocByNumber(aDocID, aSubID, aRenum);
 Result := True;
//#UC END# *4DE608AF027D_4DE60853015A_impl*
end;//ArOpenDocumentByNumber

function ArGetDocumentEditor: TevCustomEditorWindow;
//#UC START# *4DE608E101E0_4DE60853015A_var*
//#UC END# *4DE608E101E0_4DE60853015A_var*
begin
//#UC START# *4DE608E101E0_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 Result := (MainForm.ActiveMDIChild as TDocEditorWindow).DocTextEditor.DocEditor;
//#UC END# *4DE608E101E0_4DE60853015A_impl*
end;//ArGetDocumentEditor

function ArOpenByNumberAsString(const aDocID: AnsiString;
  aRenum: Boolean): Boolean;
//#UC START# *4DE62CD4032D_4DE60853015A_var*
//#UC END# *4DE62CD4032D_4DE60853015A_var*
begin
//#UC START# *4DE62CD4032D_4DE60853015A_impl*
 Result := arOpenDocumentByNumber(StrToInt(aDocID), 0, aRenum);
//#UC END# *4DE62CD4032D_4DE60853015A_impl*
end;//ArOpenByNumberAsString

function ArCloseActiveDocument: Boolean;
//#UC START# *4DE6331E00DA_4DE60853015A_var*
//#UC END# *4DE6331E00DA_4DE60853015A_var*
begin
//#UC START# *4DE6331E00DA_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 MainForm.ActiveMDIChild.Close;
 Result := True;
//#UC END# *4DE6331E00DA_4DE60853015A_impl*
end;//ArCloseActiveDocument

procedure ArSubNameEdit(aSubID: TSubID);
//#UC START# *4DFB4F0401D6_4DE60853015A_var*
//#UC END# *4DFB4F0401D6_4DE60853015A_var*
begin
//#UC START# *4DFB4F0401D6_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).SubNameEdit(aSubID);
//#UC END# *4DFB4F0401D6_4DE60853015A_impl*
end;//ArSubNameEdit

procedure ArDeleteSub(aSubID: TSubID);
//#UC START# *4E01AD6F0280_4DE60853015A_var*
//#UC END# *4E01AD6F0280_4DE60853015A_var*
begin
//#UC START# *4E01AD6F0280_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).RemoveSub(aSubID, -1);
//#UC END# *4E01AD6F0280_4DE60853015A_impl*
end;//ArDeleteSub

procedure ArCreateNewDocument(const aParams: TNewDocParams);
//#UC START# *4E0AD0AD00CD_4DE60853015A_var*
//#UC END# *4E0AD0AD00CD_4DE60853015A_var*
begin
//#UC START# *4E0AD0AD00CD_4DE60853015A_impl*
 MainForm.CreateNewDocumentFromFile(aParams);
//#UC END# *4E0AD0AD00CD_4DE60853015A_impl*
end;//ArCreateNewDocument

procedure ArCreateNewDocumentByFileName(const aFileName: TFileName;
  aDocType: TDocType);
//#UC START# *4E0AE1A90285_4DE60853015A_var*
var
 l_Param: TNewDocParams;
//#UC END# *4E0AE1A90285_4DE60853015A_var*
begin
//#UC START# *4E0AE1A90285_4DE60853015A_impl*
 l_Param.rDocKind := 0;
 l_Param.rDocName := '';
 l_Param.rAnalyseFile := aFileName;            
 l_Param.rDocType := aDocType;
 l_Param.rDocAddr.DocID := 0;
 l_Param.rAnalyseLog := False;
 ArCreateNewDocument(l_Param);
//#UC END# *4E0AE1A90285_4DE60853015A_impl*
end;//ArCreateNewDocumentByFileName

procedure AcOpenInsDWin;
//#UC START# *4E2447BF0259_4DE60853015A_var*
var
 l_Menu: TMenuItem;
//#UC END# *4E2447BF0259_4DE60853015A_var*
begin
//#UC START# *4E2447BF0259_4DE60853015A_impl*
 l_Menu := MainForm.menuDicts.Find(GetDictName(da_dlTextInsert));
 if l_Menu <> nil then
  l_Menu.Action.Execute;
//#UC END# *4E2447BF0259_4DE60853015A_impl*
end;//AcOpenInsDWin

procedure AcDeInitDB;
//#UC START# *4E4B5CDC03DF_4DE60853015A_var*
//#UC END# *4E4B5CDC03DF_4DE60853015A_var*
begin
//#UC START# *4E4B5CDC03DF_4DE60853015A_impl*
 MainForm.ShowExplorer(False);
 DoneClientBaseEngine;
 Tm3StorageHolderList.DropAll;
//#UC END# *4E4B5CDC03DF_4DE60853015A_impl*
end;//AcDeInitDB

procedure AcInitDB;
//#UC START# *4E4B5D350252_4DE60853015A_var*
//#UC END# *4E4B5D350252_4DE60853015A_var*
begin
//#UC START# *4E4B5D350252_4DE60853015A_impl*
 InitArchiBaseEngine(PromptUserPassword, True);
 MailServer.LoadMailList;
 // MainForm.OEWin.LoadStruct;
//#UC END# *4E4B5D350252_4DE60853015A_impl*
end;//AcInitDB

procedure ArAddBlock;
//#UC START# *4EA94FCA02CD_4DE60853015A_var*
//#UC END# *4EA94FCA02CD_4DE60853015A_var*
begin
//#UC START# *4EA94FCA02CD_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).acSetBlock.Execute;
//#UC END# *4EA94FCA02CD_4DE60853015A_impl*
end;//ArAddBlock

procedure AcSetActivePage(anIndex: Integer);
//#UC START# *4EAFC7CC0065_4DE60853015A_var*
//#UC END# *4EAFC7CC0065_4DE60853015A_var*
begin
//#UC START# *4EAFC7CC0065_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 if (MainForm.ActiveMDIChild is TDocEditorWindow) then
  with (MainForm.ActiveMDIChild as TDocEditorWindow) do
   case anIndex of
    piName : acPageName.Execute;
    piAttr : acPageAttr.Execute;
    piText : acPageText.Execute;
    piPicture : nbkDocPages.PageIndex := anIndex;
    piSprv : acPageSprv.Execute;
    piAnno : nbkDocPages.PageIndex := anIndex;
    piClass : acPageClass.Execute;
    piSrcImage : nbkDocPages.PageIndex := anIndex;
    piSub : acPageAnno.Execute;
    piResp : acPageResp.Execute;
    piCoresp : acPageCoresp.Execute;
    piVersion : acPageVersions.Execute;
    piJourn : acPageJourn.Execute;
   else
    Assert(False, 'Не поддерживаются другие номера вкладок!')
   end // case anIndex of
//#UC END# *4EAFC7CC0065_4DE60853015A_impl*
end;//AcSetActivePage

procedure AcCreateStructure;
//#UC START# *4ECB5AFB0277_4DE60853015A_var*
//#UC END# *4ECB5AFB0277_4DE60853015A_var*
begin
//#UC START# *4ECB5AFB0277_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).acInsCreateStructure.Execute;
//#UC END# *4ECB5AFB0277_4DE60853015A_impl*
end;//AcCreateStructure

procedure ArSetContentsSub(aBlockID: Integer);
//#UC START# *4ECB5F560065_4DE60853015A_var*
//#UC END# *4ECB5F560065_4DE60853015A_var*
begin
//#UC START# *4ECB5F560065_4DE60853015A_impl*
 (MainForm.ActiveMDIChild as TDocEditorWindow).SetContentsSub(aBlockID);
//#UC END# *4ECB5F560065_4DE60853015A_impl*
end;//ArSetContentsSub

procedure ArGotoSub(aIndex: Integer);
//#UC START# *4EEF085B0345_4DE60853015A_var*
//#UC END# *4EEF085B0345_4DE60853015A_var*
begin
//#UC START# *4EEF085B0345_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).GoToSub(aIndex);
//#UC END# *4EEF085B0345_4DE60853015A_impl*
end;//ArGotoSub

// start class TarTestConfig

var g_TarTestConfig : TarTestConfig = nil;

procedure TarTestConfigFree;
begin
 l3Free(g_TarTestConfig);
end;

class function TarTestConfig.Instance: TarTestConfig;
begin
 if (g_TarTestConfig = nil) then
 begin
  l3System.AddExitProc(TarTestConfigFree);
  g_TarTestConfig := Create;
 end;
 Result := g_TarTestConfig;
end;


procedure TarTestConfig.pm_SetSkipLockDialog(aValue: TarSkipDialog);
//#UC START# *5425578502BE_5425548D01DDset_var*
//#UC END# *5425578502BE_5425548D01DDset_var*
begin
//#UC START# *5425578502BE_5425548D01DDset_impl*
 f_SkipLockDialog := aValue;
//#UC END# *5425578502BE_5425548D01DDset_impl*
end;//TarTestConfig.pm_SetSkipLockDialog

class function TarTestConfig.Exists: Boolean;
 {-}
begin
 Result := g_TarTestConfig <> nil;
end;//TarTestConfig.Exists

procedure TarTestConfig.InitFields;
//#UC START# *47A042E100E2_5425548D01DD_var*
//#UC END# *47A042E100E2_5425548D01DD_var*
begin
//#UC START# *47A042E100E2_5425548D01DD_impl*
 f_SkipLockDialog := ar_AsUsual;
 inherited;
//#UC END# *47A042E100E2_5425548D01DD_impl*
end;//TarTestConfig.InitFields

procedure TarTestConfig.ClearFields;
//#UC START# *5000565C019C_5425548D01DD_var*
//#UC END# *5000565C019C_5425548D01DD_var*
begin
//#UC START# *5000565C019C_5425548D01DD_impl*
 inherited;
 f_SkipLockDialog := ar_AsUsual;
//#UC END# *5000565C019C_5425548D01DD_impl*
end;//TarTestConfig.ClearFields
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.