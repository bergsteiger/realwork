unit BaseChatWindow_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/BaseChatWindow_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseChatWindow
//
// Переписка
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
  Messages
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ChatInterfaces,
  AbstractHistory_Form,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
  {$If defined(Nemesis)}
  ,
  nscChatMemo
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaseChatWindow_cwChat_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseChatWindowForm = {form} class(TAbstractHistoryForm, IbsChatWindow)
  {* Переписка }
 private
 // private fields
   f_BackgroundPanel : TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel}
   f_BottomPanel : TvtSizeablePanel;
    {* Поле для свойства BottomPanel}
   f_BottomEditor : TnscChatMemo;
    {* Поле для свойства BottomEditor}
   f_TopPanel : TvtPanel;
    {* Поле для свойства TopPanel}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
 protected
 // realized methods
   procedure NewMessagesReceived;
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
   procedure HistoryCleaned;
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_GetState(var State: TvcmOperationStateIndex);
     {* OK }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
     {* OK }
   {$IfEnd} //not NoVCM
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure InitEditors; override;
   function HistoryLimit: Integer; override;
   function NeedClose: Boolean; override;
 public
 // public properties
   property BackgroundPanel: TvtProportionalPanel
     read f_BackgroundPanel;
   property BottomPanel: TvtSizeablePanel
     read f_BottomPanel;
   property BottomEditor: TnscChatMemo
     read f_BottomEditor;
   property TopPanel: TvtPanel
     read f_TopPanel;
 end;//TBaseChatWindowForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Windows
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3Memory,
  evTypes,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  evdAllDocumentSubsEliminator,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки cwChatLocalConstants }
  str_cwChatCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cwChatCaption'; rValue : 'Переписка');
   { Заголовок пользовательского типа "Переписка" }

// start class TBaseChatWindowForm

procedure TBaseChatWindowForm.WMActivate(var Message: TWMActivate);
//#UC START# *4B34C0B801B1_4A6EA44C0038_var*
var
 l_Info: TFlashWInfo;
//#UC END# *4B34C0B801B1_4A6EA44C0038_var*
begin
//#UC START# *4B34C0B801B1_4A6EA44C0038_impl*
 inherited;
 If Message.Active <> WA_INACTIVE then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0);
  l_Info.cbSize :=SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_STOP;
  FlashWindowEx(l_Info);
 end; 
//#UC END# *4B34C0B801B1_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.WMActivate

procedure TBaseChatWindowForm.NewMessagesReceived;
//#UC START# *4A6D71700008_4A6EA44C0038_var*
var
 l_Info: TFlashWInfo;
//#UC END# *4A6D71700008_4A6EA44C0038_var*
begin
//#UC START# *4A6D71700008_4A6EA44C0038_impl*
 ProcessMessages(TdmStdRes.MakeChatDispatcher.GetMessages(UserID, -1));
 if not ContainsControl(FindControl(GetForegroundWindow)) then
 begin
  l3FillChar(l_Info, SizeOf(l_Info), 0); 
  l_Info.cbSize :=SizeOf(l_Info);
  l_Info.hwnd := Handle;
  l_Info.dwFlags := FLASHW_ALL or FLASHW_TIMER;
  FlashWindowEx(l_Info);
 end;
//#UC END# *4A6D71700008_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.NewMessagesReceived

procedure TBaseChatWindowForm.RegisterInDispatcher;
//#UC START# *4A6EA5EA00CD_4A6EA44C0038_var*
//#UC END# *4A6EA5EA00CD_4A6EA44C0038_var*
begin
//#UC START# *4A6EA5EA00CD_4A6EA44C0038_impl*
 TdmStdRes.MakeChatDispatcher.RegisterChatWindow(Self);
//#UC END# *4A6EA5EA00CD_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.RegisterInDispatcher

procedure TBaseChatWindowForm.UnRegisterInDispatcher;
//#UC START# *4A6EA6000339_4A6EA44C0038_var*
//#UC END# *4A6EA6000339_4A6EA44C0038_var*
begin
//#UC START# *4A6EA6000339_4A6EA44C0038_impl*
 TdmStdRes.MakeChatDispatcher.UnRegisterChatWindow(Self);
//#UC END# *4A6EA6000339_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.UnRegisterInDispatcher

procedure TBaseChatWindowForm.HistoryCleaned;
//#UC START# *4A7C023702A5_4A6EA44C0038_var*
//#UC END# *4A7C023702A5_4A6EA44C0038_var*
begin
//#UC START# *4A7C023702A5_4A6EA44C0038_impl*
 HistoryEditor.TextSource.New;
//#UC END# *4A7C023702A5_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.HistoryCleaned

