unit l3ProxyStream;

interface

uses
 l3IntfUses
 , l3BaseStream
 , l3Interfaces
 , Classes
;

type
 Tl3ProxyStream = class(Tl3Stream)
  {* Поток служащий обёрткой над другим потоком }
  procedure Create(const aStream: IStream);
  function Make(const aStream: IStream): IStream;
   {* Создаёт обёртку над потоком }
  procedure CloseInner;
   {* Освобождает внутренний поток }
 end;//Tl3ProxyStream
 
implementation

uses
 l3ImplUses
 , ComObj
 , l3Types
;

end.
