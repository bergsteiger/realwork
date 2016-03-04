unit vtComboTreeWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vtComboTree
 , tfwClassLike
 , l3TreeInterfaces
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopComboTreeCurrentNode = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ComboTree:CurrentNode
*Тип результата:* Il3SimpleNode
*Пример:*
[code]
INTERFACE VAR l_Il3SimpleNode
 aComboTree pop:ComboTree:CurrentNode >>> l_Il3SimpleNode
[code]  }
  private
   function CurrentNode(const aCtx: TtfwContext;
    aComboTree: TvtComboTree): Il3SimpleNode;
    {* Реализация слова скрипта pop:ComboTree:CurrentNode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeCurrentNode

function TkwPopComboTreeCurrentNode.CurrentNode(const aCtx: TtfwContext;
 aComboTree: TvtComboTree): Il3SimpleNode;
 {* Реализация слова скрипта pop:ComboTree:CurrentNode }
//#UC START# *E52B39199FD5_9F9FF0616B3E_var*
//#UC END# *E52B39199FD5_9F9FF0616B3E_var*
begin
//#UC START# *E52B39199FD5_9F9FF0616B3E_impl*
 Result := aComboTree.Tree.GetCurrentNode;
//#UC END# *E52B39199FD5_9F9FF0616B3E_impl*
end;//TkwPopComboTreeCurrentNode.CurrentNode

procedure TkwPopComboTreeCurrentNode.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(CurrentNode(aCtx, l_aComboTree), TypeInfo(Il3SimpleNode));
end;//TkwPopComboTreeCurrentNode.DoDoIt

class function TkwPopComboTreeCurrentNode.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ComboTree:CurrentNode';
end;//TkwPopComboTreeCurrentNode.GetWordNameForRegister

function TkwPopComboTreeCurrentNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Il3SimpleNode);
end;//TkwPopComboTreeCurrentNode.GetResultTypeInfo

function TkwPopComboTreeCurrentNode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComboTreeCurrentNode.GetAllParamsCount

function TkwPopComboTreeCurrentNode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtComboTree)]);
end;//TkwPopComboTreeCurrentNode.ParamsTypes

initialization
 TkwPopComboTreeCurrentNode.RegisterInEngine;
 {* Регистрация pop_ComboTree_CurrentNode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboTree));
 {* Регистрация типа TvtComboTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
 {* Регистрация типа Il3SimpleNode }
{$IfEnd} // NOT Defined(NoScripts)

end.
