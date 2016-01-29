unit evInternalInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/evInternalInterfaces.pas"
// �����: 28.09.1999 10:18
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::evInternalInterfaces
//
// ��������� �������� ���������� ������� ������ ��� ���������� "�������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  l3Types,
  nevBase,
  l3Core,
  nevTools,
  evdInterfaces
  ;

type
 PIevDataObject = ^IevdDataObject;

 IevColumnBorderMarker = interface(IevMarker)
  {* ������ ������� ������ ������� }
   ['{1EC1FA6B-67EB-41A5-811B-20683FE4AFB4}']
   function pm_GetColumnID: Integer;
   procedure pm_SetColumnID(aValue: Integer);
   property ColumnID: Integer
     read pm_GetColumnID
     write pm_SetColumnID;
     {* ����� ������ ��� ������� �������� ������ ������ (������� � 1) }
 end;//IevColumnBorderMarker

{$If defined(evNeedHotSpot)}
 IevChangeParamTool = interface(IUnknown)
  {* ���������� ��� ��������� ���������� ���� }
   ['{33D9C262-0D09-41ED-B63B-0DE6FCE9EE13}']
   function ChangeParam(const aMarker: IevMarker;
    aValue: Integer;
    const anOpPack: InevOp;
    SeeByLevel: Boolean = False;
    aMinIndex: Tl3Index = l3MinIndex;
    aMaxIndex: Tl3Index = l3MaxIndex): Boolean;
     {* �������� �������� ��������� }
 end;//IevChangeParamTool
{$IfEnd} //evNeedHotSpot

 IevObjectFrame = interface(IUnknown)
   ['{841E16E1-E852-4CEF-A22B-240346E83282}']
   function ObjectXOffset: Integer;
 end;//IevObjectFrame

 TShiftState = l3Core.TShiftState;

 TevMouseButton = l3Interfaces.Tl3MouseButton;
  {* ������ ���� }

 TevMouseAction = l3Interfaces.Tl3MouseAction;
  {* ������� ���� }

 IevSubFlagsSpy = interface(IUnknown)
  {* ������, ����������� ����������� �� ��������� ������ ����� (IevSub) }
   ['{C93F6D8C-E15D-473A-99B2-567EF6FE2709}']
   procedure NotifyFlagsChange(const aSub: IevSub);
     {* ����� ����� ���������� }
 end;//IevSubFlagsSpy

 IevMarkerSpy = interface(IUnknown)
  {* ������, ����������� ����������� � ��������� �������� }
   ['{EF9AAA90-9524-42AE-B834-6E38523B0D47}']
   procedure NotifyMarkerChange;
     {* ������� ���������� }
 end;//IevMarkerSpy

 IevCursorSource = interface(IUnknown)
  {* ������-�������� ������� }
   ['{29ADCD6B-90B4-49FD-B4FC-118C765B427E}']
   procedure MakeCursor;
     {* ������� ������ }
   procedure InitAACLikeCursor;
 end;//IevCursorSource

 InevContentsNodeFilter = interface(IUnknown)
   ['{9E8D86EF-CA35-4601-9BE6-7E0054456FE5}']
   function pm_GetFilteredNodeFlag: Integer;
   procedure pm_SetFilteredNodeFlag(aValue: Integer);
   procedure ColorNode(const aNode: InevNode);
   procedure CheckTagList;
   procedure AddFilterTag(aTag: Tl3Variant);
   procedure ChangeDocument(aDocument: Tl3Variant);
   function NeedCreate(aTag: Tl3Variant): Boolean;
   property FilteredNodeFlag: Integer
     read pm_GetFilteredNodeFlag
     write pm_SetFilteredNodeFlag;
 end;//InevContentsNodeFilter

const
  { Mouse Constants }
 ev_mbLeft = l3_mbLeft;
 ev_mbMiddle = l3_mbMiddle;
 ev_mbRight = l3_mbRight;
 ev_maDown = l3_maDown;
 ev_maUp = l3_maUp;
 ev_maDouble = l3_maDouble;
 ev_maMove = l3_maMove;
 ev_maCtlMove = l3_maCtlMove;

type
 IevF1LikeEditor = interface(IUnknown)
   ['{44931BB3-8D47-435C-9F5F-41F9CC25F0E8}']
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

end.