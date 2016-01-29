unit nevMostInner.imp;

interface

uses
 l3IntfUses
 , nevTools
;

type
 _nevMostInner_ = class
  {* Самая внутренняя точка объекта }
  function MostInner: InevBasePoint;
   {* дочерний якорь самого нижнего уровня. }
 end;//_nevMostInner_
 
implementation

uses
 l3ImplUses
;

end.
