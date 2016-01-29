unit evSBSPainter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evSBSPainter.pas"
// Начат: 03.07.2001 14:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Painters::TevSBSPainter
//
// Инструмент для рисования параграфа Side By Side
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedPainters)}
uses
  evTablePainter,
  l3Interfaces,
  l3InternalInterfaces
  ;
{$IfEnd} //evNeedPainters

{$If defined(evNeedPainters)}
type
 TevSBSPainter = class(TevTablePainter)
  {* Инструмент для рисования параграфа Side By Side }
 protected
 // overridden protected methods
   function GetColorArray: Tl3LinesColorArray; override;
   function NeedsHackK235870994: Boolean; override;
   {$If defined(evNeedPainters) AND defined(nsTest)}
   function NeedLog: Boolean; override;
     {* Поддерживает ли табличный объект запись в лог для тестов. }
   {$IfEnd} //evNeedPainters AND nsTest
   function GetFameObjectBehaviur: Tl3FrameObjectBehaviour; override;
 end;//TevSBSPainter
{$IfEnd} //evNeedPainters

implementation

{$If defined(evNeedPainters)}

// start class TevSBSPainter

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

{$If defined(evNeedPainters) AND defined(nsTest)}
function TevSBSPainter.NeedLog: Boolean;
//#UC START# *4D0203AA016F_48C9390D0155_var*
//#UC END# *4D0203AA016F_48C9390D0155_var*
begin
//#UC START# *4D0203AA016F_48C9390D0155_impl*
 Result := False;
//#UC END# *4D0203AA016F_48C9390D0155_impl*
end;//TevSBSPainter.NeedLog
{$IfEnd} //evNeedPainters AND nsTest

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

{$IfEnd} //evNeedPainters

end.