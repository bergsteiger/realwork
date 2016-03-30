unit evStreamedDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evStreamedDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStreamedDataObject" MUID: (48EA32DB03E6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
  protected
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
    {* сохраняет поток в G }
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload;
    {* сохраняет выделение в G. }
 end;//TevStreamedDataObject

implementation

uses
 l3ImplUses
;

procedure TevStreamedDataObject.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evDefaultStoreFlags);
 {* сохраняет выделение в G. }
//#UC START# *47C68BFD011C_48EA32DB03E6_var*
//#UC END# *47C68BFD011C_48EA32DB03E6_var*
begin
//#UC START# *47C68BFD011C_48EA32DB03E6_impl*
 DoStore(G, aFlags);
//#UC END# *47C68BFD011C_48EA32DB03E6_impl*
end;//TevStreamedDataObject.Store

end.
