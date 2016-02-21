unit kwPopEditorPasteRTF;
 {* *Формат:* rtf_file_name anEditorControl pop:editor:PasteRTF
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате RTF из файла rtf_file_name.
*Пример:*
[code] 
Test.rtf  focused:control:push pop:editor:PasteRTF
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorPasteRTF.pas"
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
 TkwPopEditorPasteRTF = {final} class(TkwInsertFromStreamCommon)
  {* *Формат:* rtf_file_name anEditorControl pop:editor:PasteRTF
*Описание:* Эмулирует вставку из буфера обмена данных из внешних приложений, например, текст в формате RTF из файла rtf_file_name.
*Пример:*
[code] 
Test.rtf  focused:control:push pop:editor:PasteRTF
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetFormat(const aCtx: TtfwContext): Integer; override;
 end;//TkwPopEditorPasteRTF
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evTypes
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TkwPopEditorPasteRTF.GetFormat(const aCtx: TtfwContext): Integer;
//#UC START# *5265050903DB_5260EBCB0238_var*
//#UC END# *5265050903DB_5260EBCB0238_var*
begin
//#UC START# *5265050903DB_5260EBCB0238_impl*
 Result := cf_RTF;
//#UC END# *5265050903DB_5260EBCB0238_impl*
end;//TkwPopEditorPasteRTF.GetFormat

class function TkwPopEditorPasteRTF.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:PasteRTF';
end;//TkwPopEditorPasteRTF.GetWordNameForRegister

initialization
 TkwPopEditorPasteRTF.RegisterInEngine;
 {* Регистрация pop_editor_PasteRTF }
{$IfEnd} // NOT Defined(NoScripts)

end.
