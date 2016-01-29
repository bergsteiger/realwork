unit TextLoadKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// ������: "w:/common/components/gui/Garant/Daily/Forms/TextLoadKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::TextLoadKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� TextLoad
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
  evTextSource,
  evEditor,
  TextLoad_Form,
  evLoadDocumentManager,
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
 Tkw_Form_TextLoad = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TextLoad
----
*������ �������������*:
[code]
'aControl' �����::TextLoad TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TextLoad

// start class Tkw_Form_TextLoad

class function Tkw_Form_TextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::TextLoad';
end;//Tkw_Form_TextLoad.GetWordNameForRegister

function Tkw_Form_TextLoad.GetString: AnsiString;
 {-}
begin
 Result := 'TextLoadForm';
end;//Tkw_Form_TextLoad.GetString

type
 Tkw_TextLoad_Control_Text = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Control_Text

// start class Tkw_TextLoad_Control_Text

class function Tkw_TextLoad_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text';
end;//Tkw_TextLoad_Control_Text.GetWordNameForRegister

function Tkw_TextLoad_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_TextLoad_Control_Text.GetString

class procedure Tkw_TextLoad_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevEditor);
end;//Tkw_TextLoad_Control_Text.RegisterInEngine

type
 Tkw_TextLoad_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TextLoad_Control_Text_Push

// start class Tkw_TextLoad_Control_Text_Push

procedure Tkw_TextLoad_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_TextLoad_Control_Text_Push.DoDoIt

class function Tkw_TextLoad_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text:push';
end;//Tkw_TextLoad_Control_Text_Push.GetWordNameForRegister

type
 Tkw_TextLoad_Component_TextSource = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Component_TextSource

// start class Tkw_TextLoad_Component_TextSource

class function Tkw_TextLoad_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::TextSource';
end;//Tkw_TextLoad_Component_TextSource.GetWordNameForRegister

function Tkw_TextLoad_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_TextLoad_Component_TextSource.GetString

class procedure Tkw_TextLoad_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevTextSource);
end;//Tkw_TextLoad_Component_TextSource.RegisterInEngine

type
 Tkw_TextLoad_Component_LoadManager = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]
���������::LoadManager TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TextLoad_Component_LoadManager

// start class Tkw_TextLoad_Component_LoadManager

class function Tkw_TextLoad_Component_LoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::LoadManager';
end;//Tkw_TextLoad_Component_LoadManager.GetWordNameForRegister

function Tkw_TextLoad_Component_LoadManager.GetString: AnsiString;
 {-}
begin
 Result := 'LoadManager';
end;//Tkw_TextLoad_Component_LoadManager.GetString

class procedure Tkw_TextLoad_Component_LoadManager.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_TextLoad_Component_LoadManager.RegisterInEngine

type
 TkwTextLoadFormText = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.Text
[panel]������� Text ����� TTextLoadForm[panel]
*��� ����������:* TevEditor
*������:*
[code]
OBJECT VAR l_TevEditor
 aTextLoadForm .TTextLoadForm.Text >>> l_TevEditor
[code]  }
 private
 // private methods
   function Text(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevEditor;
     {* ���������� ����� ������� .TTextLoadForm.Text }
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
 end;//TkwTextLoadFormText

// start class TkwTextLoadFormText

function TkwTextLoadFormText.Text(const aCtx: TtfwContext;
  aTextLoadForm: TTextLoadForm): TevEditor;
 {-}
begin
 Result := aTextLoadForm.Text;
end;//TkwTextLoadFormText.Text

procedure TkwTextLoadFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextLoadForm : TTextLoadForm;
begin
 try
  l_aTextLoadForm := TTextLoadForm(aCtx.rEngine.PopObjAs(TTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextLoadForm: TTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aTextLoadForm)));
end;//TkwTextLoadFormText.DoDoIt

class function TkwTextLoadFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextLoadForm.Text';
end;//TkwTextLoadFormText.GetWordNameForRegister

procedure TkwTextLoadFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwTextLoadFormText.SetValuePrim

function TkwTextLoadFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevEditor);
end;//TkwTextLoadFormText.GetResultTypeInfo

function TkwTextLoadFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextLoadFormText.GetAllParamsCount

function TkwTextLoadFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextLoadForm)]);
end;//TkwTextLoadFormText.ParamsTypes

type
 TkwTextLoadFormTextSource = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.TextSource
[panel]������� TextSource ����� TTextLoadForm[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aTextLoadForm .TTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
 private
 // private methods
   function TextSource(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevTextSource;
     {* ���������� ����� ������� .TTextLoadForm.TextSource }
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
 end;//TkwTextLoadFormTextSource

// start class TkwTextLoadFormTextSource

function TkwTextLoadFormTextSource.TextSource(const aCtx: TtfwContext;
  aTextLoadForm: TTextLoadForm): TevTextSource;
 {-}
begin
 Result := aTextLoadForm.TextSource;
end;//TkwTextLoadFormTextSource.TextSource

procedure TkwTextLoadFormTextSource.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextLoadForm : TTextLoadForm;
begin
 try
  l_aTextLoadForm := TTextLoadForm(aCtx.rEngine.PopObjAs(TTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextLoadForm: TTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TextSource(aCtx, l_aTextLoadForm)));
end;//TkwTextLoadFormTextSource.DoDoIt

class function TkwTextLoadFormTextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextLoadForm.TextSource';
end;//TkwTextLoadFormTextSource.GetWordNameForRegister

procedure TkwTextLoadFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwTextLoadFormTextSource.SetValuePrim

function TkwTextLoadFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevTextSource);
end;//TkwTextLoadFormTextSource.GetResultTypeInfo

function TkwTextLoadFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextLoadFormTextSource.GetAllParamsCount

function TkwTextLoadFormTextSource.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextLoadForm)]);
end;//TkwTextLoadFormTextSource.ParamsTypes

type
 TkwTextLoadFormLoadManager = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� .TTextLoadForm.LoadManager
[panel]������� LoadManager ����� TTextLoadForm[panel]
*��� ����������:* TevLoadDocumentManager
*������:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aTextLoadForm .TTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
 private
 // private methods
   function LoadManager(const aCtx: TtfwContext;
    aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
     {* ���������� ����� ������� .TTextLoadForm.LoadManager }
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
 end;//TkwTextLoadFormLoadManager

// start class TkwTextLoadFormLoadManager

function TkwTextLoadFormLoadManager.LoadManager(const aCtx: TtfwContext;
  aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
 {-}
begin
 Result := aTextLoadForm.LoadManager;
end;//TkwTextLoadFormLoadManager.LoadManager

procedure TkwTextLoadFormLoadManager.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextLoadForm : TTextLoadForm;
begin
 try
  l_aTextLoadForm := TTextLoadForm(aCtx.rEngine.PopObjAs(TTextLoadForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTextLoadForm: TTextLoadForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LoadManager(aCtx, l_aTextLoadForm)));
end;//TkwTextLoadFormLoadManager.DoDoIt

class function TkwTextLoadFormLoadManager.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TTextLoadForm.LoadManager';
end;//TkwTextLoadFormLoadManager.GetWordNameForRegister

procedure TkwTextLoadFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� LoadManager', aCtx);
end;//TkwTextLoadFormLoadManager.SetValuePrim

function TkwTextLoadFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwTextLoadFormLoadManager.GetResultTypeInfo

function TkwTextLoadFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwTextLoadFormLoadManager.GetAllParamsCount

function TkwTextLoadFormLoadManager.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTextLoadForm)]);
end;//TkwTextLoadFormLoadManager.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_Form_TextLoad
 Tkw_Form_TextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_TextLoad_Control_Text
 Tkw_TextLoad_Control_Text.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_TextLoad_Control_Text_Push
 Tkw_TextLoad_Control_Text_Push.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_TextLoad_Component_TextSource
 Tkw_TextLoad_Component_TextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_TextLoad_Component_LoadManager
 Tkw_TextLoad_Component_LoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� TextLoadForm_Text
 TkwTextLoadFormText.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� TextLoadForm_TextSource
 TkwTextLoadFormTextSource.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� TextLoadForm_LoadManager
 TkwTextLoadFormLoadManager.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TextLoad
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextLoadForm));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TevEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevEditor));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TevTextSource
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� ���� TevLoadDocumentManager
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.