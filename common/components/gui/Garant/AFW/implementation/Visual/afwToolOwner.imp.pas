{$IfNDef afwToolOwner_imp}

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwToolOwner.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "afwToolOwner" MUID: (48BD1ABE023D)
// Имя типа: "_afwToolOwner_"

{$Define afwToolOwner_imp}

 //#UC START# *48BD1ABE023Dci*
 //#UC END# *48BD1ABE023Dci*
 //#UC START# *48BD1ABE023Dcit*
 //#UC END# *48BD1ABE023Dcit*
 _afwToolOwner_ = class(_afwToolOwner_Parent_, Il3ToolOwner)
  private
   f_Tools: Tl3LongintList;
  protected
   procedure Cleanup; override;
   procedure AddTool(const aTool: Il3Tool);
    {* Добавить инструмент. }
   procedure RemoveTool(const aTool: Il3Tool);
    {* Удалить инструмент. }
 //#UC START# *48BD1ABE023Dpubl*
    protected
    // internal methods
      {$IfDef DesignTimeLibrary}
      function CheckStamp(const aGUID: TGUID): Boolean;
        {-}
      {$EndIf DesignTimeLibrary}
 //#UC END# *48BD1ABE023Dpubl*
 end;//_afwToolOwner_

{$Else afwToolOwner_imp}

{$IfNDef afwToolOwner_imp_impl}

{$Define afwToolOwner_imp_impl}

procedure _afwToolOwner_.Cleanup;
//#UC START# *48BD1B31032C_48BD1ABE023D_var*
var
 l_Index : Integer;
//#UC END# *48BD1B31032C_48BD1ABE023D_var*
begin
//#UC START# *48BD1B31032C_48BD1ABE023D_impl*
 if (f_Tools <> nil) then
  with f_Tools do
   for l_Index := Lo to Hi do
    Il3Tool(Items[l_Index]).OwnerDead;
 FreeAndNil(f_Tools);
 inherited;
//#UC END# *48BD1B31032C_48BD1ABE023D_impl*
end;//_afwToolOwner_.Cleanup

procedure _afwToolOwner_.AddTool(const aTool: Il3Tool);
 {* Добавить инструмент. }
//#UC START# *46A5D45903CC_48BD1ABE023D_var*
//#UC END# *46A5D45903CC_48BD1ABE023D_var*
begin
//#UC START# *46A5D45903CC_48BD1ABE023D_impl*
 if (f_Tools = nil) then
  f_Tools := Tl3LongintList.Make;
 f_Tools.Add(Integer(aTool));
//#UC END# *46A5D45903CC_48BD1ABE023D_impl*
end;//_afwToolOwner_.AddTool

procedure _afwToolOwner_.RemoveTool(const aTool: Il3Tool);
 {* Удалить инструмент. }
//#UC START# *46A5D47201FC_48BD1ABE023D_var*
//#UC END# *46A5D47201FC_48BD1ABE023D_var*
begin
//#UC START# *46A5D47201FC_48BD1ABE023D_impl*
 if (f_Tools <> nil) then
  f_Tools.Remove(Integer(aTool));
//#UC END# *46A5D47201FC_48BD1ABE023D_impl*
end;//_afwToolOwner_.RemoveTool

//#UC START# *48BD1ABE023Dimpl*
{$IfDef DesignTimeLibrary}
function _afwToolOwner_.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 Result := false;
end;
{$EndIf DesignTimeLibrary}
//#UC END# *48BD1ABE023Dimpl*

{$EndIf afwToolOwner_imp_impl}

{$EndIf afwToolOwner_imp}

