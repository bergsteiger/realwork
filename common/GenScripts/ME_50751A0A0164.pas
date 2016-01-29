unit evTableSearch;

interface

uses
 l3IntfUses
 , evSearch
 , nevBase
 , l3Variant
 , l3CustomString
 , nevTools
 , evTypes
;

type
 TevTableTextSearcher = class(TevAnyParagraphSearcher)
  function CheckCellType(aCell: Tl3Variant): Boolean;
 end;//TevTableTextSearcher
 
 TevFirstTableCellSearcher = class(TevTableTextSearcher)
 end;//TevFirstTableCellSearcher
 
 TevOldNSRCFlagReplacer = class(TevBaseReplacer)
  function Make(anOptions: TevSearchOptionSet): IevReplacer;
  function ReplaceFunc(const aView: InevView;
   const Container: InevOp;
   const aBlock: InevRange): Boolean;
 end;//TevOldNSRCFlagReplacer
 
 TevTableCellFrameReplacer = class(TevBaseReplacer)
  function Make(aFrame: Integer;
   anOptions: TevSearchOptionSet): IevReplacer;
  function ReplaceFunc(const aView: InevView;
   const Container: InevOp;
   const aBlock: InevRange): Boolean;
 end;//TevTableCellFrameReplacer
 
 TevTextInContinueCellSearcher = class(TevTableTextSearcher)
 end;//TevTextInContinueCellSearcher
 
implementation

uses
 l3ImplUses
 , evParaTools
 , TableCell_Const
 , SBSCell_Const
 , SysUtils
 , SBS_Const
 , Table_Const
 , k2Tags
 , evdTypes
;

end.
