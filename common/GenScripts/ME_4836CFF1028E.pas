unit evNSRCPlusWriter;

interface

uses
 l3IntfUses
 , evCustomNSRCWriter
 , evdTypes
 , l3Variant
 , l3Interfaces
;

type
 TevFramePartIndexes = set of Tl3FramePartIndex;
 
 TevNSRCPlusWriter = class(TevCustomNSRCWriter)
  {* Писатель формата NSRC+. Для решения задачи [$91848978]. }
  function GetCellOpened: Boolean;
  procedure OutNewString(const aValue: AnsiString);
 end;//TevNSRCPlusWriter
 
implementation

uses
 l3ImplUses
 , k2Base
 , k2Tags
 , SysUtils
 , SBS_Const
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 , evdFrame_Const
 , TabStop_Const
 , l3String
;

end.
