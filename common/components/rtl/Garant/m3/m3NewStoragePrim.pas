unit m3NewStoragePrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3NewStoragePrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3NewStoragePrim" MUID: (54491A3702F4)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3CommonStorage
 , m3StoreHeader
 , m3StorageInterfaces
 , m3RootStreamManagerPrim
;

type
 Tm3NewStoragePrim = {abstract} class(Tm3CommonStorage)
  private
   f_Header: Tm3StoreHeader;
  protected
   function Manager: Tm3RootStreamManagerPrim; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoGetName: WideString; override;
  public
   constructor Create(anAccess: Tm3StoreAccess;
    aHeader: Tm3StoreHeader); reintroduce;
  public
   property Header: Tm3StoreHeader
    read f_Header;
 end;//Tm3NewStoragePrim

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *54491A3702F4impl_uses*
 //#UC END# *54491A3702F4impl_uses*
;

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
 {* Функция очистки полей объекта. }
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
