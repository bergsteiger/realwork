unit nevTableRowAnchor;

interface

uses
 l3IntfUses
 , nevParaListAnchor
 , nevTools
 , nevBase
 , nevParaListAnchorModifyTypes
;

type
 TnevTableRowAnchor = class(TnevParaListAnchor)
  {* Якорь для строки таблицы }
  procedure CheckBaseLine(const aView: InevView);
   {* Проверяет, чтобы базовая линия была инициализирована }
 end;//TnevTableRowAnchor
 
implementation

uses
 l3ImplUses
 , nevFacade
 , k2Tags
 , evdTypes
 , nevAfterEndPoint
;

end.
