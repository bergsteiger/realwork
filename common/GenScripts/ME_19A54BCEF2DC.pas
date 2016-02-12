unit FiltersKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Filters }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\FiltersKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Filters_Module
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Filters = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Filters
----
*������ �������������*:
[code]
'aControl' �����::Filters TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Filters

 Tkw_Filters_Control_FiltersList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FiltersList
----
*������ �������������*:
[code]
�������::FiltersList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Filters_Control_FiltersList

 Tkw_Filters_Control_FiltersList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FiltersList
----
*������ �������������*:
[code]
�������::FiltersList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Filters_Control_FiltersList_Push

 TkwEnFiltersFiltersList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenFilters.FiltersList
[panel]������� FiltersList ����� TenFilters[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFilters .TenFilters.FiltersList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FiltersList(const aCtx: TtfwContext;
    aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenFilters.FiltersList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFiltersFiltersList

class function Tkw_Form_Filters.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Filters';
end;//Tkw_Form_Filters.GetWordNameForRegister

function Tkw_Form_Filters.GetString: AnsiString;
begin
 Result := 'enFilters';
end;//Tkw_Form_Filters.GetString

class function Tkw_Filters_Control_FiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetWordNameForRegister

function Tkw_Filters_Control_FiltersList.GetString: AnsiString;
begin
 Result := 'FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetString

class procedure Tkw_Filters_Control_FiltersList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Filters_Control_FiltersList.RegisterInEngine

procedure Tkw_Filters_Control_FiltersList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_922109FC93A4_var*
//#UC END# *4DAEEDE10285_922109FC93A4_var*
begin
//#UC START# *4DAEEDE10285_922109FC93A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_922109FC93A4_impl*
end;//Tkw_Filters_Control_FiltersList_Push.DoDoIt

class function Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FiltersList:push';
end;//Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister

function TkwEnFiltersFiltersList.FiltersList(const aCtx: TtfwContext;
 aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenFilters.FiltersList }
begin
 Result := aenFilters.FiltersList;
end;//TkwEnFiltersFiltersList.FiltersList

procedure TkwEnFiltersFiltersList.DoDoIt(const aCtx: TtfwContext);
var l_aenFilters: TenFilters;
begin
 try
  l_aenFilters := TenFilters(aCtx.rEngine.PopObjAs(TenFilters));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenFilters: TenFilters : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FiltersList(aCtx, l_aenFilters));
end;//TkwEnFiltersFiltersList.DoDoIt

class function TkwEnFiltersFiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFilters.FiltersList';
end;//TkwEnFiltersFiltersList.GetWordNameForRegister

procedure TkwEnFiltersFiltersList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FiltersList', aCtx);
end;//TkwEnFiltersFiltersList.SetValuePrim

function TkwEnFiltersFiltersList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFiltersFiltersList.GetResultTypeInfo

function TkwEnFiltersFiltersList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFiltersFiltersList.GetAllParamsCount

function TkwEnFiltersFiltersList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenFilters)]);
end;//TkwEnFiltersFiltersList.ParamsTypes

initialization
 Tkw_Form_Filters.RegisterInEngine;
 {* ����������� Tkw_Form_Filters }
 Tkw_Filters_Control_FiltersList.RegisterInEngine;
 {* ����������� Tkw_Filters_Control_FiltersList }
 Tkw_Filters_Control_FiltersList_Push.RegisterInEngine;
 {* ����������� Tkw_Filters_Control_FiltersList_Push }
 TkwEnFiltersFiltersList.RegisterInEngine;
 {* ����������� enFilters_FiltersList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFilters));
 {* ����������� ���� Filters }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
