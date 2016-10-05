unit F1LikeFormWithBSKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� F1LikeFormWithBS }

// ������: "w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBSKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "F1LikeFormWithBSKeywordsPack" MUID: (4D6CB4B7035F_Pack)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , F1LikeFormWithBS_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
 , evLoadDocumentManager
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4D6CB4B7035F_Packimpl_uses*
 //#UC END# *4D6CB4B7035F_Packimpl_uses*
;

type
 TkwF1LikeFormWithBSFormBaseSearchControl = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.BaseSearchControl }
  private
   function BaseSearchControl(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
    {* ���������� ����� ������� .TF1LikeFormWithBSForm.BaseSearchControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwF1LikeFormWithBSFormBaseSearchControl

 TkwF1LikeFormWithBSFormText = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.Text }
  private
   function Text(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
    {* ���������� ����� ������� .TF1LikeFormWithBSForm.Text }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwF1LikeFormWithBSFormText

 TkwF1LikeFormWithBSFormTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.TextSource }
  private
   function TextSource(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
    {* ���������� ����� ������� .TF1LikeFormWithBSForm.TextSource }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwF1LikeFormWithBSFormTextSource

 TkwF1LikeFormWithBSFormLoadManager = {final} class(TtfwPropertyLike)
  {* ����� ������� .TF1LikeFormWithBSForm.LoadManager }
  private
   function LoadManager(const aCtx: TtfwContext;
    aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
    {* ���������� ����� ������� .TF1LikeFormWithBSForm.LoadManager }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwF1LikeFormWithBSFormLoadManager

 Tkw_Form_F1LikeFormWithBS = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� F1LikeFormWithBS
----
*������ �������������*:
[code]�����::F1LikeFormWithBS TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_F1LikeFormWithBS

 Tkw_F1LikeFormWithBS_Control_BaseSearchControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BaseSearchControl
----
*������ �������������*:
[code]�������::BaseSearchControl TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl

 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BaseSearchControl
----
*������ �������������*:
[code]�������::BaseSearchControl:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push

 Tkw_F1LikeFormWithBS_Control_Text = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]�������::Text TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_Text

 Tkw_F1LikeFormWithBS_Control_Text_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]�������::Text:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Control_Text_Push

 Tkw_F1LikeFormWithBS_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]���������::TextSource TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Component_TextSource

 Tkw_F1LikeFormWithBS_Component_LoadManager = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LoadManager
----
*������ �������������*:
[code]���������::LoadManager TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_F1LikeFormWithBS_Component_LoadManager

function TkwF1LikeFormWithBSFormBaseSearchControl.BaseSearchControl(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
 {* ���������� ����� ������� .TF1LikeFormWithBSForm.BaseSearchControl }
begin
 Result := aF1LikeFormWithBSForm.BaseSearchControl;
end;//TkwF1LikeFormWithBSFormBaseSearchControl.BaseSearchControl

class function TkwF1LikeFormWithBSFormBaseSearchControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.BaseSearchControl';
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetWordNameForRegister

function TkwF1LikeFormWithBSFormBaseSearchControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeComboWithHistoryAndOperations);
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetResultTypeInfo

function TkwF1LikeFormWithBSFormBaseSearchControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormBaseSearchControl.GetAllParamsCount

function TkwF1LikeFormWithBSFormBaseSearchControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeFormWithBSForm)]);
end;//TkwF1LikeFormWithBSFormBaseSearchControl.ParamsTypes

procedure TkwF1LikeFormWithBSFormBaseSearchControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BaseSearchControl', aCtx);
end;//TkwF1LikeFormWithBSFormBaseSearchControl.SetValuePrim

procedure TkwF1LikeFormWithBSFormBaseSearchControl.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeFormWithBSForm: TF1LikeFormWithBSForm;
begin
 try
  l_aF1LikeFormWithBSForm := TF1LikeFormWithBSForm(aCtx.rEngine.PopObjAs(TF1LikeFormWithBSForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeFormWithBSForm: TF1LikeFormWithBSForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BaseSearchControl(aCtx, l_aF1LikeFormWithBSForm));
end;//TkwF1LikeFormWithBSFormBaseSearchControl.DoDoIt

function TkwF1LikeFormWithBSFormText.Text(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
 {* ���������� ����� ������� .TF1LikeFormWithBSForm.Text }
begin
 Result := aF1LikeFormWithBSForm.Text;
end;//TkwF1LikeFormWithBSFormText.Text

class function TkwF1LikeFormWithBSFormText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.Text';
end;//TkwF1LikeFormWithBSFormText.GetWordNameForRegister

function TkwF1LikeFormWithBSFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeEditorExport);
end;//TkwF1LikeFormWithBSFormText.GetResultTypeInfo

function TkwF1LikeFormWithBSFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormText.GetAllParamsCount

function TkwF1LikeFormWithBSFormText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeFormWithBSForm)]);
end;//TkwF1LikeFormWithBSFormText.ParamsTypes

