unit l3IterateComponentParents;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

type
 Ml3IterateComponentParents_IterateF_Action = function(anItem: TComponent): Boolean;
  {* Тип подитеративной функции для Ml3IterateComponentParents.IterateF }
 
 (*
 Ml3IterateComponentParents = interface
  {* Контракт сервиса Tl3IterateComponentParents }
  procedure IterateF;
 end;//Ml3IterateComponentParents
 *)
 
 Il3IterateComponentParents = interface
  {* Интерфейс сервиса Tl3IterateComponentParents }
  procedure IterateF;
 end;//Il3IterateComponentParents
 
 Tl3IterateComponentParents = class(Tl3ProtoObject)
  procedure Iterate;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure IterateF;
 end;//Tl3IterateComponentParents
 
implementation

uses
 l3ImplUses
 , Controls
 , l3Base
;

end.
