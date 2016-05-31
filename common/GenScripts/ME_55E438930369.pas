unit nsListExceptions;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsListExceptions.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsListExceptions" MUID: (55E438930369)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , SysUtils
 , l3MessageID
;

const
 {* Локализуемые строки EListIsTooLong local }
 str_ListIsTooLong: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ListIsTooLong'; rValue : 'Список содержит большое количество документов, он не может быть отфильтрован. Пожалуйста, уточните запрос.');
  {* 'Список содержит большое количество документов, он не может быть отфильтрован. Пожалуйста, уточните запрос.' }

type
 EListIsTooLong = class(Exception)
 end;//EListIsTooLong
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
 str_ListIsTooLong.Init;
 str_ListIsTooLong.SetDlgType(mtWarning);
 {* Инициализация str_ListIsTooLong }
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EListIsTooLong));
 {* Регистрация типа EListIsTooLong }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
