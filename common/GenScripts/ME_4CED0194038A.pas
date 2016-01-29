unit Para2Point.imp;

interface

uses
 l3IntfUses
 , nevTools
 , l3Units
 , evCustomEditorWindow
;

type
 _Para2Point_ = class
  {* Получение точки Tl3Point из мапы параграфа. }
  function GetInnerPara(const aView: InevInputView;
   const aDocument: InevPara): InevPara;
   {* Возвращает параграф, относительно которого будет рассчитываться точка для выделения }
  function GetPoint(const aMap: InevMap): Tl3Point;
   {* Возвращает точку, на которую нужно спозиционироваться. }
  function TranslatePara2Point(aText: TevCustomEditorWindow): Tl3Point;
   {* Функци получения точки из мапы параграфа. }
 end;//_Para2Point_
 
implementation

uses
 l3ImplUses
;

end.
