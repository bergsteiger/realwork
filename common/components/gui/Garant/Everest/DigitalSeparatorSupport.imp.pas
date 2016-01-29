{$IfNDef DigitalSeparatorSupport_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/DigitalSeparatorSupport.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Generators::DigitalSeparatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DigitalSeparatorSupport_imp}
 TevCheckPointSeparator = (
   ev_cpsNone // ничего не делать (не ждать разделителя, не выливать)
 , ev_cpsWait // ждать разделителя.
 , ev_cpsReady // готовность к выливке
 );//TevCheckPointSeparator

 _DigitalSeparatorSupport_ = {mixin} class(_DigitalSeparatorSupport_Parent_)
 private
 // private fields
   f_WaitStyleD : TevCheckPointSeparator;
   f_DecimalOffset : Integer;
 private
 // private methods
   function HasDigitalSeparatorAlignment: Boolean;
 protected
 // protected methods
   procedure ContinueCell;
   procedure CellStarted;
     {* Информируем о начале ячейки. }
   procedure CellFinished;
     {* Ячейка закончена. }
   procedure SetDigitalSeparatorParams(anAtomIndex: Integer;
     const aValue: Tk2Variant);
   function GetDigitalSeparatorOffset: Integer;
 end;//_DigitalSeparatorSupport_

{$Else DigitalSeparatorSupport_imp}

// start class _DigitalSeparatorSupport_

function _DigitalSeparatorSupport_.HasDigitalSeparatorAlignment: Boolean;
//#UC START# *4E39244B0106_4E5E029D03AD_var*
//#UC END# *4E39244B0106_4E5E029D03AD_var*
begin
//#UC START# *4E39244B0106_4E5E029D03AD_impl*
 Result := f_WaitStyleD = ev_cpsReady;
//#UC END# *4E39244B0106_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.HasDigitalSeparatorAlignment

procedure _DigitalSeparatorSupport_.ContinueCell;
//#UC START# *4E392479028C_4E5E029D03AD_var*
//#UC END# *4E392479028C_4E5E029D03AD_var*
begin
//#UC START# *4E392479028C_4E5E029D03AD_impl*
 if f_WaitStyleD = ev_cpsReady then
  f_WaitStyleD := ev_cpsWait;
//#UC END# *4E392479028C_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.ContinueCell

procedure _DigitalSeparatorSupport_.CellStarted;
//#UC START# *4E5E1C8D0090_4E5E029D03AD_var*
//#UC END# *4E5E1C8D0090_4E5E029D03AD_var*
begin
//#UC START# *4E5E1C8D0090_4E5E029D03AD_impl*
 f_WaitStyleD := ev_cpsWait;
//#UC END# *4E5E1C8D0090_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.CellStarted

procedure _DigitalSeparatorSupport_.CellFinished;
//#UC START# *4E5E1CE40229_4E5E029D03AD_var*
//#UC END# *4E5E1CE40229_4E5E029D03AD_var*
begin
//#UC START# *4E5E1CE40229_4E5E029D03AD_impl*
 f_WaitStyleD := ev_cpsNone;
//#UC END# *4E5E1CE40229_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.CellFinished

procedure _DigitalSeparatorSupport_.SetDigitalSeparatorParams(anAtomIndex: Integer;
  const aValue: Tk2Variant);
//#UC START# *4E5E22FB0348_4E5E029D03AD_var*
//#UC END# *4E5E22FB0348_4E5E029D03AD_var*
begin
//#UC START# *4E5E22FB0348_4E5E029D03AD_impl*
 case anAtomIndex of
  k2_tiType:
   if (f_WaitStyleD = ev_cpsWait) and
      (aValue.AsInteger = Ord(l3_tssDecimal)) then
    f_WaitStyleD := ev_cpsReady
   else
    f_DecimalOffset := 0;
  k2_tiStart:
   f_DecimalOffset := aValue.AsInteger;
 end;//case anAtomIndex
//#UC END# *4E5E22FB0348_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.SetDigitalSeparatorParams

function _DigitalSeparatorSupport_.GetDigitalSeparatorOffset: Integer;
//#UC START# *4E5E26150131_4E5E029D03AD_var*
//#UC END# *4E5E26150131_4E5E029D03AD_var*
begin
//#UC START# *4E5E26150131_4E5E029D03AD_impl*
 Result := f_DecimalOffset;
//#UC END# *4E5E26150131_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.GetDigitalSeparatorOffset

{$EndIf DigitalSeparatorSupport_imp}
