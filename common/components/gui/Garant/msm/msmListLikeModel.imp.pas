{$IfNDef msmListLikeModel_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmListLikeModel.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmListLikeModel" MUID: (57B57EDB003F)
// Имя типа: "_msmListLikeModel_"

{$Define msmListLikeModel_imp}

 _msmListLikeModel_ = {abstract} class(TmsmModel, ImsmListLikeModel, ImsmCaptionModel)
  private
   f_ElementView: TmsmModelElementView;
   f_Selection: ImsmElementSelection;
   f_ElementToAction: ImsmModelElement;
  protected
   function DoGetList: ImsmModelElementStringList; virtual; abstract;
   procedure DoShowElementAsList(const anElement: ImsmModelElement); virtual; abstract;
   procedure ShowElementAsList(const anElement: ImsmModelElement);
   function Get_Caption: Il3CString;
   procedure Set_Caption(const aValue: Il3CString);
   function Get_ElementToAction: ImsmModelElement;
   procedure Set_ElementToAction(const aValue: ImsmModelElement);
   function Get_CurrentElement: ImsmModelElement;
   procedure Set_CurrentElement(const aValue: ImsmModelElement);
   function Get_List: ImsmModelElementStringList;
   function Get_Selection: ImsmElementSelection;
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   procedure Paste(const aSelection: ImsmElementSelection);
  public
   property Selection: ImsmElementSelection
    read f_Selection;
 end;//_msmListLikeModel_

{$Else msmListLikeModel_imp}

{$IfNDef msmListLikeModel_imp_impl}

{$Define msmListLikeModel_imp_impl}

procedure _msmListLikeModel_.ShowElementAsList(const anElement: ImsmModelElement);
//#UC START# *57B1A3DA0382_57B57EDB003F_var*
//#UC END# *57B1A3DA0382_57B57EDB003F_var*
begin
//#UC START# *57B1A3DA0382_57B57EDB003F_impl*
 DoShowElementAsList(anElement);
//#UC END# *57B1A3DA0382_57B57EDB003F_impl*
end;//_msmListLikeModel_.ShowElementAsList

function _msmListLikeModel_.Get_Caption: Il3CString;
//#UC START# *57B1A47403C5_57B57EDB003Fget_var*
var
 l_Caption : AnsiString;
//#UC END# *57B1A47403C5_57B57EDB003Fget_var*
begin
//#UC START# *57B1A47403C5_57B57EDB003Fget_impl*
 l_Caption := f_ElementView.rListName;
 if (l_Caption = 'SelfList') then
  l_Caption := f_ElementView.rTextName;
 if (l_Caption = 'DocumentationNotEmpty') then
  l_Caption := 'Doc';
 Result := TtfwCStringFactory.C(l_Caption); 
//#UC END# *57B1A47403C5_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_Caption

procedure _msmListLikeModel_.Set_Caption(const aValue: Il3CString);
//#UC START# *57B1A47403C5_57B57EDB003Fset_var*
//#UC END# *57B1A47403C5_57B57EDB003Fset_var*
begin
//#UC START# *57B1A47403C5_57B57EDB003Fset_impl*
 // - ничего не делаем
//#UC END# *57B1A47403C5_57B57EDB003Fset_impl*
end;//_msmListLikeModel_.Set_Caption

function _msmListLikeModel_.Get_ElementToAction: ImsmModelElement;
//#UC START# *57B2B019009C_57B57EDB003Fget_var*
//#UC END# *57B2B019009C_57B57EDB003Fget_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fget_impl*
 Result := f_ElementToAction;
//#UC END# *57B2B019009C_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_ElementToAction

procedure _msmListLikeModel_.Set_ElementToAction(const aValue: ImsmModelElement);
//#UC START# *57B2B019009C_57B57EDB003Fset_var*
//#UC END# *57B2B019009C_57B57EDB003Fset_var*
begin
//#UC START# *57B2B019009C_57B57EDB003Fset_impl*
 f_ElementToAction := aValue;
 Fire(ActionElementEvent.Instance);
//#UC END# *57B2B019009C_57B57EDB003Fset_impl*
end;//_msmListLikeModel_.Set_ElementToAction

function _msmListLikeModel_.Get_CurrentElement: ImsmModelElement;
//#UC START# *57B31CF301D2_57B57EDB003Fget_var*
//#UC END# *57B31CF301D2_57B57EDB003Fget_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fget_impl*
 Result := f_Selection.CurrentElement;
//#UC END# *57B31CF301D2_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_CurrentElement

procedure _msmListLikeModel_.Set_CurrentElement(const aValue: ImsmModelElement);
//#UC START# *57B31CF301D2_57B57EDB003Fset_var*
//#UC END# *57B31CF301D2_57B57EDB003Fset_var*
begin
//#UC START# *57B31CF301D2_57B57EDB003Fset_impl*
 f_Selection.CurrentElement := aValue;
//#UC END# *57B31CF301D2_57B57EDB003Fset_impl*
end;//_msmListLikeModel_.Set_CurrentElement

function _msmListLikeModel_.Get_List: ImsmModelElementStringList;
//#UC START# *57B6A4550271_57B57EDB003Fget_var*
//#UC END# *57B6A4550271_57B57EDB003Fget_var*
begin
//#UC START# *57B6A4550271_57B57EDB003Fget_impl*
 Result := DoGetList;
//#UC END# *57B6A4550271_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_List

function _msmListLikeModel_.Get_Selection: ImsmElementSelection;
//#UC START# *57D8F1B70265_57B57EDB003Fget_var*
//#UC END# *57D8F1B70265_57B57EDB003Fget_var*
begin
//#UC START# *57D8F1B70265_57B57EDB003Fget_impl*
 Result := f_Selection;
//#UC END# *57D8F1B70265_57B57EDB003Fget_impl*
end;//_msmListLikeModel_.Get_Selection

procedure _msmListLikeModel_.Paste(const aSelection: ImsmElementSelection);
//#UC START# *57E283A603D2_57B57EDB003F_var*
var
 l_List : TtfwWordRefList;

 function DoElement(const anElement: ImsmModelElement): Boolean;
 begin
  Result := true;
  l_List.Add((anElement As ITmsmBaseModelElementWrap).GetSelf.MainWord);
 end;

//#UC END# *57E283A603D2_57B57EDB003F_var*
begin
//#UC START# *57E283A603D2_57B57EDB003F_impl*
 Assert(aSelection <> nil);
 l_List := TtfwWordRefList.Create;
 try
  aSelection.ProcessSelectedF(L2ImsmElementSelectionProcessSelectedFAction(@DoElement));
  Assert(Self.Get_List.Owner <> nil);
  if Self.Get_List.Owner.BoolProp['IsDiagram'] then
   TmsmModelElementMethodCaller.Call([TtfwStackValue_C((Self.Get_List.Owner As ITmsmBaseModelElementWrap).GetSelf.MainWord), TtfwStackValue_C(TtfwWordsIterator.Make(l_List))], 'msm:Diagram:PasteElements')
  else
   Assert(false);
  Fire(ListContentChangedEvent.Instance); 
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *57E283A603D2_57B57EDB003F_impl*
end;//_msmListLikeModel_.Paste

procedure _msmListLikeModel_.InitFields;
//#UC START# *47A042E100E2_57B57EDB003F_var*
//#UC END# *47A042E100E2_57B57EDB003F_var*
begin
//#UC START# *47A042E100E2_57B57EDB003F_impl*
 inherited;
 f_Selection := TmsmElementSelection.Make(Self);
//#UC END# *47A042E100E2_57B57EDB003F_impl*
end;//_msmListLikeModel_.InitFields

procedure _msmListLikeModel_.ClearFields;
begin
 Finalize(f_ElementView);
 f_Selection := nil;
 f_ElementToAction := nil;
 inherited;
end;//_msmListLikeModel_.ClearFields

{$EndIf msmListLikeModel_imp_impl}

{$EndIf msmListLikeModel_imp}

