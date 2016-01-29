unit evEditorWindowProcessor;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evEditorWindowProcessor - }
{ �����: 21.07.2005 08:46 }
{ $Id: evEditorWindowProcessor.pas,v 1.3 2008/05/16 14:01:10 lulin Exp $ }

// $Log: evEditorWindowProcessor.pas,v $
// Revision 1.3  2008/05/16 14:01:10  lulin
// - ��������� �� ������.
//
// Revision 1.2  2007/12/04 12:47:01  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.5  2005/12/01 05:27:42  lulin
// - ����������� �� ��������� �������� ���� ��������� �� ������� Processor -> DocumentContainer -> TextSource.
//
// Revision 1.1.2.4  2005/07/25 10:54:36  lulin
// - ������� ����������� ���������� � ���������� ��������� � ���������� �� TextSource.
//
// Revision 1.1.2.3  2005/07/21 13:57:41  lulin
// - ������ ������ �������� � ���������� ��������.
//
// Revision 1.1.2.2  2005/07/21 09:19:30  lulin
// - � TextSource ������ �������� ������ � �������� ���������� ���������.
//
// Revision 1.1.2.1  2005/07/21 05:05:03  lulin
// - �������� ������ � TextSource �� ���������.
//

{$Include evDefine.inc }

interface

uses
  evCustomEditorWindowProcessor
  ;
  
type
  TevEditorWindowProcessor = class(TevCustomEditorWindowProcessor)
    published
    // published properties
      property TextParaLimit;
        {-}
      property BruttoCharLimit;
        {-}
      property DefaultStyle;
        {-}
  end;//TevEditorWindowProcessor

implementation

end.

