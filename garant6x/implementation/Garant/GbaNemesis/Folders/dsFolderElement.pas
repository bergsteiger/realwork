unit dsFolderElement;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Folders"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/dsFolderElement.pas"
// Начат: 03.05.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Основные прецеденты::Folders::Folders::Folders::TdsFolderElement
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
  FoldersInterfaces,
  FoldersDomainInterfaces
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
 _FormDataSourceType_ = IdsFolderElement;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsFolderElement = {vac} class(_vcmFormDataSourcePrim_, IdsFolderElement)
 private
 // private fields
   f_SaveObject : IdeSaveObject;
 protected
 // realized methods
   function pm_GetSaveObject: IdeSaveObject;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 end;//TdsFolderElement
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  deSaveObject,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsFolderElement;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsFolderElement

function TdsFolderElement.pm_GetSaveObject: IdeSaveObject;
//#UC START# *492192AA0144_492195FE01B3get_var*
//#UC END# *492192AA0144_492195FE01B3get_var*
begin
//#UC START# *492192AA0144_492195FE01B3get_impl*
 if not Assigned(f_SaveObject) then
  f_SaveObject := TdeSaveObject.Make;
 Result := f_SaveObject;
//#UC END# *492192AA0144_492195FE01B3get_impl*
end;//TdsFolderElement.pm_GetSaveObject

procedure TdsFolderElement.Cleanup;
//#UC START# *479731C50290_492195FE01B3_var*
//#UC END# *479731C50290_492195FE01B3_var*
begin
//#UC START# *479731C50290_492195FE01B3_impl*
 f_SaveObject := nil;
 inherited;
//#UC END# *479731C50290_492195FE01B3_impl*
end;//TdsFolderElement.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.