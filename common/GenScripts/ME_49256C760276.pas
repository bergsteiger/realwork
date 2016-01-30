unit NOT_FINISHED_DocumentRes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\NOT_FINISHED_DocumentRes.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Classes
;

type
 TnsDocumentRes = class(TDataModule)
 end;//TnsDocumentRes

procedure nsDocumentRes;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure nsDocumentRes;
//#UC START# *49256C990052_49256C760276_var*
//#UC END# *49256C990052_49256C760276_var*
begin
//#UC START# *49256C990052_49256C760276_impl*
 !!! Needs to be implemented !!!
//#UC END# *49256C990052_49256C760276_impl*
end;//nsDocumentRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
