unit kwCFPDF;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Everest"
// Модуль: "kwCFPDF.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::SchemaWords::CF_PDF
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwClipboardFormatWord,
  evTypes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwCFPDF = {final scriptword} class(TtfwClipboardFormatWord)
 protected
 // realized methods
   function GetFormat: TevFormat; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFPDF
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwCFPDF

function TkwCFPDF.GetFormat: TevFormat;
//#UC START# *54D231000227_5548AB5A0050_var*
//#UC END# *54D231000227_5548AB5A0050_var*
begin
//#UC START# *54D231000227_5548AB5A0050_impl*
 Result := CF_PDF;
//#UC END# *54D231000227_5548AB5A0050_impl*
end;//TkwCFPDF.GetFormat

class function TkwCFPDF.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CF_PDF';
end;//TkwCFPDF.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация CF_PDF
 TkwCFPDF.RegisterInEngine;
{$IfEnd} //not NoScripts

end.