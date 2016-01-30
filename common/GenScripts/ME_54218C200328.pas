unit m3CommonStorageStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3CommonStorageStream.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseStream
 , m3StorageInterfaces
 , m3RootStreamManagerPrimPrim
 , l3_String
;

type
 Tm3CommonStorageStream = {abstract} class(Tm3BaseStream)
  protected
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(anAccess: Tm3StoreAccess;
    aRootStreamManager: Tm3RootStreamManagerPrimPrim;
    aName: Tl3_String); reintroduce;
 end;//Tm3CommonStorageStream

implementation

uses
 l3ImplUses
;

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

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3CommonStorageStream.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_54218C200328_var*
//#UC END# *47A6FEE600FC_54218C200328_var*
begin
//#UC START# *47A6FEE600FC_54218C200328_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54218C200328_impl*
end;//Tm3CommonStorageStream.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
