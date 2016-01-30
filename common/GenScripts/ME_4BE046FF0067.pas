unit K208701762;
 {* [RequestLink:208701762] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K208701762.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , SearchAndReplaceTest
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK208701762 = class(TSearchAndReplaceTest)
  {* [RequestLink:208701762] }
  protected
   {$If NOT Defined(NoVCM)}
   function StringForSearch: AnsiString; override;
    {* Строка для поиска }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function StringForReplace: AnsiString; override;
    {* Строка для замены }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK208701762
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

{$If NOT Defined(NoVCM)}
function TK208701762.StringForSearch: AnsiString;
 {* Строка для поиска }
//#UC START# *4BE051200169_4BE046FF0067_var*
//#UC END# *4BE051200169_4BE046FF0067_var*
begin
//#UC START# *4BE051200169_4BE046FF0067_impl*
 Result := 'атестационная';
//#UC END# *4BE051200169_4BE046FF0067_impl*
end;//TK208701762.StringForSearch
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TK208701762.StringForReplace: AnsiString;
 {* Строка для замены }
//#UC START# *4BE0513800C9_4BE046FF0067_var*
//#UC END# *4BE0513800C9_4BE046FF0067_var*
begin
//#UC START# *4BE0513800C9_4BE046FF0067_impl*
 Result := 'аттестационная';
//#UC END# *4BE0513800C9_4BE046FF0067_impl*
end;//TK208701762.StringForReplace
{$IfEnd} // NOT Defined(NoVCM)

function TK208701762.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK208701762.GetFolder

function TK208701762.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE046FF0067';
end;//TK208701762.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK208701762.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
