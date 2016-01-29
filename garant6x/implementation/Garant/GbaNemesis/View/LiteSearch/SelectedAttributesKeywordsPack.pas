unit SelectedAttributesKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/SelectedAttributesKeywordsPack.pas"
// �����: 04.09.2009 14:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::LiteSearch::SelectedAttributesKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� SelectedAttributes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  SelectedAttributes_Form,
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

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_SelectedAttributes = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� SelectedAttributes
----
*������ �������������*:
[code]
'aControl' �����::SelectedAttributes TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_SelectedAttributes

// start class Tkw_Form_SelectedAttributes

class function Tkw_Form_SelectedAttributes.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::SelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetWordNameForRegister

function Tkw_Form_SelectedAttributes.GetString: AnsiString;
 {-}
begin
 Result := 'enSelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetString

type
  Tkw_SelectedAttributes_Control_SelectedTree = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� SelectedTree
----
*������ �������������*:
[code]
�������::SelectedTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SelectedAttributes_Control_SelectedTree

// start class Tkw_SelectedAttributes_Control_SelectedTree

class function Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister

function Tkw_SelectedAttributes_Control_SelectedTree.GetString: AnsiString;
 {-}
begin
 Result := 'SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetString

class procedure Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine

type
  Tkw_SelectedAttributes_Control_SelectedTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� SelectedTree
----
*������ �������������*:
[code]
�������::SelectedTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SelectedAttributes_Control_SelectedTree_Push

// start class Tkw_SelectedAttributes_Control_SelectedTree_Push

procedure Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SelectedTree');
 inherited;
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt

class function Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SelectedTree:push';
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister

type
  TkwEnSelectedAttributesSelectedTree = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TenSelectedAttributes.SelectedTree
[panel]������� SelectedTree ����� TenSelectedAttributes[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenSelectedAttributes .TenSelectedAttributes.SelectedTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function SelectedTree(const aCtx: TtfwContext;
     aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
     {* ���������� ����� ������� .TenSelectedAttributes.SelectedTree }
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
  end;//TkwEnSelectedAttributesSelectedTree

// start class TkwEnSelectedAttributesSelectedTree

function TkwEnSelectedAttributesSelectedTree.SelectedTree(const aCtx: TtfwContext;
  aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aenSelectedAttributes.SelectedTree;
end;//TkwEnSelectedAttributesSelectedTree.SelectedTree

procedure TkwEnSelectedAttributesSelectedTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenSelectedAttributes : TenSelectedAttributes;
begin
 try
  l_aenSelectedAttributes := TenSelectedAttributes(aCtx.rEngine.PopObjAs(TenSelectedAttributes));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenSelectedAttributes: TenSelectedAttributes : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SelectedTree(aCtx, l_aenSelectedAttributes)));
end;//TkwEnSelectedAttributesSelectedTree.DoDoIt

class function TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenSelectedAttributes.SelectedTree';
end;//TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister

procedure TkwEnSelectedAttributesSelectedTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� SelectedTree', aCtx);
end;//TkwEnSelectedAttributesSelectedTree.SetValuePrim

function TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo

function TkwEnSelectedAttributesSelectedTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnSelectedAttributesSelectedTree.GetAllParamsCount

function TkwEnSelectedAttributesSelectedTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenSelectedAttributes)]);
end;//TkwEnSelectedAttributesSelectedTree.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_SelectedAttributes
 Tkw_Form_SelectedAttributes.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_SelectedAttributes_Control_SelectedTree
 Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_SelectedAttributes_Control_SelectedTree_Push
 Tkw_SelectedAttributes_Control_SelectedTree_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� enSelectedAttributes_SelectedTree
 TkwEnSelectedAttributesSelectedTree.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� SelectedAttributes
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenSelectedAttributes));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not NoScripts

end.