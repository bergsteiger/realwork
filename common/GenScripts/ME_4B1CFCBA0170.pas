unit nevParaListAnchorModify.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevParaListAnchorModifyTypes
;

type
 _nevParaListAnchorModify_ = class(MnevAnchorModifyPrim)
  procedure SetPID(aValue: Integer);
  function Limit: Integer;
  function DoIncLine(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean;
   const aChildrenInfo: TnevChildrenInfo): Integer;
  function GetPID: Integer;
  procedure DoBottom(const aView: InevView);
  function DoIncLinePrim(const aView: InevView;
   var theLine: Integer;
   aSmall: Boolean): Integer;
 end;//_nevParaListAnchorModify_
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , Table_Const
;

end.
