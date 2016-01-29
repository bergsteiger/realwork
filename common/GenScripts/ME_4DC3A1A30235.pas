unit tfwIncludeLike;

interface

uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
 , kwIncluded
 , kwCompiledWordPrim
 , l3Interfaces
;

type
 TtfwIncludeLike = class(TtfwCompilingWord)
  {* Поддержка Include-совместимых слов. }
  procedure DoIncluded(const aContext: TtfwContext;
   const aFileName: AnsiString);
  function GetIncludedClass: RkwIncluded;
  function MakeIncluded(const aFileName: AnsiString;
   const aContext: TtfwContext): TkwIncluded;
 end;//TtfwIncludeLike
 
implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3Types
;

end.
