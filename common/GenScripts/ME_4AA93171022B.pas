unit moCommonSearch;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\moCommonSearch.pas"
// ���������: "VCMFormsPack"
// ������� ������: "CommonSearch" MUID: (4AA93171022B)
// ��� ����: "Tmo_CommonSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
