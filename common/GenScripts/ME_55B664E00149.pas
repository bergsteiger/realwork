unit archiDocEditorWindowWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\archiDocEditorWindowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(AppClientSide)}
 , Editwin
 {$IfEnd} // Defined(AppClientSide)
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *BB908F7F3619ci*
 //#UC END# *BB908F7F3619ci*
 //#UC START# *BB908F7F3619cit*
 //#UC END# *BB908F7F3619cit*
 TarchiDocEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *BB908F7F3619publ*
 //#UC END# *BB908F7F3619publ*
 end;//TarchiDocEditorWindowWordsPackResNameGetter

 TkwDocEditorWindowIsNeedSaveDocument = {final} class(TtfwClassLike)
  {* Слово скрипта DocEditorWindow:IsNeedSaveDocument
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDocEditorWindow DocEditorWindow:IsNeedSaveDocument >>> l_Boolean
[code]  }
  private
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aDocEditorWindow: TDocEditorWindow): Boolean;
    {* Реализация слова скрипта DocEditorWindow:IsNeedSaveDocument }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDocEditorWindowIsNeedSaveDocument

class function TarchiDocEditorWindowWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'archiDocEditorWindowWordsPack';
end;//TarchiDocEditorWindowWordsPackResNameGetter.ResName

 {$R archiDocEditorWindowWordsPack.res}

function TkwDocEditorWindowIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
 aDocEditorWindow: TDocEditorWindow): Boolean;
 {* Реализация слова скрипта DocEditorWindow:IsNeedSaveDocument }
//#UC START# *632EECFCBB72_1E0CF5C9A3AF_var*
//#UC END# *632EECFCBB72_1E0CF5C9A3AF_var*
begin
//#UC START# *632EECFCBB72_1E0CF5C9A3AF_impl*
 Result := aDocEditorWindow.IsNeedSaveDocument;
//#UC END# *632EECFCBB72_1E0CF5C9A3AF_impl*
end;//TkwDocEditorWindowIsNeedSaveDocument.IsNeedSaveDocument

procedure TkwDocEditorWindowIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
var l_aDocEditorWindow: TDocEditorWindow;
begin
 try
  l_aDocEditorWindow := TDocEditorWindow(aCtx.rEngine.PopObjAs(TDocEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDocEditorWindow: TDocEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNeedSaveDocument(aCtx, l_aDocEditorWindow));
end;//TkwDocEditorWindowIsNeedSaveDocument.DoDoIt

class function TkwDocEditorWindowIsNeedSaveDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'DocEditorWindow:IsNeedSaveDocument';
end;//TkwDocEditorWindowIsNeedSaveDocument.GetWordNameForRegister

function TkwDocEditorWindowIsNeedSaveDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwDocEditorWindowIsNeedSaveDocument.GetResultTypeInfo

function TkwDocEditorWindowIsNeedSaveDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDocEditorWindowIsNeedSaveDocument.GetAllParamsCount

function TkwDocEditorWindowIsNeedSaveDocument.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDocEditorWindow)]);
end;//TkwDocEditorWindowIsNeedSaveDocument.ParamsTypes

initialization
 TarchiDocEditorWindowWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwDocEditorWindowIsNeedSaveDocument.RegisterInEngine;
 {* Регистрация DocEditorWindow_IsNeedSaveDocument }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocEditorWindow));
 {* Регистрация типа TDocEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
