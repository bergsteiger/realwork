unit dsEditions;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsEditions.pas"
// Начат: 2005/09/23 17:08:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::TdsEditions
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
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsEditions;
 _UseCaseControllerType_ = IsdsPrimDocument;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 TdsEditions = {final vac} class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_, IdsEditions)
 protected
 // realized methods
   function GetEditionsRoot: Il3SimpleRootNode;
     {* получение списка редакций документа }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   function GetIsSame(const aValue: _FormDataSourceType_): Boolean; override;
   {$IfEnd} //not NoVCM
 end;//TdsEditions
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsEditionNodes,
  SysUtils,
  l3InterfacesMisc,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}

// start class TdsEditions

function TdsEditions.GetEditionsRoot: Il3SimpleRootNode;
//#UC START# *49217DB001A7_4921809902CF_var*
//#UC END# *49217DB001A7_4921809902CF_var*
begin
//#UC START# *49217DB001A7_4921809902CF_impl*
 Result := TnsEditionsRoot.MakeAsSimpleRoot(UseCaseController.DocInfo.Doc);
//#UC END# *49217DB001A7_4921809902CF_impl*
end;//TdsEditions.GetEditionsRoot

{$If not defined(NoVCM)}
function TdsEditions.GetIsSame(const aValue: _FormDataSourceType_): Boolean;
//#UC START# *49147FB4028C_4921809902CF_var*
var
 l_SDS1 : IsdsPrimDocument;
//#UC END# *49147FB4028C_4921809902CF_var*
begin
//#UC START# *49147FB4028C_4921809902CF_impl*
 Result := inherited GetIsSame(aValue);
 if not Result and Assigned(aValue) then
  if aValue.CastUCC(IsdsPrimDocument, l_SDS1) then
  //if Supports(aValue.UseCaseController, IsdsPrimDocument, l_SDS1) then
  try
   Result := UseCaseController.DocInfo.IsSame(l_SDS1.DocInfo, False);
  finally
   l_SDS1 := nil;
  end;//try..finally
//#UC END# *49147FB4028C_4921809902CF_impl*
end;//TdsEditions.GetIsSame
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.