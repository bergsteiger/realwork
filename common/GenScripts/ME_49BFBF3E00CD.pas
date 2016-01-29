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
  {* �����, ������� ��� ����, � ������� �� �������� }
  procedure Create(const aStream: IStream;
   aDB: Tm3PrimDB;
   const anID: Tm3DBStreamIndexEx);
  function Make(const aStream: IStream;
   aDB: Tm3PrimDB;
   const anID: Tm3DBStreamIndexEx): IStream;
   {* ������ ������ }
 end;//Tm3DBProxyStream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
