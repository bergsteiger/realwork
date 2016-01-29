unit l3Unknown.imp;

interface

uses
 l3IntfUses
;

type
 _l3Unknown_ = class(_l3UnknownPrim_)
  {* ¬ этом классе собираем методы, которые запрещено перекрывать и вызывать напр€мую. }
  function NewInstance: TObject;
  procedure FreeInstance;
  procedure AfterConstruction;
  procedure BeforeDestruction;
  procedure Destroy;
 end;//_l3Unknown_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

end.