procedure TkwF1LikeFormWithBSFormText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwF1LikeFormWithBSFormText.SetValuePrim

procedure TkwF1LikeFormWithBSFormText.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeFormWithBSForm: TF1LikeFormWithBSForm;
begin
 try
  l_aF1LikeFormWithBSForm := TF1LikeFormWithBSForm(aCtx.rEngine.PopObjAs(TF1LikeFormWithBSForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeFormWithBSForm: TF1LikeFormWithBSForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Text(aCtx, l_aF1LikeFormWithBSForm));
end;//TkwF1LikeFormWithBSFormText.DoDoIt

function TkwF1LikeFormWithBSFormTextSource.TextSource(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
 {* ���������� ����� ������� .TF1LikeFormWithBSForm.TextSource }
begin
 Result := aF1LikeFormWithBSForm.TextSource;
end;//TkwF1LikeFormWithBSFormTextSource.TextSource

class function TkwF1LikeFormWithBSFormTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.TextSource';
end;//TkwF1LikeFormWithBSFormTextSource.GetWordNameForRegister

function TkwF1LikeFormWithBSFormTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTextSourceExport);
end;//TkwF1LikeFormWithBSFormTextSource.GetResultTypeInfo

function TkwF1LikeFormWithBSFormTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormTextSource.GetAllParamsCount

function TkwF1LikeFormWithBSFormTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeFormWithBSForm)]);
end;//TkwF1LikeFormWithBSFormTextSource.ParamsTypes

procedure TkwF1LikeFormWithBSFormTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TextSource', aCtx);
end;//TkwF1LikeFormWithBSFormTextSource.SetValuePrim

procedure TkwF1LikeFormWithBSFormTextSource.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeFormWithBSForm: TF1LikeFormWithBSForm;
begin
 try
  l_aF1LikeFormWithBSForm := TF1LikeFormWithBSForm(aCtx.rEngine.PopObjAs(TF1LikeFormWithBSForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeFormWithBSForm: TF1LikeFormWithBSForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TextSource(aCtx, l_aF1LikeFormWithBSForm));
end;//TkwF1LikeFormWithBSFormTextSource.DoDoIt

function TkwF1LikeFormWithBSFormLoadManager.LoadManager(const aCtx: TtfwContext;
 aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
 {* ���������� ����� ������� .TF1LikeFormWithBSForm.LoadManager }
begin
 Result := aF1LikeFormWithBSForm.LoadManager;
end;//TkwF1LikeFormWithBSFormLoadManager.LoadManager

class function TkwF1LikeFormWithBSFormLoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '.TF1LikeFormWithBSForm.LoadManager';
end;//TkwF1LikeFormWithBSFormLoadManager.GetWordNameForRegister

function TkwF1LikeFormWithBSFormLoadManager.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevLoadDocumentManager);
end;//TkwF1LikeFormWithBSFormLoadManager.GetResultTypeInfo

function TkwF1LikeFormWithBSFormLoadManager.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwF1LikeFormWithBSFormLoadManager.GetAllParamsCount

function TkwF1LikeFormWithBSFormLoadManager.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TF1LikeFormWithBSForm)]);
end;//TkwF1LikeFormWithBSFormLoadManager.ParamsTypes

procedure TkwF1LikeFormWithBSFormLoadManager.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LoadManager', aCtx);
end;//TkwF1LikeFormWithBSFormLoadManager.SetValuePrim

