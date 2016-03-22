unit TestDocListUtils;
 {* ������� ��, ��� ������ �� ������� ����������. }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\TestDocListUtils.pas"
// ���������: "UtilityPack"
// ������� ������: "TestDocListUtils" MUID: (499C28950272)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(XE)}
uses
 l3IntfUses
 , DynamicDocListUnit
 {$If Defined(Nemesis)}
 , nscTreeView
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
 , DocumentUnit
;

function GetLEIFromTTV(aTTV: TnscTreeView): IListEntryInfo;
 {* �������, ��� ���? }
function GetLEIFromNode(const aNode: Il3SimpleNode): IListEntryInfo;
 {* �������, ��� ���? }
function GetSubIDByParaID(const aDocument: IDocument;
 aParaID: Integer): Integer;
 {* ���������� ����� ���� �� ������ ��������� }
{$IfEnd} // NOT Defined(XE)

implementation

{$If NOT Defined(XE)}
uses
 l3ImplUses
 , DynamicTreeUnit
 , BaseTypesUnit
 , SysUtils
 , k2Tags
 , k2Facade
 , LeafPara_Const
 , Sub_Const
 , Bookmark_Const
;

function GetLEIFromTTV(aTTV: TnscTreeView): IListEntryInfo;
 {* �������, ��� ���? }
//#UC START# *499C29190244_499C28950272_var*
var
 l_Node : INodeBase;
 l_BaseEntity : IEntityBase;
 l_ListEntry : IListEntryInfo;
//#UC END# *499C29190244_499C28950272_var*
begin
//#UC START# *499C29190244_499C28950272_impl*
 Result := nil;
 if Supports(aTTV.GetCurrentNode, INodeBase, l_Node) then
 begin
  l_Node.GetEntity(l_BaseEntity);
  if Supports(l_BaseEntity, IListEntryInfo, l_ListEntry) then
   Result := l_ListEntry;
 end;//Supports(aTTV.GetCurrentNode, INodeBase, l_Node)
//#UC END# *499C29190244_499C28950272_impl*
end;//GetLEIFromTTV

function GetLEIFromNode(const aNode: Il3SimpleNode): IListEntryInfo;
 {* �������, ��� ���? }
//#UC START# *499C296703E6_499C28950272_var*
var
 l_Node : INodeBase;
 l_BaseEntity : IEntityBase;
 l_ListEntry : IListEntryInfo;
//#UC END# *499C296703E6_499C28950272_var*
begin
//#UC START# *499C296703E6_499C28950272_impl*
 Result := nil;
 if Supports(aNode, INodeBase, l_Node) then
 begin
  l_Node.GetEntity(l_BaseEntity);
  if Supports(l_BaseEntity, IListEntryInfo, l_ListEntry) then
   Result := l_ListEntry;
 end;//Supports(aNode, INodeBase, l_Node)
//#UC END# *499C296703E6_499C28950272_impl*
end;//GetLEIFromNode

function GetSubIDByParaID(const aDocument: IDocument;
 aParaID: Integer): Integer;
 {* ���������� ����� ���� �� ������ ��������� }
//#UC START# *499C3C1E014C_499C28950272_var*
  var
    l_DocTagRoot, l_CurrNode, l_ParaNode, l_SubNode, l_TempNode : INodeBase;
    l_NodeIter : INodeIterator;
    l_IsGoToParent : Boolean;
//#UC END# *499C3C1E014C_499C28950272_var*
begin
//#UC START# *499C3C1E014C_499C28950272_impl*
 Result := -1;
 Assert(false);
  // �������� ������ ������ ���������
(*  aDocument.GetTagStructureRoot(l_DocTagRoot);
  if (l_DocTagRoot <> nil) then
  begin
    // �������� ��������
    l_DocTagRoot.IterateAllNodes(FM_SHARED_NONE, l_NodeIter);
    if (l_NodeIter <> nil) then
    begin
      // ���� �������� � �������� �������
      l_ParaNode := nil;
      l_NodeIter.GetNext(l_CurrNode);
      while (l_CurrNode <> nil) do
      begin
        if (l_CurrNode.GetNodeId = aParaID) AND k2.TypeTable[l_CurrNode.GetType].InheritsFrom(k2_typLeafPara) then
        begin // ����� ��������
          l_ParaNode := l_CurrNode;
          l_CurrNode := nil;
          break;
        end;
        // �������� ��������� ����
        l_NodeIter.GetNext(l_CurrNode);
      end;
      l_NodeIter := nil;
      //
      if (l_ParaNode <> nil) then
      begin // �������� ������
        l_SubNode := nil;
        // ������ ���� ���
        l_IsGoToParent := false;
        repeat
          // � �������� ��������� ���� �������� ���
          if (l_ParaNode.HasChildren) then
          begin
            l_ParaNode.GetFirstChild(l_CurrNode);
            while (l_CurrNode <> nil) do
            begin
              if k2.TypeTable[l_CurrNode.GetType].InheritsFrom(k2_typSub)
                AND (NOT k2.TypeTable[l_CurrNode.GetType].InheritsFrom(k2_typBookmark)) then
              begin // ����� ���
                l_SubNode := l_CurrNode;
                l_CurrNode := nil;
                break;
              end;
              // �������� ��������� ����
              l_TempNode := l_CurrNode;
              l_TempNode.GetNext(l_CurrNode);
              l_TempNode := nil;
            end; // while
          end; // if
          //
          if (l_SubNode <> nil) then
            break // �� ����� ���, ������� �� �����
          else // ��� �� �����, ������� ������ ������� ���������� ������ ���������� ��������
          begin
            l_CurrNode := l_ParaNode;
            while (true) do
            begin
              // �������� ���������� ����
              l_TempNode := l_CurrNode;
              l_TempNode.GetPrev(l_CurrNode);
              l_TempNode := nil;
              // ���� ��� �����������, �� �������
              if (l_CurrNode = nil) then
              begin
                l_IsGoToParent := true;
                break;
              end;
              if k2.TypeTable[l_CurrNode.GetType].InheritsFrom(k2_typLeafPara) then
              begin // ����� ��������
                l_ParaNode := l_CurrNode;
                break;
              end; //if
            end; // while
            l_CurrNode := nil;
          end; // if
        until l_IsGoToParent;
        // ������, ���������, ���� ��� �� ������, �� ���� ������
        if (l_SubNode = nil) then
        begin // �������� ��� �� ������, ������� ���� ������������
          l_ParaNode.GetParent(l_CurrNode);
          while (l_CurrNode <> nil) do
          begin
            if k2.TypeTable[l_CurrNode.GetType].InheritsFrom(k2_typSub) then
            begin // ����� ���
              l_SubNode := l_CurrNode;
              l_CurrNode := nil;
              break;
            end;
            // �������� ��������� ����
            l_TempNode := l_CurrNode;
            l_TempNode.GetParent(l_CurrNode);
            l_TempNode := nil;
          end; // while
        end; // if
        // ���� ��� ������, ���������� ��� �����
        if (l_SubNode <> nil) then
        begin
          // ������, ���������, � �� ������� �� ��� ���
          if (l_SubNode.GetLevel = 1) then
            Result := 0 // �������, ���������� ����
          else
            Result := l_SubNode.GetNodeId; // �� �������, ���������� ����� ����
        end;
      end;
    end; // if
  end; // if*)
//#UC END# *499C3C1E014C_499C28950272_impl*
end;//GetSubIDByParaID
{$IfEnd} // NOT Defined(XE)

end.
