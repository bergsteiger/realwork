unit m3NewStoragePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3NewStoragePrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::m3CoreObjects::Tm3NewStoragePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StorageInterfaces,
  m3StoreHeader,
  m3CommonStorage,
  m3RootStreamManagerPrim
  ;

type
 Tm3NewStoragePrim = {abstract} class(Tm3CommonStorage)
 private
 // private fields
   f_Header : Tm3StoreHeader;
    {* Поле для свойства Header}
 protected
 // realized methods
   function Manager: Tm3RootStreamManagerPrim; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function DoGetName: WideString; override;
 public
 // public methods
   constructor Create(anAccess: Tm3StoreAccess;
     aHeader: Tm3StoreHeader); reintroduce;
 public
 // public properties
   property Header: Tm3StoreHeader
     read f_Header;
 end;//Tm3NewStoragePrim

implementation

uses
  SysUtils
  ;

// start class Tm3NewStoragePrim

constructor Tm3NewStoragePrim.Create(anAccess: Tm3StoreAccess;
  aHeader: Tm3StoreHeader);
//#UC START# *54491AFD02C4_54491A3702F4_var*
//#UC END# *54491AFD02C4_54491A3702F4_var*
begin
//#UC START# *54491AFD02C4_54491A3702F4_impl*
 Assert(aHeader <> nil);
 inherited Create(anAccess);
 aHeader.SetRefTo(f_Header);
//#UC END# *54491AFD02C4_54491A3702F4_impl*
end;//Tm3NewStoragePrim.Create

function Tm3NewStoragePrim.Manager: Tm3RootStreamManagerPrim;
//#UC START# *5422C90A02CA_54491A3702F4_var*
//#UC END# *5422C90A02CA_54491A3702F4_var*
begin
//#UC START# *5422C90A02CA_54491A3702F4_impl*
 Result := Header.RootStreamManager;
//#UC END# *5422C90A02CA_54491A3702F4_impl*
end;//Tm3NewStoragePrim.Manager

procedure Tm3NewStoragePrim.Cleanup;
//#UC START# *479731C50290_54491A3702F4_var*
//#UC END# *479731C50290_54491A3702F4_var*
begin
//#UC START# *479731C50290_54491A3702F4_impl*
 try
  FreeAndNil(f_Header);
 finally
  inherited;
 end;//try..finally
//#UC END# *479731C50290_54491A3702F4_impl*
end;//Tm3NewStoragePrim.Cleanup

function Tm3NewStoragePrim.DoGetName: WideString;
//#UC START# *5412FB880320_54491A3702F4_var*
//#UC END# *5412FB880320_54491A3702F4_var*
begin
//#UC START# *5412FB880320_54491A3702F4_impl*
 Result := Header.Name.AsWideString;
//#UC END# *5412FB880320_54491A3702F4_impl*
end;//Tm3NewStoragePrim.DoGetName

end.