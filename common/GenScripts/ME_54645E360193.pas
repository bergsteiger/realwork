unit ncsFileTransferReg;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsFileTransferReg.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

procedure ncsServerRegister;
procedure ncsClientRegister;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ncsMessageFactory
 , ncsGetReadyToDeliveryTasks
 , ncsGetTaskDescription
 , ncsTaskProgress
 , ncsDeliveryResult
 , ncsGetFilePart
 , nscMessagesReg
 , ncsCorrectFolder
 , ncsGetReadyToDeliveryTasksReply
 , ncsGetTaskDescriptionReply
 , ncsGetFilePartReply
 , ncsPushFilePart
;

procedure ncsServerRegister;
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
end;//ncsServerRegister

procedure ncsClientRegister;
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
end;//ncsClientRegister
{$IfEnd} // NOT Defined(Nemesis)

end.
