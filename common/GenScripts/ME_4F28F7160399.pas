unit evCopyTableCellWidth;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evCellsOffsetsList
 , l3Variant
 , evEditorInterfaces
 , l3Interfaces
;

type
 TevCopyTableCellWidth = class(Tl3ProtoObject)
  {* ���������� ��� ����������� ����� ������� �� ����� ������� � ������. }
  procedure RememberRowWidth(const anIterator: IedCellsIterator);
  procedure RememberWidths(const aRange: IedRange);
  procedure ApplyWidths(const aRange: IedRange;
   const aProgress: Il3Progress);
  function CanApply: Boolean;
  procedure Clear;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TevCopyTableCellWidth
 
implementation

uses
 l3ImplUses
 , nevBase
 , evCellsWidthCorrecter
 , SysUtils
;

end.
