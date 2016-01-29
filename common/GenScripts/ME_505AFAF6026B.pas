unit kwFiltersAndGeneratorsPack;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
 , Classes
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , k2EVDReaderService
 , k2EVDWriterService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwFiltersAndGeneratorsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TkwFiltersAndGeneratorsPackResNameGetter
 
 TkwGeneratorsExecute = class(TtfwClassLike)
  {* Слово скрипта generators:Execute
[panel]Берёт со стека имя имя входного файла (EVD) и генератор (или цепочку). Затем делает трубу и прогоняет через неё файл.[panel]
*Пример:*
[code]
 aFileName aTagGenerator generators:Execute
[code]  }
  procedure generators_Execute(const aCtx: TtfwContext;
   const aTagGenerator: Ik2TagGenerator;
   const aFileName: AnsiString);
   {* Реализация слова скрипта generators:Execute }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratorsExecute
 
 TkwGeneratorsLink = class(TtfwClassLike)
  {* Слово скрипта generators:Link
[panel]Берёт со стека два генератора и делает из них цепочку. В результате на стеке остаётся один генератор (к которому подклеен другой)[panel]
*Тип результата:* Ik2TagGenerator
*Пример:*
[code]
INTERFACE VAR l_Ik2TagGenerator
 aGenHead aTagGenerator generators:Link >>> l_Ik2TagGenerator
[code]  }
  function generators_Link(const aCtx: TtfwContext;
   const aTagGenerator: Ik2TagGenerator;
   const aGenHead: Ik2TagGenerator): Ik2TagGenerator;
   {* Реализация слова скрипта generators:Link }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGeneratorsLink
 
end.
