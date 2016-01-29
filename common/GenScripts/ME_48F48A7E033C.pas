unit evStorable;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , evdInterfaces
 , nevBase
 , l3Interfaces
;

type
 TevStorable = class(Tl3CacheableBase, InevStorable, IevdDataObject, InevDataObjectPrim2)
  procedure Create(const aReader: InevTagReader);
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
  function Store(aFormat: TevdClipboardFormat;
   const aPool: IStream;
   const aFilters: TevdTagGenerator;
   aFlags: TevdStoreFlags): Boolean; overload;
   {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
  function Borders: TevPair;
 end;//TevStorable
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
