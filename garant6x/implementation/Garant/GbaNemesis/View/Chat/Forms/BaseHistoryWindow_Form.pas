unit BaseHistoryWindow_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/Forms/BaseHistoryWindow_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Встроенные продукты::Chat::View::Chat::BaseHistoryWindow
//
// История переписки
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ChatInterfaces,
  AbstractHistory_Form,
  Base_Operations_Chat_Controls,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  BaseHistoryWindow_utChatHistory_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TBaseHistoryWindowForm = {form} class(TAbstractHistoryForm, IbsChatHistoryWindow)
  {* История переписки }
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 protected
 // realized methods
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
   procedure Chat_ClearHistory_Test(const aParams: IvcmTestParamsPrim);
     {* Очистить историю }
   procedure Chat_ClearHistory_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Очистить историю }
 end;//TBaseHistoryWindowForm

 TvcmContainerFormRef = TBaseHistoryWindowForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Windows
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utChatHistoryLocalConstants }
  str_utChatHistoryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utChatHistoryCaption'; rValue : 'История переписки');
   { Заголовок пользовательского типа "История переписки" }

// start class TBaseHistoryWindowForm

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

procedure TBaseHistoryWindowForm.Chat_ClearHistory_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4A8AE24D003F_4A6EA45C01C4test_var*
//#UC END# *4A8AE24D003F_4A6EA45C01C4test_var*
begin
//#UC START# *4A8AE24D003F_4A6EA45C01C4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := HistoryEditor.TextSource.HasDocument AND
  not (HistoryEditor.Selection.Cursor.atStart and HistoryEditor.Selection.Cursor.atEnd(HistoryEditor.View));
//#UC END# *4A8AE24D003F_4A6EA45C01C4test_impl*
end;//TBaseHistoryWindowForm.Chat_ClearHistory_Test

procedure TBaseHistoryWindowForm.Chat_ClearHistory_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4A8AE24D003F_4A6EA45C01C4exec_var*
//#UC END# *4A8AE24D003F_4A6EA45C01C4exec_var*
begin
//#UC START# *4A8AE24D003F_4A6EA45C01C4exec_impl*
 TdmStdRes.MakeChatDispatcher.ClearHistory(UserID);
 HistoryEditor.TextSource.New;
//#UC END# *4A8AE24D003F_4A6EA45C01C4exec_impl*
end;//TBaseHistoryWindowForm.Chat_ClearHistory_Execute

procedure TBaseHistoryWindowForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Chat, nil);
  PublishOp(en_Chat, op_ClearHistory, Chat_ClearHistory_Execute, Chat_ClearHistory_Test, nil);
 end;//with Entities.Entities
end;

procedure TBaseHistoryWindowForm.MakeControls;
begin
 inherited;
 with AddUsertype(utChatHistoryName,
  str_utChatHistoryCaption,
  str_utChatHistoryCaption,
  true,
  197,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utChatHistoryName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utChatHistoryCaption
 str_utChatHistoryCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseHistoryWindow
 TtfwClassRef.Register(TBaseHistoryWindowForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.