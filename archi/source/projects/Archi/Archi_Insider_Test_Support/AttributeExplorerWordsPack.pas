unit AttributeExplorerWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\AttributeExplorerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "AttributeExplorerWordsPack" MUID: (553109700297)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , F_AttrExplorer
 , tfwClassLike
 , tfwScriptingInterfaces
 , dt_AttrSchema
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwAttrExplorerGotoOnAttrNode = {final} class(TtfwClassLike)
  {* Слово скрипта AttrExplorer:GotoOnAttrNode }
  private
   procedure GotoOnAttrNode(const aCtx: TtfwContext;
    aAttrExplorer: TAttrExplorer;
    anAttrID: TdtAttribute);
    {* Реализация слова скрипта AttrExplorer:GotoOnAttrNode }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAttrExplorerGotoOnAttrNode

 TAttributeExplorerWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TAttributeExplorerWordsPackResNameGetter

procedure TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode(const aCtx: TtfwContext;
 aAttrExplorer: TAttrExplorer;
 anAttrID: TdtAttribute);
 {* Реализация слова скрипта AttrExplorer:GotoOnAttrNode }
//#UC START# *553109D90010_553109D90010_528A0B9E02C7_Word_var*
//#UC END# *553109D90010_553109D90010_528A0B9E02C7_Word_var*
begin
//#UC START# *553109D90010_553109D90010_528A0B9E02C7_Word_impl*
 aAttrExplorer.GotoOnAttrNode(anAttrID);
//#UC END# *553109D90010_553109D90010_528A0B9E02C7_Word_impl*
end;//TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode

class function TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister: AnsiString;
begin
 Result := 'AttrExplorer:GotoOnAttrNode';
end;//TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister

function TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo

function TkwAttrExplorerGotoOnAttrNode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwAttrExplorerGotoOnAttrNode.GetAllParamsCount

function TkwAttrExplorerGotoOnAttrNode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAttrExplorer), TypeInfo(TdtAttribute)]);
end;//TkwAttrExplorerGotoOnAttrNode.ParamsTypes

procedure TkwAttrExplorerGotoOnAttrNode.DoDoIt(const aCtx: TtfwContext);
var l_aAttrExplorer: TAttrExplorer;
var l_anAttrID: TdtAttribute;
begin
 try
  l_aAttrExplorer := TAttrExplorer(aCtx.rEngine.PopObjAs(TAttrExplorer));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAttrExplorer: TAttrExplorer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAttrID := TdtAttribute(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anAttrID: TdtAttribute : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 GotoOnAttrNode(aCtx, l_aAttrExplorer, l_anAttrID);
end;//TkwAttrExplorerGotoOnAttrNode.DoDoIt

class function TAttributeExplorerWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'AttributeExplorerWordsPack';
end;//TAttributeExplorerWordsPackResNameGetter.ResName

 {$R AttributeExplorerWordsPack.res}

initialization
 TkwAttrExplorerGotoOnAttrNode.RegisterInEngine;
 {* Регистрация AttrExplorer_GotoOnAttrNode }
 TAttributeExplorerWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttrExplorer));
 {* Регистрация типа TAttrExplorer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TdtAttribute));
 {* Регистрация типа TdtAttribute }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
