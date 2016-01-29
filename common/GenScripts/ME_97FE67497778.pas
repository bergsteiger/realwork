unit ReleaseItsLAW;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseItsLAW = class(TTestResultsPlace)
  {* Вывод для отладочных целей (релизный вариант) }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TReleaseItsLAW
 
implementation

uses
 l3ImplUses
;

end.
