unit nscMessagesReg;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/nscMessagesReg.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Messages::nscMessagesReg
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
procedure NcsServerRegister;
   {* ��������� ������ ncsServerRegister }
procedure NcsClientRegister;
   {* ��������� ������ ncsClientRegister }
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  ncsMessageFactory,
  ncsMessage
  ;

// unit methods

procedure NcsServerRegister;
//#UC START# *547C34E902C1_547C34C500F7_var*
//#UC END# *547C34E902C1_547C34C500F7_var*
begin
//#UC START# *547C34E902C1_547C34C500F7_impl*
 TncsMessageFactory.Instance.Register(TncsDIsconnect);
//#UC END# *547C34E902C1_547C34C500F7_impl*
end;//NcsServerRegister

procedure NcsClientRegister;
//#UC START# *547C350000AA_547C34C500F7_var*
//#UC END# *547C350000AA_547C34C500F7_var*
begin
//#UC START# *547C350000AA_547C34C500F7_impl*
 TncsMessageFactory.Instance.Register(TncsDIsconnectReply);
//#UC END# *547C350000AA_547C34C500F7_impl*
end;//NcsClientRegister
{$IfEnd} //not Nemesis

end.