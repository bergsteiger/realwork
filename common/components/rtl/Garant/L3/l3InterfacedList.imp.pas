{$IfNDef l3InterfacedList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3InterfacedList" MUID: (47CED1980057)
// Имя типа: "_l3InterfacedList_"

{$Define l3InterfacedList_imp}

 _l3ListAssign_Parent_ = _l3InterfacedList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3ListAssign.imp.pas}
 _l3InterfacedList_ = class(_l3ListAssign_, _ListType_)
  protected
   function pm_GetCount: Integer;
  public
   class function MakeI: Ml3CountHolder; reintroduce;
 end;//_l3InterfacedList_

{$Else l3InterfacedList_imp}

{$IfNDef l3InterfacedList_imp_impl}

{$Define l3InterfacedList_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3ListAssign.imp.pas}

class function _l3InterfacedList_.MakeI: Ml3CountHolder;
var
 l_Inst : _l3InterfacedList_;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_l3InterfacedList_.MakeI

function _l3InterfacedList_.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47CED1980057get_var*
//#UC END# *4BB08B8902F2_47CED1980057get_var*
begin
//#UC START# *4BB08B8902F2_47CED1980057get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47CED1980057get_impl*
end;//_l3InterfacedList_.pm_GetCount

{$EndIf l3InterfacedList_imp_impl}

{$EndIf l3InterfacedList_imp}

