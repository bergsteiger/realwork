unit ReleaseArchi2;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleaseArchi2 = class(TTestResultsPlace)
  {* Тесты на Archi2 (релизный вариант) }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TReleaseArchi2
 
implementation

uses
 l3ImplUses
;

end.
