unit ddHTMLWriterRes;

// ������: "w:\common\components\rtl\Garant\dd\ddHTMLWriterRes.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_ddmmMultiLinkTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmMultiLinkTitle'; rValue : '%s - ������ ������������� ������');
  {* '%s - ������ ������������� ������' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_ddmmMultiLinkTitle.Init;
 {* ������������� str_ddmmMultiLinkTitle }

end.
