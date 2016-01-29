unit nevTableRowRenderInfo;

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , l3LongintList
 , nevFormatInfo
 , nevTools
;

type
 TnevTableRowRenderInfo = class(TnevListFormatInfo)
  {* ���������� � �������������� ������ �������. }
  procedure CheckDeltaHeight;
  function IsCellChildSpacingEqual(anIndex: Integer): Boolean;
  function CalcDeltaHeight: Integer;
   {* ����� ������� ������� � ������ ������. }
 end;//TnevTableRowRenderInfo
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , nevFacade
 , k2Tags
 , evdTypes
 , nevBase
 , evConst
 , SysUtils
 , l3Base
 , evTableCellUtils
;

end.
