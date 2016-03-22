unit evSBSPainter;
 {* Инструмент для рисования параграфа Side By Side }

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSBSPainter" MUID: (48C9390D0155)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTablePainter
 , l3Interfaces
 , l3InternalInterfaces
;

type
 TevSBSPainter = class(TevTablePainter)
  {* Инструмент для рисования параграфа Side By Side }
  protected
   function GetColorArray: Tl3LinesColorArray; override;
   function NeedsHackK235870994: Boolean; override;
   {$If Defined(nsTest)}
   function NeedLog: Boolean; override;
    {* Поддерживает ли табличный объект запись в лог для тестов. }
   {$IfEnd} // Defined(nsTest)
   function GetFameObjectBehaviur: Tl3FrameObjectBehaviour; override;
 end;//TevSBSPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
;

function TevSBSPainter.GetColorArray: Tl3LinesColorArray;
//#UC START# *48C9339E0013_48C9390D0155_var*
//#UC END# *48C9339E0013_48C9390D0155_var*
begin
//#UC START# *48C9339E0013_48C9390D0155_impl*
 Result := inherited GetColorArray;
 Result[lpdSpecialDraw] := $FFD000;
//#UC END# *48C9339E0013_48C9390D0155_impl*
end;//TevSBSPainter.GetColorArray

function TevSBSPainter.NeedsHackK235870994: Boolean;
//#UC START# *4CAF3D530327_48C9390D0155_var*
//#UC END# *4CAF3D530327_48C9390D0155_var*
begin
//#UC START# *4CAF3D530327_48C9390D0155_impl*
 Result := false;
//#UC END# *4CAF3D530327_48C9390D0155_impl*
end;//TevSBSPainter.NeedsHackK235870994

{$If Defined(nsTest)}
function TevSBSPainter.NeedLog: Boolean;
 {* Поддерживает ли табличный объект запись в лог для тестов. }
//#UC START# *4D0203AA016F_48C9390D0155_var*
//#UC END# *4D0203AA016F_48C9390D0155_var*
begin
//#UC START# *4D0203AA016F_48C9390D0155_impl*
 Result := False;
//#UC END# *4D0203AA016F_48C9390D0155_impl*
end;//TevSBSPainter.NeedLog
{$IfEnd} // Defined(nsTest)

function TevSBSPainter.GetFameObjectBehaviur: Tl3FrameObjectBehaviour;
//#UC START# *51B96E5A0285_48C9390D0155_var*
//#UC END# *51B96E5A0285_48C9390D0155_var*
begin
//#UC START# *51B96E5A0285_48C9390D0155_impl*
 if not Area.rCanvas.Printing and Area.rCanvas.DrawSpecial then
  Result := inherited GetFameObjectBehaviur
 else
  Result := l3_fobIgnore;
//#UC END# *51B96E5A0285_48C9390D0155_impl*
end;//TevSBSPainter.GetFameObjectBehaviur
{$IfEnd} // Defined(evNeedPainters)

end.
