{$IfNDef dsBaseSearchSupportQuery_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseSearchSupportQuery.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::Document::dsBaseSearchSupportQuery
//
// Примесь, реализующая абстрактный интерфейс BaseSearchSupportQuery
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsBaseSearchSupportQuery_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _dsBaseSearchSupportQuery_ = {abstract vac} class(_dsBaseSearchSupportQuery_Parent_)
  {* Примесь, реализующая абстрактный интерфейс BaseSearchSupportQuery }
 private
 // private fields
   ucc_BaseSearch : IucpBaseSearchSupportQuery;
 protected
  procedure InitRefs(const aDS: IvcmUseCaseController); override;
  procedure ClearRefs; override;
 protected
 // realized methods
   function Get_CanRunBaseSearch: Boolean;
 end;//_dsBaseSearchSupportQuery_
{$Else}

 _dsBaseSearchSupportQuery_ = _dsBaseSearchSupportQuery_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsBaseSearchSupportQuery_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _dsBaseSearchSupportQuery_

function _dsBaseSearchSupportQuery_.Get_CanRunBaseSearch: Boolean;
//#UC START# *496F344101D0_496F3F2500A8get_var*
//#UC END# *496F344101D0_496F3F2500A8get_var*
begin
//#UC START# *496F344101D0_496F3F2500A8get_impl*
 Result := (ucc_BaseSearch <> nil) and ucc_BaseSearch.CanRunBaseSearch;
//#UC END# *496F344101D0_496F3F2500A8get_impl*
end;//_dsBaseSearchSupportQuery_.Get_CanRunBaseSearch

procedure _dsBaseSearchSupportQuery_.InitRefs(const aDS: IvcmUseCaseController);
begin
 inherited;
 Supports(aDS, IucpBaseSearchSupportQuery, ucc_BaseSearch);
end;

procedure _dsBaseSearchSupportQuery_.ClearRefs;
begin
 inherited;
 ucc_BaseSearch := nil;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsBaseSearchSupportQuery_imp}
