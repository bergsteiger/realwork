unit k2TagPointer;

interface

uses
 l3IntfUses
 , k2ToolPrim
 , k2Interfaces
 , l3Variant
 , k2Prim
;

type
 Tk2TagPointer = class(Tk2ToolPrim, Ik2TagListener, Ik2TagTool)
  procedure ClearTagCache;
  procedure DoFire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
  procedure ClearParents;
  function GetParentTool: Ik2TagTool;
  function GetExcludeEvents: Tk2EventIDs;
  procedure Create(aTag: Tl3Variant);
  function NeedEvents: Boolean;
   {* ����� �� ������������� �� ������� ����� }
  procedure TagChanged(aNew: Tl3Variant);
  function Make(aTag: Tl3Variant): Ik2TagTool;
  procedure Fire(const anEvent: Tk2Event;
   const anOp: Ik2Op);
   {* ��������� � ���, ��� c ����� ���-�� ���������. }
  function ExcludeEvents: Tk2EventIDs;
   {* �������, ������� �� ���� �������. }
  function ParentTool: Ik2TagTool;
   {* ���������� ������������� ����. }
  procedure SetTagQT(aTag: Tl3Variant);
 end;//Tk2TagPointer
 
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
