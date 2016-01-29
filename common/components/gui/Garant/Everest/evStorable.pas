unit evStorable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStorable.pas"
// Начат: 26.12.2006 14:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevStorable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3CacheableBase,
  nevBase,
  nevTools,
  evdInterfaces,
  l3Interfaces
  ;

type
 TevStorable = class(Tl3CacheableBase, InevStorable, IevdDataObject, InevDataObjectPrim2)
 private
 // private fields
   f_Reader : InevTagReader;
 protected
 // realized methods
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload; 
     {* сохраняет выделение в G. }
   function Store(aFormat: TevdClipboardFormat;
    const aPool: IStream;
    const aFilters: TevdTagGenerator;
    aFlags: TevdStoreFlags = evd_DefaultStoreFlags): Boolean; overload; 
     {* сохраняет выделение в формате aFormat в Pool, который должен реализовывать IStream. }
   function pm_GetBorders: TevPair;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
 public
 // public methods
   constructor Create(const aReader: InevTagReader); reintroduce;
 end;//TevStorable

implementation

uses
  l3Base
  ;

// start class TevStorable

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
  aFlags: TevdStoreFlags = evd_DefaultStoreFlags): Boolean;
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
//#UC START# *479731C50290_48F48A7E033C_var*
//#UC END# *479731C50290_48F48A7E033C_var*
begin
//#UC START# *479731C50290_48F48A7E033C_impl*
 inherited;
 f_Reader := nil;
//#UC END# *479731C50290_48F48A7E033C_impl*
end;//TevStorable.Cleanup

end.