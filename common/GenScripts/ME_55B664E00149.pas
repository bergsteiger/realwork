unit archiDocEditorWindowWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\archiDocEditorWindowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "archiDocEditorWindowWordsPack" MUID: (55B664E00149)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

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
 {$If Defined(AppClientSide)}
 , Editwin
 {$IfEnd} // Defined(AppClientSide)
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwDocEditorWindowIsNeedSaveDocument = {final} class(TtfwClassLike)
  {* Слово скрипта DocEditorWindow:IsNeedSaveDocument }
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

 TarchiDocEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TarchiDocEditorWindowWordsPackResNameGetter

function TkwDocEditorWindowIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
 aDocEditorWindow: TDocEditorWindow): Boolean;
 {* Реализация слова скрипта DocEditorWindow:IsNeedSaveDocument }
//#UC START# *55B6651703CB_1E0CF5C9A3AF_var*
//#UC END# *55B6651703CB_1E0CF5C9A3AF_var*
begin
//#UC START# *55B6651703CB_1E0CF5C9A3AF_impl*
 Result := aDocEditorWindow.IsNeedSaveDocument;
//#UC END# *55B6651703CB_1E0CF5C9A3AF_impl*
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

class function TarchiDocEditorWindowWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'archiDocEditorWindowWordsPack';
end;//TarchiDocEditorWindowWordsPackResNameGetter.ResName

 {$R archiDocEditorWindowWordsPack.res}

initialization
 TkwDocEditorWindowIsNeedSaveDocument.RegisterInEngine;
 {* Регистрация DocEditorWindow_IsNeedSaveDocument }
 TarchiDocEditorWindowWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDocEditorWindow));
 {* Регистрация типа TDocEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
