unit BaseChatWindow_Form;
 {* Переписка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseChatWindow_Form.pas"
// Стереотип: "VCMContainer"

{$Include nsDefine.inc}

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
 , l3StringIDEx
;

type
 // Child

 // Parent

 TBaseChatWindowForm = class(TAbstractHistoryForm, IbsChatWindow)
  {* Переписка }
  private
   f_BackgroundPanel: TvtProportionalPanel;
    {* Поле для свойства BackgroundPanel }
   f_BottomPanel: TvtSizeablePanel;
    {* Поле для свойства BottomPanel }
   f_BottomEditor: TnscChatMemo;
    {* Поле для свойства BottomEditor }
   f_TopPanel: TvtPanel;
    {* Поле для свойства TopPanel }
  private
   procedure WMActivate(var Message: TWMActivate);
  protected
   procedure NewMessagesReceived;
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
   procedure HistoryCleaned;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure InitEditors; override;
   function HistoryLimit: Integer; override;
   function NeedClose: Boolean; override;
  public
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
    {* OK }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure OkExt; override;
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
;

const
 {* Локализуемые строки cwChatLocalConstants }
 str_cwChatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cwChatCaption'; rValue : 'Переписка');
  {* Заголовок пользовательского типа "Переписка" }

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
procedure TBaseChatWindowForm.OkExt;
 {* OK }
//#UC START# *4A8AD47D0357_4A6EA44C0038_var*
//#UC END# *4A8AD47D0357_4A6EA44C0038_var*
begin
//#UC START# *4A8AD47D0357_4A6EA44C0038_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AD47D0357_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.OkExt;
 {* OK }
//#UC START# *4C762D9B0224_4A6EA44C0038_var*
//#UC END# *4C762D9B0224_4A6EA44C0038_var*
begin
//#UC START# *4C762D9B0224_4A6EA44C0038_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C762D9B0224_4A6EA44C0038_impl*
end;//TBaseChatWindowForm.OkExt
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TBaseChatWindowForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
 {* Инициализация str_cwChatCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseChatWindowForm);
 {* Регистрация BaseChatWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
