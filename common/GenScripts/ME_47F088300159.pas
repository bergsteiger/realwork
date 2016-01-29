unit evInternalInterfaces;

interface

uses
 l3IntfUses
 , evdInterfaces
 , nevTools
 , l3Interfaces
 , nevBase
 , l3Variant
 , l3Types
 , l3Core
;

type
 PIevDataObject = ^IevdDataObject;
 
 IevColumnBorderMarker = interface(IevMarker)
  {* ������ ������� ������ ������� }
 end;//IevColumnBorderMarker
 
 IevChangeParamTool = interface
  {* ���������� ��� ��������� ���������� ���� }
  function ChangeParam(const aMarker: IevMarker;
   aValue: Integer;
   const anOpPack: InevOp;
   SeeByLevel: Boolean;
   aMinIndex: Tl3Index;
   aMaxIndex: Tl3Index): Boolean;
   {* �������� �������� ��������� }
 end;//IevChangeParamTool
 
 IevObjectFrame = interface
  function ObjectXOffset: Integer;
 end;//IevObjectFrame
 
 TShiftState = l3Core.TShiftState;
 
 TevMouseButton = Tl3MouseButton;
  {* ������ ���� }
 
 TevMouseAction = Tl3MouseAction;
  {* ������� ���� }
 
 IevSubFlagsSpy = interface
  {* ������, ����������� ����������� �� ��������� ������ ����� (IevSub) }
  procedure NotifyFlagsChange(const aSub: IevSub);
   {* ����� ����� ���������� }
 end;//IevSubFlagsSpy
 
 IevMarkerSpy = interface
  {* ������, ����������� ����������� � ��������� �������� }
  procedure NotifyMarkerChange;
   {* ������� ���������� }
 end;//IevMarkerSpy
 
 IevCursorSource = interface
  {* ������-�������� ������� }
  procedure MakeCursor;
   {* ������� ������ }
  procedure InitAACLikeCursor;
 end;//IevCursorSource
 
 InevContentsNodeFilter = interface
  procedure ColorNode(const aNode: InevNode);
  procedure CheckTagList;
  procedure AddFilterTag(aTag: Tl3Variant);
  procedure ChangeDocument(aDocument: Tl3Variant);
  function NeedCreate(aTag: Tl3Variant): Boolean;
 end;//InevContentsNodeFilter
 
 IevF1LikeEditor = interface
  function CanInsertParaOnMove: Boolean;
   {* ����� �� ��������� ��������� ��� �������� ������� }
  function IsInReadOnlyPara(const aPara: InevPara;
   NeedDeleteIfReadOnly: Boolean): Boolean;
   {* ��������� �� � ���������, � ������� ��������� �������������� }
 end;//IevF1LikeEditor
 
 TevMergeParaListType = (
  ev_mltBlocks
  , ev_mtlTables
  , ev_mtlCells
 );//TevMergeParaListType
 
implementation

uses
 l3ImplUses
;

end.
