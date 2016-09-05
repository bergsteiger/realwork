unit archiEditorWindowWordsPack;

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\archiEditorWindowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "archiEditorWindowWordsPack" MUID: (55B665AE01A8)

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EdWin
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55B665AE01A8impl_uses*
 //#UC END# *55B665AE01A8impl_uses*
;

type
 TkwIsNeedSaveDocument = {final} class(TtfwClassLike)
  {* Слово скрипта IsNeedSaveDocument }
  private
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aEditor: TEditorWindow): Boolean;
    {* Реализация слова скрипта IsNeedSaveDocument }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsNeedSaveDocument

 TarchiEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TarchiEditorWindowWordsPackResNameGetter

function TkwIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
 aEditor: TEditorWindow): Boolean;
 {* Реализация слова скрипта IsNeedSaveDocument }
//#UC START# *55B665ED0380_55B665ED0380_5146CA34003E_Word_var*
//#UC END# *55B665ED0380_55B665ED0380_5146CA34003E_Word_var*
begin
//#UC START# *55B665ED0380_55B665ED0380_5146CA34003E_Word_impl*
 Result := aEditor.IsNeedSaveDocument;
//#UC END# *55B665ED0380_55B665ED0380_5146CA34003E_Word_impl*
end;//TkwIsNeedSaveDocument.IsNeedSaveDocument

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
begin
 Result := OpenTypesToTypes([TypeInfo(TEditorWindow)]);
end;//TkwIsNeedSaveDocument.ParamsTypes

procedure TkwIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TEditorWindow;
begin
 try
  l_aEditor := TEditorWindow(aCtx.rEngine.PopObjAs(TEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNeedSaveDocument(aCtx, l_aEditor));
end;//TkwIsNeedSaveDocument.DoDoIt

class function TarchiEditorWindowWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'archiEditorWindowWordsPack';
end;//TarchiEditorWindowWordsPackResNameGetter.ResName

{$R archiEditorWindowWordsPack.res}

initialization
 TkwIsNeedSaveDocument.RegisterInEngine;
 {* Регистрация IsNeedSaveDocument }
 TarchiEditorWindowWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditorWindow));
 {* Регистрация типа TEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
