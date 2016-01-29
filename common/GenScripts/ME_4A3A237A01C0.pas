unit evParaListCursorPrim;

interface

uses
 l3IntfUses
 , evParaCursor
 , nevTools
 , nevBase
 , l3Variant
 , l3IID
 , k2Interfaces
 , l3Core
 , l3Interfaces
;

type
 PevParaListCursor = ^TevParaListCursorPrim;
 
 TevParaListCursorPrim = class(_nevParaListTool_)
  {* Курсор для списка параграфов }
  procedure OffsetPID(Delta: Integer;
   const Context: InevOp);
  procedure ParaChanged;
  function NeedGotoHidden(aCode: Integer;
   const aFI: TnevFormatInfoPrim): Boolean;
   {* Нужно ли переходить на невидимую строку. }
  function CheckFirst(aChildPID: Integer): Boolean;
  function CanRedraw: Boolean;
   {* Можно ли перисовывать, чтобы найти правильную мапу. }
  procedure ChangePointByPara(const aView: InevView;
   const anOpPack: InevOp;
   const aPara: InevPara);
  procedure SetPID(aValue: Integer);
  function GetPID: Integer;
 end;//TevParaListCursorPrim
 
implementation

uses
 l3ImplUses
 , k2TagGen
 , nevNavigation
 , evOp
 , nevFacade
 , Block_Const
 , Para_Const
 , ParaList_Const
 , evCursorConst
 , k2Base
 , k2Tags
 , l3Units
 , evCursorTools
 , ControlPara_Const
 , SysUtils
 , l3MinMax
 , Table_Const
 , nevParaListAnchorModifyTypes
;

end.
