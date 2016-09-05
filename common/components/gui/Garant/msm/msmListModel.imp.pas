{$IfNDef msmListModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmListModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmListModel" MUID: (57B189990202)
// Имя типа: "_msmListModel_"

{$Define msmListModel_imp}

 {$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}
 _msmListModel_ = {abstract} class(_msmListLikeModel_, ImsmListModel, ImsmListLikeModel)
  private
   f_List: ImsmModelElementStringList;
  protected
   function As_ImsmListLikeModel: ImsmListLikeModel;
    {* Метод приведения нашего интерфейса к ImsmListLikeModel }
   function Get_List: ImsmModelElementStringList;
   procedure Set_List(const aValue: ImsmModelElementStringList);
   procedure ShowElementAsDir(const aList: ImsmModelElement);
    {* Показывает элемент в виде "директории" }
   procedure ShowElementRelationList(const anElement: ImsmModelElement);
    {* Показывает дочерний список элемента }
   procedure ClearFields; override;
 end;//_msmListModel_

{$Else msmListModel_imp}

{$IfNDef msmListModel_imp_impl}

{$Define msmListModel_imp_impl}

{$Include w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas}

function _msmListModel_.As_ImsmListLikeModel: ImsmListLikeModel;
 {* Метод приведения нашего интерфейса к ImsmListLikeModel }
begin
 Result := Self;
end;//_msmListModel_.As_ImsmListLikeModel

function _msmListModel_.Get_List: ImsmModelElementStringList;
//#UC START# *57B167E2003A_57B189990202get_var*
//#UC END# *57B167E2003A_57B189990202get_var*
begin
//#UC START# *57B167E2003A_57B189990202get_impl*
 Result := f_List;
//#UC END# *57B167E2003A_57B189990202get_impl*
end;//_msmListModel_.Get_List

procedure _msmListModel_.Set_List(const aValue: ImsmModelElementStringList);
//#UC START# *57B167E2003A_57B189990202set_var*
//#UC END# *57B167E2003A_57B189990202set_var*
begin
//#UC START# *57B167E2003A_57B189990202set_impl*
 if (f_List <> aValue) then
 begin
  f_List := aValue;
  Fire(ListChangedEvent.Instance);
 end;//f_StringList <> aValue
//#UC END# *57B167E2003A_57B189990202set_impl*
end;//_msmListModel_.Set_List

procedure _msmListModel_.ShowElementAsDir(const aList: ImsmModelElement);
 {* Показывает элемент в виде "директории" }
//#UC START# *57B1A3DA0382_57B189990202_var*
//#UC END# *57B1A3DA0382_57B189990202_var*
begin
//#UC START# *57B1A3DA0382_57B189990202_impl*
 Self.Set_List(TmsmModelElementDir.Make(aList.List[f_ElementView.rListName], f_ElementView.rTextName));
//#UC END# *57B1A3DA0382_57B189990202_impl*
end;//_msmListModel_.ShowElementAsDir

procedure _msmListModel_.ShowElementRelationList(const anElement: ImsmModelElement);
 {* Показывает дочерний список элемента }
//#UC START# *57B32AEE0261_57B189990202_var*
//#UC END# *57B32AEE0261_57B189990202_var*
begin
//#UC START# *57B32AEE0261_57B189990202_impl*
 Self.Set_List(TmsmModelElementRelationList.Make(anElement, anElement.List[f_ElementView.rListName], f_ElementView.rTextName));
//#UC END# *57B32AEE0261_57B189990202_impl*
end;//_msmListModel_.ShowElementRelationList

procedure _msmListModel_.ClearFields;
begin
 f_List := nil;
 inherited;
end;//_msmListModel_.ClearFields

{$EndIf msmListModel_imp_impl}

{$EndIf msmListModel_imp}

