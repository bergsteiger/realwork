unit evStorable;

// Модуль: "w:\common\components\gui\Garant\Everest\evStorable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevStorable" MUID: (48F48A7E033C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

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
  private
   f_Reader: InevTagReader;
  protected
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload;
    {* сохраняет выделение в G. }
   function Store(aFormat: TevdClipboardFormat;
    const aPool: IStream;
    const aFilters: TevdTagGenerator;
    aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean; overload;
    {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
   function pm_GetBorders: TevPair;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aReader: InevTagReader); reintroduce;
 end;//TevStorable

implementation

uses
 l3ImplUses
 , l3Base
 //#UC START# *48F48A7E033Cimpl_uses*
 //#UC END# *48F48A7E033Cimpl_uses*
;

constructor TevStorable.Create(const aReader: InevTagReader);
//#UC START# *48F48B0A02D1_48F48A7E033C_var*
//#UC END# *48F48B0A02D1_48F48A7E033C_var*
begin
//#UC START# *48F48B0A02D1_48F48A7E033C_impl*
 inherited Create;
 f_Reader := aReader;
//#UC END# *48F48B0A02D1_48F48A7E033C_impl*
end;//TevStorable.Create

procedure TevStorable.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evDefaultStoreFlags);
 {* сохраняет выделение в G. }
//#UC START# *47C68BFD011C_48F48A7E033C_var*
//#UC END# *47C68BFD011C_48F48A7E033C_var*
begin
//#UC START# *47C68BFD011C_48F48A7E033C_impl*
 DoStore(G, aFlags);
//#UC END# *47C68BFD011C_48F48A7E033C_impl*
end;//TevStorable.Store

function TevStorable.Store(aFormat: TevdClipboardFormat;
 const aPool: IStream;
 const aFilters: TevdTagGenerator;
 aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean;
 {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
//#UC START# *47C68C6701AF_48F48A7E033C_var*
//#UC END# *47C68C6701AF_48F48A7E033C_var*
begin
//#UC START# *47C68C6701AF_48F48A7E033C_impl*
 Result := (f_Reader.ReadTag(aFormat, aPool, aFilters, Self, aFlags) > 0);
//#UC END# *47C68C6701AF_48F48A7E033C_impl*
end;//TevStorable.Store

function TevStorable.pm_GetBorders: TevPair;
//#UC START# *47C6962E028E_48F48A7E033Cget_var*
//#UC END# *47C6962E028E_48F48A7E033Cget_var*
begin
//#UC START# *47C6962E028E_48F48A7E033Cget_impl*
 l3FillChar(Result, SizeOf(Result), 0);
//#UC END# *47C6962E028E_48F48A7E033Cget_impl*
end;//TevStorable.pm_GetBorders

procedure TevStorable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F48A7E033C_var*
//#UC END# *479731C50290_48F48A7E033C_var*
begin
//#UC START# *479731C50290_48F48A7E033C_impl*
 inherited;
 f_Reader := nil;
//#UC END# *479731C50290_48F48A7E033C_impl*
end;//TevStorable.Cleanup

end.
