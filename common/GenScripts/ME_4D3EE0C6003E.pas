unit evHolderDataObject;

interface

uses
 l3IntfUses
 , evStreamedDataObject
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TevHolderDataObject = class(TevStreamedDataObject)
  procedure Create(const aHolder: InevObjectHolder);
  function Make(const aHolder: InevObjectHolder): InevStorable;
  procedure DoStore(const G: InevTagGenerator;
   aFlags: TevdStoreFlags);
   {* сохраняет поток в G }
 end;//TevHolderDataObject
 
implementation

uses
 l3ImplUses
;

end.
