unit dsAdmin;
 {* бизнес объект контейнера cfAdmin }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsAdmin.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 {$Include vcmFormDataSourcePrim.imp.pas}
 TdsAdmin = {final} class(_vcmFormDataSourcePrim_, IdsAdmin)
  {* бизнес объект контейнера cfAdmin }
 end;//TdsAdmin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsAdmin;

{$Include vcmFormDataSourcePrim.imp.pas}
{$IfEnd} // Defined(Admin)

end.
