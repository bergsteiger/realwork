unit FoldersTreeKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� FoldersTree }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersTreeKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimFolders_Module
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_FoldersTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� FoldersTree
----
*������ �������������*:
[code]
'aControl' �����::FoldersTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FoldersTree
----
*������ �������������*:
[code]
�������::FoldersTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersTree_Control_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FoldersTree
----
*������ �������������*:
[code]
�������::FoldersTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersTree_Control_FoldersTree_Push

 TkwEnFoldersTreeFoldersTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenFoldersTree.FoldersTree
[panel]������� FoldersTree ����� TenFoldersTree[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFoldersTree .TenFoldersTree.FoldersTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FoldersTree(const aCtx: TtfwContext;
    aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenFoldersTree.FoldersTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersTreeFoldersTree

class function Tkw_Form_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::FoldersTree';
end;//Tkw_Form_FoldersTree.GetWordNameForRegister

function Tkw_Form_FoldersTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C806163015DD_var*
//#UC END# *4DDFD2EA0116_C806163015DD_var*
begin
//#UC START# *4DDFD2EA0116_C806163015DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C806163015DD_impl*
end;//Tkw_Form_FoldersTree.GetString

class function Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister

function Tkw_FoldersTree_Control_FoldersTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_93FE3A926428_var*
//#UC END# *4DDFD2EA0116_93FE3A926428_var*
begin
//#UC START# *4DDFD2EA0116_93FE3A926428_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_93FE3A926428_impl*
end;//Tkw_FoldersTree_Control_FoldersTree.GetString

class procedure Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
//#UC START# *52A086150180_93FE3A926428_var*
//#UC END# *52A086150180_93FE3A926428_var*
begin
//#UC START# *52A086150180_93FE3A926428_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_93FE3A926428_impl*
end;//Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine

procedure Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EF0DEE51AEA8_var*
//#UC END# *4DAEEDE10285_EF0DEE51AEA8_var*
begin
//#UC START# *4DAEEDE10285_EF0DEE51AEA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EF0DEE51AEA8_impl*
end;//Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt

class function Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FoldersTree:push';
end;//Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister

function TkwEnFoldersTreeFoldersTree.FoldersTree(const aCtx: TtfwContext;
 aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenFoldersTree.FoldersTree }
//#UC START# *3DBC8AEEF2BE_6BEE06997D28_var*
//#UC END# *3DBC8AEEF2BE_6BEE06997D28_var*
begin
//#UC START# *3DBC8AEEF2BE_6BEE06997D28_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DBC8AEEF2BE_6BEE06997D28_impl*
end;//TkwEnFoldersTreeFoldersTree.FoldersTree

procedure TkwEnFoldersTreeFoldersTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6BEE06997D28_var*
//#UC END# *4DAEEDE10285_6BEE06997D28_var*
begin
//#UC START# *4DAEEDE10285_6BEE06997D28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6BEE06997D28_impl*
end;//TkwEnFoldersTreeFoldersTree.DoDoIt

class function TkwEnFoldersTreeFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersTree.FoldersTree';
end;//TkwEnFoldersTreeFoldersTree.GetWordNameForRegister

procedure TkwEnFoldersTreeFoldersTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnFoldersTreeFoldersTree.SetValuePrim

function TkwEnFoldersTreeFoldersTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFoldersTreeFoldersTree.GetResultTypeInfo

function TkwEnFoldersTreeFoldersTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersTreeFoldersTree.GetAllParamsCount

function TkwEnFoldersTreeFoldersTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnFoldersTreeFoldersTree.ParamsTypes

initialization
 Tkw_Form_FoldersTree.RegisterInEngine;
 {* ����������� Tkw_Form_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
 {* ����������� Tkw_FoldersTree_Control_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree_Push.RegisterInEngine;
 {* ����������� Tkw_FoldersTree_Control_FoldersTree_Push }
 TkwEnFoldersTreeFoldersTree.RegisterInEngine;
 {* ����������� enFoldersTree_FoldersTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersTree));
 {* ����������� ���� FoldersTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
