{$IfNDef dsBaseSearchSupportQuery_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "dsBaseSearchSupportQuery" MUID: (496F3F2500A8)
// Имя типа: "_dsBaseSearchSupportQuery_"

{$Define dsBaseSearchSupportQuery_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _dsBaseSearchSupportQuery_ = {abstract} class(_dsBaseSearchSupportQuery_Parent_)
  {* Примесь, реализующая абстрактный интерфейс BaseSearchSupportQuery }
  private
   BaseSearch: IucpBaseSearchSupportQuery;
  protected
   function Get_CanRunBaseSearch: Boolean;
 end;//_dsBaseSearchSupportQuery_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_dsBaseSearchSupportQuery_ = _dsBaseSearchSupportQuery_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsBaseSearchSupportQuery_imp}

{$IfNDef dsBaseSearchSupportQuery_imp_impl}

{$Define dsBaseSearchSupportQuery_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
function _dsBaseSearchSupportQuery_.Get_CanRunBaseSearch: Boolean;
//#UC START# *496F344101D0_496F3F2500A8get_var*
//#UC END# *496F344101D0_496F3F2500A8get_var*
begin
//#UC START# *496F344101D0_496F3F2500A8get_impl*
 Result := (ucc_BaseSearch <> nil) and ucc_BaseSearch.CanRunBaseSearch;
//#UC END# *496F344101D0_496F3F2500A8get_impl*
end;//_dsBaseSearchSupportQuery_.Get_CanRunBaseSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsBaseSearchSupportQuery_imp_impl}

{$EndIf dsBaseSearchSupportQuery_imp}

