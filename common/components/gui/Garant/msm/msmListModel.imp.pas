{$IfNDef msmListModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmListModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmListModel" MUID: (57B189990202)
// Имя типа: "_msmListModel_"

{$Define msmListModel_imp}

 {$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}
 _msmListModel_ = {abstract} class(_msmListLikeModel_, ImsmListModel)
  private
   f_IsDir: Boolean;
   f_List: ImsmModelElementStringList;
  protected
   procedure SetList(const aValue: ImsmModelElementStringList);
   function DoGetList: ImsmModelElementStringList; override;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); override;
   procedure ClearFields; override;
 end;//_msmListModel_

{$Else msmListModel_imp}

{$IfNDef msmListModel_imp_impl}

{$Define msmListModel_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}

procedure _msmListModel_.SetList(const aValue: ImsmModelElementStringList);
//#UC START# *57D274D20357_57B189990202_var*
//#UC END# *57D274D20357_57B189990202_var*
begin
//#UC START# *57D274D20357_57B189990202_impl*
 if (f_List <> aValue) then
 begin
  f_List := aValue;
  Fire(ListChangedEvent.Instance);
 end;//f_StringList <> aValue
//#UC END# *57D274D20357_57B189990202_impl*
end;//_msmListModel_.SetList

function _msmListModel_.DoGetList: ImsmModelElementStringList;
//#UC START# *57D271E300C2_57B189990202_var*
//#UC END# *57D271E300C2_57B189990202_var*
begin
//#UC START# *57D271E300C2_57B189990202_impl*
 Result := f_List;
//#UC END# *57D271E300C2_57B189990202_impl*
end;//_msmListModel_.DoGetList

procedure _msmListModel_.DoShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57D2A7D900FE_57B189990202_var*
//#UC END# *57D2A7D900FE_57B189990202_var*
begin
//#UC START# *57D2A7D900FE_57B189990202_impl*
 if (anElement = nil) then
  Self.SetList(nil)
 else 
 if f_IsDir then
  Self.SetList(TmsmModelElementDir.Make(anElement.List[f_ElementView.rListName], f_ElementView.rTextName))
 else
  Self.SetList(TmsmModelElementRelationList.Make(anElement, anElement.List[f_ElementView.rListName], f_ElementView.rTextName));
//#UC END# *57D2A7D900FE_57B189990202_impl*
end;//_msmListModel_.DoShowElementAsList

procedure _msmListModel_.ClearFields;
begin
 f_List := nil;
 inherited;
end;//_msmListModel_.ClearFields

{$EndIf msmListModel_imp_impl}

{$EndIf msmListModel_imp}

