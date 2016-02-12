unit AbstractHistory_Form;
 {* Абстрактное окно истории }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\AbstractHistory_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Result_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , ChatTypes
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 , l3Interfaces
 , DocumentUnit
 , evCustomEditorWindow
 , bsTypesNew
 , NavigationInterfaces
 , nevNavigation
 , nevBase
 , ExternalOperationUnit
 , DocumentInterfaces
 , nevGUIInterfaces
 , afwInterfaces
 , afwNavigation
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_Parent_ = _TextWithComments_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}
 TAbstractHistoryForm = class(_HyperlinkProcessorWithOwnLocalLink_, IbsAbstractChatWindow)
  {* Абстрактное окно истории }
  private
   f_HistoryEditor: TnscChatMemo;
    {* Поле для свойства HistoryEditor }
   f_UserID: TbsUserID;
    {* Поле для свойства UserID }
  protected
   procedure RegisterInDispatcher; virtual; abstract;
   procedure UnRegisterInDispatcher; virtual; abstract;
   procedure AddToHistory(const aMessage: InsChatMessage);
   procedure ProcessMessages(const aData: InsChatMessages);
   procedure InitEditors; virtual;
   function HistoryLimit: Integer; virtual;
   function NeedClose: Boolean; virtual;
   function Get_UserID: TbsUserID;
   procedure ActivateChatWindow;
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = Sub); override;
    {* Переход на точку в документе }
   function HyperlinkDocument: IDocument; override;
    {* Документ ИЗ которого ведёт ссылка }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function IsFloating: Boolean; override;
    {* Форма плавающая }
   function pm_GetTextWithComments: TevCustomEditorWindow; override;
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; override;
    {* Обработка локальных ссылок }
   procedure DoCheckLinkInfo(const aLink: IevHyperlink); override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function MakeSingleChild(anUID: TbsUserID;
    const aName: Il3CString): IbsAbstractChatWindow; reintroduce;
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Cancel; override;
    {* Отмена }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function SettingsSuffix: AnsiString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property UserID: TbsUserID
    read f_UserID
    write f_UserID;
  public
   property HistoryEditor: TnscChatMemo
    read f_HistoryEditor;
 end;//TAbstractHistoryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , evOp
 , ComObj
 , l3Types
 , evTypes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , evdTypes
 , nsTypes
 , deDocInfo
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , nevTools
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , DocumentRes
 , vtUtils
 , evdStyles
 , k2Tags
 , BitmapPara_Const
 , nsHyperLinkProcessor
 , nsOpenUtils
 , nsConst
 , nsTabbedContainerUtils
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 , nsHyperlinkProcessorTypes
 , SysUtils
;

type _Instance_R_ = TAbstractHistoryForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}

procedure TAbstractHistoryForm.AddToHistory(const aMessage: InsChatMessage);
//#UC START# *4A6EA62A0096_4A6EA4310035_var*
const
 cFlags = (evDefaultLoadFlags + [ev_lfInternal] - [ev_lfNeedJoin]) - [ev_lfSkipSubdocuments];
var
 l_Fake : Int64;
 l_W : InevTagWriter;
 l_C : InevBasePoint;
 l_Op : InevOp;
//#UC END# *4A6EA62A0096_4A6EA4310035_var*
begin
//#UC START# *4A6EA62A0096_4A6EA4310035_impl*
 with HistoryEditor do
 begin
  l_W := TextSource.DocumentContainer.TagWriter;
  Assert(l_W <> nil);
  l_C := Selection.Cursor;
  Assert(l_C <> nil);
  l_Op := Processor.StartOp;
  try
   l_C.Move(View, ev_ocBottomRight);
   OleCheck(aMessage.Title.Seek(0, STREAM_SEEK_SET, l_Fake));
   l_W.WriteTag(View, cf_EverestTxt, aMessage.Title, l_C, cFlags);
   l_C.Move(View, ev_ocBottomRight);
   OleCheck(aMessage.Body.Seek(0, STREAM_SEEK_SET, l_Fake));
   l_W.WriteTag(View, CF_EverestBin, aMessage.Body, l_C, cFlags);
   l_C.Move(View, ev_ocBottomRight);
  finally
   l_Op := nil;
  end;
  Processor.UndoBuffer.Clear;
 end;//with HistoryEditor
//#UC END# *4A6EA62A0096_4A6EA4310035_impl*
end;//TAbstractHistoryForm.AddToHistory

procedure TAbstractHistoryForm.ProcessMessages(const aData: InsChatMessages);
//#UC START# *4A6EA655038C_4A6EA4310035_var*
var
 l_IDX: Integer;
