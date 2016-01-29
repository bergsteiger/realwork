unit UnknownImpl.imp;

interface

uses
 l3IntfUses
;

type
 _UnknownImpl_ = class(_RefCounted_)
  function __AddRef: Integer; stdcall;
   {* Увеличивает счетчик ссылок. }
  function __Release: Integer; stdcall;
   {* Уменьшает счетчик ссылок. }
  function QueryInterface(const IID: TGUID;
   out Obj): HResult; stdcall;
   {* Приводит базовый интерфейс к запрашиваемуму, если это возможно. }
 end;//_UnknownImpl_
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
