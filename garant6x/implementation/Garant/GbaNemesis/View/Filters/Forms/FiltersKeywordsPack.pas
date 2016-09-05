unit FiltersKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Filters }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\FiltersKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "FiltersKeywordsPack" MUID: (4ABCD2BC0302_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Filters_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABCD2BC0302_Packimpl_uses*
 //#UC END# *4ABCD2BC0302_Packimpl_uses*
;

type
 TkwEnFiltersFiltersList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenFilters.FiltersList }
  private
   function FiltersList(const aCtx: TtfwContext;
    aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenFilters.FiltersList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnFiltersFiltersList

 Tkw_Form_Filters = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Filters
----
*������ �������������*:
[code]�����::Filters TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Filters

 Tkw_Filters_Control_FiltersList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FiltersList
----
*������ �������������*:
[code]�������::FiltersList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Filters_Control_FiltersList

 Tkw_Filters_Control_FiltersList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FiltersList
----
*������ �������������*:
[code]�������::FiltersList:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Filters_Control_FiltersList_Push

function TkwEnFiltersFiltersList.FiltersList(const aCtx: TtfwContext;
 aenFilters: TenFilters): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenFilters.FiltersList }
begin
 Result := aenFilters.FiltersList;
end;//TkwEnFiltersFiltersList.FiltersList

class function TkwEnFiltersFiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFilters.FiltersList';
end;//TkwEnFiltersFiltersList.GetWordNameForRegister

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

procedure TkwEnFiltersFiltersList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FiltersList', aCtx);
end;//TkwEnFiltersFiltersList.SetValuePrim

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

function Tkw_Form_Filters.GetString: AnsiString;
begin
 Result := 'enFilters';
end;//Tkw_Form_Filters.GetString

class procedure Tkw_Form_Filters.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenFilters);
end;//Tkw_Form_Filters.RegisterInEngine

class function Tkw_Form_Filters.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Filters';
end;//Tkw_Form_Filters.GetWordNameForRegister

function Tkw_Filters_Control_FiltersList.GetString: AnsiString;
begin
 Result := 'FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetString

class procedure Tkw_Filters_Control_FiltersList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Filters_Control_FiltersList.RegisterInEngine

class function Tkw_Filters_Control_FiltersList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FiltersList';
end;//Tkw_Filters_Control_FiltersList.GetWordNameForRegister

procedure Tkw_Filters_Control_FiltersList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FiltersList');
 inherited;
end;//Tkw_Filters_Control_FiltersList_Push.DoDoIt

class function Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FiltersList:push';
end;//Tkw_Filters_Control_FiltersList_Push.GetWordNameForRegister

initialization
 TkwEnFiltersFiltersList.RegisterInEngine;
 {* ����������� enFilters_FiltersList }
 Tkw_Form_Filters.RegisterInEngine;
 {* ����������� Tkw_Form_Filters }
 Tkw_Filters_Control_FiltersList.RegisterInEngine;
 {* ����������� Tkw_Filters_Control_FiltersList }
 Tkw_Filters_Control_FiltersList_Push.RegisterInEngine;
 {* ����������� Tkw_Filters_Control_FiltersList_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFilters));
 {* ����������� ���� TenFilters }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
