unit l3NodesKeyWordsPack;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , l3Interfaces
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
 Tl3NodesKeyWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//Tl3NodesKeyWordsPackResNameGetter
 
 TkwNodeIsFirst = class(TtfwPropertyLike)
  {* Слово скрипта Node:IsFirst
[panel]Узел первый?[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsFirst >>> l_Boolean
[code]  }
  function IsFirst(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Boolean;
   {* Реализация слова скрипта Node:IsFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIsFirst
 
 TkwNodeIsLast = class(TtfwPropertyLike)
  {* Слово скрипта Node:IsLast
[panel]Узел последний?[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsLast >>> l_Boolean
[code]  }
  function IsLast(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Boolean;
   {* Реализация слова скрипта Node:IsLast }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIsLast
 
 TkwNodeFlags = class(TtfwPropertyLike)
  {* Слово скрипта Node:Flags
[panel]Флаги узла[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:Flags >>> l_Integer
[code]  }
  function Flags(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Integer;
   {* Реализация слова скрипта Node:Flags }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeFlags
 
 TkwNodeText = class(TtfwPropertyLike)
  {* Слово скрипта Node:Text
[panel]Текст узла[panel]
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Text >>> l_Tl3WString
[code]  }
  function Text(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Tl3WString;
   {* Реализация слова скрипта Node:Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeText
 
end.
