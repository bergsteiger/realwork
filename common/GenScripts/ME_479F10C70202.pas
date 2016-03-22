unit l3RecList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3RecList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3RecList" MUID: (479F10C70202)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseRecList
;

type
 Tl3RecList = class(Tl3BaseRecList)
  private
   f_ItemSize: Integer;
  protected
   function pm_GetItemSize: Integer; override;
  public
   constructor Create(anItemSize: Integer); reintroduce;
 end;//Tl3RecList

implementation

uses
 l3ImplUses
;

constructor Tl3RecList.Create(anItemSize: Integer);
//#UC START# *479F111E032C_479F10C70202_var*
//#UC END# *479F111E032C_479F10C70202_var*
begin
//#UC START# *479F111E032C_479F10C70202_impl*
 inherited Create;
 f_ItemSize := anItemSize;
//#UC END# *479F111E032C_479F10C70202_impl*
end;//Tl3RecList.Create

function Tl3RecList.pm_GetItemSize: Integer;
//#UC START# *47BEE7FD01DC_479F10C70202get_var*
//#UC END# *47BEE7FD01DC_479F10C70202get_var*
begin
//#UC START# *47BEE7FD01DC_479F10C70202get_impl*
 Result := f_ItemSize;
//#UC END# *47BEE7FD01DC_479F10C70202get_impl*
end;//Tl3RecList.pm_GetItemSize

end.
