unit archiEditorWindowWordsPack;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\archiEditorWindowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EdWin
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *39046F3AEE5Aci*
 //#UC END# *39046F3AEE5Aci*
 //#UC START# *39046F3AEE5Acit*
 //#UC END# *39046F3AEE5Acit*
 TarchiEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *39046F3AEE5Apubl*
 //#UC END# *39046F3AEE5Apubl*
 end;//TarchiEditorWindowWordsPackResNameGetter

 TkwIsNeedSaveDocument = {final} class(TtfwClassLike)
  {* Слово скрипта IsNeedSaveDocument
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor IsNeedSaveDocument >>> l_Boolean
[code]  }
  private
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aEditor: TEditorWindow): Boolean;
    {* Реализация слова скрипта IsNeedSaveDocument }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsNeedSaveDocument

class function TarchiEditorWindowWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'archiEditorWindowWordsPack';
end;//TarchiEditorWindowWordsPackResNameGetter.ResName

 {$R archiEditorWindowWordsPack.res}

function TkwIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
 aEditor: TEditorWindow): Boolean;
 {* Реализация слова скрипта IsNeedSaveDocument }
//#UC START# *5BBB7C35D3A8_BB6D8477DC61_var*
//#UC END# *5BBB7C35D3A8_BB6D8477DC61_var*
begin
//#UC START# *5BBB7C35D3A8_BB6D8477DC61_impl*
 Result := aEditor.IsNeedSaveDocument;
//#UC END# *5BBB7C35D3A8_BB6D8477DC61_impl*
end;//TkwIsNeedSaveDocument.IsNeedSaveDocument

procedure TkwIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB6D8477DC61_var*
//#UC END# *4DAEEDE10285_BB6D8477DC61_var*
begin
//#UC START# *4DAEEDE10285_BB6D8477DC61_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB6D8477DC61_impl*
end;//TkwIsNeedSaveDocument.DoDoIt

class function TkwIsNeedSaveDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsNeedSaveDocument';
end;//TkwIsNeedSaveDocument.GetWordNameForRegister

function TkwIsNeedSaveDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsNeedSaveDocument.GetResultTypeInfo

function TkwIsNeedSaveDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsNeedSaveDocument.GetAllParamsCount

function TkwIsNeedSaveDocument.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BB6D8477DC61_var*
//#UC END# *5617F4D00243_BB6D8477DC61_var*
begin
//#UC START# *5617F4D00243_BB6D8477DC61_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BB6D8477DC61_impl*
end;//TkwIsNeedSaveDocument.ParamsTypes

initialization
 TarchiEditorWindowWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwIsNeedSaveDocument.RegisterInEngine;
 {* Регистрация IsNeedSaveDocument }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditorWindow));
 {* Регистрация типа TEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
