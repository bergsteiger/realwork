{$IfNDef vcmKeyDataListener_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmKeyDataListener.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "vcmKeyDataListener" MUID: (53B24D240088)
// Имя типа: "_vcmKeyDataListener_"

{$Define vcmKeyDataListener_imp}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 _vcmKeyDataListener_ = class(_vcmKeyDataListener_Parent_, Il3KeyDataListener)
  protected
   function NeedProcessKeyData(aKey: Byte;
    aShift: TShiftState): Boolean; virtual;
   procedure DoProcessKeyData(aKey: Byte;
    aShift: TShiftState); virtual;
   function ProcessKeyData(aKey: Byte;
    aShiftFlags: Byte): Boolean;
 end;//_vcmKeyDataListener_

{$Else NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}

_vcmKeyDataListener_ = _vcmKeyDataListener_Parent_;

{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
{$Else vcmKeyDataListener_imp}

{$IfNDef vcmKeyDataListener_imp_impl}

{$Define vcmKeyDataListener_imp_impl}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
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
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$EndIf vcmKeyDataListener_imp_impl}

{$EndIf vcmKeyDataListener_imp}

