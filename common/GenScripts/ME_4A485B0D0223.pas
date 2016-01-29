unit evStyleTableListenerPrim.imp;

interface

uses
 l3IntfUses
 , afwInterfaces
;

type
 _evStyleTableListenerPrim_ = class(IafwStyleTableSpy, Ml3Unknown)
  procedure DoStyleTableChanged;
  function NeedListen: Boolean;
   {* Нужно ли подписываться к таблице стилей (может мы уже подписались) }
  function AtEnd: Boolean;
   {* Подписываться в конец списка подписчиков }
  procedure StyleTableChanged;
   {* таблица стилей изменилась. }
 end;//_evStyleTableListenerPrim_
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
