unit evUndoB;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 TevCustomUndoBuffer = class(Ik2UndoBuffer)
  {* ������� ����� ��� ���������� Undo-������. }
  function GetActiveObject(aSucc: Boolean): TObject;
  procedure ExecutedOperation(aContainer: TObject);
   {* ����������� ������ � ����� ����� ��������. }
  function Undo(const aProcessor: Ik2Processor): Boolean;
   {* �������� ���������� ��������. }
  function Redo(const aProcessor: Ik2Processor): Boolean;
   {* ������� ���������� ��������. }
  procedure Clear;
   {* �������� ����� ��������. }
  function CanUndo: Boolean;
   {* ����� �� �������� ��������? }
  function CanRedo: Boolean;
   {* ����� �� ������� ��������? }
  function Last: TObject;
  function Empty: Boolean;
   {* ������ "������"? }
  function Disabled: Boolean;
 end;//TevCustomUndoBuffer
 
 TevUndoBuffer = class(TevCustomUndoBuffer)
  {* ����� ��� ���������� Undo-������. }
 end;//TevUndoBuffer
 
implementation

uses
 l3ImplUses
 , evStandardActions
;

end.
