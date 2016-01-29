unit PostingsListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Monitorings/PostingsListKeywordsPack.pas"
// �����: 10.09.2009 19:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::PostingOrder::View::Monitorings::CommonPost::PostingsListKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� PostingsList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  eeTreeView,
  PostingsList_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_PostingsList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� PostingsList
----
*������ �������������*:
[code]
'aControl' �����::PostingsList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_PostingsList

// start class Tkw_Form_PostingsList

class function Tkw_Form_PostingsList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::PostingsList';
end;//Tkw_Form_PostingsList.GetWordNameForRegister

function Tkw_Form_PostingsList.GetString: AnsiString;
 {-}
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList.GetString

type
  Tkw_PostingsList_Control_tvPostings = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvPostings
----
*������ �������������*:
[code]
�������::tvPostings TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PostingsList_Control_tvPostings

// start class Tkw_PostingsList_Control_tvPostings

class function Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister

function Tkw_PostingsList_Control_tvPostings.GetString: AnsiString;
 {-}
begin
 Result := 'tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetString

class procedure Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_PostingsList_Control_tvPostings.RegisterInEngine

type
  Tkw_PostingsList_Control_tvPostings_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvPostings
----
*������ �������������*:
[code]
�������::tvPostings:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PostingsList_Control_tvPostings_Push

// start class Tkw_PostingsList_Control_tvPostings_Push

procedure Tkw_PostingsList_Control_tvPostings_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvPostings');
 inherited;
end;//Tkw_PostingsList_Control_tvPostings_Push.DoDoIt

class function Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvPostings:push';
end;//Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister

type
  TkwEnPostingsListTvPostings = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TenPostingsList.tvPostings
[panel]������� tvPostings ����� TenPostingsList[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aenPostingsList .TenPostingsList.tvPostings >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TvPostings(const aCtx: TtfwContext;
     aenPostingsList: TenPostingsList): TeeTreeView;
     {* ���������� ����� ������� .TenPostingsList.tvPostings }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnPostingsListTvPostings

// start class TkwEnPostingsListTvPostings

function TkwEnPostingsListTvPostings.TvPostings(const aCtx: TtfwContext;
  aenPostingsList: TenPostingsList): TeeTreeView;
 {-}
begin
 Result := aenPostingsList.tvPostings;
end;//TkwEnPostingsListTvPostings.TvPostings

procedure TkwEnPostingsListTvPostings.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenPostingsList : TenPostingsList;
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
 aCtx.rEngine.PushObj((TvPostings(aCtx, l_aenPostingsList)));
end;//TkwEnPostingsListTvPostings.DoDoIt

class function TkwEnPostingsListTvPostings.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenPostingsList.tvPostings';
end;//TkwEnPostingsListTvPostings.GetWordNameForRegister

procedure TkwEnPostingsListTvPostings.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvPostings', aCtx);
end;//TkwEnPostingsListTvPostings.SetValuePrim

function TkwEnPostingsListTvPostings.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEnPostingsListTvPostings.GetResultTypeInfo

function TkwEnPostingsListTvPostings.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPostingsListTvPostings.GetAllParamsCount

function TkwEnPostingsListTvPostings.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenPostingsList)]);
end;//TkwEnPostingsListTvPostings.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_PostingsList
 Tkw_Form_PostingsList.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PostingsList_Control_tvPostings
 Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_PostingsList_Control_tvPostings_Push
 Tkw_PostingsList_Control_tvPostings_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� enPostingsList_tvPostings
 TkwEnPostingsListTvPostings.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� PostingsList
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenPostingsList));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not Admin AND not NoScripts

end.