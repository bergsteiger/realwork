{$IfNDef vcmKeyDataListener_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmKeyDataListener.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmKeyDataListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmKeyDataListener_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmKeyDataListener_ = {mixin} class(_vcmKeyDataListener_Parent_, Il3KeyDataListener)
 protected
 // realized methods
   function ProcessKeyData(aKey: Byte;
    aShiftFlags: Byte): Boolean;
 protected
 // protected methods
   function NeedProcessKeyData(aKey: Byte;
     aShift: TShiftState): Boolean; virtual;
   procedure DoProcessKeyData(aKey: Byte;
     aShift: TShiftState); virtual;
 end;//_vcmKeyDataListener_
{$Else}

 _vcmKeyDataListener_ = _vcmKeyDataListener_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmKeyDataListener_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmKeyDataListener_

function _vcmKeyDataListener_.NeedProcessKeyData(aKey: Byte;
  aShift: TShiftState): Boolean;
//#UC START# *53B24E7A0280_53B24D240088_var*
//#UC END# *53B24E7A0280_53B24D240088_var*
begin
//#UC START# *53B24E7A0280_53B24D240088_impl*
 Result := False;
//#UC END# *53B24E7A0280_53B24D240088_impl*
end;//_vcmKeyDataListener_.NeedProcessKeyData

procedure _vcmKeyDataListener_.DoProcessKeyData(aKey: Byte;
  aShift: TShiftState);
//#UC START# *53B24F1D034F_53B24D240088_var*
//#UC END# *53B24F1D034F_53B24D240088_var*
begin
//#UC START# *53B24F1D034F_53B24D240088_impl*
 // ничего не делаем
//#UC END# *53B24F1D034F_53B24D240088_impl*
end;//_vcmKeyDataListener_.DoProcessKeyData

function _vcmKeyDataListener_.ProcessKeyData(aKey: Byte;
  aShiftFlags: Byte): Boolean;
//#UC START# *53B1197D0372_53B24D240088_var*
var
 l_ShiftState: TShiftState;
 l_NeedProcess: Boolean;
//#UC END# *53B1197D0372_53B24D240088_var*
begin
//#UC START# *53B1197D0372_53B24D240088_impl*
 l_ShiftState := KeyDataToShiftState(aShiftFlags);
 l_NeedProcess := NeedProcessKeyData(aKey, l_ShiftState);
 if l_NeedProcess then
  DoProcessKeyData(aKey, l_ShiftState);
 Result := l_NeedProcess; 
//#UC END# *53B1197D0372_53B24D240088_impl*
end;//_vcmKeyDataListener_.ProcessKeyData

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmKeyDataListener_imp}
