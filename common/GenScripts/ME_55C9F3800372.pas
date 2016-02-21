unit TTreeNodeForTestsWordsPack;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , ComCtrls
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , FolderSupport
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *CE36BAE2E068ci*
 //#UC END# *CE36BAE2E068ci*
 //#UC START# *CE36BAE2E068cit*
 //#UC END# *CE36BAE2E068cit*
 TTTreeNodeForTestsWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *CE36BAE2E068publ*
 //#UC END# *CE36BAE2E068publ*
 end;//TTTreeNodeForTestsWordsPackResNameGetter

 TkwPopTreeNodeIsNodeFolder = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:IsNodeFolder
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTreeNode pop:TreeNode:IsNodeFolder >>> l_Boolean
[code]  }
  private
   function IsNodeFolder(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
    {* Реализация слова скрипта pop:TreeNode:IsNodeFolder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeIsNodeFolder

class function TTTreeNodeForTestsWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'TTreeNodeForTestsWordsPack';
end;//TTTreeNodeForTestsWordsPackResNameGetter.ResName

 {$R TTreeNodeForTestsWordsPack.res}

function TkwPopTreeNodeIsNodeFolder.IsNodeFolder(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): Boolean;
 {* Реализация слова скрипта pop:TreeNode:IsNodeFolder }
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
   RunnerError('Ошибка при получении параметра aTreeNode: TTreeNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNodeFolder(aCtx, l_aTreeNode));
end;//TkwPopTreeNodeIsNodeFolder.DoDoIt

class function TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TreeNode:IsNodeFolder';
end;//TkwPopTreeNodeIsNodeFolder.GetWordNameForRegister

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

initialization
 TTTreeNodeForTestsWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopTreeNodeIsNodeFolder.RegisterInEngine;
 {* Регистрация pop_TreeNode_IsNodeFolder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
