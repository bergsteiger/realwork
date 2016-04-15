unit BaseHistoryWindow_Form;
 {* ������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\BaseHistoryWindow_Form.pas"
// ���������: "VCMContainer"
// ������� ������: "BaseHistoryWindow" MUID: (4A6EA45C01C4)
// ��� ����: "TBaseHistoryWindowForm"

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
  {* ������� ��������� }
  protected
   procedure RegisterInDispatcher; override;
   procedure UnRegisterInDispatcher; override;
  public
   procedure Chat_ClearHistory_Test(const aParams: IvcmTestParamsPrim);
    {* �������� ������� }
   procedure Chat_ClearHistory_Execute(const aParams: IvcmExecuteParamsPrim);
    {* �������� ������� }
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
 , BaseHistoryWindow_utChatHistory_UserType
;

const
 {* ������������ ������ utChatHistoryLocalConstants }
 str_utChatHistoryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utChatHistoryCaption'; rValue : '������� ���������');
  {* ��������� ����������������� ���� "������� ���������" }

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
 {* �������� ������� }
//#UC START# *4A8AE24D003F_4A6EA45C01C4test_var*
//#UC END# *4A8AE24D003F_4A6EA45C01C4test_var*
begin
//#UC START# *4A8AE24D003F_4A6EA45C01C4test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := HistoryEditor.TextSource.HasDocument AND
  not (HistoryEditor.Selection.Cursor.atStart and HistoryEditor.Selection.Cursor.atEnd(HistoryEditor.View));
//#UC END# *4A8AE24D003F_4A6EA45C01C4test_impl*
end;//TBaseHistoryWindowForm.Chat_ClearHistory_Test

procedure TBaseHistoryWindowForm.Chat_ClearHistory_Execute(const aParams: IvcmExecuteParamsPrim);
 {* �������� ������� }
//#UC START# *4A8AE24D003F_4A6EA45C01C4exec_var*
//#UC END# *4A8AE24D003F_4A6EA45C01C4exec_var*
begin
//#UC START# *4A8AE24D003F_4A6EA45C01C4exec_impl*
 TdmStdRes.MakeChatDispatcher.ClearHistory(UserID);
 HistoryEditor.TextSource.New;
//#UC END# *4A8AE24D003F_4A6EA45C01C4exec_impl*
end;//TBaseHistoryWindowForm.Chat_ClearHistory_Execute

initialization
 str_utChatHistoryCaption.Init;
 {* ������������� str_utChatHistoryCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TBaseHistoryWindowForm);
 {* ����������� BaseHistoryWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
