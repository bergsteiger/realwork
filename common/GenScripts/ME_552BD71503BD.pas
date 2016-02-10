unit PictureEtalonsWorkingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwEnabledSaveRTFPictures = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EnabledSaveRTFPictures
[panel]Включить режим сохранения картинок при импорте из RTF/DOC/DOCX. Нужно вызывать перед каждой выливкой из RTF, т.к.флаг сбрасывается.[panel]
*Пример:*
[code]
 EnabledSaveRTFPictures
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEnabledSaveRTFPictures

 TkwGeneratePDFForEtalon = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GeneratePDFForEtalon
[panel]*Формат*:
[code]
aFlag GeneratePDFForEtalon
[code]
где aFlag - true или false.
Включить/выключить режим генерации текстового PDF, который удобно использовать для сравнения. Нужно выставлять при каждом экспорте, т.к.флаг сбрасывается в False.[panel]
*Пример:*
[code]
 aValue GeneratePDFForEtalon
[code]  }
  private
   procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
    aValue: Boolean);
    {* Реализация слова скрипта GeneratePDFForEtalon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratePDFForEtalon

procedure TkwEnabledSaveRTFPictures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0624C398EE8C_var*
//#UC END# *4DAEEDE10285_0624C398EE8C_var*
begin
//#UC START# *4DAEEDE10285_0624C398EE8C_impl*
 Tl3PicturePathService.Instance.SetEnableSave(true);
//#UC END# *4DAEEDE10285_0624C398EE8C_impl*
end;//TkwEnabledSaveRTFPictures.DoDoIt

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

procedure TkwGeneratePDFForEtalon.GeneratePDFForEtalon(const aCtx: TtfwContext;
 aValue: Boolean);
 {* Реализация слова скрипта GeneratePDFForEtalon }
//#UC START# *03229B3839D8_8682318410BD_var*
//#UC END# *03229B3839D8_8682318410BD_var*
begin
//#UC START# *03229B3839D8_8682318410BD_impl*
 Tl3PicturePathService.Instance.SetPDF4Etalon(aValue);
//#UC END# *03229B3839D8_8682318410BD_impl*
end;//TkwGeneratePDFForEtalon.GeneratePDFForEtalon

procedure TkwGeneratePDFForEtalon.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8682318410BD_var*
//#UC END# *4DAEEDE10285_8682318410BD_var*
begin
//#UC START# *4DAEEDE10285_8682318410BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8682318410BD_impl*
end;//TkwGeneratePDFForEtalon.DoDoIt

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
//#UC START# *5617F4D00243_8682318410BD_var*
//#UC END# *5617F4D00243_8682318410BD_var*
begin
//#UC START# *5617F4D00243_8682318410BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8682318410BD_impl*
end;//TkwGeneratePDFForEtalon.ParamsTypes

initialization
 TkwEnabledSaveRTFPictures.RegisterInEngine;
 {* Регистрация EnabledSaveRTFPictures }
 TkwGeneratePDFForEtalon.RegisterInEngine;
 {* Регистрация GeneratePDFForEtalon }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
