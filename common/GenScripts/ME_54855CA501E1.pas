unit ncsTaskSendReg;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskSendReg.pas"
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
 , nscMessagesReg
 , ncsSendTask
 , ncsGetTaskDescriptionReply
 , ncsPushFilePart
 , ncsGetFilePartReply
 , ncsSendTaskReply
 , ncsGetPartialTaskDescription
 , ncsGetFilePart
;

procedure ncsServerRegister;
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
end;//ncsServerRegister

procedure ncsClientRegister;
//#UC START# *54855CE1027C_54855CA501E1_var*
//#UC END# *54855CE1027C_54855CA501E1_var*
begin
//#UC START# *54855CE1027C_54855CA501E1_impl*
 nscMessagesReg.NcsClientRegister;
 TncsMessageFactory.Instance.Register(TncsSendTaskReply);
 TncsMessageFactory.Instance.Register(TncsGetPartialTaskDescription);
 TncsMessageFactory.Instance.Register(TncsGetFilePart);
//#UC END# *54855CE1027C_54855CA501E1_impl*
end;//ncsClientRegister
{$IfEnd} // NOT Defined(Nemesis)

end.
