unit AttributesKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/AttributesKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::AttributesKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Attributes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Attributes_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_Attributes = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Attributes
----
*������ �������������*:
[code]
'aControl' �����::Attributes TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Attributes

// start class Tkw_Form_Attributes

class function Tkw_Form_Attributes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Attributes';
end;//Tkw_Form_Attributes.GetWordNameForRegister

function Tkw_Form_Attributes.GetString: AnsiString;
 {-}
begin
 Result := 'AttributesForm';
end;//Tkw_Form_Attributes.GetString

type
  Tkw_Attributes_Control_tvAttributes = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvAttributes
----
*������ �������������*:
[code]
�������::tvAttributes TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Attributes_Control_tvAttributes

// start class Tkw_Attributes_Control_tvAttributes

class function Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvAttributes';
end;//Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister

function Tkw_Attributes_Control_tvAttributes.GetString: AnsiString;
 {-}
begin
 Result := 'tvAttributes';
end;//Tkw_Attributes_Control_tvAttributes.GetString

class procedure Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Attributes_Control_tvAttributes.RegisterInEngine

type
  Tkw_Attributes_Control_tvAttributes_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvAttributes
----
*������ �������������*:
[code]
�������::tvAttributes:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Attributes_Control_tvAttributes_Push

// start class Tkw_Attributes_Control_tvAttributes_Push

procedure Tkw_Attributes_Control_tvAttributes_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvAttributes');
 inherited;
end;//Tkw_Attributes_Control_tvAttributes_Push.DoDoIt

class function Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvAttributes:push';
end;//Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister

type
  TkwAttributesFormTvAttributes = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TAttributesForm.tvAttributes
[panel]������� tvAttributes ����� TAttributesForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aAttributesForm .TAttributesForm.tvAttributes >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvAttributes(const aCtx: TtfwContext;
     aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .TAttributesForm.tvAttributes }
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
  end;//TkwAttributesFormTvAttributes

// start class TkwAttributesFormTvAttributes

function TkwAttributesFormTvAttributes.TvAttributes(const aCtx: TtfwContext;
  aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aAttributesForm.tvAttributes;
end;//TkwAttributesFormTvAttributes.TvAttributes

procedure TkwAttributesFormTvAttributes.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAttributesForm : TAttributesForm;
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
 aCtx.rEngine.PushObj((TvAttributes(aCtx, l_aAttributesForm)));
end;//TkwAttributesFormTvAttributes.DoDoIt

class function TkwAttributesFormTvAttributes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAttributesForm.tvAttributes';
end;//TkwAttributesFormTvAttributes.GetWordNameForRegister

procedure TkwAttributesFormTvAttributes.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvAttributes', aCtx);
end;//TkwAttributesFormTvAttributes.SetValuePrim

function TkwAttributesFormTvAttributes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwAttributesFormTvAttributes.GetResultTypeInfo

function TkwAttributesFormTvAttributes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAttributesFormTvAttributes.GetAllParamsCount

function TkwAttributesFormTvAttributes.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAttributesForm)]);
end;//TkwAttributesFormTvAttributes.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Attributes
 Tkw_Form_Attributes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Attributes_Control_tvAttributes
 Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Attributes_Control_tvAttributes_Push
 Tkw_Attributes_Control_tvAttributes_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� AttributesForm_tvAttributes
 TkwAttributesFormTvAttributes.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Attributes
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttributesForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.