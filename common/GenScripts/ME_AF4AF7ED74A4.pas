unit OutlinerFormKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� OutlinerForm }

// ������: "w:\common\components\gui\Garant\Daily\Forms\OutlinerFormKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "OutlinerFormKeywordsPack" MUID: (AF4AF7ED74A4)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtOutlinerControl
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Outliner_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_OutlinerForm = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� OutlinerForm
----
*������ �������������*:
[code]
'aControl' �����::OutlinerForm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_OutlinerForm

 Tkw_OutlinerForm_Control_TreeControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OutlinerForm_Control_TreeControl

 Tkw_OutlinerForm_Control_TreeControl_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_OutlinerForm_Control_TreeControl_Push

 TkwOutlinerFormFormTreeControl = {final} class(TtfwPropertyLike)
  {* ����� ������� .TOutlinerFormForm.TreeControl
[panel]������� TreeControl ����� TOutlinerFormForm[panel]
*��� ����������:* TvtOutlinerControl
*������:*
[code]
OBJECT VAR l_TvtOutlinerControl
 aOutlinerFormForm .TOutlinerFormForm.TreeControl >>> l_TvtOutlinerControl
[code]  }
  private
   function TreeControl(const aCtx: TtfwContext;
    aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
    {* ���������� ����� ������� .TOutlinerFormForm.TreeControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwOutlinerFormFormTreeControl

function Tkw_Form_OutlinerForm.GetString: AnsiString;
begin
 Result := 'OutlinerFormForm';
end;//Tkw_Form_OutlinerForm.GetString

class function Tkw_Form_OutlinerForm.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::OutlinerForm';
end;//Tkw_Form_OutlinerForm.GetWordNameForRegister

function Tkw_OutlinerForm_Control_TreeControl.GetString: AnsiString;
begin
 Result := 'TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetString

class procedure Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtOutlinerControl);
end;//Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine

class function Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister

procedure Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TreeControl');
 inherited;
end;//Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt

class function Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeControl:push';
end;//Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister

function TkwOutlinerFormFormTreeControl.TreeControl(const aCtx: TtfwContext;
 aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
 {* ���������� ����� ������� .TOutlinerFormForm.TreeControl }
begin
 Result := aOutlinerFormForm.TreeControl;
end;//TkwOutlinerFormFormTreeControl.TreeControl

procedure TkwOutlinerFormFormTreeControl.DoDoIt(const aCtx: TtfwContext);
var l_aOutlinerFormForm: TOutlinerFormForm;
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
 aCtx.rEngine.PushObj(TreeControl(aCtx, l_aOutlinerFormForm));
end;//TkwOutlinerFormFormTreeControl.DoDoIt

procedure TkwOutlinerFormFormTreeControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TreeControl', aCtx);
end;//TkwOutlinerFormFormTreeControl.SetValuePrim

function TkwOutlinerFormFormTreeControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtOutlinerControl);
end;//TkwOutlinerFormFormTreeControl.GetResultTypeInfo

function TkwOutlinerFormFormTreeControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwOutlinerFormFormTreeControl.GetAllParamsCount

function TkwOutlinerFormFormTreeControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TOutlinerFormForm)]);
end;//TkwOutlinerFormFormTreeControl.ParamsTypes

class function TkwOutlinerFormFormTreeControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TOutlinerFormForm.TreeControl';
end;//TkwOutlinerFormFormTreeControl.GetWordNameForRegister

initialization
 Tkw_Form_OutlinerForm.RegisterInEngine;
 {* ����������� Tkw_Form_OutlinerForm }
 Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
 {* ����������� Tkw_OutlinerForm_Control_TreeControl }
 Tkw_OutlinerForm_Control_TreeControl_Push.RegisterInEngine;
 {* ����������� Tkw_OutlinerForm_Control_TreeControl_Push }
 TkwOutlinerFormFormTreeControl.RegisterInEngine;
 {* ����������� OutlinerFormForm_TreeControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TOutlinerFormForm));
 {* ����������� ���� OutlinerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtOutlinerControl));
 {* ����������� ���� TvtOutlinerControl }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

end.
