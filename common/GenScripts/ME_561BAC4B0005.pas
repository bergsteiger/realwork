unit tfwGlobalKeyWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwGlobalKeyWord.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwGlobalKeyWord" MUID: (561BAC4B0005)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwClassLike
;

type
 TtfwGlobalKeyWord = {abstract} class(TtfwClassLike)
  protected
   function BindParams: Boolean; override;
   function StrictChecking: Boolean; override;
 end;//TtfwGlobalKeyWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwGlobalKeyWord.BindParams: Boolean;
//#UC START# *5617C8A30023_561BAC4B0005_var*
//#UC END# *5617C8A30023_561BAC4B0005_var*
begin
//#UC START# *5617C8A30023_561BAC4B0005_impl*
 Result := true;
 //Result := false;
//#UC END# *5617C8A30023_561BAC4B0005_impl*
end;//TtfwGlobalKeyWord.BindParams

function TtfwGlobalKeyWord.StrictChecking: Boolean;
//#UC START# *561916700342_561BAC4B0005_var*
//#UC END# *561916700342_561BAC4B0005_var*
begin
//#UC START# *561916700342_561BAC4B0005_impl*
 Result := false;
//#UC END# *561916700342_561BAC4B0005_impl*
end;//TtfwGlobalKeyWord.StrictChecking

initialization
 TtfwGlobalKeyWord.RegisterClass;
 {* Регистрация TtfwGlobalKeyWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
