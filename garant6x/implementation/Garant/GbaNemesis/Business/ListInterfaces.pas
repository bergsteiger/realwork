unit ListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/ListInterfaces.pas"
// Начат: 07.09.2009 14:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Common::Business::ListInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsLinkType = (
  {* Тип ссылки на данные для сборки. Операция модуля использует этот тип для определения какую сборку необходимо создать }
   ltDocument // Открыть сборку документ
 , ltList // Открыть сборку список
 );//TbsLinkType
{$IfEnd} //not Admin AND not Monitorings

implementation

end.