unit K259890927;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K259890927.pas"
// Начат: 13.10.2011 18:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K259890927
//
// {RequestLink:259890927}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoEVDWriterTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK259890927 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:259890927] }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK259890927
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdLeafParaFilter,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK259890927

procedure TK259890927.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4E96F20A02AD_var*
//#UC END# *4C07BCBE01F2_4E96F20A02AD_var*
begin
//#UC START# *4C07BCBE01F2_4E96F20A02AD_impl*
 TevdLeafParaFilter.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4E96F20A02AD_impl*
end;//TK259890927.SetFilters

function TK259890927.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK259890927.GetFolder

function TK259890927.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E96F20A02AD';
end;//TK259890927.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK259890927.Suite);

end.