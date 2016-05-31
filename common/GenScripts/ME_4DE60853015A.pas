unit arArchiTestsAdapter;
 {* Обертки для вызова функциональности из Арчи }

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\arArchiTestsAdapter.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arArchiTestsAdapter" MUID: (4DE60853015A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evCustomEditorWindow
 , dt_Types
 {$If Defined(AppClientSide)}
 , Main
 {$IfEnd} // Defined(AppClientSide)
 , SysUtils
 , l3ProtoObject
;

type
 TarSkipDialog = (
  ar_AsUsual
   {* Показывать диалог и проверять его результат. }
  , ar_OpenDocument
   {* Если есть залоченный - все равно открывать. }
  , ar_NotOpen
   {* Если есть залоченный - не открывать. }
 );//TarSkipDialog

 TarTestConfig = class(Tl3ProtoObject)
  {* Хранилище всяких флагов, настроек и т.п. чтобы в одном месте было. }
  private
   f_SkipLockDialog: TarSkipDialog;
  protected
   procedure pm_SetSkipLockDialog(aValue: TarSkipDialog);
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   class function Instance: TarTestConfig;
    {* Метод получения экземпляра синглетона TarTestConfig }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property SkipLockDialog: TarSkipDialog
    read f_SkipLockDialog
    write pm_SetSkipLockDialog;
 end;//TarTestConfig

function arOpenDocumentByNumber(aDocID: TDocID;
 aSubID: TDocID;
 aRenum: Boolean): Boolean;
 {* Открыть документ по номеру. }
function arGetDocumentEditor: TevCustomEditorWindow;
 {* Получить редактор для текста документа. }
function arOpenByNumberAsString(const aDocID: AnsiString;
 aRenum: Boolean): Boolean;
 {* Открыть документ по номеру }
function arCloseActiveDocument: Boolean;
procedure arSubNameEdit(aSubID: TSubID);
 {* Редакторование саба. }
procedure arDeleteSub(aSubID: TSubID);
procedure arCreateNewDocument(const aParams: TNewDocParams);
procedure arCreateNewDocumentByFileName(const aFileName: TFileName;
 aDocType: TDocType);
procedure acOpenInsDWin;
procedure acDeInitDB;
procedure acInitDB;
procedure arAddBlock;
procedure acSetActivePage(anIndex: Integer);
procedure acCreateStructure;
procedure arSetContentsSub(aBlockID: Integer);
procedure arGotoSub(aIndex: Integer);
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If Defined(AppClientSide)}
 , Editwin
 {$IfEnd} // Defined(AppClientSide)
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , daTypes
 {$If NOT Defined(Nemesis)}
 , DictsSup
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(AppClientSide) AND NOT Defined(Nemesis)}
 , ddClientBaseEngine
 {$IfEnd} // Defined(AppClientSide) AND NOT Defined(Nemesis)
 , m3StorageHolderList
 {$If Defined(AppClientSide)}
 , archiHTInit
 {$IfEnd} // Defined(AppClientSide)
 {$If NOT Defined(Nemesis)}
 , dt_Mail
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Base
;

var g_TarTestConfig: TarTestConfig = nil;
 {* Экземпляр синглетона TarTestConfig }

procedure TarTestConfigFree;
 {* Метод освобождения экземпляра синглетона TarTestConfig }
begin
 l3Free(g_TarTestConfig);
end;//TarTestConfigFree

function arOpenDocumentByNumber(aDocID: TDocID;
 aSubID: TDocID;
 aRenum: Boolean): Boolean;
 {* Открыть документ по номеру. }
//#UC START# *4DE608AF027D_4DE60853015A_var*
//#UC END# *4DE608AF027D_4DE60853015A_var*
begin
//#UC START# *4DE608AF027D_4DE60853015A_impl*
 Assert(MainForm <> nil);
 MainForm.OpenDocByNumber(aDocID, aSubID, aRenum);
 Result := True;
//#UC END# *4DE608AF027D_4DE60853015A_impl*
end;//arOpenDocumentByNumber

function arGetDocumentEditor: TevCustomEditorWindow;
 {* Получить редактор для текста документа. }
//#UC START# *4DE608E101E0_4DE60853015A_var*
//#UC END# *4DE608E101E0_4DE60853015A_var*
begin
//#UC START# *4DE608E101E0_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 Result := (MainForm.ActiveMDIChild as TDocEditorWindow).DocTextEditor.DocEditor;
//#UC END# *4DE608E101E0_4DE60853015A_impl*
end;//arGetDocumentEditor

function arOpenByNumberAsString(const aDocID: AnsiString;
 aRenum: Boolean): Boolean;
 {* Открыть документ по номеру }
//#UC START# *4DE62CD4032D_4DE60853015A_var*
//#UC END# *4DE62CD4032D_4DE60853015A_var*
begin
//#UC START# *4DE62CD4032D_4DE60853015A_impl*
 Result := arOpenDocumentByNumber(StrToInt(aDocID), 0, aRenum);
//#UC END# *4DE62CD4032D_4DE60853015A_impl*
end;//arOpenByNumberAsString

function arCloseActiveDocument: Boolean;
//#UC START# *4DE6331E00DA_4DE60853015A_var*
//#UC END# *4DE6331E00DA_4DE60853015A_var*
begin
//#UC START# *4DE6331E00DA_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 MainForm.ActiveMDIChild.Close;
 Result := True;
