unit destNormSpec;
 {* Специализированная dest, для колонок, например. }

// Модуль: "w:\common\components\rtl\Garant\dd\destNormSpec.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , destNorm
 , ddTable
 , ddRTFState
;

type
 TdestNormSpec = class(TdestNorm)
  {* Специализированная dest, для колонок, например. }
  private
   procedure AddColumn4Table(aTable: TddTable;
    aUsePrevWith: Boolean);
   procedure FinishColumn(aState: TddRTFState);
   procedure CheckColumnRow;
   procedure CheckColumnTable;
 end;//TdestNormSpec

implementation

uses
 l3ImplUses
;

procedure TdestNormSpec.AddColumn4Table(aTable: TddTable;
 aUsePrevWith: Boolean);
//#UC START# *56BB3E570128_56BB14F503A0_var*
//#UC END# *56BB3E570128_56BB14F503A0_var*
begin
//#UC START# *56BB3E570128_56BB14F503A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB3E570128_56BB14F503A0_impl*
end;//TdestNormSpec.AddColumn4Table

procedure TdestNormSpec.FinishColumn(aState: TddRTFState);
//#UC START# *56BB3E9801EA_56BB14F503A0_var*
//#UC END# *56BB3E9801EA_56BB14F503A0_var*
begin
//#UC START# *56BB3E9801EA_56BB14F503A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB3E9801EA_56BB14F503A0_impl*
end;//TdestNormSpec.FinishColumn

procedure TdestNormSpec.CheckColumnRow;
//#UC START# *56BB3EC800A3_56BB14F503A0_var*
//#UC END# *56BB3EC800A3_56BB14F503A0_var*
begin
//#UC START# *56BB3EC800A3_56BB14F503A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB3EC800A3_56BB14F503A0_impl*
end;//TdestNormSpec.CheckColumnRow

procedure TdestNormSpec.CheckColumnTable;
//#UC START# *56BB3EE301F6_56BB14F503A0_var*
//#UC END# *56BB3EE301F6_56BB14F503A0_var*
begin
//#UC START# *56BB3EE301F6_56BB14F503A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB3EE301F6_56BB14F503A0_impl*
end;//TdestNormSpec.CheckColumnTable

end.
