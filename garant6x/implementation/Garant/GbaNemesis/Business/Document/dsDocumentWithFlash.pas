unit dsDocumentWithFlash;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsDocumentWithFlash.pas"
// Начат: 2008/06/19 11:30:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsDocumentWithFlash
//
// БОФ документа-схемы
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
  DocumentUnit,
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
 _FormDataSourceType_ = IdsDocumentWithFlash;
 {$Include ..\Document\dsDocument.imp.pas}
 TdsDocumentWithFlash = {vac} class(_dsDocument_, IdsDocumentWithFlash)
  {* БОФ документа-схемы }
 private
 // private fields
   ucp_IDocument : IDocument;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} //not NoVCM
 end;//TdsDocumentWithFlash
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDocumentTools
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

type _Instance_R_ = TdsDocumentWithFlash;

{$Include ..\Document\dsDocument.imp.pas}

// start class TdsDocumentWithFlash

{$If not defined(NoVCM)}
function TdsDocumentWithFlash.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_493D480502CF_var*
//#UC END# *491476B001D3_493D480502CF_var*
begin
//#UC START# *491476B001D3_493D480502CF_impl*
 Result := nsGetDocumentShortName(ucp_IDocument);
//#UC END# *491476B001D3_493D480502CF_impl*
end;//TdsDocumentWithFlash.MakeDisplayName
{$IfEnd} //not NoVCM

procedure TdsDocumentWithFlash.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 ucp_IDocument := aDS As IDocument;
end;

procedure TdsDocumentWithFlash.ClearRefs;
begin
 inherited;
 ucp_IDocument := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.