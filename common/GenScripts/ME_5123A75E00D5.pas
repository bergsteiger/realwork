unit toKAdmin;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\toKAdmin.pas"
// Стереотип: "TestResults"
// Элемент модели: "toKAdmin" MUID: (5123A75E00D5)
// Имя типа: "TtoKAdmin"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TtoKAdmin = class(TTestResultsPlace)
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
 end;//TtoKAdmin
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3ImplUses
;

{$If NOT Defined(NotTunedDUnit)}
class function TtoKAdmin.CommandLineKey: AnsiString;
 {* Ключ командной строки при указании которого будет выбрано данное место расположения результатов }
//#UC START# *4B7AB0B6016E_5123A75E00D5_var*
//#UC END# *4B7AB0B6016E_5123A75E00D5_var*
begin
//#UC START# *4B7AB0B6016E_5123A75E00D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B7AB0B6016E_5123A75E00D5_impl*
end;//TtoKAdmin.CommandLineKey

class function TtoKAdmin.TimesPage: Integer;
 {* Страница для вывода замеров времени }
//#UC START# *4B7C0B43005B_5123A75E00D5_var*
//#UC END# *4B7C0B43005B_5123A75E00D5_var*
begin
//#UC START# *4B7C0B43005B_5123A75E00D5_impl*
 Result := 431378129;
//#UC END# *4B7C0B43005B_5123A75E00D5_impl*
end;//TtoKAdmin.TimesPage

class function TtoKAdmin.ResultsPage: Integer;
 {* Страница для вывода результатов тестов }
//#UC START# *4B7C0B670215_5123A75E00D5_var*
//#UC END# *4B7C0B670215_5123A75E00D5_var*
begin
//#UC START# *4B7C0B670215_5123A75E00D5_impl*
 Result := 431378120;
//#UC END# *4B7C0B670215_5123A75E00D5_impl*
end;//TtoKAdmin.ResultsPage
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)
end.
