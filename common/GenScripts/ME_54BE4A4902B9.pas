unit eeTextParaCursor;

interface

uses
 l3IntfUses
 , evTextParaCursor
 , eeInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
;

type
 TeeTextParaCursor = class(TevTextParaCursor)
  function Editor: IeeEditor;
  function IsReadOnly(const aView: InevView): Boolean;
  function ShowComments(const aView: InevView): Boolean;
 end;//TeeTextParaCursor
 
implementation

uses
 l3ImplUses
 , eeCursorTools
 , eePara
 , evdStyles
 , LeafPara_Const
 , eeInterfacesEx
 , evParaTools
 , k2OpMisc
 , CommentPara_Const
 , SysUtils
 , evOp
;

end.
