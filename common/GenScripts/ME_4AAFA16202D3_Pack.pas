unit PostingsListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PostingsList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\Forms\PostingsListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PostingsListKeywordsPack" MUID: (4AAFA16202D3_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , PostingsList_Form
 , tfwPropertyLike
 , eeTreeView
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnPostingsListTvPostings = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenPostingsList.tvPostings }
  private
   function tvPostings(const aCtx: TtfwContext;
    aenPostingsList: TenPostingsList): TeeTreeView;
    {* ���������� ����� ������� .TenPostingsList.tvPostings }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnPostingsListTvPostings

 Tkw_Form_PostingsList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PostingsList
----
*������ �������������*:
[code]�����::PostingsList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PostingsList

 Tkw_PostingsList_Control_tvPostings = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvPostings
----
*������ �������������*:
[code]�������::tvPostings TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings

 Tkw_PostingsList_Control_tvPostings_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvPostings
----
*������ �������������*:
[code]�������::tvPostings:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings_Push

function TkwEnPostingsListTvPostings.tvPostings(const aCtx: TtfwContext;
 aenPostingsList: TenPostingsList): TeeTreeView;
 {* ���������� ����� ������� .TenPostingsList.tvPostings }
begin
 Result := aenPostingsList.tvPostings;
end;//TkwEnPostingsListTvPostings.tvPostings

class function TkwEnPostingsListTvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenPostingsList.tvPostings';
end;//TkwEnPostingsListTvPostings.GetWordNameForRegister

function TkwEnPostingsListTvPostings.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEnPostingsListTvPostings.GetResultTypeInfo

function TkwEnPostingsListTvPostings.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPostingsListTvPostings.GetAllParamsCount

function TkwEnPostingsListTvPostings.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenPostingsList)]);
end;//TkwEnPostingsListTvPostings.ParamsTypes

procedure TkwEnPostingsListTvPostings.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvPostings', aCtx);
end;//TkwEnPostingsListTvPostings.SetValuePrim

procedure TkwEnPostingsListTvPostings.DoDoIt(const aCtx: TtfwContext);
var l_aenPostingsList: TenPostingsList;
begin
 try
  l_aenPostingsList := TenPostingsList(aCtx.rEngine.PopObjAs(TenPostingsList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenPostingsList: TenPostingsList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvPostings(aCtx, l_aenPostingsList));
end;//TkwEnPostingsListTvPostings.DoDoIt

function Tkw_Form_PostingsList.GetString: AnsiString;
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList.GetString

class procedure Tkw_Form_PostingsList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenPostingsList);
end;//Tkw_Form_PostingsList.RegisterInEngine

class function Tkw_Form_PostingsList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PostingsList';
end;//Tkw_Form_PostingsList.GetWordNameForRegister

function Tkw_PostingsList_Control_tvPostings.GetString: AnsiString;
begin
 Result := 'tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetString

class procedure Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_PostingsList_Control_tvPostings.RegisterInEngine

class function Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister

procedure Tkw_PostingsList_Control_tvPostings_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvPostings');
 inherited;
end;//Tkw_PostingsList_Control_tvPostings_Push.DoDoIt

class function Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvPostings:push';
end;//Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister

initialization
 TkwEnPostingsListTvPostings.RegisterInEngine;
 {* ����������� enPostingsList_tvPostings }
 Tkw_Form_PostingsList.RegisterInEngine;
 {* ����������� Tkw_Form_PostingsList }
 Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
 {* ����������� Tkw_PostingsList_Control_tvPostings }
 Tkw_PostingsList_Control_tvPostings_Push.RegisterInEngine;
 {* ����������� Tkw_PostingsList_Control_tvPostings_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenPostingsList));
 {* ����������� ���� TenPostingsList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
