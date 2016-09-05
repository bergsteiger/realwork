unit NOT_FINISHED_nsManagers;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\NOT_FINISHED_nsManagers.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsManagers" MUID: (49228EF60100)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If Defined(vcmUseProfilers)}
 , ProfilersInterfaces
 {$IfEnd} // Defined(vcmUseProfilers)
;

{$If NOT Defined(vcmUseProfilers)}
function ProfilersManager: InsProfilersManager;
{$IfEnd} // NOT Defined(vcmUseProfilers)
procedure fake;

implementation

uses
 l3ImplUses
 //#UC START# *49228EF60100impl_uses*
 //#UC END# *49228EF60100impl_uses*
;

{$If NOT Defined(vcmUseProfilers)}
function ProfilersManager: InsProfilersManager;
//#UC START# *4AA1182503AD_49228EF60100_var*
//#UC END# *4AA1182503AD_49228EF60100_var*
begin
//#UC START# *4AA1182503AD_49228EF60100_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA1182503AD_49228EF60100_impl*
end;//ProfilersManager
{$IfEnd} // NOT Defined(vcmUseProfilers)

procedure fake;
//#UC START# *49228EFF01C6_49228EF60100_var*
//#UC END# *49228EFF01C6_49228EF60100_var*
begin
//#UC START# *49228EFF01C6_49228EF60100_impl*
 !!! Needs to be implemented !!!
//#UC END# *49228EFF01C6_49228EF60100_impl*
end;//fake

end.
