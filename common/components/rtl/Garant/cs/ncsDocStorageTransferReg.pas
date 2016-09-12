unit ncsDocStorageTransferReg;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsDocStorageTransferReg.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ncsDocStorageTransferReg" MUID: (57C6874900D4)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

procedure ncsClientRegister;
procedure ncsServerRegister;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ncsMessageFactory
 , csDownloadDocStreamReply
 , nscMessagesReg
 , csUploadDocStreamReply
 , csDownloadDocStream
 , csUploadDocStream
 //#UC START# *57C6874900D4impl_uses*
 //#UC END# *57C6874900D4impl_uses*
;

procedure ncsClientRegister;
//#UC START# *57C687CA01EE_57C6874900D4_var*
//#UC END# *57C687CA01EE_57C6874900D4_var*
begin
//#UC START# *57C687CA01EE_57C6874900D4_impl*
 nscMessagesReg.ncsClientRegister;
 TncsMessageFactory.Instance.Register(TcsDownloadDocStreamReply);
 TncsMessageFactory.Instance.Register(TcsUploadDocStreamReply);
//#UC END# *57C687CA01EE_57C6874900D4_impl*
end;//ncsClientRegister

procedure ncsServerRegister;
//#UC START# *57C687E100FF_57C6874900D4_var*
//#UC END# *57C687E100FF_57C6874900D4_var*
begin
//#UC START# *57C687E100FF_57C6874900D4_impl*
 nscMessagesReg.NcsServerRegister;
 TncsMessageFactory.Instance.Register(TcsDownloadDocStream);
 TncsMessageFactory.Instance.Register(TcsUploadDocStream);
//#UC END# *57C687E100FF_57C6874900D4_impl*
end;//ncsServerRegister
{$IfEnd} // NOT Defined(Nemesis)

end.
