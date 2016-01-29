unit dsDrugDocument;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsDrugDocument.pas"
// Начат: 2008/04/03 13:44:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsDrugDocument
//
// Описание лекарственного препарата
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
  InpharmInterfaces,
  WorkWithDocumentInterfaces,
  l3Interfaces,
  l3Types,
  afwInterfaces,
  nevTools,
  DocumentAndListInterfaces,
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
  PrimPrimListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsDrugDocument;
 {$Include ..\Medic\dsBaseDrugDocument.imp.pas}
 _dsDocumentFromList_Parent_ = _dsBaseDrugDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}
 TdsDrugDocument = {final vac} class(_dsDocumentFromList_, IdsDrugDocument, IucbDocumentWithContents {from IdsDrugDocument}, IucbDocumentFromList {from IdsDrugDocument})
  {* Описание лекарственного препарата }
 private
 // private fields
   ucc_BaseDrugDocument : IsdsDrugDocument;
   ucc_DocumentWithContents : IucpDocumentWithContents;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   procedure DoReturnToList(const aList: IDynList;
    const aNodeForPositioning: Il3SimpleNode); override;
     {* параметры создания списка }
   procedure OpenDrugInternationalNameSynonims;
     {* открыть список похожих по международному названию }
   function Get_DsContents: IdsBaseContents;
 public
 // realized methods
   procedure OpenContents(const aTree: IdeSimpleTree;
    anForceOpen: TnsContentsOpenMode;
    const aContainerOfDocument: InevDocumentContainer);
 protected
 // overridden protected methods
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IucbDocumentWithContents: IucbDocumentWithContents;
   function As_IucbDocumentFromList: IucbDocumentFromList;
 end;//TdsDrugDocument
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  deList,
  nsF1DocumentContainer,
  IOUnit,
  l3Base,
  bsUtils,
  BaseTypesUnit,
  bsConvert,
  l3Utils,
  deDocInfo,
  nsTypes,
  nsDocInfoHAFMacroReplacer,
  nsFolderFilterInfo,
  l3InterfacesMisc,
  SysUtils,
  afwFacade,
  deSearchInfo,
  DynamicTreeUnit,
  nsINodeWrap
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDrugDocument;

{$Include ..\Medic\dsBaseDrugDocument.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsDocumentFromList.imp.pas}

// start class TdsDrugDocument

procedure TdsDrugDocument.DoReturnToList(const aList: IDynList;
  const aNodeForPositioning: Il3SimpleNode);
//#UC START# *491465BF0275_491D89A001A9_var*
//#UC END# *491465BF0275_491D89A001A9_var*
begin
//#UC START# *491465BF0275_491D89A001A9_impl*
 TdmStdRes.OpenList(TdeList.Make(aList,
                                 True,
                                 wdOpenIfUserDefine,
                                 aNodeForPositioning), nil);
//#UC END# *491465BF0275_491D89A001A9_impl*
end;//TdsDrugDocument.DoReturnToList

procedure TdsDrugDocument.OpenDrugInternationalNameSynonims;
//#UC START# *491D88070148_491D89A001A9_var*
//#UC END# *491D88070148_491D89A001A9_var*
begin
//#UC START# *491D88070148_491D89A001A9_impl*
 if (ucc_BaseDrugDocument <> nil) then
  ucc_BaseDrugDocument.OpenDrugInternationalNameSynonims;
//#UC END# *491D88070148_491D89A001A9_impl*
end;//TdsDrugDocument.OpenDrugInternationalNameSynonims

procedure TdsDrugDocument.OpenContents(const aTree: IdeSimpleTree;
  anForceOpen: TnsContentsOpenMode;
  const aContainerOfDocument: InevDocumentContainer);
//#UC START# *4953D3B20211_491D89A001A9_var*
//#UC END# *4953D3B20211_491D89A001A9_var*
begin
//#UC START# *4953D3B20211_491D89A001A9_impl*
 if (ucc_DocumentWithContents <> nil) then
  ucc_DocumentWithContents.OpenContents(aTree, anForceOpen, aContainerOfDocument);
//#UC END# *4953D3B20211_491D89A001A9_impl*
end;//TdsDrugDocument.OpenContents

function TdsDrugDocument.Get_DsContents: IdsBaseContents;
//#UC START# *4E7B663D00A9_491D89A001A9get_var*
//#UC END# *4E7B663D00A9_491D89A001A9get_var*
begin
//#UC START# *4E7B663D00A9_491D89A001A9get_impl*
 if (ucc_DocumentWithContents = nil) then
  Result := nil
 else
  Result := ucc_DocumentWithContents.dsContents;
//#UC END# *4E7B663D00A9_491D89A001A9get_impl*
end;//TdsDrugDocument.Get_DsContents

function TdsDrugDocument.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_491D89A001A9_var*
//#UC END# *4C6AB38800F3_491D89A001A9_var*
begin
//#UC START# *4C6AB38800F3_491D89A001A9_impl*
 Result := TnsF1DocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_491D89A001A9_impl*
end;//TdsDrugDocument.MakeContainer

procedure TdsDrugDocument.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsDrugDocument, ucc_BaseDrugDocument);
 Supports(aDS, IucpDocumentWithContents, ucc_DocumentWithContents);
end;

procedure TdsDrugDocument.ClearRefs;
begin
 inherited;
 ucc_BaseDrugDocument := nil;
 ucc_DocumentWithContents := nil;
end;

// Методы преобразования к реализуемым интерфейсам

function TdsDrugDocument.As_IucbDocumentWithContents: IucbDocumentWithContents;
begin
 Result := Self;
end;

function TdsDrugDocument.As_IucbDocumentFromList: IucbDocumentFromList;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

end.