{$If not defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AD47D0357_4A6EA44C0038test_var*
//#UC END# *4A8AD47D0357_4A6EA44C0038test_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := BottomEditor.TextSource.HasDocument AND
  not BottomEditor.IsEmpty;
//#UC END# *4A8AD47D0357_4A6EA44C0038test_impl*
end;//TBaseChatWindowForm.Result_OkExt_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4A8AD47D0357_4A6EA44C0038getstate_var*
//#UC END# *4A8AD47D0357_4A6EA44C0038getstate_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038getstate_impl*
 State := st_user_Result_OkExt_Chat;
//#UC END# *4A8AD47D0357_4A6EA44C0038getstate_impl*
end;//TBaseChatWindowForm.Result_OkExt_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AD47D0357_4A6EA44C0038exec_var*
var
 l_Memory: Tl3MemoryStream;
 l_Message: InsChatMessage;
const
 cMaxSize = 1024*10;
//#UC END# *4A8AD47D0357_4A6EA44C0038exec_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038exec_impl*
 l_Memory := Tl3MemoryStream.Make;
 try
   BottomEditor.TextSource.DocumentContainer.TagReader.ReadTag(CF_EverestBin,
                                                               l_Memory,
                                                               TevdAllDocumentSubsEliminator.Make);
  l_Memory.Position := 0;
  if l_Memory.Size > cMaxSize then
  begin
   Say(war_ChatLimitReached);
   Exit;
  end;
  try
   l_Message := TdmStdRes.MakeChatDispatcher.SendMessage(UserID, l_Memory);
  except
   on EnsUnknownChatUser do
    SafeClose;
  end;
  BottomEditor.TextSource.New;
  AddToHistory(l_Message);
 finally
  FreeAndNil(l_Memory);
 end;
//#UC END# *4A8AD47D0357_4A6EA44C0038exec_impl*
end;//TBaseChatWindowForm.Result_OkExt_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TBaseChatWindowForm.InitControls;
//#UC START# *4A8E8F2E0195_4A6EA44C0038_var*
//#UC END# *4A8E8F2E0195_4A6EA44C0038_var*
begin
//#UC START# *4A8E8F2E0195_4A6EA44C0038_impl*
 inherited;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with BottomPanel do
 begin
  Align := alBottom;
  SizeableSides := [szTop];
  SplitterBevel := bvRaised;
  Height := Parent.ClientHeight div 2;
 end;
 with TopPanel do
 begin
  Align := alClient;
 end;
 with HistoryEditor do
 begin
  Align := alClient;
 end;

 with BottomEditor do
 begin
  Align := alClient;
  OnJumpTo := Self.JumpTo;
  OnGetHotSpotInfo := Self.GetHotSpotInfo;
  TextSource.OnGetControlItemImg := Self.TextSourceGetControlItemImg;
  {$IfOpt D+}
  ShowDocumentParts := true;
  DrawSpecial := true;
  {$EndIf}
 end;//with BottomEditor
//#UC END# *4A8E8F2E0195_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.InitControls
{$IfEnd} //not NoVCM

procedure TBaseChatWindowForm.InitEditors;
//#UC START# *4AC5CD4402E7_4A6EA44C0038_var*
//#UC END# *4AC5CD4402E7_4A6EA44C0038_var*
begin
//#UC START# *4AC5CD4402E7_4A6EA44C0038_impl*
 inherited;
 BottomEditor.TextSource.New;
//#UC END# *4AC5CD4402E7_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.InitEditors

function TBaseChatWindowForm.HistoryLimit: Integer;
//#UC START# *4AC5CD9C02FA_4A6EA44C0038_var*
//#UC END# *4AC5CD9C02FA_4A6EA44C0038_var*
begin
//#UC START# *4AC5CD9C02FA_4A6EA44C0038_impl*
 Result := 10;
//#UC END# *4AC5CD9C02FA_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.HistoryLimit

function TBaseChatWindowForm.NeedClose: Boolean;
//#UC START# *4B1633CF01C2_4A6EA44C0038_var*
//#UC END# *4B1633CF01C2_4A6EA44C0038_var*
begin
//#UC START# *4B1633CF01C2_4A6EA44C0038_impl*
 Result := False;
//#UC END# *4B1633CF01C2_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.NeedClose

procedure TBaseChatWindowForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Result, nil);
  PublishFormEntity(en_Edit, nil);
  MakeEntitySupportedByControl(en_Edit, BottomEditor);
  {$If not defined(NoVCM)}
  PublishOp(en_Result, op_OkExt, Result_OkExt_Execute, Result_OkExt_Test, Result_OkExt_GetState);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

procedure TBaseChatWindowForm.MakeControls;
begin
 inherited;
 with AddUsertype(cwChatName,
  str_cwChatCaption,
  str_cwChatCaption,
  true,
  198,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(cwChatName
 f_BackgroundPanel := TvtProportionalPanel.Create(Self);
 f_BackgroundPanel.Name := 'BackgroundPanel';
 f_BackgroundPanel.Parent := Self;
 f_BottomPanel := TvtSizeablePanel.Create(Self);
 f_BottomPanel.Name := 'BottomPanel';
 f_BottomPanel.Parent := BackgroundPanel;
 with DefineZone(vcm_ztChild, f_BottomPanel) do
 begin
 end;//with DefineZone(vcm_ztChild, f_BottomPanel)
 f_BottomEditor := TnscChatMemo.Create(Self);
 f_BottomEditor.Name := 'BottomEditor';
 f_BottomEditor.Parent := BottomPanel;
 f_TopPanel := TvtPanel.Create(Self);
 f_TopPanel.Name := 'TopPanel';
 f_TopPanel.Parent := BackgroundPanel;
 with DefineZone(vcm_ztParent, f_TopPanel) do
 begin
 end;//with DefineZone(vcm_ztParent, f_TopPanel)
 HistoryEditor.Parent := TopPanel;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_cwChatCaption
 str_cwChatCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseChatWindow
 TtfwClassRef.Register(TBaseChatWindowForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.