{$IfNDef atObjectHistory_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atObjectHistory.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::OperationsFramework::atObjectHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atObjectHistory_imp}
 _InterfaceListElement_ = _HistoryStoredObject_;
 _atTypedInterfaceList_Parent_ = TInterfaceList;
 {$Include w:\quality\test\garant6x\AdapterTest\MixIns\atTypedInterfaceList.imp.pas}
 _atObjectHistory_ = {mixin} class(_atTypedInterfaceList_)
 private
 // private fields
   f_HistoryLength : Integer;
    {* Поле для свойства HistoryLength}
 private
 // private methods
   procedure TrimHistory; virtual;
 protected
 // property methods
   function pm_GetHistoryLength: Integer;
   procedure pm_SetHistoryLength(aValue: Integer);
   function pm_GetCurrent: _HistoryStoredObject_; virtual;
 public
 // public methods
   procedure AddToHistory(const aStoredObject: _HistoryStoredObject_); virtual;
 public
 // public properties
   property HistoryLength: Integer
     read pm_GetHistoryLength
     write pm_SetHistoryLength;
   property Current: _HistoryStoredObject_
     read pm_GetCurrent;
 end;//_atObjectHistory_

{$Else atObjectHistory_imp}

{$Include w:\quality\test\garant6x\AdapterTest\MixIns\atTypedInterfaceList.imp.pas}

// start class _atObjectHistory_

function _atObjectHistory_.pm_GetHistoryLength: Integer;
//#UC START# *483A8008021E_483A7BE60395get_var*
//#UC END# *483A8008021E_483A7BE60395get_var*
begin
//#UC START# *483A8008021E_483A7BE60395get_impl*
 Result := f_HistoryLength
//#UC END# *483A8008021E_483A7BE60395get_impl*
end;//_atObjectHistory_.pm_GetHistoryLength

procedure _atObjectHistory_.pm_SetHistoryLength(aValue: Integer);
//#UC START# *483A8008021E_483A7BE60395set_var*
//#UC END# *483A8008021E_483A7BE60395set_var*
begin
//#UC START# *483A8008021E_483A7BE60395set_impl*
 f_HistoryLength := aValue;
 TrimHistory;
//#UC END# *483A8008021E_483A7BE60395set_impl*
end;//_atObjectHistory_.pm_SetHistoryLength

function _atObjectHistory_.pm_GetCurrent: _HistoryStoredObject_;
//#UC START# *483A8053003A_483A7BE60395get_var*
//#UC END# *483A8053003A_483A7BE60395get_var*
begin
//#UC START# *483A8053003A_483A7BE60395get_impl*
 Result := Last;
//#UC END# *483A8053003A_483A7BE60395get_impl*
end;//_atObjectHistory_.pm_GetCurrent

procedure _atObjectHistory_.AddToHistory(const aStoredObject: _HistoryStoredObject_);
//#UC START# *483A8088025D_483A7BE60395_var*
//#UC END# *483A8088025D_483A7BE60395_var*
begin
//#UC START# *483A8088025D_483A7BE60395_impl*
  Add(aStoredObject);
  TrimHistory;
//#UC END# *483A8088025D_483A7BE60395_impl*
end;//_atObjectHistory_.AddToHistory

procedure _atObjectHistory_.TrimHistory;
//#UC START# *483AA4810302_483A7BE60395_var*
//#UC END# *483AA4810302_483A7BE60395_var*
begin
//#UC START# *483AA4810302_483A7BE60395_impl*
  while (Count > f_HistoryLength) do Delete(0);
//#UC END# *483AA4810302_483A7BE60395_impl*
end;//_atObjectHistory_.TrimHistory

{$EndIf atObjectHistory_imp}
