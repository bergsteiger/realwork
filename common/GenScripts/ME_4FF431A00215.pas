unit TestNameString;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\TestNameString.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3_String
 , l3Types
;

type
 TTestNameString = class(Tl3_String)
  protected
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
 end;//TTestNameString
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , l3String
;

procedure TTestNameString.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_4FF431A00215_var*
//#UC END# *47A869D10074_4FF431A00215_var*
begin
//#UC START# *47A869D10074_4FF431A00215_impl*
 inherited DoSetAsPCharLen(Tl3PCharLen(l3LTrim(Value, ['+', '-', '?', '!'])));
//#UC END# *47A869D10074_4FF431A00215_impl*
end;//TTestNameString.DoSetAsPCharLen
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