//#UC END# *4DE6331E00DA_4DE60853015A_impl*
end;//arCloseActiveDocument

procedure arSubNameEdit(aSubID: TSubID);
 {* Редакторование саба. }
//#UC START# *4DFB4F0401D6_4DE60853015A_var*
//#UC END# *4DFB4F0401D6_4DE60853015A_var*
begin
//#UC START# *4DFB4F0401D6_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).SubNameEdit(aSubID);
//#UC END# *4DFB4F0401D6_4DE60853015A_impl*
end;//arSubNameEdit

procedure arDeleteSub(aSubID: TSubID);
//#UC START# *4E01AD6F0280_4DE60853015A_var*
//#UC END# *4E01AD6F0280_4DE60853015A_var*
begin
//#UC START# *4E01AD6F0280_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).RemoveSub(aSubID, -1);
//#UC END# *4E01AD6F0280_4DE60853015A_impl*
end;//arDeleteSub

procedure arCreateNewDocument(const aParams: TNewDocParams);
//#UC START# *4E0AD0AD00CD_4DE60853015A_var*
//#UC END# *4E0AD0AD00CD_4DE60853015A_var*
begin
//#UC START# *4E0AD0AD00CD_4DE60853015A_impl*
 MainForm.CreateNewDocumentFromFile(aParams);
//#UC END# *4E0AD0AD00CD_4DE60853015A_impl*
end;//arCreateNewDocument

procedure arCreateNewDocumentByFileName(const aFileName: TFileName;
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
end;//arCreateNewDocumentByFileName

procedure acOpenInsDWin;
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
end;//acOpenInsDWin

procedure acDeInitDB;
//#UC START# *4E4B5CDC03DF_4DE60853015A_var*
//#UC END# *4E4B5CDC03DF_4DE60853015A_var*
begin
//#UC START# *4E4B5CDC03DF_4DE60853015A_impl*
 MainForm.ShowExplorer(False);
 DoneClientBaseEngine;
 Tm3StorageHolderList.DropAll;
//#UC END# *4E4B5CDC03DF_4DE60853015A_impl*
end;//acDeInitDB

procedure acInitDB;
//#UC START# *4E4B5D350252_4DE60853015A_var*
//#UC END# *4E4B5D350252_4DE60853015A_var*
begin
//#UC START# *4E4B5D350252_4DE60853015A_impl*
 InitArchiBaseEngine(PromptUserPassword, True);
 MailServer.LoadMailList;
 // MainForm.OEWin.LoadStruct;
//#UC END# *4E4B5D350252_4DE60853015A_impl*
end;//acInitDB

procedure arAddBlock;
//#UC START# *4EA94FCA02CD_4DE60853015A_var*
//#UC END# *4EA94FCA02CD_4DE60853015A_var*
begin
//#UC START# *4EA94FCA02CD_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).acSetBlock.Execute;
//#UC END# *4EA94FCA02CD_4DE60853015A_impl*
end;//arAddBlock

procedure acSetActivePage(anIndex: Integer);
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
end;//acSetActivePage

procedure acCreateStructure;
//#UC START# *4ECB5AFB0277_4DE60853015A_var*
//#UC END# *4ECB5AFB0277_4DE60853015A_var*
begin
//#UC START# *4ECB5AFB0277_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).acInsCreateStructure.Execute;
//#UC END# *4ECB5AFB0277_4DE60853015A_impl*
end;//acCreateStructure

procedure arSetContentsSub(aBlockID: Integer);
//#UC START# *4ECB5F560065_4DE60853015A_var*
//#UC END# *4ECB5F560065_4DE60853015A_var*
begin
//#UC START# *4ECB5F560065_4DE60853015A_impl*
 (MainForm.ActiveMDIChild as TDocEditorWindow).SetContentsSub(aBlockID);
//#UC END# *4ECB5F560065_4DE60853015A_impl*
end;//arSetContentsSub

procedure arGotoSub(aIndex: Integer);
//#UC START# *4EEF085B0345_4DE60853015A_var*
//#UC END# *4EEF085B0345_4DE60853015A_var*
begin
//#UC START# *4EEF085B0345_4DE60853015A_impl*
 Assert(MainForm <> nil);
 Assert(MainForm.ActiveMDIChild <> nil);
 (MainForm.ActiveMDIChild as TDocEditorWindow).GoToSub(aIndex);
//#UC END# *4EEF085B0345_4DE60853015A_impl*
end;//arGotoSub

procedure TarTestConfig.pm_SetSkipLockDialog(aValue: TarSkipDialog);
//#UC START# *5425578502BE_5425548D01DDset_var*
//#UC END# *5425578502BE_5425548D01DDset_var*
begin
//#UC START# *5425578502BE_5425548D01DDset_impl*
 f_SkipLockDialog := aValue;
//#UC END# *5425578502BE_5425548D01DDset_impl*
end;//TarTestConfig.pm_SetSkipLockDialog

class function TarTestConfig.Instance: TarTestConfig;
 {* Метод получения экземпляра синглетона TarTestConfig }
begin
 if (g_TarTestConfig = nil) then
 begin
  l3System.AddExitProc(TarTestConfigFree);
  g_TarTestConfig := Create;
 end;
 Result := g_TarTestConfig;
end;//TarTestConfig.Instance

class function TarTestConfig.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
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
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
