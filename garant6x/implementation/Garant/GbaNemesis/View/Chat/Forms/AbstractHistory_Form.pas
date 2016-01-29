unit AbstractHistory_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/AbstractHistory_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Встроенные продукты::Chat::View::Chat::AbstractHistory
//
// Абстрактное окно истории
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  ChatTypes,
  ChatInterfaces
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nevBase,
  evCustomEditorWindow,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  DocumentUnit,
  ExternalOperationUnit,
  afwInterfaces,
  nevGUIInterfaces,
  afwNavigation,
  nevNavigation,
  NavigationInterfaces,
  DocumentInterfaces,
  bsTypesNew,
  vcmBase {a},
  vcmContainerForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _TextWithComments_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}
 _HyperlinkProcessorWithOwnLocalLink_Parent_ = _TextWithComments_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}
 TAbstractHistoryForm = {form} class(_HyperlinkProcessorWithOwnLocalLink_, IbsAbstractChatWindow)
  {* Абстрактное окно истории }
 private
 // private fields
   f_HistoryEditor : TnscChatMemo;
    {* Поле для свойства HistoryEditor}
   f_UserID : TbsUserID;
    {* Поле для свойства UserID}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   function Get_UserID: TbsUserID;
   procedure ActivateChatWindow;
   procedure GotoPoint(aPointID: Cardinal;
    aPointType: TDocumentPositionType = dptSub); override;
     {* Переход на точку в документе }
   function HyperlinkDocument: IDocument; override;
     {* Документ ИЗ которого ведёт ссылка }
   function pm_GetHyperlinkText: TevCustomEditorWindow; override;
   function IsFloating: Boolean; override;
     {* Форма плавающая }
   function pm_GetTextWithComments: TevCustomEditorWindow; override;
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_GetState(var State: TvcmOperationStateIndex);
     {* Отмена }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Отмена }
   {$IfEnd} //not NoVCM
   procedure OpenRedactionGlobalLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoProcessLocalLink(const aDocument: IDocument;
    aPointType: TDocumentPositionType;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; override;
     {* Обработка локальных ссылок }
   procedure DoCheckLinkInfo(const aLink: IevHyperlink); override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function SettingsSuffix: AnsiString; override;
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure RegisterInDispatcher; virtual; abstract;
   procedure UnRegisterInDispatcher; virtual; abstract;
   procedure AddToHistory(const aMessage: InsChatMessage);
   procedure ProcessMessages(const aData: InsChatMessages);
   procedure InitEditors; virtual;
   function HistoryLimit: Integer; virtual;
   function NeedClose: Boolean; virtual;
 public
 // public methods
   class function MakeSingleChild(anUID: TbsUserID;
    const aName: Il3CString;
    const aCont   : IvcmContainer;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 protected
 // protected properties
   property UserID: TbsUserID
     read f_UserID
     write f_UserID;
 public
 // public properties
   property HistoryEditor: TnscChatMemo
     read f_HistoryEditor;
 end;//TAbstractHistoryForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evOp,
  ComObj,
  l3Types,
  evTypes,
  afwFacade
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  evdTypes,
  nsTypes,
  deDocInfo
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Windows,
  nevTools
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  DocumentRes,
  vtUtils,
  evdStyles,
  k2Tags,
  BitmapPara_Const,
  nsConst,
  SysUtils,
  nsHyperLinkProcessor,
  nsOpenUtils,
  nsTabbedContainerUtils
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  nsHyperlinkProcessorTypes,
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TAbstractHistoryForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\TextWithComments.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\HyperlinkProcessorWithOwnLocalLink.imp.pas}

// start class TAbstractHistoryForm

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
  const aName: Il3CString;
  const aCont   : IvcmContainer;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TAbstractHistoryForm);
 begin
  with aForm do
  begin
//#UC START# *4AC4EFBA012A_4A6EA4310035_impl*
   CCaption := vcmFmt(str_ChatWindowCaption, [aName]);
   UserID := anUID;
   InitEditors;
   RegisterInDispatcher;
   ProcessMessages(TdmStdRes.MakeChatDispatcher.GetMessages(UserID, HistoryLimit));
//#UC END# *4AC4EFBA012A_4A6EA4310035_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited MakeSingleChild(aCont, vcmMakeParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

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
  aPointType: TDocumentPositionType = dptSub);
//#UC START# *4A8164E801AE_4A6EA4310035_var*
//#UC END# *4A8164E801AE_4A6EA4310035_var*
begin
//#UC START# *4A8164E801AE_4A6EA4310035_impl*
 Assert(false);
//#UC END# *4A8164E801AE_4A6EA4310035_impl*
end;//TAbstractHistoryForm.GotoPoint

function TAbstractHistoryForm.HyperlinkDocument: IDocument;
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

{$If not defined(NoVCM)}
procedure TAbstractHistoryForm.Result_Cancel_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AC5D61E0284_4A6EA4310035test_var*
//#UC END# *4AC5D61E0284_4A6EA4310035test_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035test_impl*
 // - ничего не делаем
//#UC END# *4AC5D61E0284_4A6EA4310035test_impl*
end;//TAbstractHistoryForm.Result_Cancel_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TAbstractHistoryForm.Result_Cancel_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4AC5D61E0284_4A6EA4310035getstate_var*
//#UC END# *4AC5D61E0284_4A6EA4310035getstate_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035getstate_impl*
 if NeedClose then
  State := st_user_Result_Cancel_Close
//#UC END# *4AC5D61E0284_4A6EA4310035getstate_impl*
end;//TAbstractHistoryForm.Result_Cancel_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TAbstractHistoryForm.Result_Cancel_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4AC5D61E0284_4A6EA4310035exec_var*
//#UC END# *4AC5D61E0284_4A6EA4310035exec_var*
begin
//#UC START# *4AC5D61E0284_4A6EA4310035exec_impl*
 SafeClose;
//#UC END# *4AC5D61E0284_4A6EA4310035exec_impl*
end;//TAbstractHistoryForm.Result_Cancel_Execute
{$IfEnd} //not NoVCM

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

{$If not defined(NoVCM)}
function TAbstractHistoryForm.SettingsSuffix: AnsiString;
//#UC START# *4A8E425D0268_4A6EA4310035_var*
//#UC END# *4A8E425D0268_4A6EA4310035_var*
begin
//#UC START# *4A8E425D0268_4A6EA4310035_impl*
 Result := Format('_%d',[f_UserID]);
//#UC END# *4A8E425D0268_4A6EA4310035_impl*
end;//TAbstractHistoryForm.SettingsSuffix
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TAbstractHistoryForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TAbstractHistoryForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, HistoryEditor);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_Cancel, Result_Cancel_Execute, Result_Cancel_Test, Result_Cancel_GetState);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TAbstractHistoryForm.MakeControls;
begin
 inherited;
 f_HistoryEditor := TnscChatMemo.Create(Self);
 f_HistoryEditor.Name := 'HistoryEditor';
 f_HistoryEditor.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AbstractHistory
 TtfwClassRef.Register(TAbstractHistoryForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.