procedure TkwF1LikeFormWithBSFormLoadManager.DoDoIt(const aCtx: TtfwContext);
var l_aF1LikeFormWithBSForm: TF1LikeFormWithBSForm;
begin
 try
  l_aF1LikeFormWithBSForm := TF1LikeFormWithBSForm(aCtx.rEngine.PopObjAs(TF1LikeFormWithBSForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aF1LikeFormWithBSForm: TF1LikeFormWithBSForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LoadManager(aCtx, l_aF1LikeFormWithBSForm));
end;//TkwF1LikeFormWithBSFormLoadManager.DoDoIt

function Tkw_Form_F1LikeFormWithBS.GetString: AnsiString;
begin
 Result := 'F1LikeFormWithBSForm';
end;//Tkw_Form_F1LikeFormWithBS.GetString

class procedure Tkw_Form_F1LikeFormWithBS.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TF1LikeFormWithBSForm);
end;//Tkw_Form_F1LikeFormWithBS.RegisterInEngine

class function Tkw_Form_F1LikeFormWithBS.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::F1LikeFormWithBS';
end;//Tkw_Form_F1LikeFormWithBS.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetString: AnsiString;
begin
 Result := 'BaseSearchControl';
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetString

class procedure Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeComboWithHistoryAndOperations);
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine

class function Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchControl';
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl.GetWordNameForRegister

procedure Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BaseSearchControl');
 inherited;
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.DoDoIt

class function Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BaseSearchControl:push';
end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Control_Text.GetString: AnsiString;
begin
 Result := 'Text';
end;//Tkw_F1LikeFormWithBS_Control_Text.GetString

class procedure Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeEditorExport);
end;//Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine

class function Tkw_F1LikeFormWithBS_Control_Text.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text';
end;//Tkw_F1LikeFormWithBS_Control_Text.GetWordNameForRegister

procedure Tkw_F1LikeFormWithBS_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_F1LikeFormWithBS_Control_Text_Push.DoDoIt

class function Tkw_F1LikeFormWithBS_Control_Text_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Text:push';
end;//Tkw_F1LikeFormWithBS_Control_Text_Push.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Component_TextSource.GetString: AnsiString;
begin
 Result := 'TextSource';
end;//Tkw_F1LikeFormWithBS_Component_TextSource.GetString

class procedure Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTextSourceExport);
end;//Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine

class function Tkw_F1LikeFormWithBS_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_F1LikeFormWithBS_Component_TextSource.GetWordNameForRegister

function Tkw_F1LikeFormWithBS_Component_LoadManager.GetString: AnsiString;
begin
 Result := 'LoadManager';
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.GetString

class procedure Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TevLoadDocumentManager);
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine

class function Tkw_F1LikeFormWithBS_Component_LoadManager.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::LoadManager';
end;//Tkw_F1LikeFormWithBS_Component_LoadManager.GetWordNameForRegister

initialization
 TkwF1LikeFormWithBSFormBaseSearchControl.RegisterInEngine;
 {* ����������� F1LikeFormWithBSForm_BaseSearchControl }
 TkwF1LikeFormWithBSFormText.RegisterInEngine;
 {* ����������� F1LikeFormWithBSForm_Text }
 TkwF1LikeFormWithBSFormTextSource.RegisterInEngine;
 {* ����������� F1LikeFormWithBSForm_TextSource }
 TkwF1LikeFormWithBSFormLoadManager.RegisterInEngine;
 {* ����������� F1LikeFormWithBSForm_LoadManager }
 Tkw_Form_F1LikeFormWithBS.RegisterInEngine;
 {* ����������� Tkw_Form_F1LikeFormWithBS }
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Control_BaseSearchControl }
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push }
 Tkw_F1LikeFormWithBS_Control_Text.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Control_Text }
 Tkw_F1LikeFormWithBS_Control_Text_Push.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Control_Text_Push }
 Tkw_F1LikeFormWithBS_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Component_TextSource }
 Tkw_F1LikeFormWithBS_Component_LoadManager.RegisterInEngine;
 {* ����������� Tkw_F1LikeFormWithBS_Component_LoadManager }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TF1LikeFormWithBSForm));
 {* ����������� ���� TF1LikeFormWithBSForm }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeComboWithHistoryAndOperations));
 {* ����������� ���� TnscTreeComboWithHistoryAndOperations }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeEditorExport));
 {* ����������� ���� TeeEditorExport }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTextSourceExport));
 {* ����������� ���� TeeTextSourceExport }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevLoadDocumentManager));
 {* ����������� ���� TevLoadDocumentManager }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
