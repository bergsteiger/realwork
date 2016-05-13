unit SelectedAttributesKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SelectedAttributes }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\SelectedAttributesKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SelectedAttributesKeywordsPack" MUID: (2F60CBABB288)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SelectedAttributes_Form
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
 Tkw_Form_SelectedAttributes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� SelectedAttributes
----
*������ �������������*:
[code]
'aControl' �����::SelectedAttributes TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_SelectedAttributes

 Tkw_SelectedAttributes_Control_SelectedTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SelectedTree
----
*������ �������������*:
[code]
�������::SelectedTree TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree

 Tkw_SelectedAttributes_Control_SelectedTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� SelectedTree
----
*������ �������������*:
[code]
�������::SelectedTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SelectedAttributes_Control_SelectedTree_Push

 TkwEnSelectedAttributesSelectedTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenSelectedAttributes.SelectedTree }
  private
   function SelectedTree(const aCtx: TtfwContext;
    aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenSelectedAttributes.SelectedTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnSelectedAttributesSelectedTree

function Tkw_Form_SelectedAttributes.GetString: AnsiString;
begin
 Result := 'enSelectedAttributes';
end;//Tkw_Form_SelectedAttributes.GetString

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

function TkwEnSelectedAttributesSelectedTree.SelectedTree(const aCtx: TtfwContext;
 aenSelectedAttributes: TenSelectedAttributes): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenSelectedAttributes.SelectedTree }
begin
 Result := aenSelectedAttributes.SelectedTree;
end;//TkwEnSelectedAttributesSelectedTree.SelectedTree

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

initialization
 Tkw_Form_SelectedAttributes.RegisterInEngine;
 {* ����������� Tkw_Form_SelectedAttributes }
 Tkw_SelectedAttributes_Control_SelectedTree.RegisterInEngine;
 {* ����������� Tkw_SelectedAttributes_Control_SelectedTree }
 Tkw_SelectedAttributes_Control_SelectedTree_Push.RegisterInEngine;
 {* ����������� Tkw_SelectedAttributes_Control_SelectedTree_Push }
 TkwEnSelectedAttributesSelectedTree.RegisterInEngine;
 {* ����������� enSelectedAttributes_SelectedTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenSelectedAttributes));
 {* ����������� ���� TenSelectedAttributes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(NoScripts)

end.
