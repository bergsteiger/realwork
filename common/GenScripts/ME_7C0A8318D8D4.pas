unit ReleasetoKT;

interface

uses
 l3IntfUses
 , KTestRunner
;

type
 TReleasetoKT = class(TTestResultsPlace)
  {* Ежедневные тесты библиотек в Твери (релизный вариант) }
  function CommandLineKey: AnsiString;
   {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
  function TimesPage: Integer;
   {* Страница для вывода замеров времени }
  function ResultsPage: Integer;
   {* Страница для вывода результатов тестов }
 end;//TReleasetoKT
 
implementation

uses
 l3ImplUses
;

end.
