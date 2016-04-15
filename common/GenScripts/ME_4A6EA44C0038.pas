unit BaseChatWindow_Form;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "BaseChatWindow" MUID: (4A6EA44C0038)
// ��� ����: "TBaseChatWindowForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AbstractHistory_Form
 , ChatInterfaces
 {$If NOT Defined(NoVCM)}
 , OfficeLike_ResultEx_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , Messages
;

type
 // Child

 // Parent

 TBaseChatWindowForm = class(TAbstractHistoryForm, IbsChatWindow)
  {* ��������� }
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* ���� ��� �������� BackgroundPanel }
   f_BottomPanel: TvtSizeablePanel;
    {* ���� ��� �������� BottomPanel }
   f_BottomEditor: TnscChatMemo;
    {* ���� ��� �������� BottomEditor }
   f_TopPanel: TvtPanel;
    {* ���� ��� �������� TopPanel }
  private
   procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
  protected
   procedure NewMessagesReceived;
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
   procedure HistoryCleaned;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure InitEditors; override;
   function HistoryLimit: Integer; override;
   function NeedClose: Boolean; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Result_OkExt_GetState(var State: TvcmOperationStateIndex);
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtProportionalPanel
    read f_BackgroundPanel;
 end;//TBaseChatWindowForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , Windows
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Memory
 , evTypes
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , evdAllDocumentSubsEliminator
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , BaseChatWindow_cwChat_UserType
;

const
 {* ������������ ������ cwChatLocalConstants }
 str_cwChatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cwChatCaption'; rValue : '���������');
  {* ��������� ����������������� ���� "���������" }

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

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_Test(const aParams: IvcmTestParamsPrim);
 {* OK }
//#UC START# *4A8AD47D0357_4A6EA44C0038test_var*
//#UC END# *4A8AD47D0357_4A6EA44C0038test_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := BottomEditor.TextSource.HasDocument AND
  not BottomEditor.IsEmpty;
//#UC END# *4A8AD47D0357_4A6EA44C0038test_impl*
end;//TBaseChatWindowForm.Result_OkExt_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_Execute(const aParams: IvcmExecuteParamsPrim);
 {* OK }
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.Result_OkExt_GetState(var State: TvcmOperationStateIndex);
 {* OK }
//#UC START# *4A8AD47D0357_4A6EA44C0038getstate_var*
//#UC END# *4A8AD47D0357_4A6EA44C0038getstate_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038getstate_impl*
 State := st_user_Result_OkExt_Chat;
//#UC END# *4A8AD47D0357_4A6EA44C0038getstate_impl*
end;//TBaseChatWindowForm.Result_OkExt_GetState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
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
{$IfEnd} // NOT Defined(NoVCM)

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

initialization
 str_cwChatCaption.Init;
 {* ������������� str_cwChatCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseChatWindowForm);
 {* ����������� BaseChatWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
