unit dCommonDiction;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.pas"
// ���������: "SimpleClass"
// ������� ������: "TdCommonDiction" MUID: (4B220E9B0348)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseDocumentWithAttributesInterfaces
 , l3Types
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdCommonDiction;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.imp.pas}
 TdCommonDiction = class(_dCommonDiction_)
 end;//TdCommonDiction
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Utils
 //#UC START# *4B220E9B0348impl_uses*
 //#UC END# *4B220E9B0348impl_uses*
;

type _Instance_R_ = TdCommonDiction;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
