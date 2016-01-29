unit InterfacedNodeWords;

interface

uses
 l3IntfUses
 , l3Tree_TLB
 , l3Interfaces
 , l3TreeInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TInterfacedNodeWordsResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TInterfacedNodeWordsResNameGetter
 
 TkwNodeCaption = class(TtfwPropertyLike)
  {* Слово скрипта Node:Caption
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Caption >>> l_Tl3WString
[code]  }
  function Caption(const aCtx: TtfwContext;
   const aNode: Il3Node): Tl3WString;
   {* Реализация слова скрипта Node:Caption }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeCaption
 
 TkwNodeIndex = class(TtfwPropertyLike)
  {* Слово скрипта Node:Index
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:Index >>> l_Integer
[code]  }
  function Index(const aCtx: TtfwContext;
   const aNode: Il3Node): Integer;
   {* Реализация слова скрипта Node:Index }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIndex
 
 TkwNodeIndexInTree = class(TtfwPropertyLike)
  {* Слово скрипта Node:IndexInTree
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:IndexInTree >>> l_Integer
[code]  }
  function IndexInTree(const aCtx: TtfwContext;
   const aNode: Il3Node): Integer;
   {* Реализация слова скрипта Node:IndexInTree }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIndexInTree
 
end.
