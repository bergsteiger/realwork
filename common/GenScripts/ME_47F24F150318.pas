unit evSubImplementation;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , l3Variant
 , evdTypes
 , l3Interfaces
 , k2ProcTagTool
 , nevBase
;

type
 TevDocumentImplementation = class
  {* ���������� ���������� IevDocument. }
 end;//TevDocumentImplementation
 
 TevDocumentPartImplementation = class(Tl3CacheableBase, IevSub, IevDocumentPart, IevDocumentPoint)
  procedure SetTo(EntryPoint: Tl3Variant);
   {* ������������� ����� � EntryPoint. }
  function Select(const Selection: InevSelection): Boolean; overload;
   {* ���������� Selection �� ������ �����. }
  function Delete(const aView: InevView): Boolean;
   {* ������� �����. }
  function IsInIndex: Boolean;
  function Exists: Boolean;
   {* ��������� ���������� �� ����� �����. }
  function SubInstance: Tl3Variant;
   {* ���������� Sub. }
  function SubPlace: TevSubPlace;
   {* �������� �� ���� � ����������. }
  function Name: Tl3WString;
   {* ��� �����. }
  function ID: Integer;
   {* ������������� �����. }
  function LayerID: Integer;
   {* ������������� ���� �� ������� ��������� �����. }
  function Flags: Integer;
   {* ����� ������� ������ �����. }
  function Cursor: Tl3Tag;
   {* ������ �� �����. }
  function SubList: InevSubList;
   {* ������ �����. }
  function Next: IevSub;
   {* ��������� ����� ���������. }
  function LeafPara: Tl3Variant;
   {* �������� ������� ������, �� ������� ��������� �����. }
  function Para: Tl3Variant;
   {* ��������, �� ������� ��������� �����. }
  function Document: IevDocument;
  function Merge: Boolean;
   {* ���������� ���� �� ���������. }
  function ExternalHandle: Integer;
   {* ������� ������������� ����� (��� ���������� � RTF). }
  function ObjType: Integer;
   {* ��� �������� ������� ObjType. }
  function ParaCount: Integer;
   {* ����� ���������� � �����. }
  function ParentDocumentPart: IevDocumentPart;
   {* ������������ ����. }
  function ContentsRec: TevContentsRec;
   {* ������� ����� � ����������. }
  function Select(const Selection: InevSelection): Boolean; overload;
   {* ���������� Selection �� ������ �����. }
  function Obj: PInevObject;
  function IsVisibleOnSubPanel: Boolean;
  function GetViewKind: TevBlockViewKind;
 end;//TevDocumentPartImplementation
 
 TevSubImplementation = class(Tk2ProcTagTool)
  function DoGetFlags(aTag: Tl3Variant;
   aFlag: LongInt): LongInt;
 end;//TevSubImplementation
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

end.
