unit ReleasetoK;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoK = class(TTestResultsPlace)
  {* Стандартный вывод для ГК (релизный вариант) }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TReleasetoK
 
implementation

uses
 l3ImplUses
;

end.
