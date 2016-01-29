unit ParentKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/ParentKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::ParentAndChildPrim::ParentKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Parent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  vtPanel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  Parent_Form,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_Parent = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Parent
----
*������ �������������*:
[code]
'aControl' �����::Parent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Parent

// start class Tkw_Form_Parent

class function Tkw_Form_Parent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Parent';
end;//Tkw_Form_Parent.GetWordNameForRegister

function Tkw_Form_Parent.GetString: AnsiString;
 {-}
begin
 Result := 'ParentForm';
end;//Tkw_Form_Parent.GetString

type
  Tkw_Parent_Control_ParentZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Parent_Control_ParentZone

// start class Tkw_Parent_Control_ParentZone

class function Tkw_Parent_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetWordNameForRegister

function Tkw_Parent_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetString

class procedure Tkw_Parent_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Parent_Control_ParentZone.RegisterInEngine

type
  Tkw_Parent_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Parent_Control_ParentZone_Push

// start class Tkw_Parent_Control_ParentZone_Push

procedure Tkw_Parent_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Parent_Control_ParentZone_Push.DoDoIt

class function Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ParentZone:push';
end;//Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister

type
  TkwParentFormParentZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TParentForm.ParentZone
[panel]������� ParentZone ����� TParentForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aParentForm .TParentForm.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     aParentForm: TParentForm): TvtPanel;
     {* ���������� ����� ������� .TParentForm.ParentZone }
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
  end;//TkwParentFormParentZone

// start class TkwParentFormParentZone

function TkwParentFormParentZone.ParentZone(const aCtx: TtfwContext;
  aParentForm: TParentForm): TvtPanel;
 {-}
begin
 Result := aParentForm.ParentZone;
end;//TkwParentFormParentZone.ParentZone

procedure TkwParentFormParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParentForm : TParentForm;
begin
 try
  l_aParentForm := TParentForm(aCtx.rEngine.PopObjAs(TParentForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParentForm: TParentForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_aParentForm)));
end;//TkwParentFormParentZone.DoDoIt

class function TkwParentFormParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TParentForm.ParentZone';
end;//TkwParentFormParentZone.GetWordNameForRegister

procedure TkwParentFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwParentFormParentZone.SetValuePrim

function TkwParentFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwParentFormParentZone.GetResultTypeInfo

function TkwParentFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwParentFormParentZone.GetAllParamsCount

function TkwParentFormParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TParentForm)]);
end;//TkwParentFormParentZone.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_Parent
 Tkw_Form_Parent.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Parent_Control_ParentZone
 Tkw_Parent_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Parent_Control_ParentZone_Push
 Tkw_Parent_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ParentForm_ParentZone
 TkwParentFormParentZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Parent
 TtfwTypeRegistrator.RegisterType(TypeInfo(TParentForm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts

end.