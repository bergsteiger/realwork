unit m3DBProxyWriteStream;

interface

uses
 l3IntfUses
 , m3DBProxyStream
 , l3Interfaces
;

type
 Tm3DBProxyWriteStream = class(Tm3DBProxyStream, Il3Rollback)
  {* �����, ������� � ���� }
  procedure Rollback;
   {* �������� ������ }
 end;//Tm3DBProxyWriteStream
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
