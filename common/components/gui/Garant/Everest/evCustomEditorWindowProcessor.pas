unit evCustomEditorWindowProcessor;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evEditorWindowProcessor - }
{ �����: 21.07.2005 08:46 }
{ $Id: evCustomEditorWindowProcessor.pas,v 1.2 2009/04/14 18:11:54 lulin Exp $ }

// $Log: evCustomEditorWindowProcessor.pas,v $
// Revision 1.2  2009/04/14 18:11:54  lulin
// [$143396720]. ���������������� ������.
//
// Revision 1.1  2008/05/16 14:01:10  lulin
// - ��������� �� ������.
//
// Revision 1.2  2007/12/04 12:47:01  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.5  2005/12/01 05:27:42  lulin
// - ����������� �� ��������� �������� ���� ��������� �� ������� _Processor -> DocumentContainer -> TextSource.
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
  evNotifiedProcessor
  ;
  
type
  TevCustomEditorWindowProcessor = class(TevNotifiedProcessor)
   {* ��������� �������� ��� ���� ��������� (��. TevCustomEditorWindow). }
  end;//TevCustomEditorWindowProcessor

implementation

end.

