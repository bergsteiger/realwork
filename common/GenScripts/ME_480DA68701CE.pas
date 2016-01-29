unit evStyleTableListener.imp;

interface

uses
 l3IntfUses
;

type
 _evStyleTableListener_ = class(_evStyleTableListenerPrim_)
  {* Объект, слушающий изменения таблицы стилей }
 end;//_evStyleTableListener_
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
