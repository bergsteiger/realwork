unit evStreamedDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evStreamedDataObject.pas"
// Начат: 16.12.2004 14:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevStreamedDataObject
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
  evdInterfaces
  ;

type
 TevStreamedDataObject = class(Tl3CacheableBase, InevStorable)
 protected
 // realized methods
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload; 
     {* сохраняет выделение в G. }
 protected
 // protected methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual; abstract;
     {* сохраняет поток в G }
 end;//TevStreamedDataObject

implementation

// start class TevStreamedDataObject

procedure TevStreamedDataObject.Store(const aView: InevView;
  const G: InevTagGenerator;
  aFlags: TevdStoreFlags = evDefaultStoreFlags);
//#UC START# *47C68BFD011C_48EA32DB03E6_var*
//#UC END# *47C68BFD011C_48EA32DB03E6_var*
begin
//#UC START# *47C68BFD011C_48EA32DB03E6_impl*
 DoStore(G, aFlags);
//#UC END# *47C68BFD011C_48EA32DB03E6_impl*
end;//TevStreamedDataObject.Store

end.