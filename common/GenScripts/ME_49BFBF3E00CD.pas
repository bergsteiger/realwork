unit m3DBProxyStream;

interface

uses
 l3IntfUses
 , l3ProxyStream
 , m3PrimDB
 , m3DBInterfaces
 , l3Interfaces
;

type
 Tm3DBProxyStream = class(Tl3ProxyStream)
  {* Поток, знающий про базу, с которой он работает }
  procedure Create(const aStream: IStream;
   aDB: Tm3PrimDB;
   const anID: Tm3DBStreamIndexEx);
  function Make(const aStream: IStream;
   aDB: Tm3PrimDB;
   const anID: Tm3DBStreamIndexEx): IStream;
   {* Создаёт обёртку }
 end;//Tm3DBProxyStream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
