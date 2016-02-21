unit PictureInfo_Form;
 {* ���������� � �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_Form.pas"
// ���������: "VCMFinalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimPictureInfoOptions_Form
;

type
 Ten_PictureInfo = {final} class(TPrimPictureInfoOptionsForm)
  {* ���������� � �������� }
 end;//Ten_PictureInfo
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , PictureInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_PictureInfoLocalConstants }
 str_ut_PictureInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PictureInfoCaption'; rValue : '���������� � ��������');
  {* ��������� ����������������� ���� "���������� � ��������" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PictureInfo);
 {* ����������� PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_PictureInfoCaption.Init;
 {* ������������� str_ut_PictureInfoCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
