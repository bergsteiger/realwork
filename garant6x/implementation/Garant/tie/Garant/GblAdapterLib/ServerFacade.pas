unit ServerFacade;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ServerFacade.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ServerFacade" MUID: (4746FD4401F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 ServerFacade = {abstract} class
  public
   function GetServerInterface(facet: PAnsiChar): Object; virtual; abstract; stdcall;
 end;//ServerFacade

implementation

uses
 l3ImplUses
 //#UC START# *4746FD4401F3impl_uses*
 //#UC END# *4746FD4401F3impl_uses*
;

end.
