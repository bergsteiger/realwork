unit moCommonSearch;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\moCommonSearch.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , CommonSearch_Module
;

type
 Tmo_CommonSearch = {final} class(TCommonSearchModule)
 end;//Tmo_CommonSearch
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin)

end.
