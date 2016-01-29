unit TestNameString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/TestNameString.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::Source::TTestNameString
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3_String,
  l3Types
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TTestNameString = class(Tl3_String)
 protected
 // overridden protected methods
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
 end;//TTestNameString
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3String
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}

// start class TTestNameString

procedure TTestNameString.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4FF431A00215_var*
//#UC END# *47A869D10074_4FF431A00215_var*
begin
//#UC START# *47A869D10074_4FF431A00215_impl*
 inherited DoSetAsPCharLen(Tl3PCharLen(l3LTrim(Value, ['+', '-', '?', '!'])));
//#UC END# *47A869D10074_4FF431A00215_impl*
end;//TTestNameString.DoSetAsPCharLen

{$IfEnd} //nsTest AND not NotTunedDUnit

end.