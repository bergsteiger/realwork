unit ToK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TToK = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TToK
 
implementation

uses
 l3ImplUses
;

end.
