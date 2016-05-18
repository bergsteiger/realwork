unit CreateFilterKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CreateFilter }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\CreateFilterKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "CreateFilterKeywordsPack" MUID: (4CB6DBE6009F_Pack)

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
 , CreateFilter_Form
 , tfwPropertyLike
 , vtLabel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwCreateFilterFormNameLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCreateFilterForm.NameLabel }
  private
   function NameLabel(const aCtx: TtfwContext;
    aCreateFilterForm: TCreateFilterForm): TvtLabel;
    {* ���������� ����� ������� .TCreateFilterForm.NameLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCreateFilterFormNameLabel

 TkwCreateFilterFormFilterName = {final} class(TtfwPropertyLike)
  {* ����� ������� .TCreateFilterForm.FilterName }
  private
   function FilterName(const aCtx: TtfwContext;
    aCreateFilterForm: TCreateFilterForm): TnscEdit;
    {* ���������� ����� ������� .TCreateFilterForm.FilterName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCreateFilterFormFilterName

 Tkw_Form_CreateFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CreateFilter
----
*������ �������������*:
[code]�����::CreateFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CreateFilter

 Tkw_CreateFilter_Control_NameLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NameLabel
----
*������ �������������*:
[code]�������::NameLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_NameLabel

 Tkw_CreateFilter_Control_NameLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NameLabel
----
*������ �������������*:
[code]�������::NameLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_NameLabel_Push

 Tkw_CreateFilter_Control_FilterName = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FilterName
----
*������ �������������*:
[code]�������::FilterName TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_FilterName

 Tkw_CreateFilter_Control_FilterName_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FilterName
----
*������ �������������*:
[code]�������::FilterName:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_FilterName_Push

function TkwCreateFilterFormNameLabel.NameLabel(const aCtx: TtfwContext;
 aCreateFilterForm: TCreateFilterForm): TvtLabel;
 {* ���������� ����� ������� .TCreateFilterForm.NameLabel }
begin
 Result := aCreateFilterForm.NameLabel;
end;//TkwCreateFilterFormNameLabel.NameLabel

class function TkwCreateFilterFormNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCreateFilterForm.NameLabel';
end;//TkwCreateFilterFormNameLabel.GetWordNameForRegister

function TkwCreateFilterFormNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCreateFilterFormNameLabel.GetResultTypeInfo

function TkwCreateFilterFormNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCreateFilterFormNameLabel.GetAllParamsCount

function TkwCreateFilterFormNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCreateFilterForm)]);
end;//TkwCreateFilterFormNameLabel.ParamsTypes

procedure TkwCreateFilterFormNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NameLabel', aCtx);
end;//TkwCreateFilterFormNameLabel.SetValuePrim

procedure TkwCreateFilterFormNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aCreateFilterForm: TCreateFilterForm;
begin
 try
  l_aCreateFilterForm := TCreateFilterForm(aCtx.rEngine.PopObjAs(TCreateFilterForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCreateFilterForm: TCreateFilterForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NameLabel(aCtx, l_aCreateFilterForm));
end;//TkwCreateFilterFormNameLabel.DoDoIt

function TkwCreateFilterFormFilterName.FilterName(const aCtx: TtfwContext;
 aCreateFilterForm: TCreateFilterForm): TnscEdit;
 {* ���������� ����� ������� .TCreateFilterForm.FilterName }
begin
 Result := aCreateFilterForm.FilterName;
end;//TkwCreateFilterFormFilterName.FilterName

class function TkwCreateFilterFormFilterName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCreateFilterForm.FilterName';
end;//TkwCreateFilterFormFilterName.GetWordNameForRegister

function TkwCreateFilterFormFilterName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwCreateFilterFormFilterName.GetResultTypeInfo

function TkwCreateFilterFormFilterName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCreateFilterFormFilterName.GetAllParamsCount

function TkwCreateFilterFormFilterName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCreateFilterForm)]);
end;//TkwCreateFilterFormFilterName.ParamsTypes

procedure TkwCreateFilterFormFilterName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FilterName', aCtx);
end;//TkwCreateFilterFormFilterName.SetValuePrim

procedure TkwCreateFilterFormFilterName.DoDoIt(const aCtx: TtfwContext);
var l_aCreateFilterForm: TCreateFilterForm;
begin
 try
  l_aCreateFilterForm := TCreateFilterForm(aCtx.rEngine.PopObjAs(TCreateFilterForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCreateFilterForm: TCreateFilterForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FilterName(aCtx, l_aCreateFilterForm));
end;//TkwCreateFilterFormFilterName.DoDoIt

function Tkw_Form_CreateFilter.GetString: AnsiString;
begin
 Result := 'CreateFilterForm';
end;//Tkw_Form_CreateFilter.GetString

class procedure Tkw_Form_CreateFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TCreateFilterForm);
end;//Tkw_Form_CreateFilter.RegisterInEngine

class function Tkw_Form_CreateFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::CreateFilter';
end;//Tkw_Form_CreateFilter.GetWordNameForRegister

function Tkw_CreateFilter_Control_NameLabel.GetString: AnsiString;
begin
 Result := 'NameLabel';
end;//Tkw_CreateFilter_Control_NameLabel.GetString

class procedure Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CreateFilter_Control_NameLabel.RegisterInEngine

class function Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NameLabel';
end;//Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister

procedure Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NameLabel');
 inherited;
end;//Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt

class function Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NameLabel:push';
end;//Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister

function Tkw_CreateFilter_Control_FilterName.GetString: AnsiString;
begin
 Result := 'FilterName';
end;//Tkw_CreateFilter_Control_FilterName.GetString

class procedure Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_CreateFilter_Control_FilterName.RegisterInEngine

class function Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FilterName';
end;//Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister

procedure Tkw_CreateFilter_Control_FilterName_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FilterName');
 inherited;
end;//Tkw_CreateFilter_Control_FilterName_Push.DoDoIt

class function Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FilterName:push';
end;//Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister

initialization
 TkwCreateFilterFormNameLabel.RegisterInEngine;
 {* ����������� CreateFilterForm_NameLabel }
 TkwCreateFilterFormFilterName.RegisterInEngine;
 {* ����������� CreateFilterForm_FilterName }
 Tkw_Form_CreateFilter.RegisterInEngine;
 {* ����������� Tkw_Form_CreateFilter }
 Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
 {* ����������� Tkw_CreateFilter_Control_NameLabel }
 Tkw_CreateFilter_Control_NameLabel_Push.RegisterInEngine;
 {* ����������� Tkw_CreateFilter_Control_NameLabel_Push }
 Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
 {* ����������� Tkw_CreateFilter_Control_FilterName }
 Tkw_CreateFilter_Control_FilterName_Push.RegisterInEngine;
 {* ����������� Tkw_CreateFilter_Control_FilterName_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCreateFilterForm));
 {* ����������� ���� TCreateFilterForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
