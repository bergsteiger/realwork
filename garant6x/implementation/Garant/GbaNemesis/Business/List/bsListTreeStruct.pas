unit bsListTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/bsListTreeStruct.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::List::TbsListTreeStruct
//
// ������ ������ ������. ���� ���������� �� IdsList ����� ������������� � ������� �������� ������ �
// Data/List
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDataResetTreeStruct,
  DocumentAndListInterfaces,
  l3Interfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  DynamicTreeUnit,
  afwInterfaces,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 IbsListTreeStruct = interface(IUnknown)
  {* ������ ������ ��� ������ }
   ['{F2B07141-C4A5-4757-94AB-EB5EB33572AF}']
   procedure Set_DsList(const aValue: IdsList);
   property dsList: IdsList
     write Set_DsList;
 end;//IbsListTreeStruct

 TbsListTreeStruct = class(TnsDataResetTreeStruct, IbsListTreeStruct)
  {* ������ ������ ������. ���� ���������� �� IdsList ����� ������������� � ������� �������� ������ � Data/List }
 private
 // private fields
   f_dsList : Pointer;
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
   procedure Set_DsList(const aValue: IdsList);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function DoMakeDataObject(const aData: Il3SimpleNode;
    const aBitmap: Il3Bitmap): IDataObject; override;
     {* ������ ������ ������. aData - ������� ������� ������. aBitmap (Il3Bitmap) - �������� ��� �������������� }
   function DoCanAcceptData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData;
    aProcessed: PBoolean): Boolean; override;
   function DoDropData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData;
    var aProcessed: Boolean): Boolean; override;
   function GetFilteredRoot(const aRoot: INodeBase;
    const aFilters: Il3TreeFilters;
    const aCurrentNode: INodeBase;
    out aSyncIndex: Integer;
    aAutoOpen: Boolean;
    FullRefilter: Boolean;
    ApplyEmptyFilter: Boolean): INodeBase; override;
     {* aSyncIndex     : Integer
                              - ���� ��� �������������. ������ ���� ���� �
                                  ������������� ���, ����� ��������� �
                                  ��������� sync_index.
aAutoOpen     : Boolean
                               - ���������� ���� � �������� �������������.
                                   ����, ����� ����� ������� ��������������,
                                   ����� ������������� ������������.
FullRefilter: Boolean
                               - ����������������� ������ ���������
                                   ����� - ��������� ������ (������) aRoot
ApplyEmptyFilter: Boolean
                              - ���� ������ �������� ��������� ������ -
                                   ��� ����� �������� ��� �������� }
   function SettingsID: TafwSettingId; override;
   function DoMakeFiltered(const aFilters: Il3TreeFilters;
    const aCurrentNode: Il3SimpleNode;
    out aSyncIndex: Integer;
    aAutoOpen: Boolean;
    CalcPartialContext: Boolean): Il3SimpleTree; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* ���������� ������� ���������� }
   function ReAqurieUnfilteredRootForMakeResettedSimpleRoot: INodeBase; override;
     {* ^^^ http://mdp.garant.ru/pages/viewpage.action?pageId=324570732&focusedCommentId=327818238#comment-327818238 }
 end;//TbsListTreeStruct
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  bsListDataObject,
  DynamicDocListUnit,
  BaseTypesUnit,
  bsInterfaces,
  nsAdapterFilters,
  nsConst,
  bsListTreeData
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsListTreeStruct

function TbsListTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_47F4D386036C_var*
//#UC END# *48FF64F60078_47F4D386036C_var*
begin
//#UC START# *48FF64F60078_47F4D386036C_impl*
 if f_dsList <> nil then // http://mdp.garant.ru/pages/viewpage.action?pageId=324570732
  IdsList(f_dsList).List.GetRoot(Result)
 else
  Result := nil;
//#UC END# *48FF64F60078_47F4D386036C_impl*
end;//TbsListTreeStruct.ReAqurieUnfilteredRoot

procedure TbsListTreeStruct.Set_DsList(const aValue: IdsList);
//#UC START# *4B1547A80016_47F4D386036Cset_var*
//#UC END# *4B1547A80016_47F4D386036Cset_var*
begin
//#UC START# *4B1547A80016_47F4D386036Cset_impl*
 f_dsList := Pointer(aValue);
//#UC END# *4B1547A80016_47F4D386036Cset_impl*
end;//TbsListTreeStruct.Set_DsList

procedure TbsListTreeStruct.Cleanup;
//#UC START# *479731C50290_47F4D386036C_var*
//#UC END# *479731C50290_47F4D386036C_var*
begin
//#UC START# *479731C50290_47F4D386036C_impl*
 f_dsList := nil;
 inherited;
//#UC END# *479731C50290_47F4D386036C_impl*
end;//TbsListTreeStruct.Cleanup

function TbsListTreeStruct.DoMakeDataObject(const aData: Il3SimpleNode;
  const aBitmap: Il3Bitmap): IDataObject;
//#UC START# *48FEE6210205_47F4D386036C_var*
//#UC END# *48FEE6210205_47F4D386036C_var*
begin
//#UC START# *48FEE6210205_47F4D386036C_impl*
 Result := inherited DoMakeDataObject(aData, aBitmap);
 if Result = nil then
  Result := TbsListDataObject.Make(aData, aBitmap,
   TbsListTreeData.Make(IdsList(f_dsList).List, RootNode, aData));
//#UC END# *48FEE6210205_47F4D386036C_impl*
end;//TbsListTreeStruct.DoMakeDataObject

function TbsListTreeStruct.DoCanAcceptData(const aTargetNode: Il3SimpleNode;
  const aData: Tl3TreeData;
  aProcessed: PBoolean): Boolean;
//#UC START# *48FEE78E01B2_47F4D386036C_var*
var
 l_ListData: IbsListTreeData;
//#UC END# *48FEE78E01B2_47F4D386036C_var*
begin
//#UC START# *48FEE78E01B2_47F4D386036C_impl*
 if Supports(aData.rNodes, IbsListTreeData, l_ListData) then
 begin
  Result := True;
  if aProcessed <> nil then
   aProcessed^ := True;
 end//if Supports(aData.rNodes, IbsListTreeData, l_ListData) then
 else
  Result := inherited DoCanAcceptData(aTargetNode, aData, aProcessed);
//#UC END# *48FEE78E01B2_47F4D386036C_impl*
end;//TbsListTreeStruct.DoCanAcceptData

function TbsListTreeStruct.DoDropData(const aTargetNode: Il3SimpleNode;
  const aData: Tl3TreeData;
  var aProcessed: Boolean): Boolean;
//#UC START# *48FEE9D303B6_47F4D386036C_var*
var
 l_ListData: IbsListTreeData;
//#UC END# *48FEE9D303B6_47F4D386036C_var*
begin
//#UC START# *48FEE9D303B6_47F4D386036C_impl*
 Result := DoCanAcceptData(aTargetNode, aData, nil);
 if Result and Supports(aData.rNodes, IbsListTreeData, l_ListData) then
 begin
  RootNode.AddLastChilds(l_ListData.Nodes);
  aProcessed := True;
 end
 else
  Result := inherited DoDropData(aTargetNode, aData, aProcessed);
 IdsList(f_dsList).UpdateListInfo;
  // - ���������� �������� ���������� ����� ������� (<K>: 105251026);
//#UC END# *48FEE9D303B6_47F4D386036C_impl*
end;//TbsListTreeStruct.DoDropData

function TbsListTreeStruct.GetFilteredRoot(const aRoot: INodeBase;
  const aFilters: Il3TreeFilters;
  const aCurrentNode: INodeBase;
  out aSyncIndex: Integer;
  aAutoOpen: Boolean;
  FullRefilter: Boolean;
  ApplyEmptyFilter: Boolean): INodeBase;
//#UC START# *48FF4C4F03CA_47F4D386036C_var*
  
  function lp_MakeContextFilter: IContextFilter;
  var
   l_Filters: InsAdapterFilters;
  begin
   l_Filters := TnsAdapterFilters.Make;
   try
    FillFilters(aFilters, l_Filters);
    l_Filters.MakeFilterList;
    if l_Filters.FiltersCount > 0 then
     Result := l_Filters.Context
    else
     Result := nil;
   finally
    l_Filters := nil;
   end;//try..finally
  end;//lp_MakeContextFilter

//#UC END# *48FF4C4F03CA_47F4D386036C_var*
begin
//#UC START# *48FF4C4F03CA_47F4D386036C_impl*
(* Assert(aRoot = nil, '�� ���� ���� aRoot ��������, �� �� ����� �� ������������');
 Assert(aCurrentNode = nil, '�� ���� ���� aCurrentNode ��������, �� �� ����� �� ������������');*)
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=330694724

 aSyncIndex := 0;

 if f_dsList <> nil then // http://mdp.garant.ru/pages/viewpage.action?pageId=324570732
  Result := IdsList(f_dsList).ApplyContextFilter(lp_MakeContextFilter)
 else
  Result := nil;
//#UC END# *48FF4C4F03CA_47F4D386036C_impl*
end;//TbsListTreeStruct.GetFilteredRoot

function TbsListTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_47F4D386036C_var*
//#UC END# *48FF56D003E6_47F4D386036C_var*
begin
//#UC START# *48FF56D003E6_47F4D386036C_impl*
 Result := gi_cpDrugList;
//#UC END# *48FF56D003E6_47F4D386036C_impl*
end;//TbsListTreeStruct.SettingsID

function TbsListTreeStruct.DoMakeFiltered(const aFilters: Il3TreeFilters;
  const aCurrentNode: Il3SimpleNode;
  out aSyncIndex: Integer;
  aAutoOpen: Boolean;
  CalcPartialContext: Boolean): Il3SimpleTree;
//#UC START# *48FF5A9002CC_47F4D386036C_var*
//#UC END# *48FF5A9002CC_47F4D386036C_var*
begin
//#UC START# *48FF5A9002CC_47F4D386036C_impl*
 try
  Result := inherited DoMakeFiltered(aFilters,
                                   aCurrentNode,
                                   aSyncIndex,
                                   aAutoOpen,
                                   CalcPartialContext);
  if Result.CountView > 0 then
   IdsList(f_dsList).SimpleTree := Result;
 except
  on EAllContentIsFiltered do
   Result := nil;
 end;//try..except
//#UC END# *48FF5A9002CC_47F4D386036C_impl*
end;//TbsListTreeStruct.DoMakeFiltered

function TbsListTreeStruct.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_47F4D386036C_var*
//#UC END# *4A60B23E00C3_47F4D386036C_var*
begin
//#UC START# *4A60B23E00C3_47F4D386036C_impl*
 Result.SetOK;
 if IID.EQ(IDynList) then
  IDynList(Obj) := IdsList(f_dsList).List
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_47F4D386036C_impl*
end;//TbsListTreeStruct.COMQueryInterface

function TbsListTreeStruct.ReAqurieUnfilteredRootForMakeResettedSimpleRoot: INodeBase;
//#UC START# *4F1D334C0371_47F4D386036C_var*
//#UC END# *4F1D334C0371_47F4D386036C_var*
begin
//#UC START# *4F1D334C0371_47F4D386036C_impl*
 Result := nil;
//#UC END# *4F1D334C0371_47F4D386036C_impl*
end;//TbsListTreeStruct.ReAqurieUnfilteredRootForMakeResettedSimpleRoot

{$IfEnd} //not Admin AND not Monitorings

end.