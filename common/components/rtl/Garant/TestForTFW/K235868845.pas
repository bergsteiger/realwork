unit K235868845;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestForTFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/TestForTFW/K235868845.pas"
// Начат: 06.10.2010 19:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::TestForTFW::TFWTests::K235868845
//
// {RequestLink:235868845}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
 TK235868845 = class(TBaseTest)
  {* [RequestLink:235868845] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TK235868845
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK235868845

procedure TK235868845.DoIt;
//#UC START# *4CAC95F60396_4CAC95AC011D_var*
var
 l_N : String;
 l_F : Text;
//#UC END# *4CAC95F60396_4CAC95AC011D_var*
begin
//#UC START# *4CAC95F60396_4CAC95AC011D_impl*
 l_N := FileForOutput;
 AssignFile(l_F, l_N);
 Rewrite(l_F);
 try
  System.WriteLn(l_F, 'Специально, чтобы сравнение не прошло');
 finally
  CloseFile(l_F);
 end;//try..finally
 CheckOutputWithInput(KPage + EtalonSuffix + '.fake');
//#UC END# *4CAC95F60396_4CAC95AC011D_impl*
end;//TK235868845.DoIt

function TK235868845.GetFolder: AnsiString;
 {-}
begin
 Result := 'TFWTests';
end;//TK235868845.GetFolder

function TK235868845.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CAC95AC011D';
end;//TK235868845.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK235868845.Suite);

end.