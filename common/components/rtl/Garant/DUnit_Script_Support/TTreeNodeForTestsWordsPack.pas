unit TTreeNodeForTestsWordsPack;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\TTreeNodeForTestsWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TTreeNodeForTestsWordsPack" MUID: (55C9F3800372)

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
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopTreeNodeIsNodeFolder = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TreeNode:IsNodeFolder }
  private
   function IsNodeFolder(const aCtx: TtfwContext;
    aTreeNode: TTreeNode): Boolean;
    {* Реализация слова скрипта pop:TreeNode:IsNodeFolder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTreeNodeIsNodeFolder

 TTTreeNodeForTestsWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TTTreeNodeForTestsWordsPackResNameGetter

function TkwPopTreeNodeIsNodeFolder.IsNodeFolder(const aCtx: TtfwContext;
 aTreeNode: TTreeNode): Boolean;
 {* Реализация слова скрипта pop:TreeNode:IsNodeFolder }
//#UC START# *55C9F3B6011B_55C9F3B6011B_512F3FCB02F3_Word_var*
//#UC END# *55C9F3B6011B_55C9F3B6011B_512F3FCB02F3_Word_var*
begin
//#UC START# *55C9F3B6011B_55C9F3B6011B_512F3FCB02F3_Word_impl*
 Result := FolderSupport.IsNodeFolder(aTreeNode);
//#UC END# *55C9F3B6011B_55C9F3B6011B_512F3FCB02F3_Word_impl*
end;//TkwPopTreeNodeIsNodeFolder.IsNodeFolder

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

class function TTTreeNodeForTestsWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'TTreeNodeForTestsWordsPack';
end;//TTTreeNodeForTestsWordsPackResNameGetter.ResName

 {$R TTreeNodeForTestsWordsPack.res}

initialization
 TkwPopTreeNodeIsNodeFolder.RegisterInEngine;
 {* Регистрация pop_TreeNode_IsNodeFolder }
 TTTreeNodeForTestsWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTreeNode));
 {* Регистрация типа TTreeNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
