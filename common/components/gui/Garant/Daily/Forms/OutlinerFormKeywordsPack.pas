unit OutlinerFormKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// ������: "w:/common/components/gui/Garant/Daily/Forms/OutlinerFormKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Outliner::OutlinerFormKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� OutlinerForm
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  Outliner_Form,
  vtOutlinerControl,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 Tkw_Form_OutlinerForm = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� OutlinerForm
----
*������ �������������*:
[code]
'aControl' �����::OutlinerForm TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_OutlinerForm

// start class Tkw_Form_OutlinerForm

class function Tkw_Form_OutlinerForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::OutlinerForm';
end;//Tkw_Form_OutlinerForm.GetWordNameForRegister

function Tkw_Form_OutlinerForm.GetString: AnsiString;
 {-}
begin
 Result := 'OutlinerFormForm';
end;//Tkw_Form_OutlinerForm.GetString

type
 Tkw_OutlinerForm_Control_TreeControl = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_OutlinerForm_Control_TreeControl

// start class Tkw_OutlinerForm_Control_TreeControl

class function Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister

function Tkw_OutlinerForm_Control_TreeControl.GetString: AnsiString;
 {-}
begin
 Result := 'TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetString

class procedure Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtOutlinerControl);
end;//Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine

type
 Tkw_OutlinerForm_Control_TreeControl_Push = {final scriptword} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OutlinerForm_Control_TreeControl_Push

// start class Tkw_OutlinerForm_Control_TreeControl_Push

procedure Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TreeControl');
 inherited;
end;//Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt

class function Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TreeControl:push';
end;//Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister

type
 TkwOutlinerFormFormTreeControl = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� .TOutlinerFormForm.TreeControl
[panel]������� TreeControl ����� TOutlinerFormForm[panel]
*��� ����������:* TvtOutlinerControl
*������:*
[code]
OBJECT VAR l_TvtOutlinerControl
 aOutlinerFormForm .TOutlinerFormForm.TreeControl >>> l_TvtOutlinerControl
[code]  }
 private
 // private methods
   function TreeControl(const aCtx: TtfwContext;
    aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
     {* ���������� ����� ������� .TOutlinerFormForm.TreeControl }
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
 end;//TkwOutlinerFormFormTreeControl

// start class TkwOutlinerFormFormTreeControl

function TkwOutlinerFormFormTreeControl.TreeControl(const aCtx: TtfwContext;
  aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
 {-}
begin
 Result := aOutlinerFormForm.TreeControl;
end;//TkwOutlinerFormFormTreeControl.TreeControl

procedure TkwOutlinerFormFormTreeControl.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aOutlinerFormForm : TOutlinerFormForm;
begin
 try
  l_aOutlinerFormForm := TOutlinerFormForm(aCtx.rEngine.PopObjAs(TOutlinerFormForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aOutlinerFormForm: TOutlinerFormForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TreeControl(aCtx, l_aOutlinerFormForm)));
end;//TkwOutlinerFormFormTreeControl.DoDoIt

class function TkwOutlinerFormFormTreeControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TOutlinerFormForm.TreeControl';
end;//TkwOutlinerFormFormTreeControl.GetWordNameForRegister

procedure TkwOutlinerFormFormTreeControl.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TreeControl', aCtx);
end;//TkwOutlinerFormFormTreeControl.SetValuePrim

function TkwOutlinerFormFormTreeControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtOutlinerControl);
end;//TkwOutlinerFormFormTreeControl.GetResultTypeInfo

function TkwOutlinerFormFormTreeControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwOutlinerFormFormTreeControl.GetAllParamsCount

function TkwOutlinerFormFormTreeControl.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TOutlinerFormForm)]);
end;//TkwOutlinerFormFormTreeControl.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_Form_OutlinerForm
 Tkw_Form_OutlinerForm.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_OutlinerForm_Control_TreeControl
 Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_OutlinerForm_Control_TreeControl_Push
 Tkw_OutlinerForm_Control_TreeControl_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� OutlinerFormForm_TreeControl
 TkwOutlinerFormFormTreeControl.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� OutlinerForm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TOutlinerFormForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TvtOutlinerControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtOutlinerControl));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.