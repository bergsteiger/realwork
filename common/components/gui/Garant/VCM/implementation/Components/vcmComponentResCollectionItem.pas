unit vcmComponentResCollectionItem;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmComponentResCollectionItem - }
{ �����: 17.10.2006 10:25 }
{ $Id: vcmComponentResCollectionItem.pas,v 1.8 2013/11/11 15:21:14 lulin Exp $ }

// $Log: vcmComponentResCollectionItem.pas,v $
// Revision 1.8  2013/11/11 15:21:14  lulin
// - �������� ���������� ���.
//
// Revision 1.7  2012/04/28 10:38:51  lulin
// {RequestLink:361404275}
//
// Revision 1.6  2009/05/26 10:29:59  oman
// - new: ������ ���� ��� ���������� - [$148018532]
//
// Revision 1.5  2008/07/14 17:43:51  lulin
// - <K>: 100958755.
//
// Revision 1.4  2007/07/27 10:11:10  oman
// - new: ���������� �������� "EmptyHint" (cq25825)
//
// Revision 1.3  2007/07/26 12:24:26  oman
// - fix: ������� ��� ����������� vtHeader - ����� �����������
// _OnGetLocalizationInfo (cq24480)
//
// Revision 1.2  2006/11/03 11:00:32  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.1.2.4  2006/10/25 09:51:33  oman
// - fix: �� ��������/�������� ����� � ��������� (cq23207)
//
// Revision 1.1.2.3  2006/10/23 07:41:00  lulin
// - �������� �������� Text.
//
// Revision 1.1.2.2  2006/10/23 07:29:01  lulin
// - �������� ��� ��������� �������� Text � ItemsText.
//
// Revision 1.1.2.1  2006/10/17 07:37:05  lulin
// - ������� ��������� ��������� � ���������� ��������������� ��� ����� ���������.
//

{$Include vcmDefine.inc }

interface

uses
  vcmBaseCollectionItem
  ;

type
  TvcmComponentResCollectionItem = class(TvcmBaseCollectionItem)
    private
    // internal fields
      f_Text      : String;
      f_ItemsText : String;
      f_Hint      : String;
//      f_AdditionalInfo: String;
      f_EmptyHint : String;
      f_FooterCaption: String;
    published
    // published properties
      property Text: String
        read f_Text
        write f_Text;
        {-}
      property ItemsText: String
        read f_ItemsText
        write f_ItemsText;
        {-}
      property Hint: String
        read f_Hint
        write f_Hint;
        {-}
(*      property AdditionalInfo: String
        read f_AdditionalInfo
        write f_AdditionalInfo;
        {-}*)
      property EmptyHint: String
        read f_EmptyHint
        write f_EmptyHint;
        {-}
      property FooterCaption: String
        read f_FooterCaption
        write f_FooterCaption;
        {-}
  end;//TvcmComponentResCollectionItem

implementation

end.

