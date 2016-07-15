{$IfNDef dsBaseSearchSupportQuery_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "dsBaseSearchSupportQuery" MUID: (496F3F2500A8)
// ��� ����: "_dsBaseSearchSupportQuery_"

{$Define dsBaseSearchSupportQuery_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _dsBaseSearchSupportQuery_ = {abstract} class(_dsBaseSearchSupportQuery_Parent_)
  {* �������, ����������� ����������� ��������� BaseSearchSupportQuery }
  private
   ucc_BaseSearch: IucpBaseSearchSupportQuery;
  protected
   function Get_CanRunBaseSearch: Boolean;
   {$If NOT Defined(NoVCM)}
   procedure InitRefs(const aDS: IvcmFormSetDataSource); override;
    {* �������������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure ClearRefs; override;
    {* ������� ������ �� ��������� ������������� ���������� }
   {$IfEnd} // NOT Defined(NoVCM)
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

{$If NOT Defined(NoVCM)}
procedure _dsBaseSearchSupportQuery_.InitRefs(const aDS: IvcmFormSetDataSource);
 {* �������������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 Supports(aDS, IucpBaseSearchSupportQuery, ucc_BaseSearch);
end;//_dsBaseSearchSupportQuery_.InitRefs
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsBaseSearchSupportQuery_.ClearRefs;
 {* ������� ������ �� ��������� ������������� ���������� }
begin
 inherited;
 ucc_BaseSearch := nil;
end;//_dsBaseSearchSupportQuery_.ClearRefs
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf dsBaseSearchSupportQuery_imp_impl}

{$EndIf dsBaseSearchSupportQuery_imp}

