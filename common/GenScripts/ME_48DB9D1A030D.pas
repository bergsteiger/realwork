unit nevTableCellFormatInfo;

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , nevTools
 , nevBase
 , nevFormatInfo
;

type
 TnevTableCellFormatInfo = class(TnevListFormatInfo)
  function GetContinueCellAtTheTop: InevPara;
  function GetContinueCellBoottom: InevPara;
  function GetHeadCell: InevPara;
 end;//TnevTableCellFormatInfo
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3MinMax
 , k2Base
 , nevFacade
;

end.
