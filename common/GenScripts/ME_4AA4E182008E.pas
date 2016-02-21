unit ListInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\ListInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 TbsLinkType = (
  {* Тип ссылки на данные для сборки. Операция модуля использует этот тип для определения какую сборку необходимо создать }
  ltDocument
   {* Открыть сборку документ }
  , ltList
   {* Открыть сборку список }
 );//TbsLinkType
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
