unit kwPopEditorInsertStream;
 {* *Формат:* aFromat file_name anEditorControl pop:editor:InsertStream
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате aFromat  из файла file_name.
*Пример:*
[code] 
Test.rtf CF_RTF  focused:control:push pop:editor:InsertStream
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorInsertStream.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwInsertFromStreamCommon
 , tfwScriptingInterfaces
;

type
 TkwPopEditorInsertStream = {final} class(TkwInsertFromStreamCommon)
  {* *Формат:* aFromat file_name anEditorControl pop:editor:InsertStream
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате aFromat  из файла file_name.
*Пример:*
[code] 
Test.rtf CF_RTF  focused:control:push pop:editor:InsertStream
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetFormat(const aCtx: TtfwContext): Integer; override;
 end;//TkwPopEditorInsertStream
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TkwPopEditorInsertStream.GetFormat(const aCtx: TtfwContext): Integer;
//#UC START# *5265050903DB_5265029302FC_var*
//#UC END# *5265050903DB_5265029302FC_var*
begin
//#UC START# *5265050903DB_5265029302FC_impl*
 RunnerAssert(aCtx.rEngine.IsTopInt, 'Не задан формат файла!', aCtx);
 Result := aCtx.rEngine.PopInt
//#UC END# *5265050903DB_5265029302FC_impl*
end;//TkwPopEditorInsertStream.GetFormat

class function TkwPopEditorInsertStream.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:InsertStream';
end;//TkwPopEditorInsertStream.GetWordNameForRegister

initialization
 TkwPopEditorInsertStream.RegisterInEngine;
 {* Регистрация pop_editor_InsertStream }
{$IfEnd} // NOT Defined(NoScripts)

end.
