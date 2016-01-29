unit RedactionsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/RedactionsKeywordsPack.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::RedactionsKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Redactions
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
  Redactions_Form,
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
  Tkw_Form_Redactions = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Redactions
----
*������ �������������*:
[code]
'aControl' �����::Redactions TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Redactions

// start class Tkw_Form_Redactions

class function Tkw_Form_Redactions.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Redactions';
end;//Tkw_Form_Redactions.GetWordNameForRegister

function Tkw_Form_Redactions.GetString: AnsiString;
 {-}
begin
 Result := 'RedactionsForm';
end;//Tkw_Form_Redactions.GetString

type
  Tkw_Redactions_Control_RedactionTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� RedactionTree
----
*������ �������������*:
[code]
�������::RedactionTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Redactions_Control_RedactionTree

// start class Tkw_Redactions_Control_RedactionTree

class function Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetWordNameForRegister

function Tkw_Redactions_Control_RedactionTree.GetString: AnsiString;
 {-}
begin
 Result := 'RedactionTree';
end;//Tkw_Redactions_Control_RedactionTree.GetString

class procedure Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Redactions_Control_RedactionTree.RegisterInEngine

type
  Tkw_Redactions_Control_RedactionTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� RedactionTree
----
*������ �������������*:
[code]
�������::RedactionTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Redactions_Control_RedactionTree_Push

// start class Tkw_Redactions_Control_RedactionTree_Push

procedure Tkw_Redactions_Control_RedactionTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RedactionTree');
 inherited;
end;//Tkw_Redactions_Control_RedactionTree_Push.DoDoIt

class function Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::RedactionTree:push';
end;//Tkw_Redactions_Control_RedactionTree_Push.GetWordNameForRegister

type
  TkwRedactionsFormRedactionTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRedactionsForm.RedactionTree
[panel]������� RedactionTree ����� TRedactionsForm[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aRedactionsForm .TRedactionsForm.RedactionTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function RedactionTree(const aCtx: TtfwContext;
     aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .TRedactionsForm.RedactionTree }
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
  end;//TkwRedactionsFormRedactionTree

// start class TkwRedactionsFormRedactionTree

function TkwRedactionsFormRedactionTree.RedactionTree(const aCtx: TtfwContext;
  aRedactionsForm: TRedactionsForm): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aRedactionsForm.RedactionTree;
end;//TkwRedactionsFormRedactionTree.RedactionTree

procedure TkwRedactionsFormRedactionTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRedactionsForm : TRedactionsForm;
begin
 try
  l_aRedactionsForm := TRedactionsForm(aCtx.rEngine.PopObjAs(TRedactionsForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRedactionsForm: TRedactionsForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RedactionTree(aCtx, l_aRedactionsForm)));
end;//TkwRedactionsFormRedactionTree.DoDoIt

class function TkwRedactionsFormRedactionTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRedactionsForm.RedactionTree';
end;//TkwRedactionsFormRedactionTree.GetWordNameForRegister

procedure TkwRedactionsFormRedactionTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� RedactionTree', aCtx);
end;//TkwRedactionsFormRedactionTree.SetValuePrim

function TkwRedactionsFormRedactionTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwRedactionsFormRedactionTree.GetResultTypeInfo

function TkwRedactionsFormRedactionTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRedactionsFormRedactionTree.GetAllParamsCount

function TkwRedactionsFormRedactionTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRedactionsForm)]);
end;//TkwRedactionsFormRedactionTree.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_Redactions
 Tkw_Form_Redactions.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Redactions_Control_RedactionTree
 Tkw_Redactions_Control_RedactionTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Redactions_Control_RedactionTree_Push
 Tkw_Redactions_Control_RedactionTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RedactionsForm_RedactionTree
 TkwRedactionsFormRedactionTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� Redactions
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRedactionsForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.