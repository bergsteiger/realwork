unit k2OperationContainer;

interface

uses
 l3IntfUses
 , k2OpRefList
 , k2Prim
 , l3Variant
 , k2Op
 , l3StringIDEx
;

type
 Ik2OpPackInternal = interface
  {* "�����" ����� ��������. }
  procedure Put(Op: Tk2Op;
   Modify: Boolean);
   {* �������� ��������. }
 end;//Ik2OpPackInternal
 
 Tk2OperationContainer = class(Tk2OpRefList, Ik2OpPackInternal, Il3OpPack)
  function CheckWasExceptionInFreeInOwner: Boolean;
   {* ��������� ���� �� ���������� FreeInOwner � ���������� ���� ���� }
  function GetSaveUndo: Boolean;
  function GetNeedOptimize: Boolean;
  function DoUndo(const aProcessor: Ik2Processor): Integer;
  function DoRedo(const aProcessor: Ik2Processor): Integer;
  procedure FreeInOwner;
  procedure Add(anItem: Tk2Op);
  procedure Create(anOwner: TObject);
  procedure DoSetOwner(Value: TObject);
   {* ����� ��� ��������� "���������" �������. ��� ���������� � ��������. }
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  function InUndo: Boolean;
  function SaveUndo: Boolean;
  function DeleteMapped: Boolean;
  function Optimize: Boolean;
  function InIOProcess: Boolean;
  function Processor: Ik2Processor;
   {* ��������� �������� � ��������� �������� ����������� ������ �����. }
  function Undo(const aProcessor: Ik2Processor): Integer;
   {* ���������� ��� �������� � ���������� �� ����������. }
  function Redo(const aProcessor: Ik2Processor): Integer;
   {* ���������� ��� �������� � ���������� �� ����������. }
  procedure Lock;
   {* �������. }
  procedure Unlock;
   {* �������. }
  function Code: Integer;
   {* ��� �������� }
  procedure Put(Op: Tk2Op;
   Modify: Boolean);
   {* �������� ��������. }
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* ��������� ����� �������� ReadOnly }
  procedure EnableReadOnly;
   {* �������� ����� �������� ReadOnly }
  function ReadOnly: Boolean;
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
 end;//Tk2OperationContainer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3IntegerValueMapManager
 , l3Base
 , l3Const
 , l3Interfaces
 , k2NilOp
 , l3MessageID
;

end.
