unit evCacheableStyleTableListener.imp;

interface

uses
 l3IntfUses
;

type
 _evCacheableStyleTableListener_ = class(_evStyleTableListenerPrim_)
  {* Подписчик на изменение таблицы стилей, который держит какие-то параметры зависящие от с тилей в то время, когда находится в кеше }
 end;//_evCacheableStyleTableListener_
 
implementation

uses
 l3ImplUses
 , evStyleTableSpy
;

end.
