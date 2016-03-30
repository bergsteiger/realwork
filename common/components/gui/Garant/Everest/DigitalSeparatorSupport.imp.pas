{$IfNDef DigitalSeparatorSupport_imp}

// ћодуль: "w:\common\components\gui\Garant\Everest\DigitalSeparatorSupport.imp.pas"
// —тереотип: "Impurity"
// Ёлемент модели: "DigitalSeparatorSupport" MUID: (4E5E029D03AD)
// »м€ типа: "_DigitalSeparatorSupport_"

{$Define DigitalSeparatorSupport_imp}

type
 TevCheckPointSeparator = (
  ev_cpsNone
   {* ничего не делать (не ждать разделител€, не выливать) }
  , ev_cpsWait
   {* ждать разделител€. }
  , ev_cpsReady
   {* готовность к выливке }
 );//TevCheckPointSeparator

 _DigitalSeparatorSupport_ = class(_DigitalSeparatorSupport_Parent_)
  private
   f_WaitStyleD: TevCheckPointSeparator;
   f_DecimalOffset: Integer;
  private
   function HasDigitalSeparatorAlignment: Boolean;
  protected
   procedure ContinueCell;
   procedure CellStarted;
    {* »нформируем о начале €чейки. }
   procedure CellFinished;
    {* ячейка закончена. }
   procedure SetDigitalSeparatorParams(anAtomIndex: Integer;
    const aValue: Tk2Variant);
   function GetDigitalSeparatorOffset: Integer;
 end;//_DigitalSeparatorSupport_

{$Else DigitalSeparatorSupport_imp}

{$IfNDef DigitalSeparatorSupport_imp_impl}

{$Define DigitalSeparatorSupport_imp_impl}

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
 {* »нформируем о начале €чейки. }
//#UC START# *4E5E1C8D0090_4E5E029D03AD_var*
//#UC END# *4E5E1C8D0090_4E5E029D03AD_var*
begin
//#UC START# *4E5E1C8D0090_4E5E029D03AD_impl*
 f_WaitStyleD := ev_cpsWait;
//#UC END# *4E5E1C8D0090_4E5E029D03AD_impl*
end;//_DigitalSeparatorSupport_.CellStarted

procedure _DigitalSeparatorSupport_.CellFinished;
 {* ячейка закончена. }
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

{$EndIf DigitalSeparatorSupport_imp_impl}

{$EndIf DigitalSeparatorSupport_imp}

