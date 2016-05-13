unit vtComboTreeWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\vtComboTreeWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "vtComboTreeWordsPack" MUID: (55B782940096)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopComboTreeCurrentNode = {final} class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:CurrentNode }
  private
   function CurrentNode(const aCtx: TtfwContext;
    aComboTree: TvtComboTree): Il3SimpleNode;
    {* ���������� ����� ������� pop:ComboTree:CurrentNode }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComboTreeCurrentNode

function TkwPopComboTreeCurrentNode.CurrentNode(const aCtx: TtfwContext;
 aComboTree: TvtComboTree): Il3SimpleNode;
 {* ���������� ����� ������� pop:ComboTree:CurrentNode }
//#UC START# *55B783230053_55B783230053_55B780E60398_Word_var*
//#UC END# *55B783230053_55B783230053_55B780E60398_Word_var*
begin
//#UC START# *55B783230053_55B783230053_55B780E60398_Word_impl*
 Result := aComboTree.Tree.GetCurrentNode;
//#UC END# *55B783230053_55B783230053_55B780E60398_Word_impl*
end;//TkwPopComboTreeCurrentNode.CurrentNode

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

procedure TkwPopComboTreeCurrentNode.DoDoIt(const aCtx: TtfwContext);
var l_aComboTree: TvtComboTree;
begin
 try
  l_aComboTree := TvtComboTree(aCtx.rEngine.PopObjAs(TvtComboTree));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComboTree: TvtComboTree : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(CurrentNode(aCtx, l_aComboTree), TypeInfo(Il3SimpleNode));
end;//TkwPopComboTreeCurrentNode.DoDoIt

initialization
 TkwPopComboTreeCurrentNode.RegisterInEngine;
 {* ����������� pop_ComboTree_CurrentNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboTree));
 {* ����������� ���� TvtComboTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
 {* ����������� ���� Il3SimpleNode }
{$IfEnd} // NOT Defined(NoScripts)

end.
