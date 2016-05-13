unit DocNumberQueryKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� DocNumberQuery }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\DocNumberQueryKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "DocNumberQueryKeywordsPack" MUID: (A40358DFC617)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DocNumberQuery_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_DocNumberQuery = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� DocNumberQuery
----
*������ �������������*:
[code]
'aControl' �����::DocNumberQuery TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_DocNumberQuery

 Tkw_DocNumberQuery_Control_Label1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Label1
----
*������ �������������*:
[code]
�������::Label1 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_Label1

 Tkw_DocNumberQuery_Control_Label1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� Label1
----
*������ �������������*:
[code]
�������::Label1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_Label1_Push

 Tkw_DocNumberQuery_Control_edNumber = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edNumber
----
*������ �������������*:
[code]
�������::edNumber TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_edNumber

 Tkw_DocNumberQuery_Control_edNumber_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� edNumber
----
*������ �������������*:
[code]
�������::edNumber:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_edNumber_Push

 Tkw_DocNumberQuery_Control_cbInternal = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� cbInternal
----
*������ �������������*:
[code]
�������::cbInternal TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_cbInternal

 Tkw_DocNumberQuery_Control_cbInternal_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� cbInternal
----
*������ �������������*:
[code]
�������::cbInternal:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DocNumberQuery_Control_cbInternal_Push

 TkwDocNumberQueryFormLabel1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDocNumberQueryForm.Label1 }
  private
   function Label1(const aCtx: TtfwContext;
    aDocNumberQueryForm: TDocNumberQueryForm): TvtLabel;
    {* ���������� ����� ������� .TDocNumberQueryForm.Label1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDocNumberQueryFormLabel1

 TkwDocNumberQueryFormEdNumber = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDocNumberQueryForm.edNumber }
  private
   function edNumber(const aCtx: TtfwContext;
    aDocNumberQueryForm: TDocNumberQueryForm): TnscComboBox;
    {* ���������� ����� ������� .TDocNumberQueryForm.edNumber }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDocNumberQueryFormEdNumber

 TkwDocNumberQueryFormCbInternal = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDocNumberQueryForm.cbInternal }
  private
   function cbInternal(const aCtx: TtfwContext;
    aDocNumberQueryForm: TDocNumberQueryForm): TvtCheckBox;
    {* ���������� ����� ������� .TDocNumberQueryForm.cbInternal }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDocNumberQueryFormCbInternal

function Tkw_Form_DocNumberQuery.GetString: AnsiString;
begin
 Result := 'DocNumberQueryForm';
end;//Tkw_Form_DocNumberQuery.GetString

class function Tkw_Form_DocNumberQuery.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DocNumberQuery';
end;//Tkw_Form_DocNumberQuery.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_Label1.GetString: AnsiString;
begin
 Result := 'Label1';
end;//Tkw_DocNumberQuery_Control_Label1.GetString

class procedure Tkw_DocNumberQuery_Control_Label1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DocNumberQuery_Control_Label1.RegisterInEngine

class function Tkw_DocNumberQuery_Control_Label1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1';
end;//Tkw_DocNumberQuery_Control_Label1.GetWordNameForRegister

procedure Tkw_DocNumberQuery_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_DocNumberQuery_Control_Label1_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_Label1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Label1:push';
end;//Tkw_DocNumberQuery_Control_Label1_Push.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_edNumber.GetString: AnsiString;
begin
 Result := 'edNumber';
end;//Tkw_DocNumberQuery_Control_edNumber.GetString

class procedure Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboBox);
end;//Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine

class function Tkw_DocNumberQuery_Control_edNumber.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edNumber';
end;//Tkw_DocNumberQuery_Control_edNumber.GetWordNameForRegister

procedure Tkw_DocNumberQuery_Control_edNumber_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edNumber');
 inherited;
end;//Tkw_DocNumberQuery_Control_edNumber_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_edNumber_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edNumber:push';
end;//Tkw_DocNumberQuery_Control_edNumber_Push.GetWordNameForRegister

function Tkw_DocNumberQuery_Control_cbInternal.GetString: AnsiString;
begin
 Result := 'cbInternal';
end;//Tkw_DocNumberQuery_Control_cbInternal.GetString

class procedure Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine

class function Tkw_DocNumberQuery_Control_cbInternal.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbInternal';
end;//Tkw_DocNumberQuery_Control_cbInternal.GetWordNameForRegister

procedure Tkw_DocNumberQuery_Control_cbInternal_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbInternal');
 inherited;
end;//Tkw_DocNumberQuery_Control_cbInternal_Push.DoDoIt

class function Tkw_DocNumberQuery_Control_cbInternal_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::cbInternal:push';
end;//Tkw_DocNumberQuery_Control_cbInternal_Push.GetWordNameForRegister

function TkwDocNumberQueryFormLabel1.Label1(const aCtx: TtfwContext;
 aDocNumberQueryForm: TDocNumberQueryForm): TvtLabel;
 {* ���������� ����� ������� .TDocNumberQueryForm.Label1 }
begin
 Result := aDocNumberQueryForm.Label1;
end;//TkwDocNumberQueryFormLabel1.Label1

