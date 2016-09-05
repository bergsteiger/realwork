unit nsDownloaderRes;

// ������: "w:\common\components\gui\Garant\Nemesis\nsDownloaderRes.pas"
// ���������: "UtilityPack"
// ������� ������: "nsDownloaderRes" MUID: (57BD790600B0)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ nsDownloaderLocalConst }
 str_UnknownFile: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'UnknownFile'; rValue : '�����������');
  {* '�����������' }
 str_FileDownload: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FileDownload'; rValue : '�������� �����');
  {* '�������� �����' }
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *57BD790600B0impl_uses*
 //#UC END# *57BD790600B0impl_uses*
;

initialization
 str_UnknownFile.Init;
 {* ������������� str_UnknownFile }
 str_FileDownload.Init;
 {* ������������� str_FileDownload }
{$IfEnd} // Defined(Nemesis)

end.
