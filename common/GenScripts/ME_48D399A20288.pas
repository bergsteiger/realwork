unit evDropCombo;

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , nevBase
 , l3Interfaces
 , l3TreeInterfaces
 , nevTools
;

type
 TEditableState = (
  esNone
  , esSemiCompleted
  , esCompleted
  , esWrong
 );//TEditableState
 
 TevDropCombo = class(TevDropControl, IevEditorFieldWithTree, IevDropCombo)
  function GetFullPath(const aNode: InevSimpleNode): Il3CString;
  procedure CheckAsterisk;
  function ComboReq: IevComboReq;
  procedure InitTree;
  function MakeNodesFromItems: Boolean;
  procedure ChangeDropTreeForHistory(ForHistory: Boolean);
  procedure SetRootNode(const Value: InevNode);
  procedure Change(const aView: InevView;
   const aPara: InevPara);
  procedure DefilterTree;
  procedure SetRoot(const aRoot: InevNode);
  procedure ChooseMean(NeedHide: Boolean);
  procedure FilterPromptTree;
  procedure FilterNewTree;
  function Filter(const aExpTree: Il3FilterableTree;
   const aContext: Il3CString;
   out anIndex: Integer;
   AutoOpen: Boolean;
   NeedRefilter: Boolean): Il3SimpleTree;
  procedure DoSetContextText(const aText: Il3CString);
  procedure SetNodeByIndex(aIndex: Integer);
  function GetNodeIndex(const aNode: InevSimpleNode): Integer;
   {* ���������� ����� ����. }
  procedure ShowNode(const aNode: InevSimpleNode);
   {* ���������� ���� � ����. }
  function Value: InevSimpleNode;
   {* ��������� ���� � ������. }
  function IsAsterisk: Boolean;
   {* ������������ �� � ������ ������ '*'. }
  function DefaultNode: InevSimpleNode;
   {* ���� � ��������� �� ���������. }
  function Asterisk: AnsiChar;
   {* ������ ���������. }
  function SourceTree: InevSimpleTree;
   {* ������ � �������.
� ���� - Get_Tree. }
  function ComboStyle: TevComboStyle;
   {* ����� ��������� ����������� ������. }
  function LogicalState: Integer;
   {* ������������ ���������� �������� ��� ����. }
  function Down: Boolean;
   {* ������ �� ������ � ���������.
� ���� - Get_Checked/Set_Checked. }
  procedure CheckTextVersusValue;
   {* ������� �� ��� ������ ����� ����� Undo ����� � �������� �� ���������
        � ��������� ����� - � ���� ������ ������� ���. }
  function GetNode(anIndex: Integer): InevSimpleNode;
   {* ���������� ����. }
  procedure ChooseNode(const Value: InevSimpleNode;
   NeedHide: Boolean);
   {* ���������� ������ ���� � ������ ��� ��� ��������. }
  function IsList: Boolean;
  function NeedClearOnEscape: Boolean;
  procedure DoDrop(const aPoint: TPoint;
   AInvert: Boolean;
   AWidth: Integer;
   ByUser: Boolean);
   {* ���������� ���������� ������ �� ��������� ����������� }
  function IsLogicalStateButtonEnabled: Boolean;
  procedure SetMaskText(const aText: Il3CString);
 end;//TevDropCombo
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Chars
 , evControlParaTools
 , l3String
 , l3Const
 , k2Tags
 , evParaTools
 , l3Tree
 , l3Base
 , l3Nodes
 , evTextStyle_Const
 , l3Types
 , evTextParaTools
 , evdTextStyle_Const
 , l3Tree_TLB
;

end.
