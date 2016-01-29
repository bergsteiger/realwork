unit nevSolidParaAnchorModify.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevSolidParaAnchorModify_ = class(MnevAnchorModifyPrim)
  function GetY: Integer;
  procedure SetY(aValue: Integer);
  procedure DoBottom(const aView: InevView);
  function DoIncLinePrim(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean): Integer;
 end;//_nevSolidParaAnchorModify_
 
implementation

uses
 l3ImplUses
 , l3MinMax
;

end.
