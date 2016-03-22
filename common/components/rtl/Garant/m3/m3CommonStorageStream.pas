unit m3CommonStorageStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3CommonStorageStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3CommonStorageStream
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
  l3_String,
  m3BaseStream,
  m3RootStreamManagerPrimPrim
  ;

type
 Tm3CommonStorageStream = {abstract} class(Tm3BaseStream)
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public methods
   constructor Create(anAccess: Tm3StoreAccess;
     aRootStreamManager: Tm3RootStreamManagerPrimPrim;
     aName: Tl3_String); reintroduce;
 end;//Tm3CommonStorageStream

implementation

// start class Tm3CommonStorageStream

constructor Tm3CommonStorageStream.Create(anAccess: Tm3StoreAccess;
  aRootStreamManager: Tm3RootStreamManagerPrimPrim;
  aName: Tl3_String);
//#UC START# *54218C6B02B1_54218C200328_var*
//#UC END# *54218C6B02B1_54218C200328_var*
begin
//#UC START# *54218C6B02B1_54218C200328_impl*
 Assert(aRootStreamManager <> nil);
 Assert(aName <> nil);
 inherited Create(anAccess);
//#UC END# *54218C6B02B1_54218C200328_impl*
end;//Tm3CommonStorageStream.Create

{$If not defined(DesignTimeLibrary)}
class function Tm3CommonStorageStream.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_54218C200328_var*
//#UC END# *47A6FEE600FC_54218C200328_var*
begin
//#UC START# *47A6FEE600FC_54218C200328_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54218C200328_impl*
end;//Tm3CommonStorageStream.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.