unit l3Memory;

interface

uses
 l3IntfUses
 , l3BaseStream
 , l3ProtoObject
 , l3ProtoDataContainerWithCOMQI
;

type
 Tl3Ptr = record
  {* Smart-указатель на память. }
 end;//Tl3Ptr
 
 Tl3CustomMemoryStream = class(Tl3Stream)
 end;//Tl3CustomMemoryStream
 
 Tl3MemoryStream = class(Tl3CustomMemoryStream)
 end;//Tl3MemoryStream
 
 Tl3MemoryPoolAdapter = class(Tl3ProtoObject)
 end;//Tl3MemoryPoolAdapter
 
 Rl3MemoryPoolAdapter = class of Tl3MemoryPoolAdapter;
 
 Tl3ConstMemoryStream = class(Tl3CustomMemoryStream)
  {* Константный поток в памяти (без перераспределения памяти) }
 end;//Tl3ConstMemoryStream
 
 Tl3HMemoryStream = class(Tl3ConstMemoryStream)
  {* Константный поток в глобальной памяти (без перераспределения памяти) }
 end;//Tl3HMemoryStream
 
 Tl3HPCharStream = class(Tl3HMemoryStream)
  {* Константный поток в глобальной памяти оканчивающийся нулем (#0) }
 end;//Tl3HPCharStream
 
 Tl3HPWideCharStream = class(Tl3HMemoryStream)
  {* Константный поток в глобальной памяти оканчивающийся нулем (#0) в кодировке Unicode }
 end;//Tl3HPWideCharStream
 
 Tl3StringStream = class(Tl3CustomMemoryStream)
 end;//Tl3StringStream
 
 Tl3IStreamAdapter = class(Tl3Stream)
 end;//Tl3IStreamAdapter
 
 Rl3MemoryStream = class of Tl3MemoryStream;
 
 Tl3MemoryPoolPrim = class(Tl3ProtoDataContainerWithCOMQI)
  function GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter;
  function GetMemoryStreamClass: Rl3MemoryStream;
 end;//Tl3MemoryPoolPrim
 
 Tl3MemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3MemoryPool
 
 Tl3SizedMemoryPool = class(Tl3MemoryPool)
 end;//Tl3SizedMemoryPool
 
 Tl3MemoryChain = record
 end;//Tl3MemoryChain
 
 Pl3MemoryChain = ^Tl3MemoryChain;
 
 Tl3BufferStreamMemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3BufferStreamMemoryPool
 
implementation

uses
 l3ImplUses
;

end.
