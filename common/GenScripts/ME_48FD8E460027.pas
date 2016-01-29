unit l3ThreadNotifier.imp;

interface

uses
 l3IntfUses
 , l3Core
 , l3CacheableBase
;

type
 Tl3DataHolder = class(Tl3CacheableBase)
  procedure Create(aData: Pointer;
   aDataSize: Integer;
   const anIntf: array of IUnknown);
 end;//Tl3DataHolder
 
 Rl3DataHolder = class of Tl3DataHolder;
 
 TnsOnChangeInOtherThreadMethod = procedure(aDataPtr: Tl3DataHolder) of object;
 
 _l3ThreadNotifier_ = class
  function HolderClass: Rl3DataHolder;
  function SynchronizeMessage: Longword;
  procedure WndProc(var aMessage: TMessage);
  procedure InitFields;
  procedure Cleanup;
  procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
   aDataPtr: Pointer;
   aDataSize: Integer;
   const anIntf: array of IUnknown); overload;
  procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
   aDataPtr: Pointer;
   aDataSize: Integer); overload;
  procedure Synchronize(aOnChangeInOtherThread: TnsOnChangeInOtherThreadMethod;
   aDataPtr: Tl3DataHolder); overload;
 end;//_l3ThreadNotifier_
 
implementation

uses
 l3ImplUses
 , Classes
 , Windows
 , l3Base
 , Messages
 , l3Interlocked
;

end.
