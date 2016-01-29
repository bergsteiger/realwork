unit K289933137;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K289933137.pas"
// Начат: 05.10.2011 17:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.7 Lulin::K289933137
//
// {RequestLink:289933137}
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
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK289933137 = class(TBaseTest)
  {* [RequestLink:289933137] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TK289933137
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  l3KeyWrd,
  l3Except,
  SysUtils,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK289933137

procedure TK289933137.DoIt;
//#UC START# *4E8C5F96027B_4E8C5F6502AA_var*
var
 l_KW : Tl3KeyWords;
 l_Raised : Boolean;
//#UC END# *4E8C5F96027B_4E8C5F6502AA_var*
begin
//#UC START# *4E8C5F96027B_4E8C5F6502AA_impl*
 l_KW := Tl3KeyWords.Create;
 try
  l_KW.AddKeyWord('a', 1);
  l_KW.AddKeyWord('b', 2);
  l_Raised := false;
  try
   l_KW.AddKeyWord('B', 3);
  except
   on El3DuplicateItem do
    l_Raised := true;
  end;//try..except
  Assert(l_Raised);
  Check(l_KW.DRbyName['A'] <> nil);
 finally
  FreeAndNil(l_KW);
 end;//try..finally
//#UC END# *4E8C5F96027B_4E8C5F6502AA_impl*
end;//TK289933137.DoIt

function TK289933137.GetFolder: AnsiString;
 {-}
begin
 Result := '7.7 Lulin';
end;//TK289933137.GetFolder

function TK289933137.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E8C5F6502AA';
end;//TK289933137.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK289933137.Suite);

end.