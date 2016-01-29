unit l3Changing.imp;

interface

uses
 l3IntfUses
 , l3PureMixIns
;

type
 _l3Changing_ = class
  {* Объект с нотификацией об изменении состояния }
  procedure DoChanged;
  procedure DoChanging;
  procedure Changing;
   {* нотификация о начале изменения состояния объекта. Для перекрытия и использования в потомках. }
  procedure Changed;
   {* нотификация о завершении изменения состояния объекта. Для перекрытия и использования в потомках. }
 end;//_l3Changing_
 
implementation

uses
 l3ImplUses
;

end.
