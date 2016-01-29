unit vcmDefaultOperations;

{$WEAKPACKAGEUNIT ON}

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmDefaultOperations - }
{ �����: 18.11.2004 21:00 }
{ $Id: vcmDefaultOperations.pas,v 1.12 2008/04/02 14:22:09 lulin Exp $ }

// $Log: vcmDefaultOperations.pas,v $
// Revision 1.12  2008/04/02 14:22:09  lulin
// - cleanup.
//
// Revision 1.11  2007/02/14 14:24:16  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.10  2006/07/03 10:56:12  oman
// - new beh: ��������� �������� WordLeft � WordRight (cq21546)
//
// Revision 1.9  2004/12/30 14:47:20  lulin
// - TevEditorWithOperations ������ ������������ �������� ������.
//
// Revision 1.8  2004/12/30 14:04:31  lulin
// - ������ TeePreviewPanel ���� ������������ �������� PrintDialog.
//
// Revision 1.7  2004/12/23 15:34:06  lulin
// - ����������� �������� ���������� � ����� _Preview �� ������ _Preview.
//
// Revision 1.6  2004/11/24 16:27:06  lulin
// - ��������� �������� � ����������� ������.
//
// Revision 1.5  2004/11/24 16:12:57  lulin
// - ��������� �������� � ��������� � �������� �������.
//
// Revision 1.4  2004/11/24 15:50:56  lulin
// - ��������� �������� - �������� �������.
//
// Revision 1.3  2004/11/24 13:47:50  lulin
// - new behavior: ����������� �������� �� ��������� ������ ����������, ����� ���� ��������� ��������.
//
// Revision 1.2  2004/11/24 12:35:53  lulin
// - new behavior: ����������� �������� �� ��������� ������ ������������� � ���������.
//
// Revision 1.1  2004/11/18 18:05:45  lulin
// - new unit: vcmDefaultOperations.
//

{$Include vcmDefine.inc }

interface

resourcestring
  vcm_deEdit = 'Edit';
   vcm_doSelectAll = 'SelectAll';
   vcm_doDeselect = 'Deselect';
   vcm_doCut = 'Cut';
   vcm_doCopy = 'Copy';
   vcm_doPaste = 'Paste';
   vcm_doUndo = 'Undo';
   vcm_doRedo = 'Redo';
   vcm_doDelete = 'Delete';
  vcm_deTable = 'Table';
   vcm_doInsert = 'Insert';
   vcm_doInsertRow = 'InsertRow';
   vcm_doDeleteRow = 'DeleteRow';
   vcm_doInsertColumn = 'InsertColumn';
   vcm_doDeleteColumn = 'DeleteColumn';
  vcm_deFont = 'Font';
   vcm_doBold = 'Bold'; 
   vcm_doItalic = 'Italic';
   vcm_doUnderline = 'Underline';
   vcm_doStrikeout = 'Strikeout';
  vcm_dePreview = 'Preview';
   vcm_doZoomWidth = 'ZoomWidth';
   vcm_doZoomPage = 'ZoomPage';
   vcm_doZoomIn = 'ZoomIn';
   vcm_doZoomOut = 'ZoomOut';
  vcm_deDocument = 'Document';
   vcm_doRGBGrayscaleSwitch = 'RGBGrayscaleSwitch';
   vcm_doPrintInfoSwitch = 'PrintInfoSwitch';
   vcm_doFullSelectedSwitch = 'FullSelectedSwitch';
  vcm_deFile = 'File';
   vcm_doPrint = 'Print';
   vcm_doPrintDialog = 'PrintDialog';
   vcm_doPrintPreview = 'PrintPreview';
  vcm_deText = 'Text';
   vcm_doWordLeft = 'WordLeft';
   vcm_doWordRight = 'WordRight';

implementation

end.

