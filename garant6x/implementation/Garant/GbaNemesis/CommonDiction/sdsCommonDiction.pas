unit sdsCommonDiction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/sdsCommonDiction.pas"
// Начат: 11.12.2008 22:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Common::CommonDiction::CommonDiction::TsdsCommonDiction
//
// Обобщённый словарь
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
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
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
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicTreeUnit,
  QueryCardInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetDataType_ = IdCommonDiction;
 _SetType_ = IsdsCommonDiction;
 {$Include ..\CommonDiction\sdsCommonDiction.imp.pas}
 TsdsCommonDiction = {ucc} class(_sdsCommonDiction_)
  {* Обобщённый словарь }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
 end;//TsdsCommonDiction
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsSaveLoad,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmFormSetRefreshParams
  {$IfEnd} //not NoVCM
  ,
  afwFacade,
  l3Base,
  dCommonDiction,
  dsChild,
  dsAttributes,
  l3Types,
  bsUtils,
  l3Utils,
  deDocInfo,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsCommonDiction;

{$Include ..\CommonDiction\sdsCommonDiction.imp.pas}

// start class TsdsCommonDiction

{$If not defined(NoVCM)}
function TsdsCommonDiction.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_4941654603E7_var*
//#UC END# *47F3778403D9_4941654603E7_var*
begin
//#UC START# *47F3778403D9_4941654603E7_impl*
 Result := TdCommonDiction.Make;
//#UC END# *47F3778403D9_4941654603E7_impl*
end;//TsdsCommonDiction.MakeData
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.