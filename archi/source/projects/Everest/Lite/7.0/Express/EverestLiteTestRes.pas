unit EverestLiteTestRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/archi/source/projects/Everest/Lite/7.0/Express/EverestLiteTestRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$EverestLite$Test::EverestLite$Test::TEverestLiteTestRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Express\EverestLite.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  GUIAppTester
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TEverestLiteTestRes = class(TGUIAppTester)
 public
 // realized methods
   class function GetResultsPlaces: TResultsPlaces; override;
 end;//TEverestLiteTestRes
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  toK,
  TestFrameWork
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  afwAnswer
  {$IfEnd} //not NoScripts
  
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  KTestRunner
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  ,
  EverestLiteTestSuite,
  toKT
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

// start class TEverestLiteTestRes

class function TEverestLiteTestRes.GetResultsPlaces: TResultsPlaces;
//#UC START# *52F264840382_512AF4F300FC_var*
//#UC END# *52F264840382_512AF4F300FC_var*
begin
//#UC START# *52F264840382_512AF4F300FC_impl*
 Result := MakeResults([TtoK, TtoKT]);
//#UC END# *52F264840382_512AF4F300FC_impl*
end;//TEverestLiteTestRes.GetResultsPlaces

{$IfEnd} //InsiderTest AND nsTest

end.