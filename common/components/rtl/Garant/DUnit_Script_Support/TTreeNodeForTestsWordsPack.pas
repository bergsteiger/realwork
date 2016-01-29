unit TTreeNodeForTestsWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DUnit Script Support"
// ������: "w:/common/components/rtl/Garant/DUnit_Script_Support/TTreeNodeForTestsWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi Testing Framework::DUnit Script Support::DUnit Keywords::TTreeNodeForTestsWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\DUnit_Script_Support\dsDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
uses
  ComCtrls,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

implementation

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
uses
  FolderSupport,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *CE36BAE2E068ci*
//#UC END# *CE36BAE2E068ci*
//#UC START# *CE36BAE2E068cit*
//#UC END# *CE36BAE2E068cit*
 TTTreeNodeForTestsWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *CE36BAE2E068publ*
//#UC END# *CE36BAE2E068publ*
 end;//TTTreeNodeForTestsWordsPackResNameGetter

// start class TTTreeNodeForTestsWordsPackResNameGetter

class function TTTreeNodeForTestsWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'TTreeNodeForTestsWordsPack';
end;//TTTreeNodeForTestsWordsPackResNameGetter.ResName

 {$R TTreeNodeForTestsWordsPack.res}

type
 TkwPopTreeNodeIsNodeFolder = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:TreeNode:IsNodeFolder
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:IsNodeFolder >>> l_Boolean
[code]  }
 private
 // private methods
   function IsNodeFolder(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
     {* ���������� ����� ������� pop:TreeNode:IsNodeFolder }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeIsNodeFolder

// start class TkwPopTreeNodeIsNodeFolder

function TkwPopTreeNodeIsNodeFolder.IsNodeFolder(const aCtx: TtfwContext;
  aTreeNode: TTreeNode): Boolean;
//#UC START# *B5879A320542_565CDF98FF94_var*
//#UC END# *B5879A320542_565CDF98FF94_var*
begin
//#UC START# *B5879A320542_565CDF98FF94_impl*
 Result := FolderSupport.IsNodeFolder(aTreeNode);
//#UC END# *B5879A320542_565CDF98FF94_impl*
end;//TkwPopTreeNodeIsNodeFolder.IsNodeFolder

procedure TkwPopTreeNodeIsNodeFolder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTreeNode : TTreeNode;
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
 aCtx.rEngine.PushBool((IsNodeFolder(aCtx, l_aTreeNode)));
end;//TkwPopTreeNodeIsNodeFolder.DoDoIt

class function TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TreeNode:IsNodeFolder';
end;//TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister

function TkwPopTreeNodeIsNodeFolder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTreeNodeIsNodeFolder.GetResultTypeInfo

function TkwPopTreeNodeIsNodeFolder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopTreeNodeIsNodeFolder.GetAllParamsCount

function TkwPopTreeNodeIsNodeFolder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TTreeNode)]);
end;//TkwPopTreeNodeIsNodeFolder.ParamsTypes
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ������������ �����������
 TTTreeNodeForTestsWordsPackResNameGetter.Register;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// ����������� pop_TreeNode_IsNodeFolder
 TkwPopTreeNodeIsNodeFolder.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� TTreeNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCL)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //nsTest AND not NoScripts AND not NoVCL

end.