unit AttributesKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Attributes }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\AttributesKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "AttributesKeywordsPack" MUID: (4AB1357D0253_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Attributes_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AB1357D0253_Packimpl_uses*
 //#UC END# *4AB1357D0253_Packimpl_uses*
;

type
 TkwAttributesFormTvAttributes = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAttributesForm.tvAttributes }
  private
   function tvAttributes(const aCtx: TtfwContext;
    aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TAttributesForm.tvAttributes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAttributesFormTvAttributes

 Tkw_Form_Attributes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Attributes
----
*������ �������������*:
[code]�����::Attributes TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Attributes

 Tkw_Attributes_Control_tvAttributes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvAttributes
----
*������ �������������*:
[code]�������::tvAttributes TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Attributes_Control_tvAttributes

 Tkw_Attributes_Control_tvAttributes_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvAttributes
----
*������ �������������*:
[code]�������::tvAttributes:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Attributes_Control_tvAttributes_Push

function TkwAttributesFormTvAttributes.tvAttributes(const aCtx: TtfwContext;
 aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TAttributesForm.tvAttributes }
begin
 Result := aAttributesForm.tvAttributes;
end;//TkwAttributesFormTvAttributes.tvAttributes

class function TkwAttributesFormTvAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAttributesForm.tvAttributes';
end;//TkwAttributesFormTvAttributes.GetWordNameForRegister

function TkwAttributesFormTvAttributes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwAttributesFormTvAttributes.GetResultTypeInfo

function TkwAttributesFormTvAttributes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAttributesFormTvAttributes.GetAllParamsCount

function TkwAttributesFormTvAttributes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAttributesForm)]);
end;//TkwAttributesFormTvAttributes.ParamsTypes

procedure TkwAttributesFormTvAttributes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvAttributes', aCtx);
end;//TkwAttributesFormTvAttributes.SetValuePrim

procedure TkwAttributesFormTvAttributes.DoDoIt(const aCtx: TtfwContext);
var l_aAttributesForm: TAttributesForm;
begin
 try
  l_aAttributesForm := TAttributesForm(aCtx.rEngine.PopObjAs(TAttributesForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAttributesForm: TAttributesForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvAttributes(aCtx, l_aAttributesForm));
end;//TkwAttributesFormTvAttributes.DoDoIt

function Tkw_Form_Attributes.GetString: AnsiString;
begin
 Result := 'AttributesForm';
end;//Tkw_Form_Attributes.GetString

class procedure Tkw_Form_Attributes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TAttributesForm);
end;//Tkw_Form_Attributes.RegisterInEngine

class function Tkw_Form_Attributes.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Attributes';
end;//Tkw_Form_Attributes.GetWordNameForRegister

function Tkw_Attributes_Control_tvAttributes.GetString: AnsiString;
begin
 Result := 'tvAttributes';
end;//Tkw_Attributes_Control_tvAttributes.GetString

class procedure Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Attributes_Control_tvAttributes.RegisterInEngine

class function Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvAttributes';
end;//Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister

procedure Tkw_Attributes_Control_tvAttributes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvAttributes');
 inherited;
end;//Tkw_Attributes_Control_tvAttributes_Push.DoDoIt

class function Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvAttributes:push';
end;//Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister

initialization
 TkwAttributesFormTvAttributes.RegisterInEngine;
 {* ����������� AttributesForm_tvAttributes }
 Tkw_Form_Attributes.RegisterInEngine;
 {* ����������� Tkw_Form_Attributes }
 Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
 {* ����������� Tkw_Attributes_Control_tvAttributes }
 Tkw_Attributes_Control_tvAttributes_Push.RegisterInEngine;
 {* ����������� Tkw_Attributes_Control_tvAttributes_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttributesForm));
 {* ����������� ���� TAttributesForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
