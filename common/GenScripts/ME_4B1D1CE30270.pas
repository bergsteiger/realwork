unit nevBreakParaAnchorModify.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevBreakParaAnchorModify_ = class(MnevAnchorModifyPrim)
  procedure DoBottom(const aView: InevView);
  function DoIncLinePrim(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean): Integer;
 end;//_nevBreakParaAnchorModify_
 
implementation

uses
 l3ImplUses
;

end.
