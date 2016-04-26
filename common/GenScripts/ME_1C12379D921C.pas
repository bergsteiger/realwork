unit PostingsListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PostingsList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\PostingsListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PostingsListKeywordsPack" MUID: (1C12379D921C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , eeTreeView
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , PostingsList_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 Tkw_Form_PostingsList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PostingsList
----
*������ �������������*:
[code]
'aControl' �����::PostingsList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PostingsList

 Tkw_PostingsList_Control_tvPostings = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvPostings
----
*������ �������������*:
[code]
�������::tvPostings TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings

 Tkw_PostingsList_Control_tvPostings_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvPostings
----
*������ �������������*:
[code]
�������::tvPostings:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings_Push

 TkwEnPostingsListTvPostings = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenPostingsList.tvPostings
[panel]������� tvPostings ����� TenPostingsList[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aenPostingsList .TenPostingsList.tvPostings >>> l_TeeTreeView
[code]  }
  private
   function tvPostings(const aCtx: TtfwContext;
    aenPostingsList: TenPostingsList): TeeTreeView;
    {* ���������� ����� ������� .TenPostingsList.tvPostings }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPostingsListTvPostings

function Tkw_Form_PostingsList.GetString: AnsiString;
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList.GetString

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

function TkwEnPostingsListTvPostings.tvPostings(const aCtx: TtfwContext;
 aenPostingsList: TenPostingsList): TeeTreeView;
 {* ���������� ����� ������� .TenPostingsList.tvPostings }
begin
 Result := aenPostingsList.tvPostings;
end;//TkwEnPostingsListTvPostings.tvPostings

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

procedure TkwEnPostingsListTvPostings.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvPostings', aCtx);
end;//TkwEnPostingsListTvPostings.SetValuePrim

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

class function TkwEnPostingsListTvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenPostingsList.tvPostings';
end;//TkwEnPostingsListTvPostings.GetWordNameForRegister

initialization
 Tkw_Form_PostingsList.RegisterInEngine;
 {* ����������� Tkw_Form_PostingsList }
 Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
 {* ����������� Tkw_PostingsList_Control_tvPostings }
 Tkw_PostingsList_Control_tvPostings_Push.RegisterInEngine;
 {* ����������� Tkw_PostingsList_Control_tvPostings_Push }
 TkwEnPostingsListTvPostings.RegisterInEngine;
 {* ����������� enPostingsList_tvPostings }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenPostingsList));
 {* ����������� ���� PostingsList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
