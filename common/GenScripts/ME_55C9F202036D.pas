unit ITestWordsPack;

interface

uses
 l3IntfUses
 , TestFrameWork
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
 , tfwGlobalKeyWord
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TITestWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TITestWordsPackResNameGetter
 
 TkwPopTestName = class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   const aTest: ITest): AnsiString;
   {* Реализация слова скрипта pop:Test:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestName
 
 TkwPopTestEnabled = class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:Enabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:Enabled >>> l_Boolean
[code]  }
  function Enabled(const aCtx: TtfwContext;
   const aTest: ITest): Boolean;
   {* Реализация слова скрипта pop:Test:Enabled }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestEnabled
 
 TkwPopTestSubFolder = class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:SubFolder
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTest pop:Test:SubFolder >>> l_String
[code]  }
  function SubFolder(const aCtx: TtfwContext;
   const aTest: ITest): AnsiString;
   {* Реализация слова скрипта pop:Test:SubFolder }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestSubFolder
 
 TkwPopTestHasScriptChildren = class(TtfwPropertyLike)
  {* Слово скрипта pop:Test:HasScriptChildren
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTest pop:Test:HasScriptChildren >>> l_Boolean
[code]  }
  function HasScriptChildren(const aCtx: TtfwContext;
   const aTest: ITest): Boolean;
   {* Реализация слова скрипта pop:Test:HasScriptChildren }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTestHasScriptChildren
 
 TkwTestShouldStop = class(TtfwGlobalKeyWord)
  {* Слово скрипта test:ShouldStop
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 test:ShouldStop >>> l_Boolean
[code]  }
  function test_ShouldStop(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта test:ShouldStop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTestShouldStop
 
end.
