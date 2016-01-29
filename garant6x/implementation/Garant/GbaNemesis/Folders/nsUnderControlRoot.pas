unit nsUnderControlRoot;

////////////////////////////////////////////////////////////////////////////////
// ���������� : ������ �������;
// ���������� : ������ ������ ���������� �� ��������;
// ������     : $Id: nsUnderControlRoot.pas,v 1.5 2013/06/03 11:51:37 kostitsin Exp $
////////////////////////////////////////////////////////////////////////////////

interface

uses
  afwInterfaces,

  l3TreeInterfaces,
  l3Tree_TLB,
  l3Interfaces,
  l3LongintList,

  BaseTreeSupportUnit,

  nsNodes,
  nsTypes,

  FoldersDomainInterfaces
  ;

type
  TnsUnderControlRoot = class(TnsCacheableNode,
                              InsUnderControlRoot)
  private
  // fields
    f_SortType : TnsUCSortType;
  protected
  // methods
   function pm_GetSortType: TnsUCSortType;
   procedure pm_SetSortType(aValue: TnsUCSortType);
    function DoCompareChild(const aChildrenNode1, aChildrenNode2 : Il3Node) : Integer;
     override;
     {* - ���������� aChildrenNode1 � aChildrenNode2 (������ Text),  ����������
          <0 ���� aChildrenNode1 < aChildrenNode2
           0 ���� aChildrenNode1 = aChildrenNode2
          >0 ���� aChildrenNode1 > aChildrenNode2
          ������������ ��� ���������� ����� ������. }
  public
  // methods
    class function Make: Il3Node;
      reintroduce;
      {-}
  end;//TnsUnderControlRoot

implementation

uses
  SysUtils,

  l3String,
  l3Types,
  l3MinMax,
  l3Nodes,
  l3Base,

  vcmBase,

  UnderControlUnit,
  DataAdapter,

  nsUtils,
  nsUnderControlNode,

  StdRes
  ;

// Start class TnsUnderControlRoot

class function TnsUnderControlRoot.Make : Il3Node;
var
 l_Node : TnsUnderControlRoot;
begin
 l_Node := Create(nil, -1, -1);
 try
  result := l_Node;
 finally
  FreeAndNil(l_Node);
 end;
end;

function TnsUnderControlRoot.pm_GetSortType: TnsUCSortType;
begin
 Result := f_SortType;
end;

procedure TnsUnderControlRoot.pm_SetSortType(aValue: TnsUCSortType);
begin
 f_SortType := aValue;
 SortChilds;
end;

function TnsUnderControlRoot.DoCompareChild(const aChildrenNode1,
                                                aChildrenNode2 : Il3Node): Integer;
 //override;
var
 l_Controllable1,
 l_Controllable2: IControllable;
begin
 case f_SortType of
  ucstAlphabet :
    Result := l3Compare(aChildrenNode1.Text, aChildrenNode2.Text, l3_siCaseUnsensitive);
  ucstChanging :
   begin
    Result := 0;
    // ���������� �������� �� ���� ���������
    if Supports(aChildrenNode1, IControllable, l_Controllable1) and
       Supports(aChildrenNode2, IControllable, l_Controllable2) then
     try
       Result := ULongComp(LongInt(l_Controllable2.GetControlStatus), LongInt(l_Controllable1.GetControlStatus));
     finally
      l_Controllable1 := nil;
      l_Controllable2 := nil;
     end;

    // ���� �������� �����, �� ���������� �� ��������
    if Result = 0 then
     Result := l3Compare(aChildrenNode1.Text, aChildrenNode2.Text, l3_siCaseUnsensitive);
   end;
  else
   Result := 0;
 end;
end;

end.
