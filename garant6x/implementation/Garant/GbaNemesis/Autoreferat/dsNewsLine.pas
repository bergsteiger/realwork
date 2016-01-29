unit dsNewsLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Autoreferat"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/dsNewsLine.pas"
// Начат: 28.11.2008 15:06
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::Autoreferat::Autoreferat::Autoreferat::TdsNewsLine
//
// Новостная лента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  AutoreferatInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsNewsLine;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsNewsLine = {vac} class(_vcmFormDataSourcePrim_, IdsNewsLine)
  {* Новостная лента }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* существуют ли данные }
    {$IfEnd} //not NoVCM
 end;//TdsNewsLine
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsNewsLine;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsNewsLine

procedure TdsNewsLine.Cleanup;
//#UC START# *479731C50290_492FDE91018F_var*
//#UC END# *479731C50290_492FDE91018F_var*
begin
//#UC START# *479731C50290_492FDE91018F_impl*
 inherited;
//#UC END# *479731C50290_492FDE91018F_impl*
end;//TdsNewsLine.Cleanup

{$If not defined(NoVCM)}
function TdsNewsLine.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_492FDE91018F_var*
//#UC END# *55097FF5008E_492FDE91018F_var*
begin
//#UC START# *55097FF5008E_492FDE91018F_impl*
 Result := not defDataAdapter.AdministratorLogin and defDataAdapter.Monitoring.IsExist;
//#UC END# *55097FF5008E_492FDE91018F_impl*
end;//TdsNewsLine.GetIsDataAvailable
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.