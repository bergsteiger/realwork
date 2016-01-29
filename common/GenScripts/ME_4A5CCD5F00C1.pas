unit nevViewBounds.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
;

type
 _nevViewBounds_ = class
  {* Границы отображаемого объекта }
  function GetViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* Ограничивающий точку "прямоугольник". Для текстовых параграфов реализация не самая быстрая. Если потребуется активное использование, то реализацию стоит пересмотреть }
 end;//_nevViewBounds_
 
implementation

uses
 l3ImplUses
;

end.
