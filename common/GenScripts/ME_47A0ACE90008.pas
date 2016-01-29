unit l3Castable.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 _l3Castable_ = class
  {* Класс-примесь с методом QueryInterface }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_l3Castable_
 
implementation

uses
 l3ImplUses
;

end.
