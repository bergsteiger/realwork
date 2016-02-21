unit evSBSCellPainter;
 {* Реализация интерфейса IevPainter для ячеек подписи }

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSCellPainter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTableCellPainter
 , nevTools
;

type
 TevSBSCellPainter = class(TevTableCellPainter)
  {* Реализация интерфейса IevPainter для ячеек подписи }
  protected
   function pm_GetInvisibleFrameColor: TnevColor; override;
   function NeedsHackK235870994: Boolean; override;
 end;//TevSBSCellPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
;

function TevSBSCellPainter.pm_GetInvisibleFrameColor: TnevColor;
//#UC START# *4804A83F030B_49DA43AA01B9get_var*
//#UC END# *4804A83F030B_49DA43AA01B9get_var*
begin
//#UC START# *4804A83F030B_49DA43AA01B9get_impl*
 Result := TnevColor($FFD000);
//#UC END# *4804A83F030B_49DA43AA01B9get_impl*
end;//TevSBSCellPainter.pm_GetInvisibleFrameColor

function TevSBSCellPainter.NeedsHackK235870994: Boolean;
//#UC START# *4CAF3D530327_49DA43AA01B9_var*
//#UC END# *4CAF3D530327_49DA43AA01B9_var*
begin
//#UC START# *4CAF3D530327_49DA43AA01B9_impl*
 Result := false;
//#UC END# *4CAF3D530327_49DA43AA01B9_impl*
end;//TevSBSCellPainter.NeedsHackK235870994
{$IfEnd} // Defined(evNeedPainters)

end.
