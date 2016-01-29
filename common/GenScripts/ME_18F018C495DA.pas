unit ReleasetoK64;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoK64 = class(TTestResultsPlace)
  {*  (релизный вариант) }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TReleasetoK64
 
implementation

uses
 l3ImplUses
;

end.
