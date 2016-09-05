unit m3RootStreamManagerPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3RootStreamManagerPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3RootStreamManagerPrim" MUID: (543FBAC30068)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3RootStreamManagerPrimPrim
 , m3StoreHeaderDataPrim
;

type
 Tm3RootStreamManagerPrim = {abstract} class(Tm3RootStreamManagerPrimPrim)
  protected
   function pm_GetRootStorageFATElement: Int64; virtual; abstract;
  public
   function StoreHeaderDataClass: Rm3StoreHeaderDataPrim; virtual; abstract;
   procedure RemoveFATElementAtPos(aPosition: Int64); virtual; abstract;
   function AllocNewFATElement: Int64; virtual; abstract;
   function ReadOnly: Boolean; virtual; abstract;
  public
   property RootStorageFATElement: Int64
    read pm_GetRootStorageFATElement;
 end;//Tm3RootStreamManagerPrim

implementation

uses
 l3ImplUses
 , m3Exceptions
 , SysUtils
 //#UC START# *543FBAC30068impl_uses*
 //#UC END# *543FBAC30068impl_uses*
;

end.
