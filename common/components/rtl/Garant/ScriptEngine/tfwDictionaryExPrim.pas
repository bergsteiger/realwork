unit tfwDictionaryExPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryExPrim.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionary
;

type
 TtfwDictionaryExPrim = {abstract} class(TtfwDictionary)
  public
   function UsesDictionary(anOther: TtfwDictionaryExPrim): Boolean; virtual;
   function IsValidCode: Boolean; virtual;
 end;//TtfwDictionaryExPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwDictionaryExPrim.UsesDictionary(anOther: TtfwDictionaryExPrim): Boolean;
//#UC START# *55A4FD6401D3_55A4FCDC01B8_var*
//#UC END# *55A4FD6401D3_55A4FCDC01B8_var*
begin
//#UC START# *55A4FD6401D3_55A4FCDC01B8_impl*
 Result := false;
//#UC END# *55A4FD6401D3_55A4FCDC01B8_impl*
end;//TtfwDictionaryExPrim.UsesDictionary

function TtfwDictionaryExPrim.IsValidCode: Boolean;
//#UC START# *55A3E53A00A8_55A4FCDC01B8_var*
//#UC END# *55A3E53A00A8_55A4FCDC01B8_var*
begin
//#UC START# *55A3E53A00A8_55A4FCDC01B8_impl*
 Result := true;
//#UC END# *55A3E53A00A8_55A4FCDC01B8_impl*
end;//TtfwDictionaryExPrim.IsValidCode
{$IfEnd} // NOT Defined(NoScripts)

end.
