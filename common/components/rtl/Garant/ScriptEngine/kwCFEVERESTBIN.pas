unit kwCFEVERESTBIN;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCFEVERESTBIN.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "CF_EVERESTBIN" MUID: (52E11B1F02E7)
// Имя типа: "TkwCFEVERESTBIN"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClipboardFormatWord
 , evTypes
;

type
 TkwCFEVERESTBIN = {final} class(TtfwClipboardFormatWord)
  protected
   function GetFormat: TevFormat; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCFEVERESTBIN
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwCFEVERESTBIN.GetFormat: TevFormat;
//#UC START# *54D231000227_52E11B1F02E7_var*
//#UC END# *54D231000227_52E11B1F02E7_var*
begin
//#UC START# *54D231000227_52E11B1F02E7_impl*
 Result := CF_EverestBin;
//#UC END# *54D231000227_52E11B1F02E7_impl*
end;//TkwCFEVERESTBIN.GetFormat

class function TkwCFEVERESTBIN.GetWordNameForRegister: AnsiString;
begin
 Result := 'CF_EVERESTBIN';
end;//TkwCFEVERESTBIN.GetWordNameForRegister

initialization
 TkwCFEVERESTBIN.RegisterInEngine;
 {* Регистрация CF_EVERESTBIN }
{$IfEnd} // NOT Defined(NoScripts)

end.
