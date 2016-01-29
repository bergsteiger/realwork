unit evStreamedDataObject;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TevStreamedDataObject = class(Tl3CacheableBase, InevStorable)
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
   {* сохраняет поток в G }
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* сохраняет выделение в G. }
 end;//TevStreamedDataObject
 
implementation

uses
 l3ImplUses
;

end.
