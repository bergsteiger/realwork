unit toK;

// Модуль: "w:\archi\source\projects\Archi\toK.pas"
// Стереотип: "TestResults"
// Элемент модели: "toK" MUID: (4DE4A70402F1)
// Имя типа: "TtoK"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoK = class(TTestResultsPlace)
  public
   {$If NOT Defined(NotTunedDUnit)}
   class function CommandLineKey: AnsiString; override;
    {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function TimesPage: Integer; override;
    {* Страница для вывода замеров времени }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
   {$If NOT Defined(NotTunedDUnit)}
   class function ResultsPage: Integer; override;
    {* Страница для вывода результатов тестов }
   {$IfEnd} // NOT Defined(NotTunedDUnit)
 end;//TtoK
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoK.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-toK';
end;//TtoK.CommandLineKey

class function TtoK.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_4DE4A70402F1_var*
//#UC END# *4B7C0B43005B_4DE4A70402F1_var*
begin
//#UC START# *4B7C0B43005B_4DE4A70402F1_impl*
 Result := 267330016;
//#UC END# *4B7C0B43005B_4DE4A70402F1_impl*
end;//TtoK.TimesPage

class function TtoK.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_4DE4A70402F1_var*
//#UC END# *4B7C0B670215_4DE4A70402F1_var*
begin
//#UC START# *4B7C0B670215_4DE4A70402F1_impl*
 Result := 267330013;
//#UC END# *4B7C0B670215_4DE4A70402F1_impl*
end;//TtoK.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