//#UC END# *4A6EA655038C_4A6EA4310035_var*
begin
//#UC START# *4A6EA655038C_4A6EA4310035_impl*
 if Assigned(aData) then
 begin
  for l_IDX := 0 to aData.Messagescount - 1 do
   AddToHistory(aData.Message[l_IDX]);
  //HistoryEditor.Selection.Unselect; 
 end;//Assigned(aData)
//#UC END# *4A6EA655038C_4A6EA4310035_impl*
end;//TAbstractHistoryForm.ProcessMessages

class function TAbstractHistoryForm.MakeSingleChild(anUID: TbsUserID;
 const aName: Il3CString): IbsAbstractChatWindow;
var
 l_Inst : TAbstractHistoryForm;
begin
 l_Inst := Create(anUID, aName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAbstractHistoryForm.MakeSingleChild

procedure TAbstractHistoryForm.InitEditors;
//#UC START# *4AC5CD4402E7_4A6EA4310035_var*
//#UC END# *4AC5CD4402E7_4A6EA4310035_var*
begin
//#UC START# *4AC5CD4402E7_4A6EA4310035_impl*
 HistoryEditor.TextSource.New;
//#UC END# *4AC5CD4402E7_4A6EA4310035_impl*
end;//TAbstractHistoryForm.InitEditors

function TAbstractHistoryForm.HistoryLimit: Integer;
//#UC START# *4AC5CD9C02FA_4A6EA4310035_var*
//#UC END# *4AC5CD9C02FA_4A6EA4310035_var*
begin
//#UC START# *4AC5CD9C02FA_4A6EA4310035_impl*
 Result := 0;
//#UC END# *4AC5CD9C02FA_4A6EA4310035_impl*
end;//TAbstractHistoryForm.HistoryLimit

function TAbstractHistoryForm.NeedClose: Boolean;
//#UC START# *4B1633CF01C2_4A6EA4310035_var*
//#UC END# *4B1633CF01C2_4A6EA4310035_var*
begin
//#UC START# *4B1633CF01C2_4A6EA4310035_impl*
 Result := True;
//#UC END# *4B1633CF01C2_4A6EA4310035_impl*
end;//TAbstractHistoryForm.NeedClose

function TAbstractHistoryForm.Get_UserID: TbsUserID;
//#UC START# *4A6EA502033A_4A6EA4310035get_var*
//#UC END# *4A6EA502033A_4A6EA4310035get_var*
begin
//#UC START# *4A6EA502033A_4A6EA4310035get_impl*
 Result := UserID;
//#UC END# *4A6EA502033A_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.Get_UserID

procedure TAbstractHistoryForm.ActivateChatWindow;
//#UC START# *4A6EA50801BA_4A6EA4310035_var*
//#UC END# *4A6EA50801BA_4A6EA4310035_var*
begin
//#UC START# *4A6EA50801BA_4A6EA4310035_impl*
 if IsIconic(Handle) then
  ShowWindow(Handle, SW_RESTORE);
 SetFocus;
//#UC END# *4A6EA50801BA_4A6EA4310035_impl*
end;//TAbstractHistoryForm.ActivateChatWindow

procedure TAbstractHistoryForm.GotoPoint(aPointID: Cardinal;
 aPointType: TDocumentPositionType = Sub);
 {* Переход на точку в документе }
//#UC START# *4A8164E801AE_4A6EA4310035_var*
//#UC END# *4A8164E801AE_4A6EA4310035_var*
begin
//#UC START# *4A8164E801AE_4A6EA4310035_impl*
 Assert(false);
//#UC END# *4A8164E801AE_4A6EA4310035_impl*
end;//TAbstractHistoryForm.GotoPoint

function TAbstractHistoryForm.HyperlinkDocument: IDocument;
 {* Документ ИЗ которого ведёт ссылка }
//#UC START# *4A8168BB0217_4A6EA4310035_var*
//#UC END# *4A8168BB0217_4A6EA4310035_var*
begin
//#UC START# *4A8168BB0217_4A6EA4310035_impl*
 Result := nil;
//#UC END# *4A8168BB0217_4A6EA4310035_impl*
end;//TAbstractHistoryForm.HyperlinkDocument

function TAbstractHistoryForm.pm_GetHyperlinkText: TevCustomEditorWindow;
//#UC START# *4A82BC390036_4A6EA4310035get_var*
//#UC END# *4A82BC390036_4A6EA4310035get_var*
begin
//#UC START# *4A82BC390036_4A6EA4310035get_impl*
 Result := HistoryEditor;
//#UC END# *4A82BC390036_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.pm_GetHyperlinkText

function TAbstractHistoryForm.IsFloating: Boolean;
 {* Форма плавающая }
//#UC START# *4A8A9DB0001A_4A6EA4310035_var*
//#UC END# *4A8A9DB0001A_4A6EA4310035_var*
begin
//#UC START# *4A8A9DB0001A_4A6EA4310035_impl*
 Result := true;
//#UC END# *4A8A9DB0001A_4A6EA4310035_impl*
end;//TAbstractHistoryForm.IsFloating

function TAbstractHistoryForm.pm_GetTextWithComments: TevCustomEditorWindow;
//#UC START# *4A8AAD450084_4A6EA4310035get_var*
//#UC END# *4A8AAD450084_4A6EA4310035get_var*
begin
//#UC START# *4A8AAD450084_4A6EA4310035get_impl*
 Result := HistoryEditor;
//#UC END# *4A8AAD450084_4A6EA4310035get_impl*
end;//TAbstractHistoryForm.pm_GetTextWithComments

{$If NOT Defined(NoVCM)}
procedure TAbstractHistoryForm.Cancel;
 {* Отмена }
//#UC START# *4AC5D61E0284_4A6EA4310035_var*
//#UC END# *4AC5D61E0284_4A6EA4310035_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC5D61E0284_4A6EA4310035_impl*
end;//TAbstractHistoryForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TAbstractHistoryForm.Cancel;
 {* Отмена }
//#UC START# *4C762C910358_4A6EA4310035_var*
//#UC END# *4C762C910358_4A6EA4310035_var*
begin
//#UC START# *4C762C910358_4A6EA4310035_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762C910358_4A6EA4310035_impl*
end;//TAbstractHistoryForm.Cancel
{$IfEnd} // NOT Defined(NoVCM)

procedure TAbstractHistoryForm.OpenRedactionGlobalLink(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *53A303BE03A8_4A6EA4310035_var*
//#UC END# *53A303BE03A8_4A6EA4310035_var*
begin
//#UC START# *53A303BE03A8_4A6EA4310035_impl*
 Assert(False, '513615258');
//#UC END# *53A303BE03A8_4A6EA4310035_impl*
end;//TAbstractHistoryForm.OpenRedactionGlobalLink

procedure TAbstractHistoryForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A6EA4310035_var*
//#UC END# *479731C50290_4A6EA4310035_var*
begin
//#UC START# *479731C50290_4A6EA4310035_impl*
 if (ZoneType <> vcm_ztForToolbarsInfo) then
  UnRegisterInDispatcher;
 inherited;
//#UC END# *479731C50290_4A6EA4310035_impl*
end;//TAbstractHistoryForm.Cleanup

function TAbstractHistoryForm.DoProcessLocalLink(const aDocument: IDocument;
 aPointType: TDocumentPositionType;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
 {* Обработка локальных ссылок }
//#UC START# *4A8160720125_4A6EA4310035_var*
//#UC END# *4A8160720125_4A6EA4310035_var*
begin
//#UC START# *4A8160720125_4A6EA4310035_impl*
 Result := false;
//#UC END# *4A8160720125_4A6EA4310035_impl*
end;//TAbstractHistoryForm.DoProcessLocalLink

procedure TAbstractHistoryForm.DoCheckLinkInfo(const aLink: IevHyperlink);
//#UC START# *4A8A9E2A004F_4A6EA4310035_var*
//#UC END# *4A8A9E2A004F_4A6EA4310035_var*
begin
//#UC START# *4A8A9E2A004F_4A6EA4310035_impl*
 if (aLink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = CI_ExternalOperation) then
 begin
  alink.Kind := ev_lvkInternalInvalid;
  alink.Hint := Tl3PCharLen(nsWStr(vcmCStr(str_UnsupportedLink)));
 end;//aLink.Address.TypeID = CI_ExternalOperation
//#UC END# *4A8A9E2A004F_4A6EA4310035_impl*
end;//TAbstractHistoryForm.DoCheckLinkInfo

{$If NOT Defined(NoVCM)}
function TAbstractHistoryForm.SettingsSuffix: AnsiString;
//#UC START# *4A8E425D0268_4A6EA4310035_var*
//#UC END# *4A8E425D0268_4A6EA4310035_var*
begin
//#UC START# *4A8E425D0268_4A6EA4310035_impl*
 Result := Format('_%d',[f_UserID]);
//#UC END# *4A8E425D0268_4A6EA4310035_impl*
end;//TAbstractHistoryForm.SettingsSuffix
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TAbstractHistoryForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A6EA4310035_var*
//#UC END# *4A8E8F2E0195_4A6EA4310035_var*
begin
//#UC START# *4A8E8F2E0195_4A6EA4310035_impl*
 inherited;
 with HistoryEditor do
 begin
  Align := alClient;
  ReadOnly := true;
 end;//with HistoryEditor
//#UC END# *4A8E8F2E0195_4A6EA4310035_impl*
end;//TAbstractHistoryForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAbstractHistoryForm);
 {* Регистрация AbstractHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
