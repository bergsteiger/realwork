unit OutlinerFormKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� OutlinerForm }

// ������: "w:\common\components\gui\Garant\Daily\Forms\OutlinerFormKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Outliner_Form
 , vtOutlinerControl
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_OutlinerForm

 Tkw_OutlinerForm_Control_TreeControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TreeControl
----
*������ �������������*:
[code]
�������::TreeControl TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
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

class function Tkw_Form_OutlinerForm.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::OutlinerForm';
end;//Tkw_Form_OutlinerForm.GetWordNameForRegister

function Tkw_Form_OutlinerForm.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_09DAEB2FD8D0_var*
//#UC END# *4DDFD2EA0116_09DAEB2FD8D0_var*
begin
//#UC START# *4DDFD2EA0116_09DAEB2FD8D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_09DAEB2FD8D0_impl*
end;//Tkw_Form_OutlinerForm.GetString

class function Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeControl';
end;//Tkw_OutlinerForm_Control_TreeControl.GetWordNameForRegister

function Tkw_OutlinerForm_Control_TreeControl.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C286239A9B7E_var*
//#UC END# *4DDFD2EA0116_C286239A9B7E_var*
begin
//#UC START# *4DDFD2EA0116_C286239A9B7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C286239A9B7E_impl*
end;//Tkw_OutlinerForm_Control_TreeControl.GetString

class procedure Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine;
//#UC START# *52A086150180_C286239A9B7E_var*
//#UC END# *52A086150180_C286239A9B7E_var*
begin
//#UC START# *52A086150180_C286239A9B7E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C286239A9B7E_impl*
end;//Tkw_OutlinerForm_Control_TreeControl.RegisterInEngine

procedure Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B86AAC3D28B3_var*
//#UC END# *4DAEEDE10285_B86AAC3D28B3_var*
begin
//#UC START# *4DAEEDE10285_B86AAC3D28B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B86AAC3D28B3_impl*
end;//Tkw_OutlinerForm_Control_TreeControl_Push.DoDoIt

class function Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TreeControl:push';
end;//Tkw_OutlinerForm_Control_TreeControl_Push.GetWordNameForRegister

function TkwOutlinerFormFormTreeControl.TreeControl(const aCtx: TtfwContext;
 aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
 {* ���������� ����� ������� .TOutlinerFormForm.TreeControl }
//#UC START# *F29E9001A722_B10A49D0279E_var*
//#UC END# *F29E9001A722_B10A49D0279E_var*
begin
//#UC START# *F29E9001A722_B10A49D0279E_impl*
 !!! Needs to be implemented !!!
//#UC END# *F29E9001A722_B10A49D0279E_impl*
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

class function TkwOutlinerFormFormTreeControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.TOutlinerFormForm.TreeControl';
end;//TkwOutlinerFormFormTreeControl.GetWordNameForRegister

procedure TkwOutlinerFormFormTreeControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_OutlinerFormForm: TOutlinerFormForm;
begin
 try
  l_OutlinerFormForm := TOutlinerFormForm(aCtx.rEngine.PopObjAs(TOutlinerFormForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� OutlinerFormForm: TOutlinerFormForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 OutlinerFormForm. := TvtOutlinerControl(aValue.AsObject(TvtOutlinerControl));
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
