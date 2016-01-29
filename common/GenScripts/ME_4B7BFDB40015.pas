unit toK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TtoK = class(TTestResultsPlace)
  {* Стандартный вывод для ГК }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TtoK
 
implementation

uses
 l3ImplUses
 , SHDTestScriptEngine
;

end.
