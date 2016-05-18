unit SelectedAttributesKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SelectedAttributes }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\SelectedAttributesKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SelectedAttributesKeywordsPack" MUID: (4AAF51FC0061_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SelectedAttributes_Form
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
;

type
 TkwEnSelectedAttributesSelectedTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenSelectedAttributes.SelectedTree }
  private
   function SelectedTree(const aCtx: TtfwContext;
    aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenSelectedAttributes.SelectedTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnSelectedAttributesSelectedTree

 Tkw_Form_SelectedAttributes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� SelectedAttributes
----
*������ �������������*:
[code]�����::SelectedAttributes TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_SelectedAttributes

 Tkw_SelectedAttributes_Control_SelectedTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SelectedTree
----
*������ �������������*:
[code]�������::SelectedTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree

 Tkw_SelectedAttributes_Control_SelectedTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SelectedTree
----
*������ �������������*:
[code]�������::SelectedTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree_Push

function TkwEnSelectedAttributesSelectedTree.SelectedTree(const aCtx: TtfwContext;
 aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenSelectedAttributes.SelectedTree }
begin
 Result := aenSelectedAttributes.SelectedTree;
end;//TkwEnSelectedAttributesSelectedTree.SelectedTree

class function TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenSelectedAttributes.SelectedTree';
end;//TkwEnSelectedAttributesSelectedTree.GetWordNameForRegister

function TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnSelectedAttributesSelectedTree.GetResultTypeInfo

function TkwEnSelectedAttributesSelectedTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnSelectedAttributesSelectedTree.GetAllParamsCount

function TkwEnSelectedAttributesSelectedTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenSelectedAttributes)]);
end;//TkwEnSelectedAttributesSelectedTree.ParamsTypes

procedure TkwEnSelectedAttributesSelectedTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SelectedTree', aCtx);
end;//TkwEnSelectedAttributesSelectedTree.SetValuePrim

procedure TkwEnSelectedAttributesSelectedTree.DoDoIt(const aCtx: TtfwContext);
var l_aenSelectedAttributes: TenSelectedAttributes;
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
 aCtx.rEngine.PushObj(SelectedTree(aCtx, l_aenSelectedAttributes));
end;//TkwEnSelectedAttributesSelectedTree.DoDoIt

function Tkw_Form_SelectedAttributes.GetString: AnsiString;
begin
 Result := 'enSelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetString

class procedure Tkw_Form_SelectedAttributes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenSelectedAttributes);
end;//Tkw_Form_SelectedAttributes.RegisterInEngine

class function Tkw_Form_SelectedAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetWordNameForRegister

function Tkw_SelectedAttributes_Control_SelectedTree.GetString: AnsiString;
begin
 Result := 'SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetString

class procedure Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine

class function Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SelectedTree';
end;//Tkw_SelectedAttributes_Control_SelectedTree.GetWordNameForRegister

procedure Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SelectedTree');
 inherited;
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.DoDoIt

class function Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SelectedTree:push';
end;//Tkw_SelectedAttributes_Control_SelectedTree_Push.GetWordNameForRegister

initialization
 TkwEnSelectedAttributesSelectedTree.RegisterInEngine;
 {* ����������� enSelectedAttributes_SelectedTree }
 Tkw_Form_SelectedAttributes.RegisterInEngine;
 {* ����������� Tkw_Form_SelectedAttributes }
 Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
 {* ����������� Tkw_SelectedAttributes_Control_SelectedTree }
 Tkw_SelectedAttributes_Control_SelectedTree_Push.RegisterInEngine;
 {* ����������� Tkw_SelectedAttributes_Control_SelectedTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenSelectedAttributes));
 {* ����������� ���� TenSelectedAttributes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
