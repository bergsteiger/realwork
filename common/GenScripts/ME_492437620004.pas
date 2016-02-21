unit dsTreeAttributeSelect;
 {* ������ ������ ����� ��������� �������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTreeAttributeSelect.pas"
// ���������: "ViewAreaControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchInterfaces
 , L10nInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchDomainInterfaces
 , TreeInterfaces
 , bsInterfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _FormDataSourceType_ = IdsTreeAttributeSelect;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSituation.imp.pas}
 TdsTreeAttributeSelect = class(_dsSituation_, IdsTreeAttributeSelect)
  {* ������ ������ ����� ��������� �������� ������ }
  private
   SelectedAttributes: IbsSelectedAttributes;
   f_CaptionMap: InsStringValueMap;
  protected
   function MakeSimpleTree: Il3SimpleTree; override;
    {* ������� ������ ������ }
   function pm_GetRefreshValues: InsSelectedAttributesIterators;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure UpdateSelectedAttributes;
    {* �������� ������ � ����� ��������� ��������� }
 end;//TdsTreeAttributeSelect

implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsLogicOperationToFlags
 , nsConst
 , nsAttributeTreeStruct
 , nsValueMaps
 , nsValueMapsIDs
 , nsSelectedAttributesIterators
 , bsUtils
 , l3Base
 , vtUtils
 , vtStdRes
 , nsNewCachableNode
 , Windows
 , l3InterfacesMisc
;

{$If not Declared(_InitDataType_)}type _InitDataType_ = IdeSearch;{$IfEnd}

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsTreeAttributeSelect;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSituation.imp.pas}

function TdsTreeAttributeSelect.MakeSimpleTree: Il3SimpleTree;
 {* ������� ������ ������ }
//#UC START# *47F4C2B9014A_492437620004_var*
var
 lRoot : INodeBase;
//#UC END# *47F4C2B9014A_492437620004_var*
begin
//#UC START# *47F4C2B9014A_492437620004_impl*
 Result := TnsAttributeTreeStruct.Make(PartData.Tag,
                                       False);
 // View �� ������ ������������ � �������������� �������, ��� �� ������ ����.
 // ��� ������, ������� ���� ������� ����� ����� ��������� SimpleTree.
 if Assigned(Result) and Supports(Result.RootNode, INodeBase, lRoot) then
 try
  DropAllOperations(lRoot);
 finally
  lRoot := nil;
 end;
//#UC END# *47F4C2B9014A_492437620004_impl*
end;//TdsTreeAttributeSelect.MakeSimpleTree

function TdsTreeAttributeSelect.pm_GetRefreshValues: InsSelectedAttributesIterators;
//#UC START# *4924354D01CC_492437620004get_var*
var
 l_Root : INodeBase;
//#UC END# *4924354D01CC_492437620004get_var*
begin
//#UC START# *4924354D01CC_492437620004get_impl*
 Result := nil;
 Supports(pm_GetSimpleTree.RootNode, INodeBase, l_Root);

 if Assigned(l_Root) then
  Result := TnsSelectedAttributesIterators.Make(GetOperationIterator(l_Root, loOr),
              GetOperationIterator(l_Root, loAnd), GetOperationIterator(l_Root, loNot));
//#UC END# *4924354D01CC_492437620004get_impl*
end;//TdsTreeAttributeSelect.pm_GetRefreshValues

procedure TdsTreeAttributeSelect.UpdateSelectedAttributes;
 {* �������� ������ � ����� ��������� ��������� }
//#UC START# *4959149300F9_492437620004_var*
//#UC END# *4959149300F9_492437620004_var*
begin
//#UC START# *4959149300F9_492437620004_impl*
 if (SelectedAttributes <> nil) then
  SelectedAttributes.UpdateSelectedAttributes;
//#UC END# *4959149300F9_492437620004_impl*
end;//TdsTreeAttributeSelect.UpdateSelectedAttributes

procedure TdsTreeAttributeSelect.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_492437620004_var*
//#UC END# *479731C50290_492437620004_var*
begin
//#UC START# *479731C50290_492437620004_impl*
 f_CaptionMap := nil;
 inherited;
//#UC END# *479731C50290_492437620004_impl*
end;//TdsTreeAttributeSelect.Cleanup

{$If NOT Defined(NoVCM)}
function TdsTreeAttributeSelect.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_492437620004_var*
//#UC END# *491476B001D3_492437620004_var*
begin
//#UC START# *491476B001D3_492437620004_impl*
 if (l3Same(PartData.Tag, AT_KW)) or
    (l3Same(PartData.Tag, AT_PUBLISH_SOURCE)) then
 begin
  if (f_CaptionMap = nil) then
   f_CaptionMap := nsStringMapManager.Map[smap_ContextParamsCaptions];
  Result := f_CaptionMap.ValueToDisplayName(PartData.Tag);
 end//l3Same(PartData.Tag, AT_KW)..
 else
  Result := inherited MakeDisplayName;
//#UC END# *491476B001D3_492437620004_impl*
end;//TdsTreeAttributeSelect.MakeDisplayName
{$IfEnd} // NOT Defined(NoVCM)

end.
