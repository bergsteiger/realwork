unit dsNewsLine;
 {* Новостная лента }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Autoreferat\dsNewsLine.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , AutoreferatInterfaces
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
 _FormDataSourceType_ = IdsNewsLine;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsNewsLine = class(_vcmFormDataSourcePrim_, IdsNewsLine)
  {* Новостная лента }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
    {* существуют ли данные }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsNewsLine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsNewsLine;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

procedure TdsNewsLine.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_492FDE91018F_var*
//#UC END# *479731C50290_492FDE91018F_var*
begin
//#UC START# *479731C50290_492FDE91018F_impl*
 inherited;
//#UC END# *479731C50290_492FDE91018F_impl*
end;//TdsNewsLine.Cleanup

{$If NOT Defined(NoVCM)}
function TdsNewsLine.GetIsDataAvailable: Boolean;
 {* существуют ли данные }
//#UC START# *55097FF5008E_492FDE91018F_var*
//#UC END# *55097FF5008E_492FDE91018F_var*
begin
//#UC START# *55097FF5008E_492FDE91018F_impl*
 Result := not defDataAdapter.AdministratorLogin and defDataAdapter.Monitoring.IsExist;
//#UC END# *55097FF5008E_492FDE91018F_impl*
end;//TdsNewsLine.GetIsDataAvailable
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
