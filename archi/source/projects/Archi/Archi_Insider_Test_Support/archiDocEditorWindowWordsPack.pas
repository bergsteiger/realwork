unit archiDocEditorWindowWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Insider Test Support"
// Модуль: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/archiDocEditorWindowWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::archiDocEditorWindowWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwScriptingInterfaces
  {$If defined(AppClientSide)}
  ,
  Editwin
  {$IfEnd} //AppClientSide
  ,
  tfwRegisterableWord,
  tfwAxiomaticsResNameGetter
  ;

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *BB908F7F3619ci*
//#UC END# *BB908F7F3619ci*
 TarchiDocEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *BB908F7F3619publ*
//#UC END# *BB908F7F3619publ*
 end;//TarchiDocEditorWindowWordsPackResNameGetter

// start class TarchiDocEditorWindowWordsPackResNameGetter

class function TarchiDocEditorWindowWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'archiDocEditorWindowWordsPack';
end;//TarchiDocEditorWindowWordsPackResNameGetter.ResName

 {$R archiDocEditorWindowWordsPack.res archiDocEditorWindowWordsPack.rc}

type
 TkwDocEditorWindowIsNeedSaveDocument = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта DocEditorWindow:IsNeedSaveDocument
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDocEditorWindow DocEditorWindow:IsNeedSaveDocument >>> l_Boolean
[code]  }
 private
 // private methods
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aDocEditorWindow: TDocEditorWindow): Boolean;
     {* Реализация слова скрипта DocEditorWindow:IsNeedSaveDocument }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwDocEditorWindowIsNeedSaveDocument

// start class TkwDocEditorWindowIsNeedSaveDocument

function TkwDocEditorWindowIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
  aDocEditorWindow: TDocEditorWindow): Boolean;
//#UC START# *632EECFCBB72_1E0CF5C9A3AF_var*
//#UC END# *632EECFCBB72_1E0CF5C9A3AF_var*
begin
//#UC START# *632EECFCBB72_1E0CF5C9A3AF_impl*
 Result := aDocEditorWindow.IsNeedSaveDocument;
//#UC END# *632EECFCBB72_1E0CF5C9A3AF_impl*
end;//TkwDocEditorWindowIsNeedSaveDocument.IsNeedSaveDocument

procedure TkwDocEditorWindowIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDocEditorWindow : TDocEditorWindow;
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
 aCtx.rEngine.PushBool((IsNeedSaveDocument(aCtx, l_aDocEditorWindow)));
end;//TkwDocEditorWindowIsNeedSaveDocument.DoDoIt

class function TkwDocEditorWindowIsNeedSaveDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DocEditorWindow:IsNeedSaveDocument';
end;//TkwDocEditorWindowIsNeedSaveDocument.GetWordNameForRegister

function TkwDocEditorWindowIsNeedSaveDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwDocEditorWindowIsNeedSaveDocument.GetResultTypeInfo
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TarchiDocEditorWindowWordsPackResNameGetter.Register;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация DocEditorWindow_IsNeedSaveDocument
 TkwDocEditorWindowIsNeedSaveDocument.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация типа TDocEditorWindow
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocEditorWindow));
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.