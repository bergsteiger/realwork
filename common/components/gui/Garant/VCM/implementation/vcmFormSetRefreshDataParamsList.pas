unit vcmFormSetRefreshDataParamsList;

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefreshDataParamsList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmFormSetRefreshDataParamsList" MUID: (55C1E2610332)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmFormSetRefreshDataParams;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmFormSetRefreshDataParamsList = class(_l3InterfaceRefList_)
 end;//TvcmFormSetRefreshDataParamsList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55C1E2610332impl_uses*
 //#UC END# *55C1E2610332impl_uses*
;

type _Instance_R_ = TvcmFormSetRefreshDataParamsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
