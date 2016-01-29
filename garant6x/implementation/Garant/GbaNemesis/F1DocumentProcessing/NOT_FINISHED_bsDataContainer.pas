unit NOT_FINISHED_bsDataContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/NOT_FINISHED_bsDataContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::F1DocumentProcessing::DocInfo::bsDataContainer
//
// Модуль содержит реализации контейнеров данных. Получение данных с адаптера
// может занимать длительное время, поэтому вводятся контейнеры данных, которые
// возвращают данные по первому требованию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsMedicFirmNodeContainer = class
 end;//TbsMedicFirmNodeContainer

 TbsNestedDocumentContainer = class
 end;//TbsNestedDocumentContainer

 TbsDocumentContainer = class
 end;//TbsDocumentContainer
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$IfEnd} //not Admin AND not Monitorings
end.