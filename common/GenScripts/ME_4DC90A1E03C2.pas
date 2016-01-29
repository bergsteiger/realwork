unit kwMain;

interface

uses
 l3IntfUses
 , tfwScriptEnginePrim
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
 , tfwStreamFactory
 , tfwAxiomaticsResNameGetter
;

type
 TkwMain = class(TtfwScriptEnginePrim)
  {* Поддержка основного кода скрипта. }
  procedure CompileScriptToAxiomatics(const aContext: TtfwContext;
   const aScriptCode: array of AnsiString);
   {* Компилируем скипт в аксиоматику }
  procedure CompileScriptToAxiomaticsIfDefined(const aContext: TtfwContext;
   const aDefined: array of AnsiString;
   const aScriptCode: array of AnsiString);
  procedure CompileResScriptToAxiomatics(const aContext: TtfwContext;
   const aResName: AnsiString);
 end;//TkwMain
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , kwSystemIncluded
 , l3Stream
 , l3Types
 , kwCompiledMain
 , seThreadSupport
 , tfwFileStreamFactory
 , tfwCOMStreamFactory
 , tfwStringStreamFactory
 , l3EtalonsService
 , tfwResourceStreamFactory
 , tfwAutoregisteredDiction
 , tfwAxiomaticsResNameGetters
 , tfwCompiledAxiomaticsRes
 , l3Memory
 , l3_String
 , l3String
 , l3Chars
;

type
 TkwMainResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TkwMainResNameGetter
 
end.
