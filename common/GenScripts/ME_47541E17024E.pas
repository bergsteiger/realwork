unit l3InterfacedComponent;

interface

uses
 l3IntfUses
 , Classes
 , l3IID
;

type
 Tl3InterfacedComponent = class(_l3Unknown_)
  {* Базовый класс компонентов, поддерживающих счетчик ссылок и интерфейсы IUnknown. }
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
   {* метод для реализации QueryInterface (Для перекрытия в потомках). }
  procedure CreateX;
 end;//Tl3InterfacedComponent
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
;

end.
