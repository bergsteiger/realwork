unit m3RootStream;

interface

uses
 l3IntfUses
 , ActiveX
;

type
 Tm3RootStreamHeader = record
  {* «аголовок потока в котором живет IStorage.

ƒанные определ€ютс€ через пользовательскую секцию, чтобы они не дай бог местами не переставились. }
 end;//Tm3RootStreamHeader
 
 Rm3RootStream = class of Tm3RootStream;
 
 Tm3RootStream = class(_m3RootStream_)
  procedure ForceLockHeader;
   {* √арантированно блокирует заголовок потока. }
  function HeaderID: TCLSID;
  function DefaultHeaderValue: _HeaderType_;
 end;//Tm3RootStream
 
implementation

uses
 l3ImplUses
 , m3StorageBlock
 , SysUtils
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
 , Windows
;

end.
