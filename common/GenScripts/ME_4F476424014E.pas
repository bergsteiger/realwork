unit IncludesAndUsesPack;

interface

uses
 l3IntfUses
 , tfwIncludeLike
 , tfwScriptingInterfaces
 , kwUsesLike
 , kwIncluded
;

type
 TkwInclude = class(TtfwIncludeLike)
  {* Зарезервированное слово: INCLUDE
Пример:
[code]
 INCLUDE 'Included.script'
[code] }
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwInclude
 
 TkwUses = class(TkwUsesLike)
  {* Подлючение внешних модулей в скрипт:
Пример:
[code]
USES
 DocumentNumbers.script
;
[code] }
 end;//TkwUses
 
 TkwINCLUDES = class(TkwUsesLike)
  {* Как USES, но позволяет включать слова во ВНУТРЕННИЙ словарь - откуда слово было вызвано }
 end;//TkwINCLUDES
 
 TkwIncludesInChildren = class(TkwUsesLike)
  {* Как USES, но позволяет включать слова во ВНУТРЕННИЙ словарь - в коробку детей (%C) - откуда слово было вызвано }
 end;//TkwIncludesInChildren
 
implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , l3String
 , kwInnerIncluded
 , kwInnerIncludedInChildren
 , kwCompiledProcedure
 , kwCompiledWord
 , kwCompiledWordPrim
 , SysUtils
;

end.
