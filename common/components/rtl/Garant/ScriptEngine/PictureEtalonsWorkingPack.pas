unit PictureEtalonsWorkingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PictureEtalonsWorkingPack" MUID: (552BD71503BD)

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
 , tfwGlobalKeyWord
 , TypInfo
 , tfwScriptingInterfaces
 , l3PicturePathService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnabledSaveRTFPictures = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EnabledSaveRTFPictures }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnabledSaveRTFPictures

 TkwGeneratePDFForEtalon = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GeneratePDFForEtalon }
  private
   procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
    aValue: Boolean);
    {* Реализация слова скрипта GeneratePDFForEtalon }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratePDFForEtalon

class function TkwEnabledSaveRTFPictures.GetWordNameForRegister: AnsiString;
begin
 Result := 'EnabledSaveRTFPictures';
end;//TkwEnabledSaveRTFPictures.GetWordNameForRegister

function TkwEnabledSaveRTFPictures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEnabledSaveRTFPictures.GetResultTypeInfo

function TkwEnabledSaveRTFPictures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEnabledSaveRTFPictures.GetAllParamsCount

function TkwEnabledSaveRTFPictures.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnabledSaveRTFPictures.ParamsTypes

procedure TkwEnabledSaveRTFPictures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_552BD761009D_Word_var*
//#UC END# *4DAEEDE10285_552BD761009D_Word_var*
begin
//#UC START# *4DAEEDE10285_552BD761009D_Word_impl*
 Tl3PicturePathService.Instance.SetEnableSave(true);
//#UC END# *4DAEEDE10285_552BD761009D_Word_impl*
end;//TkwEnabledSaveRTFPictures.DoDoIt

procedure TkwGeneratePDFForEtalon.GeneratePDFForEtalon(const aCtx: TtfwContext;
 aValue: Boolean);
 {* Реализация слова скрипта GeneratePDFForEtalon }
//#UC START# *552BD7870165_552BD7870165_Word_var*
//#UC END# *552BD7870165_552BD7870165_Word_var*
begin
//#UC START# *552BD7870165_552BD7870165_Word_impl*
 Tl3PicturePathService.Instance.SetPDF4Etalon(aValue);
//#UC END# *552BD7870165_552BD7870165_Word_impl*
end;//TkwGeneratePDFForEtalon.GeneratePDFForEtalon

class function TkwGeneratePDFForEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'GeneratePDFForEtalon';
end;//TkwGeneratePDFForEtalon.GetWordNameForRegister

function TkwGeneratePDFForEtalon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGeneratePDFForEtalon.GetResultTypeInfo

function TkwGeneratePDFForEtalon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwGeneratePDFForEtalon.GetAllParamsCount

function TkwGeneratePDFForEtalon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwGeneratePDFForEtalon.ParamsTypes

procedure TkwGeneratePDFForEtalon.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Boolean;
begin
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 GeneratePDFForEtalon(aCtx, l_aValue);
end;//TkwGeneratePDFForEtalon.DoDoIt

initialization
 TkwEnabledSaveRTFPictures.RegisterInEngine;
 {* Регистрация EnabledSaveRTFPictures }
 TkwGeneratePDFForEtalon.RegisterInEngine;
 {* Регистрация GeneratePDFForEtalon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
