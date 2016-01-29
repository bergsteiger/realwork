{$IfNDef atTypedInterfaceList_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/MixIns/atTypedInterfaceList.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::MixIns::atTypedInterfaceList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atTypedInterfaceList_imp}
 _atTypedInterfaceList_ = {mixin} class(_atTypedInterfaceList_Parent_)
 protected
 // property methods
   function pm_GetFirst: _InterfaceListElement_; virtual;
   function pm_GetItems(anIndex: Integer): _InterfaceListElement_; virtual;
   procedure pm_SetItems(anIndex: Integer; const aValue: _InterfaceListElement_); virtual;
   function pm_GetLast: _InterfaceListElement_; virtual;
 public
 // public methods
   function Add(const anInterface: _InterfaceListElement_): Integer; virtual;
   procedure Delete(anIndex: Integer); virtual;
   function Remove(const anInterface: _InterfaceListElement_): Integer; virtual;
   function IndexOf(const anInterface: _InterfaceListElement_): Integer; virtual;
   procedure Insert(anIndex: Integer;
    const anInterface: _InterfaceListElement_); virtual;
 public
 // public properties
   property First: _InterfaceListElement_
     read pm_GetFirst;
   property Items[anIndex: Integer]: _InterfaceListElement_
     read pm_GetItems
     write pm_SetItems;
     default;
   property Last: _InterfaceListElement_
     read pm_GetLast;
 end;//_atTypedInterfaceList_

{$Else atTypedInterfaceList_imp}

// start class _atTypedInterfaceList_

function _atTypedInterfaceList_.pm_GetFirst: _InterfaceListElement_;
//#UC START# *4836E1400166_4836DFD401E3get_var*
//#UC END# *4836E1400166_4836DFD401E3get_var*
begin
//#UC START# *4836E1400166_4836DFD401E3get_impl*
 Result := _InterfaceListElement_(inherited First);
//#UC END# *4836E1400166_4836DFD401E3get_impl*
end;//_atTypedInterfaceList_.pm_GetFirst

function _atTypedInterfaceList_.pm_GetItems(anIndex: Integer): _InterfaceListElement_;
//#UC START# *4836E1A0031B_4836DFD401E3get_var*
//#UC END# *4836E1A0031B_4836DFD401E3get_var*
begin
//#UC START# *4836E1A0031B_4836DFD401E3get_impl*
 Result := _InterfaceListElement_(inherited Items[anIndex]);
//#UC END# *4836E1A0031B_4836DFD401E3get_impl*
end;//_atTypedInterfaceList_.pm_GetItems

procedure _atTypedInterfaceList_.pm_SetItems(anIndex: Integer; const aValue: _InterfaceListElement_);
//#UC START# *4836E1A0031B_4836DFD401E3set_var*
//#UC END# *4836E1A0031B_4836DFD401E3set_var*
begin
//#UC START# *4836E1A0031B_4836DFD401E3set_impl*
  inherited Items[anIndex] := aValue;
//#UC END# *4836E1A0031B_4836DFD401E3set_impl*
end;//_atTypedInterfaceList_.pm_SetItems

function _atTypedInterfaceList_.pm_GetLast: _InterfaceListElement_;
//#UC START# *4836E234001E_4836DFD401E3get_var*
//#UC END# *4836E234001E_4836DFD401E3get_var*
begin
//#UC START# *4836E234001E_4836DFD401E3get_impl*
 Result := _InterfaceListElement_(inherited Last);
//#UC END# *4836E234001E_4836DFD401E3get_impl*
end;//_atTypedInterfaceList_.pm_GetLast

function _atTypedInterfaceList_.Add(const anInterface: _InterfaceListElement_): Integer;
//#UC START# *4836DFF301A4_4836DFD401E3_var*
//#UC END# *4836DFF301A4_4836DFD401E3_var*
begin
//#UC START# *4836DFF301A4_4836DFD401E3_impl*
 Result := inherited Add(anInterface);
//#UC END# *4836DFF301A4_4836DFD401E3_impl*
end;//_atTypedInterfaceList_.Add

procedure _atTypedInterfaceList_.Delete(anIndex: Integer);
//#UC START# *4836E01D0137_4836DFD401E3_var*
//#UC END# *4836E01D0137_4836DFD401E3_var*
begin
//#UC START# *4836E01D0137_4836DFD401E3_impl*
 inherited Delete(anIndex);
//#UC END# *4836E01D0137_4836DFD401E3_impl*
end;//_atTypedInterfaceList_.Delete

function _atTypedInterfaceList_.Remove(const anInterface: _InterfaceListElement_): Integer;
//#UC START# *4836E04D03D7_4836DFD401E3_var*
//#UC END# *4836E04D03D7_4836DFD401E3_var*
begin
//#UC START# *4836E04D03D7_4836DFD401E3_impl*
  Result := inherited Remove(anInterface);
//#UC END# *4836E04D03D7_4836DFD401E3_impl*
end;//_atTypedInterfaceList_.Remove

function _atTypedInterfaceList_.IndexOf(const anInterface: _InterfaceListElement_): Integer;
//#UC START# *4836E082002D_4836DFD401E3_var*
//#UC END# *4836E082002D_4836DFD401E3_var*
begin
//#UC START# *4836E082002D_4836DFD401E3_impl*
  Result := inherited IndexOf(anInterface);
//#UC END# *4836E082002D_4836DFD401E3_impl*
end;//_atTypedInterfaceList_.IndexOf

procedure _atTypedInterfaceList_.Insert(anIndex: Integer;
  const anInterface: _InterfaceListElement_);
//#UC START# *4836E0B6004D_4836DFD401E3_var*
//#UC END# *4836E0B6004D_4836DFD401E3_var*
begin
//#UC START# *4836E0B6004D_4836DFD401E3_impl*
  inherited Insert(anIndex, anInterface);
//#UC END# *4836E0B6004D_4836DFD401E3_impl*
end;//_atTypedInterfaceList_.Insert

{$EndIf atTypedInterfaceList_imp}
