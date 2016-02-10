unit AttributeExplorerWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\AttributeExplorerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , F_AttrExplorer
 , dt_AttrSchema
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *83014FAE4406ci*
 //#UC END# *83014FAE4406ci*
 //#UC START# *83014FAE4406cit*
 //#UC END# *83014FAE4406cit*
 TAttributeExplorerWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *83014FAE4406publ*
 //#UC END# *83014FAE4406publ*
 end;//TAttributeExplorerWordsPackResNameGetter

 TkwAttrExplorerGotoOnAttrNode = {final} class(TtfwClassLike)
  {* Слово скрипта AttrExplorer:GotoOnAttrNode
[panel]Формат: aNumberAttribute aControl AttributeExplorer:GotoOnAttrNode
где aNumberAttribute - номер атрибута, а aControl - форма TAttrExplorer.
Пример:
[code]
TdtAttribute::atKeyWords "Контрол по имени [('otlAttributes')]- в стек" pop:Component:Owner AttributeExplorer:GotoOnAttrNode
[code][panel]
*Пример:*
[code]
 anAttrID aAttrExplorer AttrExplorer:GotoOnAttrNode
[code]  }
  private
   procedure GotoOnAttrNode(const aCtx: TtfwContext;
    aAttrExplorer: TAttrExplorer;
    anAttrID: TdtAttribute);
    {* Реализация слова скрипта AttrExplorer:GotoOnAttrNode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAttrExplorerGotoOnAttrNode

class function TAttributeExplorerWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'AttributeExplorerWordsPack';
end;//TAttributeExplorerWordsPackResNameGetter.ResName

 {$R AttributeExplorerWordsPack.res}

procedure TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode(const aCtx: TtfwContext;
 aAttrExplorer: TAttrExplorer;
 anAttrID: TdtAttribute);
 {* Реализация слова скрипта AttrExplorer:GotoOnAttrNode }
//#UC START# *986AD64514D6_50112451BECA_var*
//#UC END# *986AD64514D6_50112451BECA_var*
begin
//#UC START# *986AD64514D6_50112451BECA_impl*
 aAttrExplorer.GotoOnAttrNode(anAttrID);
//#UC END# *986AD64514D6_50112451BECA_impl*
end;//TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode

procedure TkwAttrExplorerGotoOnAttrNode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50112451BECA_var*
//#UC END# *4DAEEDE10285_50112451BECA_var*
begin
//#UC START# *4DAEEDE10285_50112451BECA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_50112451BECA_impl*
end;//TkwAttrExplorerGotoOnAttrNode.DoDoIt

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
 Result := OpenTypesToTypes([TypeInfo(TdtAttribute)]);
end;//TkwAttrExplorerGotoOnAttrNode.ParamsTypes

initialization
 TAttributeExplorerWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwAttrExplorerGotoOnAttrNode.RegisterInEngine;
 {* Регистрация AttrExplorer_GotoOnAttrNode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttrExplorer));
 {* Регистрация типа TAttrExplorer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TdtAttribute));
 {* Регистрация типа TdtAttribute }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
