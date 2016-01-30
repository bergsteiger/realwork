{$IfNDef nsContextFilter_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Tree\nsContextFilter.imp.pas"
// Стереотип: "Impurity"

{$Define nsContextFilter_imp}

 _nsContextFilter_ = class(_nsContextFilter_Parent_)
  {* Контекстный фильтр }
  private
   f_CurrentContextFilter: InscContextFilterState;
  protected
   procedure Cleanup; override;
   function pm_GetCurrentContextFilter: InscContextFilterState;
  public
   function FiltrateByContext(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode;
    const aFilter: InscContextFilterState;
    out aCurrent: Integer): Il3SimpleTree;
 end;//_nsContextFilter_

{$Else nsContextFilter_imp}

{$IfNDef nsContextFilter_imp_impl}

{$Define nsContextFilter_imp_impl}

procedure _nsContextFilter_.Cleanup;
//#UC START# *492D92370149_492D91B7037E_var*
//#UC END# *492D92370149_492D91B7037E_var*
begin
//#UC START# *492D92370149_492D91B7037E_impl*
 f_CurrentContextFilter := nil;
 inherited;
//#UC END# *492D92370149_492D91B7037E_impl*
end;//_nsContextFilter_.Cleanup

function _nsContextFilter_.pm_GetCurrentContextFilter: InscContextFilterState;
//#UC START# *492D9071038D_492D91B7037Eget_var*
//#UC END# *492D9071038D_492D91B7037Eget_var*
begin
//#UC START# *492D9071038D_492D91B7037Eget_impl*
 if f_CurrentContextFilter = nil then
  f_CurrentContextFilter := TnscContextFilterState.Make(False, nil, 0);
 Result := f_CurrentContextFilter;
//#UC END# *492D9071038D_492D91B7037Eget_impl*
end;//_nsContextFilter_.pm_GetCurrentContextFilter

function _nsContextFilter_.FiltrateByContext(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode;
 const aFilter: InscContextFilterState;
 out aCurrent: Integer): Il3SimpleTree;
//#UC START# *492D90AA0118_492D91B7037E_var*
var
 l_FilterableTree: Il3FilterableTree;
//#UC END# *492D90AA0118_492D91B7037E_var*
begin
//#UC START# *492D90AA0118_492D91B7037E_impl*
 if Supports(aTreeSource, Il3FilterableTree, l_FilterableTree) then
 begin
  if (aFilter = nil) then
   pm_GetCurrentContextFilter
  else
   f_CurrentContextFilter := aFilter;
  Result := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters.
                                          SetContext(f_CurrentContextFilter.ActiveContext),
                                          aCurrentNode,
                                          aCurrent,
                                          True,
                                          f_CurrentContextFilter.NeedRefilterTree);
 end
 else
  Result := aTreeSource;
//#UC END# *492D90AA0118_492D91B7037E_impl*
end;//_nsContextFilter_.FiltrateByContext

{$EndIf nsContextFilter_imp_impl}

{$EndIf nsContextFilter_imp}

