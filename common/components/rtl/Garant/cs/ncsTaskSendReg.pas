unit ncsTaskSendReg;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsTaskSendReg.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::TaskSend::ncsTaskSendReg
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
  nscMessagesReg,
  ncsSendTask,
  ncsGetTaskDescriptionReply,
  ncsPushFilePart,
  ncsGetFilePartReply,
  ncsSendTaskReply,
  ncsGetPartialTaskDescription,
  ncsGetFilePart
  ;

// unit methods

procedure NcsServerRegister;
//#UC START# *54855CCF019F_54855CA501E1_var*
//#UC END# *54855CCF019F_54855CA501E1_var*
begin
//#UC START# *54855CCF019F_54855CA501E1_impl*
 nscMessagesReg.NcsServerRegister;
 TncsMessageFactory.Instance.Register(TncsSendTask);
 TncsMessageFactory.Instance.Register(TncsGetTaskDescriptionReply);
 TncsMessageFactory.Instance.Register(TncsPushFilePart);
 TncsMessageFactory.Instance.Register(TncsGetFilePartReply);
//#UC END# *54855CCF019F_54855CA501E1_impl*
end;//NcsServerRegister

procedure NcsClientRegister;
//#UC START# *54855CE1027C_54855CA501E1_var*
//#UC END# *54855CE1027C_54855CA501E1_var*
begin
//#UC START# *54855CE1027C_54855CA501E1_impl*
 nscMessagesReg.NcsClientRegister;
 TncsMessageFactory.Instance.Register(TncsSendTaskReply);
 TncsMessageFactory.Instance.Register(TncsGetPartialTaskDescription);
 TncsMessageFactory.Instance.Register(TncsGetFilePart);
//#UC END# *54855CE1027C_54855CA501E1_impl*
end;//NcsClientRegister
{$IfEnd} //not Nemesis

end.