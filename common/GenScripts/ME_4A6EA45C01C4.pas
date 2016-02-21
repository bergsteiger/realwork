unit BaseHistoryWindow_Form;
 {* История переписки }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_Form.pas"
// Стереотип: "VCMContainer"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AbstractHistory_Form
 , ChatInterfaces
 , Base_Operations_Chat_Controls
;

type
 TBaseHistoryWindowForm = class(TAbstractHistoryForm, IbsChatHistoryWindow)
  {* История переписки }
  protected
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
  public
   procedure ClearHistory; override;
    {* Очистить историю }
 end;//TBaseHistoryWindowForm
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
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utChatHistoryLocalConstants }
 str_utChatHistoryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utChatHistoryCaption'; rValue : 'История переписки');
  {* Заголовок пользовательского типа "История переписки" }

procedure TBaseHistoryWindowForm.RegisterInDispatcher;
//#UC START# *4A6EA5EA00CD_4A6EA45C01C4_var*
//#UC END# *4A6EA5EA00CD_4A6EA45C01C4_var*
begin
//#UC START# *4A6EA5EA00CD_4A6EA45C01C4_impl*
 TdmStdRes.MakeChatDispatcher.RegisterChatHistory(Self);
//#UC END# *4A6EA5EA00CD_4A6EA45C01C4_impl*
end;//TBaseHistoryWindowForm.RegisterInDispatcher

procedure TBaseHistoryWindowForm.UnRegisterInDispatcher;
//#UC START# *4A6EA6000339_4A6EA45C01C4_var*
//#UC END# *4A6EA6000339_4A6EA45C01C4_var*
begin
//#UC START# *4A6EA6000339_4A6EA45C01C4_impl*
 TdmStdRes.MakeChatDispatcher.UnRegisterChatHistory(Self);
//#UC END# *4A6EA6000339_4A6EA45C01C4_impl*
end;//TBaseHistoryWindowForm.UnRegisterInDispatcher

procedure TBaseHistoryWindowForm.ClearHistory;
 {* Очистить историю }
//#UC START# *4A8AE24D003F_4A6EA45C01C4_var*
//#UC END# *4A8AE24D003F_4A6EA45C01C4_var*
begin
//#UC START# *4A8AE24D003F_4A6EA45C01C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AE24D003F_4A6EA45C01C4_impl*
end;//TBaseHistoryWindowForm.ClearHistory

initialization
 str_utChatHistoryCaption.Init;
 {* Инициализация str_utChatHistoryCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseHistoryWindowForm);
 {* Регистрация BaseHistoryWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
