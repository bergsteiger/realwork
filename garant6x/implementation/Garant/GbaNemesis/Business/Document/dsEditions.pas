unit dsEditions;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsEditions.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsEditions" MUID: (4921809902CF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , l3TreeInterfaces
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
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
 _UseCaseControllerType_ = IsdsPrimDocument;
 _FormDataSourceType_ = IdsEditions;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 TdsEditions = {final} class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_, IdsEditions)
  protected
   function GetEditionsRoot: Il3SimpleRootNode;
    {* получение списка редакций документа }
   {$If NOT Defined(NoVCM)}
   function GetIsSame(const aValue: _FormDataSourceType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsEditions
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsEditionNodes
 , SysUtils
 , l3InterfacesMisc
 , l3Base
;

type _Instance_R_ = TdsEditions;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}

function TdsEditions.GetEditionsRoot: Il3SimpleRootNode;
 {* получение списка редакций документа }
//#UC START# *49217DB001A7_4921809902CF_var*
//#UC END# *49217DB001A7_4921809902CF_var*
begin
//#UC START# *49217DB001A7_4921809902CF_impl*
 Result := TnsEditionsRoot.MakeAsSimpleRoot(UseCaseController.DocInfo.Doc);
//#UC END# *49217DB001A7_4921809902CF_impl*
end;//TdsEditions.GetEditionsRoot

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
