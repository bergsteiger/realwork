unit dsDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsDocument.pas"
// Начат: 08.12.2008 21:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::TdsDocument
//
// Обычный юридический документ, если я правильно всё понимаю (Люлин)
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
  DocumentAndListInterfaces,
  WorkWithDocumentInterfaces,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentInterfaces,
  WorkWithListInterfaces,
  nsDocumentLikeStateHolder
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
  l3NotifyPtrList,
  UnderControlUnit,
  UnderControlInterfaces,
  bsTypes,
  DocumentUnit,
  bsTypesNew,
  FoldersDomainInterfaces,
  vcmControllers {a},
  DynamicDocListUnit,
  l3TreeInterfaces,
  PrimPrimListInterfaces,
  l3IID,
  evdInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsDocument;
 {$Include ..\Document\dsDocument.imp.pas}
 TdsDocument = {vac} class(_dsDocument_)
  {* Обычный юридический документ, если я правильно всё понимаю (Люлин) }
 protected
 // overridden protected methods
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsF1DocumentContainer
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3String,
  l3Base,
  deListSet,
  evdHyperlinkInfo,
  afwNavigation,
  IOUnit,
  bsUtils,
  BaseTypesUnit,
  bsConvert,
  l3Utils,
  deDocInfo,
  nsTypes,
  nsDocInfoHAFMacroReplacer
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  nsFolderFilterInfo,
  l3InterfacesMisc,
  afwFacade,
  deSearchInfo,
  DynamicTreeUnit,
  nsINodeWrap
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDocument;

{$Include ..\Document\dsDocument.imp.pas}

// start class TdsDocument

function TdsDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_493D63D20049_var*
//#UC END# *4C6AB38800F3_493D63D20049_var*
begin
//#UC START# *4C6AB38800F3_493D63D20049_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_493D63D20049_impl*
end;//TdsDocument.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.