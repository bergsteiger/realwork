unit ncsFileTransferReg;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsFileTransferReg.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::ResultDelivery::ncsFileTransferReg
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
  ncsGetReadyToDeliveryTasks,
  ncsGetTaskDescription,
  ncsTaskProgress,
  ncsDeliveryResult,
  ncsGetFilePart,
  nscMessagesReg,
  ncsCorrectFolder,
  ncsGetReadyToDeliveryTasksReply,
  ncsGetTaskDescriptionReply,
  ncsGetFilePartReply,
  ncsPushFilePart
  ;

// unit methods

procedure NcsServerRegister;
//#UC START# *54645E5F018E_54645E360193_var*
//#UC END# *54645E5F018E_54645E360193_var*
begin
//#UC START# *54645E5F018E_54645E360193_impl*
 nscMessagesReg.NcsServerRegister;
 TncsMessageFactory.Instance.Register(TncsGetReadyToDeliveryTasks);
 TncsMessageFactory.Instance.Register(TncsGetTaskDescription);
 TncsMessageFactory.Instance.Register(TncsTaskProgress);
 TncsMessageFactory.Instance.Register(TncsGetFilePart);
 TncsMessageFactory.Instance.Register(TncsDeliveryResult);
 TncsMessageFactory.Instance.Register(TncsCorrectFolder);
//#UC END# *54645E5F018E_54645E360193_impl*
end;//NcsServerRegister

procedure NcsClientRegister;
//#UC START# *54645E7C0285_54645E360193_var*
//#UC END# *54645E7C0285_54645E360193_var*
begin
//#UC START# *54645E7C0285_54645E360193_impl*
 nscMessagesReg.NcsClientRegister;
 TncsMessageFactory.Instance.Register(TncsGetReadyToDeliveryTasksReply);
 TncsMessageFactory.Instance.Register(TncsGetTaskDescriptionReply);
 TncsMessageFactory.Instance.Register(TncsGetFilePartReply);
 TncsMessageFactory.Instance.Register(TncsPushFilePart);
//#UC END# *54645E7C0285_54645E360193_impl*
end;//NcsClientRegister
{$IfEnd} //not Nemesis

end.