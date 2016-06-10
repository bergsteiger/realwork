unit dsDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dsDrugList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdsDrugList
//
// Список лекарственных препаратов
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
  PrimPrimListInterfaces,
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  FiltersUnit,
  l3Interfaces,
  afwInterfaces,
  l3TreeInterfaces,
  nsRootManager,
  bsTypes,
  DocumentAndListInterfaces,
  nsTypes,
  DocumentInterfaces,
  WorkWithListInterfaces,
  BaseDocumentWithAttributesInterfaces,
  l3InternalInterfaces,
  bsInterfaces
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  TreeInterfaces
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
  WorkWithDocumentInterfaces,
  vcmControllers {a},
  nsTypesNew,
  PreviewInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsDrugList;
 _InitDataType_ = IdeList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}
 TdsDrugList = {final vac} class(_dsList_, IdsDrugList)
  {* Список лекарственных препаратов }
 private
 // private fields
   ucc_DrugList : IsdsDrugList;
 protected

  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // overridden protected methods
   function MakeDocInfo(const aNode: INodeBase): IdeDocInfo; override;
     {* создать информацию о документе по узлу. }
   function MakeImageList: Il3ImageList; override;
     {* - создать иконки дерева. }
   procedure DoUpdateListInfo; override;
     {* - обновить информацию о списке. }
   procedure MarkNodeForExport(const aNode: Il3SimpleNode;
    aOnlyFirstLevel: Boolean); override;
     {* - пометить узел для экспорта. }
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* существуют ли данные }
    {$IfEnd} //not NoVCM
 end;//TdsDrugList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  bsUtils,
  BaseTypesUnit,
  vtUtils,
  ListRes,
  DataAdapter,
  afwComplexDocumentPreview,
  nsINodesClipboardDataObject,
  nsHAFPainter,
  nsDocumentPreview,
  nsIListDataObject,
  IOUnit
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  l3String
  {$If not defined(NoVCM)}
  ,
  vcmForm
  {$IfEnd} //not NoVCM
  ,
  BaseTreeSupportUnit,
  nsNodes,
  nsDocumentTools,
  l3Nodes,
  nsExternalObjectPrim,
  bsConvert,
  nsDocumentStreamWrapper,
  afwFacade,
  evMultiDocumentPreview,
  bsConst,
  evHTMLDataObject,
  l3Memory,
  nsFolders,
  nsSuperComplexDocumentPreview,
  bsListTreeStruct,
  nevBase,
  nsListHAFMacroReplacer,
  evFormatHAFMacroReplacer,
  LoggingInterfaces,
  nsListPrintEvent,
  deList,
  nevInterfaces,
  bsTypesNew,
  nsFiltersContainer,
  nsTreeMultiDocumentPreviewContainer,
  bsDocumentMissingMessage,
  nsExternalObjectModelPart,
  nsDocumentStreamList,
  nsListExceptions,
  nsFiltersUtils,
  nsFiltersInterfaces,
  nsDocumentWithSnippetList,
  l3Base,
  vtStdRes,
  nsNewCachableNode,
  Windows,
  l3InterfacesMisc
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsDrugList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}

// start class TdsDrugList

function TdsDrugList.MakeDocInfo(const aNode: INodeBase): IdeDocInfo;
//#UC START# *47F0C98F020C_47E9EDD301A4_var*
//#UC END# *47F0C98F020C_47E9EDD301A4_var*
begin
//#UC START# *47F0C98F020C_47E9EDD301A4_impl*
 inherited MakeDocInfo(aNode);
 Result := bsDocInfoMake(CurrentEntryInfo,
                         aNode,
                         ImpList,
                         LG_RUSSIAN,
                         Root);
//#UC END# *47F0C98F020C_47E9EDD301A4_impl*
end;//TdsDrugList.MakeDocInfo

function TdsDrugList.MakeImageList: Il3ImageList;
//#UC START# *47F465F80149_47E9EDD301A4_var*
//#UC END# *47F465F80149_47E9EDD301A4_var*
begin
//#UC START# *47F465F80149_47E9EDD301A4_impl*
 Result := vtMakeImageListWrapper(nsListRes.ilDrugListItems);
//#UC END# *47F465F80149_47E9EDD301A4_impl*
end;//TdsDrugList.MakeImageList

procedure TdsDrugList.DoUpdateListInfo;
//#UC START# *47F4BDDB026E_47E9EDD301A4_var*
//#UC END# *47F4BDDB026E_47E9EDD301A4_var*
begin
//#UC START# *47F4BDDB026E_47E9EDD301A4_impl*
 if (ucc_DrugList <> nil) then
  ucc_DrugList.UpdateListInfo;
//#UC END# *47F4BDDB026E_47E9EDD301A4_impl*
end;//TdsDrugList.DoUpdateListInfo

procedure TdsDrugList.MarkNodeForExport(const aNode: Il3SimpleNode;
  aOnlyFirstLevel: Boolean);
//#UC START# *47F9BFED004F_47E9EDD301A4_var*
//#UC END# *47F9BFED004F_47E9EDD301A4_var*
begin
//#UC START# *47F9BFED004F_47E9EDD301A4_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=481814546
 inherited MarkNodeForExport(aNode, True);
//#UC END# *47F9BFED004F_47E9EDD301A4_impl*
end;//TdsDrugList.MarkNodeForExport

{$If not defined(NoVCM)}
function TdsDrugList.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_47E9EDD301A4_var*
//#UC END# *55097FF5008E_47E9EDD301A4_var*
begin
//#UC START# *55097FF5008E_47E9EDD301A4_impl*
 Result := DefDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_47E9EDD301A4_impl*
end;//TdsDrugList.GetIsDataAvailable
{$IfEnd} //not NoVCM

procedure TdsDrugList.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IsdsDrugList, ucc_DrugList);
end;

procedure TdsDrugList.ClearRefs;
begin
 inherited;
 ucc_DrugList := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

end.