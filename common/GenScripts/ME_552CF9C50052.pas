unit AutolinkFilterWordsPack;

interface

uses
 l3IntfUses
 , l3Variant
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , l3AutolinkService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwFilterAutolinkFilter = class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:AutolinkFilter
[panel]Создаёт на стеке фильтр TddAutolinkFilter (в виде Ik2TagGenerator).[panel]
*Тип результата:* Ik2TagGenerator
*Пример:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 filter:AutolinkFilter >>> l_Ik2TagGenerator
[code]  }
  function filter_AutolinkFilter(const aCtx: TtfwContext): Ik2TagGenerator;
   {* Реализация слова скрипта filter:AutolinkFilter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFilterAutolinkFilter
 
 TkwFilterCleanAutolinkFilter = class(TtfwGlobalKeyWord)
  {* Слово скрипта filter:CleanAutolinkFilter
[panel]Поскольку TddAutolinkFilter создаётся один на всё приложение, от него нужно отрезать Generator после использования. А иначе цепочка сохранится и будет мешать другим тестам.[panel]
*Пример:*
[code]
 filter:CleanAutolinkFilter
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFilterCleanAutolinkFilter
 
end.
