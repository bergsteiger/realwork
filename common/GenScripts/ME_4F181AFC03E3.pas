unit nsStringValueMapFactoryRes;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStringValueMapFactoryRes.pas"
// ���������: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_cpClassCaptionReview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpClassCaptionReview'; rValue : '������/���� � ���');
  {* '������/���� � ���' }
 str_cpSourceCaptionReview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpSourceCaptionReview'; rValue : '�����/�������� � ���');
  {* '�����/�������� � ���' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_cpClassCaptionReview.Init;
 {* ������������� str_cpClassCaptionReview }
 str_cpSourceCaptionReview.Init;
 {* ������������� str_cpSourceCaptionReview }

end.
