unit ToK3;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TToK3 = class(TTestResultsPlace)
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TToK3
 
implementation

uses
 l3ImplUses
;

end.
