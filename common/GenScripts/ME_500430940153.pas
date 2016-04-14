unit BaseUC;
 {* Тесты для запуска перед коммитами }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\BaseUC.pas"
// Стереотип: "TestResults"
// Элемент модели: "BaseUC" MUID: (500430940153)
// Имя типа: "TBaseUC"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TBaseUC = class(TTestResultsPlace)
  {* Тесты для запуска перед коммитами }
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
 end;//TBaseUC
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TBaseUC.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
begin
 Result := '-BaseUC';
end;//TBaseUC.CommandLineKey

class function TBaseUC.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_500430940153_var*
//#UC END# *4B7C0B43005B_500430940153_var*
begin
//#UC START# *4B7C0B43005B_500430940153_impl*
 Result := 378543494;
//#UC END# *4B7C0B43005B_500430940153_impl*
end;//TBaseUC.TimesPage

class function TBaseUC.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_500430940153_var*
//#UC END# *4B7C0B670215_500430940153_var*
begin
//#UC START# *4B7C0B670215_500430940153_impl*
 Result := 378543492;
//#UC END# *4B7C0B670215_500430940153_impl*
end;//TBaseUC.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
