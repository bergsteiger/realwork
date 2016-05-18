unit ParentKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Parent }

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\ParentKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ParentKeywordsPack" MUID: (4F6B66CB0200_Pack)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Parent_Form
 , tfwPropertyLike
 , vtPanel
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
 TkwParentFormParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TParentForm.ParentZone }
  private
   function ParentZone(const aCtx: TtfwContext;
    aParentForm: TParentForm): TvtPanel;
    {* ���������� ����� ������� .TParentForm.ParentZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwParentFormParentZone

 Tkw_Form_Parent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Parent
----
*������ �������������*:
[code]�����::Parent TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Parent

 Tkw_Parent_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]�������::ParentZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Parent_Control_ParentZone

 Tkw_Parent_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]�������::ParentZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Parent_Control_ParentZone_Push

function TkwParentFormParentZone.ParentZone(const aCtx: TtfwContext;
 aParentForm: TParentForm): TvtPanel;
 {* ���������� ����� ������� .TParentForm.ParentZone }
begin
 Result := aParentForm.ParentZone;
end;//TkwParentFormParentZone.ParentZone

class function TkwParentFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TParentForm.ParentZone';
end;//TkwParentFormParentZone.GetWordNameForRegister

function TkwParentFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwParentFormParentZone.GetResultTypeInfo

function TkwParentFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParentFormParentZone.GetAllParamsCount

function TkwParentFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TParentForm)]);
end;//TkwParentFormParentZone.ParamsTypes

procedure TkwParentFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwParentFormParentZone.SetValuePrim

procedure TkwParentFormParentZone.DoDoIt(const aCtx: TtfwContext);
var l_aParentForm: TParentForm;
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
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_aParentForm));
end;//TkwParentFormParentZone.DoDoIt

function Tkw_Form_Parent.GetString: AnsiString;
begin
 Result := 'ParentForm';
end;//Tkw_Form_Parent.GetString

class procedure Tkw_Form_Parent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TParentForm);
end;//Tkw_Form_Parent.RegisterInEngine

class function Tkw_Form_Parent.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Parent';
end;//Tkw_Form_Parent.GetWordNameForRegister

function Tkw_Parent_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetString

class procedure Tkw_Parent_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Parent_Control_ParentZone.RegisterInEngine

class function Tkw_Parent_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetWordNameForRegister

procedure Tkw_Parent_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Parent_Control_ParentZone_Push.DoDoIt

class function Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister

initialization
 TkwParentFormParentZone.RegisterInEngine;
 {* ����������� ParentForm_ParentZone }
 Tkw_Form_Parent.RegisterInEngine;
 {* ����������� Tkw_Form_Parent }
 Tkw_Parent_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_Parent_Control_ParentZone }
 Tkw_Parent_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_Parent_Control_ParentZone_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TParentForm));
 {* ����������� ���� TParentForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
