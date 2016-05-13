unit moSearch;
 {* Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\moSearch.pas"
// Стереотип: "VCMUseCaseRealization"
// Элемент модели: "Search" MUID: (4AA641D100B7)
// Имя типа: "Tmo_Search"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Search_Module
;

type
 Tmo_Search = {final} class(TSearchModule)
  {* Поиск }
 end;//Tmo_Search
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Tmo_Search);
 {* Регистрация Search$UC }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
