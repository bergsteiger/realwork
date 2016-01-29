unit dsRightEdition;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editions"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Editions/dsRightEdition.pas"
// Начат: 30.07.2009 15:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::CompareEditions::Editions::Editions::TdsRightEdition
//
// Текущая редакция
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
  l3Tree_TLB,
  EditionsInterfaces,
  DocumentUnit,
  nevTools
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
  l3NotifyPtrList,
  vcmControllers {a},
  UnderControlUnit,
  l3Types,
  UnderControlInterfaces,
  afwInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  eeInterfaces,
  FoldersDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsRightEdition;
 {$Include ..\Editions\dsEditionDiff.imp.pas}
 TdsRightEdition = {final vac} class(_dsEditionDiff_, IdsRightEdition)
  {* Текущая редакция }
 private
 // private fields
   f_NextEditions : Il3Node;
 protected
 // realized methods
   function IsLeft: Boolean; override;
   function Get_NextEditions: Il3Node;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//TdsRightEdition
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsEditionNodes,
  nsTypes,
  deDocInfo,
  nsDocInfoHAFMacroReplacer,
  nsFolderFilterInfo,
  nsEditionFromDTPDocumentContainer,
  l3InterfacesMisc,
  SysUtils,
  l3Base,
  l3Utils,
  afwFacade
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsRightEdition;

{$Include ..\Editions\dsEditionDiff.imp.pas}

// start class TdsRightEdition

function TdsRightEdition.IsLeft: Boolean;
//#UC START# *4A8443C30125_4A717FA60328_var*
//#UC END# *4A8443C30125_4A717FA60328_var*
begin
//#UC START# *4A8443C30125_4A717FA60328_impl*
 Result := false;
//#UC END# *4A8443C30125_4A717FA60328_impl*
end;//TdsRightEdition.IsLeft

function TdsRightEdition.Get_NextEditions: Il3Node;
//#UC START# *4B55B0DE0078_4A717FA60328get_var*
//#UC END# *4B55B0DE0078_4A717FA60328get_var*
begin
//#UC START# *4B55B0DE0078_4A717FA60328get_impl*
 if (f_NextEditions = nil) then
  f_NextEditions := TnsEditionsRoot.MakeForNextEditions(DoGetDocument);
 Result := f_NextEditions;
//#UC END# *4B55B0DE0078_4A717FA60328get_impl*
end;//TdsRightEdition.Get_NextEditions

procedure TdsRightEdition.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_NextEditions := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdsRightEdition.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.