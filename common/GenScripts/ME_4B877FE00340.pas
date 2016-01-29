unit eeEditorExportModelPart;

interface

uses
 l3IntfUses
 , evTunedEditor
 , eeInterfaces
 , afwInterfaces
 , nevGUIInterfaces
 , eeInterfacesEx
 , nevTools
 , Windows
 , evCustomEditorModelPart
 , evTypes
 , eeDocumentTool
 , evdTypes
 , l3Interfaces
 , k2Base
 , l3IID
 , Classes
;

type
 TeeBlock = class(TeeDocumentTool, IeeBlock)
  procedure Create(const aDocument: IeeDocumentEx;
   anID: Integer;
   aLayerID: Integer);
  procedure Make(const aDocument: IeeDocumentEx;
   anID: Integer;
   aLayerID: Integer);
  function Delete: Boolean;
  function Exists: Boolean;
  function Select: Boolean;
  function IsSame(const aSub: IeeSub): Boolean;
  function SubPlace: TevSubPlace;
  function ID: Integer;
  function LayerID: Integer;
  function Flag: Integer;
  function Flags: Integer;
  function Name: Tl3WString;
  function Next: IeeSub;
   {* ��������� ����� ��������� � ��� �� ���� }
  function LeafPara: IeeLeafPara;
   {* �����, �� ������� ��������� �����, �������� ������� ������� ������ }
  function Para: IeePara;
   {* �����, �� ������� ��������� ����� }
  function Document: IeeDocument;
  function ParentBlock: IeeBlock;
  function IsKindOf(aType: Tk2Type): Boolean;
 end;//TeeBlock
 
 TeeCanSplitParaEvent = procedure(aSender: TObject;
  const aPara: IeePara;
  var Allow: Boolean) of object;
 
 TeeBlockChangeEvent = TNotifyEvent;
 
 TeeBlockScrollEvent = procedure(aSender: TObject;
  aDown: Boolean) of object;
 
 TeeEditorExportModelPart = class(TevTunedEditor, IeeEditor, IeeDocument, IeeData, IeeCommands)
  {* ����� TeeEditorExport ������������ �� ������ }
  function MakeHotSpot(const aPt: TafwPoint;
   const aHotSpot: IevHotSpot;
   out theHotSpot: IeeHotSpot): Boolean;
  function AsIeeDocumentEx: IeeDocumentEx;
  function CanInsertParaOnMove: Boolean;
   {* ����� �� ��������� ��������� ��� �������� ������� }
  function IsInReadOnlyPara(const aPara: InevPara;
   NeedDeleteIfReadOnly: Boolean): Boolean;
   {* ��������� �� � ���������, � ������� ��������� �������������� }
  function Block: IeeBlock;
  function BlockEx: IeeBlock;
  function Subs: IeeSubList;
   {* ������ ����� � ��������� (Sub'�) }
  function Markers: IeeSubList;
   {* ������ ���������������x ����� � ��������� }
  function Bookmarks: IeeSubList;
   {* ������ ���������������x �������� � ��������� }
  function Marks: IeeSubList;
  function ExternalHandle: Integer;
   {* ������� ������������� ��������� }
  function Document: IeeDocument;
  procedure Cut;
  procedure Copy;
  procedure Delete;
  function Paste: Boolean;
  procedure SelectAll;
  procedure HideSelection;
  function GetHotspotOnPoint(const aPt: TPoint;
   out theHotSpot: IeeHotSpot): Boolean;
  function CanSplitPara(const aPara: IeePara): Boolean;
  function Commands: IeeCommands;
  function Data: IeeData;
 end;//TeeEditorExportModelPart
 
implementation

uses
 l3ImplUses
 , nevNavigation
 , SysUtils
 , eeHotSpot
 , eeSubList
 , evStandardActions
 , nevBase
 , TtfwClassRef_Proxy
 , l3InterfacesMisc
 , eeSub
 , eePara
 , l3String
 , l3Variant
;

end.