class function TkwDocNumberQueryFormLabel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDocNumberQueryForm.Label1';
end;//TkwDocNumberQueryFormLabel1.GetWordNameForRegister

function TkwDocNumberQueryFormLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDocNumberQueryFormLabel1.GetResultTypeInfo

function TkwDocNumberQueryFormLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDocNumberQueryFormLabel1.GetAllParamsCount

function TkwDocNumberQueryFormLabel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormLabel1.ParamsTypes

procedure TkwDocNumberQueryFormLabel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Label1', aCtx);
end;//TkwDocNumberQueryFormLabel1.SetValuePrim

procedure TkwDocNumberQueryFormLabel1.DoDoIt(const aCtx: TtfwContext);
var l_aDocNumberQueryForm: TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Label1(aCtx, l_aDocNumberQueryForm));
end;//TkwDocNumberQueryFormLabel1.DoDoIt

function TkwDocNumberQueryFormEdNumber.edNumber(const aCtx: TtfwContext;
 aDocNumberQueryForm: TDocNumberQueryForm): TnscComboBox;
 {* ���������� ����� ������� .TDocNumberQueryForm.edNumber }
begin
 Result := aDocNumberQueryForm.edNumber;
end;//TkwDocNumberQueryFormEdNumber.edNumber

class function TkwDocNumberQueryFormEdNumber.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDocNumberQueryForm.edNumber';
end;//TkwDocNumberQueryFormEdNumber.GetWordNameForRegister

function TkwDocNumberQueryFormEdNumber.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboBox);
end;//TkwDocNumberQueryFormEdNumber.GetResultTypeInfo

function TkwDocNumberQueryFormEdNumber.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDocNumberQueryFormEdNumber.GetAllParamsCount

function TkwDocNumberQueryFormEdNumber.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormEdNumber.ParamsTypes

procedure TkwDocNumberQueryFormEdNumber.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edNumber', aCtx);
end;//TkwDocNumberQueryFormEdNumber.SetValuePrim

procedure TkwDocNumberQueryFormEdNumber.DoDoIt(const aCtx: TtfwContext);
var l_aDocNumberQueryForm: TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edNumber(aCtx, l_aDocNumberQueryForm));
end;//TkwDocNumberQueryFormEdNumber.DoDoIt

function TkwDocNumberQueryFormCbInternal.cbInternal(const aCtx: TtfwContext;
 aDocNumberQueryForm: TDocNumberQueryForm): TvtCheckBox;
 {* ���������� ����� ������� .TDocNumberQueryForm.cbInternal }
begin
 Result := aDocNumberQueryForm.cbInternal;
end;//TkwDocNumberQueryFormCbInternal.cbInternal

class function TkwDocNumberQueryFormCbInternal.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDocNumberQueryForm.cbInternal';
end;//TkwDocNumberQueryFormCbInternal.GetWordNameForRegister

function TkwDocNumberQueryFormCbInternal.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwDocNumberQueryFormCbInternal.GetResultTypeInfo

function TkwDocNumberQueryFormCbInternal.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDocNumberQueryFormCbInternal.GetAllParamsCount

function TkwDocNumberQueryFormCbInternal.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDocNumberQueryForm)]);
end;//TkwDocNumberQueryFormCbInternal.ParamsTypes

procedure TkwDocNumberQueryFormCbInternal.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� cbInternal', aCtx);
end;//TkwDocNumberQueryFormCbInternal.SetValuePrim

procedure TkwDocNumberQueryFormCbInternal.DoDoIt(const aCtx: TtfwContext);
var l_aDocNumberQueryForm: TDocNumberQueryForm;
begin
 try
  l_aDocNumberQueryForm := TDocNumberQueryForm(aCtx.rEngine.PopObjAs(TDocNumberQueryForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDocNumberQueryForm: TDocNumberQueryForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbInternal(aCtx, l_aDocNumberQueryForm));
end;//TkwDocNumberQueryFormCbInternal.DoDoIt

initialization
 Tkw_Form_DocNumberQuery.RegisterInEngine;
 {* ����������� Tkw_Form_DocNumberQuery }
 Tkw_DocNumberQuery_Control_Label1.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_Label1 }
 Tkw_DocNumberQuery_Control_Label1_Push.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_Label1_Push }
 Tkw_DocNumberQuery_Control_edNumber.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_edNumber }
 Tkw_DocNumberQuery_Control_edNumber_Push.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_edNumber_Push }
 Tkw_DocNumberQuery_Control_cbInternal.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_cbInternal }
 Tkw_DocNumberQuery_Control_cbInternal_Push.RegisterInEngine;
 {* ����������� Tkw_DocNumberQuery_Control_cbInternal_Push }
 TkwDocNumberQueryFormLabel1.RegisterInEngine;
 {* ����������� DocNumberQueryForm_Label1 }
 TkwDocNumberQueryFormEdNumber.RegisterInEngine;
 {* ����������� DocNumberQueryForm_edNumber }
 TkwDocNumberQueryFormCbInternal.RegisterInEngine;
 {* ����������� DocNumberQueryForm_cbInternal }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocNumberQueryForm));
 {* ����������� ���� TDocNumberQueryForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBox));
 {* ����������� ���� TnscComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
