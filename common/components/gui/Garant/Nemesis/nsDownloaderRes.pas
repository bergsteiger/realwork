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
 str_OpenOrDownloadQuestion: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OpenOrDownloadQuestion'; rValue : '�� ������ ������� ��� ��������� ���� ����?');
  {* '�� ������ ������� ��� ��������� ���� ����?' }
 str_FileName: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FileName'; rValue : '���:');
  {* '���:' }
 str_Type: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Type'; rValue : '���:');
  {* '���:' }
 str_From: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'From'; rValue : '��:');
  {* '��:' }
 str_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Open'; rValue : '�������');
  {* '�������' }
 str_Download: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Download'; rValue : '���������');
  {* '���������' }
 str_Cancel: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Cancel'; rValue : '������');
  {* '������' }
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
 str_OpenOrDownloadQuestion.Init;
 {* ������������� str_OpenOrDownloadQuestion }
 str_FileName.Init;
 {* ������������� str_FileName }
 str_Type.Init;
 {* ������������� str_Type }
 str_From.Init;
 {* ������������� str_From }
 str_Open.Init;
 {* ������������� str_Open }
 str_Download.Init;
 {* ������������� str_Download }
 str_Cancel.Init;
 {* ������������� str_Cancel }
{$IfEnd} // Defined(Nemesis)

end.
