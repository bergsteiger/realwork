unit ArchiScriptEngine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Script Engine"
// Модуль: "w:/archi/source/projects/Archi/Archi_Script_Engine/ArchiScriptEngine.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$ScriptEngine::Archi Script Engine::ScriptEngine::TArchiScriptEngine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngineEX
  {$IfEnd} //not NoScripts
  
  ;

type
 TArchiScriptEngine = class(TtfwScriptEngineEX)
 end;//TArchiScriptEngine

implementation

uses
  SysUtils
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arEditorUtils
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  arDialogsPack
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  CommonArchiWords
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  kwCompiledWord
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  kwDocumentSpravka
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwEditorKeyWordsPack
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  
  {$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  kwCommonArchiWords
  {$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
  
  ;

end.