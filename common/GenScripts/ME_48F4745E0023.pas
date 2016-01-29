unit l3BaseStream;

interface

uses
 l3IntfUses
 , Classes
 , l3InternalInterfaces
 , ActiveX
 , l3IID
;

type
 Tl3Stream = class(_l3Unknown_, Il3ObjectWrap, IStream)
  {* Базовый класс потоков, поддерживающих счетчик ссылок и интерфейсы IUnknown и IStream }
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
   {* метод для реализации QueryInterface (Для перекрытия в потомках) }
  function GetObject: TObject;
   {* получить объект из обертки. }
  function Read(var Buffer;
   Count: Integer): Integer;
  function Write(Buffer;
   Count: Integer): Integer;
 end;//Tl3Stream
 
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
