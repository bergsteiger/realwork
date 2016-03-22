unit NOT_FINISHED_l3Memory;
 {* Объекты, классы и функции для работы с памятью. }

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Memory.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "l3Memory" MUID: (47AB1FDE03E4)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseStream
 , l3ProtoObject
 , l3ProtoDataContainerWithCOMQI
;

type
 Pl3MemoryChain = ^Tl3MemoryChain;

 Rl3MemoryPoolAdapter = class of Tl3MemoryPoolAdapter;

 Rl3MemoryStream = class of Tl3MemoryStream;

 Tl3Ptr = record
  {* Smart-указатель на память. }
 end;//Tl3Ptr

 Tl3CustomMemoryStream = class(Tl3Stream)
 end;//Tl3CustomMemoryStream

 Tl3MemoryStream = class(Tl3CustomMemoryStream)
 end;//Tl3MemoryStream

 Tl3MemoryPoolAdapter = class(Tl3ProtoObject)
 end;//Tl3MemoryPoolAdapter

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

 Tl3MemoryPoolPrim = class(Tl3ProtoDataContainerWithCOMQI)
  protected
   function GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter; virtual;
   function GetMemoryStreamClass: Rl3MemoryStream; virtual;
 end;//Tl3MemoryPoolPrim

 Tl3MemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3MemoryPool

 Tl3SizedMemoryPool = class(Tl3MemoryPool)
 end;//Tl3SizedMemoryPool

 Tl3MemoryChain = record
 end;//Tl3MemoryChain

 Tl3BufferStreamMemoryPool = class(Tl3MemoryPoolPrim)
 end;//Tl3BufferStreamMemoryPool

implementation

uses
 l3ImplUses
;

function Tl3MemoryPoolPrim.GetMemoryPoolAdapterClass: Rl3MemoryPoolAdapter;
//#UC START# *530B3ADB014E_53076BFC02F2_var*
//#UC END# *530B3ADB014E_53076BFC02F2_var*
begin
//#UC START# *530B3ADB014E_53076BFC02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B3ADB014E_53076BFC02F2_impl*
end;//Tl3MemoryPoolPrim.GetMemoryPoolAdapterClass

function Tl3MemoryPoolPrim.GetMemoryStreamClass: Rl3MemoryStream;
//#UC START# *530B3F560201_53076BFC02F2_var*
//#UC END# *530B3F560201_53076BFC02F2_var*
begin
//#UC START# *530B3F560201_53076BFC02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *530B3F560201_53076BFC02F2_impl*
end;//Tl3MemoryPoolPrim.GetMemoryStreamClass

end.
