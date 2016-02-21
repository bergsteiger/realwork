unit dsDrugList;
 {* ������ ������������� ���������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dsDrugList.pas"
// ���������: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , PrimPrimListInterfaces
 , DocumentInterfaces
 , l3InternalInterfaces
 , DynamicTreeUnit
 , l3TreeInterfaces
 , l3Interfaces
 , DocumentAndListInterfaces
 , afwInterfaces
 , DynamicDocListUnit
 , nsRootManager
 , WorkWithListInterfaces
 , BaseDocumentWithAttributesInterfaces
 , FiltersUnit
 , bsTypes
 , DocumentUnit
 , nsTypes
 , PreviewInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , WorkWithDocumentInterfaces
;

type
 _InitDataType_ = IdeList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}
 TdsDrugList = {final} class(_dsList_, IdsDrugList)
  {* ������ ������������� ���������� }
  private
   DrugList: IsdsDrugList;
  protected
   function MakeDocInfo(const aNode: INodeBase): IdeDocInfo; override;
    {* ������� ���������� � ��������� �� ����. }
   function MakeImageList: Il3ImageList; override;
    {* - ������� ������ ������. }
   procedure DoUpdateListInfo; override;
    {* - �������� ���������� � ������. }
   procedure MarkNodeForExport(const aNode: Il3SimpleNode;
    aOnlyFirstLevel: Boolean); override;
    {* - �������� ���� ��� ��������. }
   {$If NOT Defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
    {* ���������� �� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , bsUtils
 , BaseTypesUnit
 , vtUtils
 , ListRes
 , DataAdapter
 , afwComplexDocumentPreview
 , nsINodesClipboardDataObject
 , nsHAFPainter
 , nsDocumentPreview
 , nsIListDataObject
 , IOUnit
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTreeSupportUnit
 , nsNodes
 , nsDocumentTools
 , l3Nodes
 , nsExternalObjectPrim
 , bsConvert
 , nsDocumentStreamWrapper
 , afwFacade
 , evMultiDocumentPreview
 , bsConst
 , evHTMLDataObject
 , l3Memory
 , nsFolders
 , nsSuperComplexDocumentPreview
 , bsListTreeStruct
 , nevBase
 , nsListHAFMacroReplacer
 , evFormatHAFMacroReplacer
 , LoggingInterfaces
 , nsListPrintEvent
 , deList
 , nevInterfaces
 , bsTypesNew
 , nsFiltersContainer
 , nsTreeMultiDocumentPreviewContainer
 , bsDocumentMissingMessage
 , nsExternalObjectModelPart
 , nsDocumentStreamList
 , nsListExceptions
 , nsFiltersUtils
 , nsFiltersInterfaces
 , nsDocumentWithSnippetList
 , l3Base
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsDrugList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}

function TdsDrugList.MakeDocInfo(const aNode: INodeBase): IdeDocInfo;
 {* ������� ���������� � ��������� �� ����. }
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
 {* - ������� ������ ������. }
//#UC START# *47F465F80149_47E9EDD301A4_var*
//#UC END# *47F465F80149_47E9EDD301A4_var*
begin
//#UC START# *47F465F80149_47E9EDD301A4_impl*
 Result := vtMakeImageListWrapper(nsListRes.ilDrugListItems);
//#UC END# *47F465F80149_47E9EDD301A4_impl*
end;//TdsDrugList.MakeImageList

procedure TdsDrugList.DoUpdateListInfo;
 {* - �������� ���������� � ������. }
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
 {* - �������� ���� ��� ��������. }
//#UC START# *47F9BFED004F_47E9EDD301A4_var*
//#UC END# *47F9BFED004F_47E9EDD301A4_var*
begin
//#UC START# *47F9BFED004F_47E9EDD301A4_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=481814546
 inherited MarkNodeForExport(aNode, True);
//#UC END# *47F9BFED004F_47E9EDD301A4_impl*
end;//TdsDrugList.MarkNodeForExport

{$If NOT Defined(NoVCM)}
function TdsDrugList.GetIsDataAvailable: Boolean;
 {* ���������� �� ������ }
//#UC START# *55097FF5008E_47E9EDD301A4_var*
//#UC END# *55097FF5008E_47E9EDD301A4_var*
begin
//#UC START# *55097FF5008E_47E9EDD301A4_impl*
 Result := DefDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_47E9EDD301A4_impl*
end;//TdsDrugList.GetIsDataAvailable
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
