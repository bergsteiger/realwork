unit sdsMedicFirmDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/sdsMedicFirmDocument.pas"
// Начат: 11.12.2008 20:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TsdsMedicFirmDocument
//
// Документ-фирма
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
  MedicInterfaces,
  DocumentInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID,
  nevTools,
  bsTypes,
  afwInterfaces,
  FoldersDomainInterfaces,
  vcmControllers {a},
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicDocListUnit,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  DynamicTreeUnit,
  PreviewInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdMedicFirmDocument;
 _SetType_ = IsdsMedicFirmDocument;
 {$Include ..\Medic\sdsMedicFirmDocument.imp.pas}
 TsdsMedicFirmDocument = {ucc} class(_sdsMedicFirmDocument_, IsdsMedicFirmDocument)
  {* Документ-фирма }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
 end;//TsdsMedicFirmDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dMedicFirmDocument,
  dsMedicFirmDocument,
  dsDrugList,
  SysUtils,
  afwFacade,
  BaseTypesUnit,
  deList,
  bsUtils,
  dsAttributes,
  l3Types,
  l3Utils,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsMedicFirmDocument;

{$Include ..\Medic\sdsMedicFirmDocument.imp.pas}

// start class TsdsMedicFirmDocument

{$If not defined(NoVCM)}
function TsdsMedicFirmDocument.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_49414F880240_var*
//#UC END# *47F3778403D9_49414F880240_var*
begin
//#UC START# *47F3778403D9_49414F880240_impl*
 Result := TdMedicFirmDocument.Make;
 Result.dsDrugListRef.NeedMake := vcm_nmYes;
//#UC END# *47F3778403D9_49414F880240_impl*
end;//TsdsMedicFirmDocument.MakeData
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.