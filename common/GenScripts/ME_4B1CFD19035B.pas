unit nevTextParaAnchorModify.imp;

interface

uses
 l3IntfUses
 , nevBase
 , nevTools
;

type
 _nevTextParaAnchorModify_ = class(MnevAnchorModifyPrim)
  procedure SetLinePrim(aValue: Integer;
   aMap: TnevFormatInfoPrim);
  procedure DoBottom(const aView: InevView);
  function DoIncLinePrim(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean): Integer;
 end;//_nevTextParaAnchorModify_
 
implementation

uses
 l3ImplUses
;

end.
