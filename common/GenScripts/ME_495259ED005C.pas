unit l3Forms;

interface

uses
 l3IntfUses
 , Forms
;

type
 Tl3Form = class(_l3Unknown_)
  {* Базовый класс форм, поддерживающих счетчик ссылок и интерфейс IUnknown }
 end;//Tl3Form
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , l3IID
 , l3InterfacesMisc
;

end.
