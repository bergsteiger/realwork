unit TTreeNodeForTestsWordsPack;

// ������: "w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TTreeNodeForTestsWordsPack" MUID: (55C9F3800372)

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ComCtrls
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , FolderSupport
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwPopTreeNodeIsNodeFolder = {final} class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:IsNodeFolder
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:IsNodeFolder >>> l_Boolean
[code]  }
  private
   function IsNodeFolder(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
    {* ���������� ����� ������� pop:TreeNode:IsNodeFolder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeIsNodeFolder

 TTTreeNodeForTestsWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TTTreeNodeForTestsWordsPackResNameGetter

function TkwPopTreeNodeIsNodeFolder.IsNodeFolder(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): Boolean;
 {* ���������� ����� ������� pop:TreeNode:IsNodeFolder }
//#UC START# *B5879A320542_565CDF98FF94_var*
//#UC END# *B5879A320542_565CDF98FF94_var*
begin
//#UC START# *B5879A320542_565CDF98FF94_impl*
 Result := FolderSupport.IsNodeFolder(aTreeNode);
//#UC END# *B5879A320542_565CDF98FF94_impl*
end;//TkwPopTreeNodeIsNodeFolder.IsNodeFolder

procedure TkwPopTreeNodeIsNodeFolder.DoDoIt(const aCtx: TtfwContext);
var l_aTreeNode: TTreeNode;
begin
 try
  l_aTreeNode := TTreeNode(aCtx.rEngine.PopObjAs(TTreeNode));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNodeFolder(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeIsNodeFolder.DoDoIt

function TkwPopTreeNodeIsNodeFolder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTreeNodeIsNodeFolder.GetResultTypeInfo

function TkwPopTreeNodeIsNodeFolder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTreeNodeIsNodeFolder.GetAllParamsCount

function TkwPopTreeNodeIsNodeFolder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeIsNodeFolder.ParamsTypes

class function TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:IsNodeFolder';
end;//TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister

class function TTTreeNodeForTestsWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'TTreeNodeForTestsWordsPack';
end;//TTTreeNodeForTestsWordsPackResNameGetter.ResName

 {$R TTreeNodeForTestsWordsPack.res}

initialization
 TkwPopTreeNodeIsNodeFolder.RegisterInEngine;
 {* ����������� pop_TreeNode_IsNodeFolder }
 TTTreeNodeForTestsWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* ����������� ���� TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
