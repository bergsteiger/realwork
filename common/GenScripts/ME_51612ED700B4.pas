unit RefCountedPrim.imp;

interface

uses
 l3IntfUses
;

type
 _RefCountedPrim_ = class(MObject)
  procedure Cleanup;
   {* Функция очистки полей объекта. }
  function Use: Pointer;
   {* увеличить счетчик ссылок на 1 и вернуть указатель на себя. }
  function SetRefTo(var F): Boolean;
  procedure BeforeRelease;
  procedure Release;
 end;//_RefCountedPrim_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
