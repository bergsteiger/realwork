unit kwCFPDF;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFPDF.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "CF_PDF" MUID: (5548AB5A0050)
// Имя типа: "TkwCFPDF"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFPDF = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFPDF
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFPDF.GetFormat: TevFormat;
//#UC START# *54D231000227_5548AB5A0050_var*
//#UC END# *54D231000227_5548AB5A0050_var*
begin
//#UC START# *54D231000227_5548AB5A0050_impl*
 Result := CF_PDF;
//#UC END# *54D231000227_5548AB5A0050_impl*
end;//TkwCFPDF.GetFormat

class function TkwCFPDF.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_PDF';
end;//TkwCFPDF.GetWordNameForRegister

initialization
 TkwCFPDF.RegisterInEngine;
 {* Регистрация CF_PDF }
{$IfEnd} // NOT Defined(NoScripts)

end.
