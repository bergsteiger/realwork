unit RefCounted.imp;

interface

uses
 l3IntfUses
;

type
 _RefCounted_ = class(_RefCountedPrim_)
  {* В этом классе собираем методы, которые запрещено перекрывать и вызывать напрямую }
  procedure destroy;
   {* Это чтобы не было соблазна перекрывать destroy. }
  function NewInstance: TObject;
  procedure FreeInstance;
  procedure AfterConstruction;
  procedure BeforeDestruction;
 end;//_RefCounted_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
