unit evExtActionsRes;

{ ���������� "�������"      }
{ �����: ����� �.�. �       }
{ ������: evExtActionsRes - }
{ �����: 04.10.2001 11:32   }
{ $Id: evExtActionsRes.pas,v 1.22 2016/10/20 10:15:52 dinishev Exp $ }

// $Log: evExtActionsRes.pas,v $
// Revision 1.22  2016/10/20 10:15:52  dinishev
// {Requestlink:632196336}. ����� ������� ������� � ������ � ���������.
//
// Revision 1.21  2012/11/01 09:41:42  lulin
// - ����� ����� � �������.
//
// Revision 1.20  2012/11/01 07:43:08  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.19  2010/05/26 06:22:19  dinishev
// [$210436129]
//
// Revision 1.18  2010/03/02 09:04:12  dinishev
// ��������� ������ ��� Tools'�� ������ �� ������� ������.
//
// Revision 1.17  2009/11/19 12:05:16  dinishev
// [$171968600]
//
// Revision 1.16  2009/04/08 12:56:39  lulin
// [$142610892]. �������� �������� ���������.
//
// Revision 1.15  2009/04/08 12:12:34  lulin
// [$142610892]. ������� ������� ������� � ���������� _Nemesis.
//
// Revision 1.14  2008/08/01 07:07:41  dinishev
// ������ ���������� ����� ������� ��� HEAD'�
//
// Revision 1.13  2003/01/21 12:49:47  law
// - new behavior: ������� ����������� �������������� �������.
//
// Revision 1.12  2003/01/21 09:52:17  law
// - new standard actions: ev_ccBullet, ev_ccNumber, ev_ccDecIndent, ev_ccIncIndent.
//
// Revision 1.11  2002/10/10 13:21:32  law
// - new action group: ev_giViewMode.
//
// Revision 1.10  2002/09/17 13:03:04  law
// - new standard action: ev_ccWebStyle.
//
// Revision 1.9  2002/07/12 11:05:12  law
// - new actions: ev_ccInsertPageBreak, ev_ccInsertSectionBreak.
//
// Revision 1.8  2002/05/22 11:10:08  law
// no message
//
// Revision 1.7  2002/01/12 14:55:59  law
// - new operation: ev_ccMergeCellsHorz.
//
// Revision 1.6  2002/01/11 16:02:26  law
// - new operation: ev_ccMergeCellsVert.
//
// Revision 1.5  2001/12/28 12:31:07  law
// - new prop: � �������� �������� ��������� �������� ShortCut.
//
// Revision 1.4  2001/10/10 13:11:21  law
// - new behavior: ��������� GroupIndex �� ���������.
//
// Revision 1.3  2001/10/04 12:42:36  law
// - new behavior: ������ �������� �� ����������� ������� Category � AutoCheck.
//
// Revision 1.2  2001/10/04 09:52:04  law
// - new behavior: ������� ����������� ����������� ��������� �������� �� ���������.
//
// Revision 1.1  2001/10/04 08:05:53  law
// - new behavior: ������� ����������� ����������� ��������� �������� �� ���������.
//

{$I evDefine.inc }

interface


implementation

{$IfDef evNeedDisp}

uses
  evStandardActions,
  evExtDisp
  ;

const
  ev_giJustify   = 1;
  ev_giVAlign    = 2;
  ev_giFontIndex = 3;
  ev_giViewMode  = 4;
  ev_giList      = 5;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActionsRes.pas initialization enter'); {$EndIf}

{����������� �������� ��������������:}
evAddOperationDescriptor(ev_ccUndo,         '��������', '�������� ���������� ��������', 'Ctrl+Z');
evAddOperationDescriptor(ev_ccRedo,         '�������', '������� ����������� ��������', 'Shift+Ctrl+Z');
evAddOperationDescriptor(ev_ccDelete,       '�������', '', 'Ctrl+Del');
evAddOperationDescriptor(ev_ccCut,          '��������', '������� � ����� ������', 'Shift+Del');
evAddOperationDescriptor(ev_ccPaste,        '��������', '�������� �� ������ ������', 'Shift+Ins');
evAddOperationDescriptor(ev_ccSpecialPaste, '����������� �������...', '�������� �� ������ ������ � ������� �������');
evAddOperationDescriptor(ev_ccInsert,       '', '');
evAddOperationDescriptor(ev_ccCopy,         '����������', '���������� � ����� ������', 'Ctrl+Ins');
evAddOperationDescriptor(ev_ccAdd,          '��������', '�������� � ����� ������', 'Shift+Ctrl+Ins');
{������� ����������:}
evAddOperationDescriptor(ev_ccInsertTable,  '��������...', '�������� �������');
evAddOperationDescriptor(ev_ccInsertSBS,    '�������', '�������� �������');
evAddOperationDescriptor(ev_ccInsertSBSMark,'�����������', '�������� ����������� �������');
{�������� � ���������:}
evAddOperationDescriptor(ev_ccInsertRow,    '�������� ������', '�������� ������ �������');
evAddOperationDescriptor(ev_ccInsertColumn, '�������� �������', '�������� ������� �������');
evAddOperationDescriptor(ev_ccInsertCells,  '�������� ������', '�������� ������ �������');
evAddOperationDescriptor(ev_ccDeleteRow,    '������� ������', '������� ������ �������');
evAddOperationDescriptor(ev_ccDeleteColumn, '������� �������', '������� ������� �������');
evAddOperationDescriptor(ev_ccDeleteCells,  '������� ������', '������� ������ �������');
evAddOperationDescriptor(ev_ccMergeCells,   '���������� ������', '���������� ������ �������');
evAddOperationDescriptor(ev_ccMergeCellsHorz, '���������� ������ �� �����������', '���������� ������ ������� �� �����������');
evAddOperationDescriptor(ev_ccMergeCellsVert, '���������� ������ �� ���������', '���������� ������ ������� �� ���������');
evAddOperationDescriptor(ev_ccSplitCells,   '��������� ������', '��������� ������ �������');
evAddOperationDescriptor(ev_ccSplitTable,   '��������� �������', '');
evAddOperationDescriptor(ev_ccMergeTables,  '���������� �������', '');
evAddOperationDescriptor(ev_ccVAlignTop,    '������������ � �����', '��������� ���������� ������ � �����', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccVAlignCenter, '������������ �� ������', '��������� ���������� ������ �� ������', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccVAlignBottom, '������������ � ����', '��������� ���������� ������ � ����', '', true, ev_giVAlign);
evAddOperationDescriptor(ev_ccHSplit,       '��������� �� �����������', '��������� ������ �� �����������');
evAddOperationDescriptor(ev_ccVSplit,       '��������� �� ���������', '��������� ������ �� ���������');
evAddOperationDescriptor(ev_ccOldNSRCTable, '�������� � �������������', '�������� � �������������');
evAddOperationDescriptor(ev_ccTranslate2Text, '������������� � �����', '������������� � �����');
{�������� ������:}
evAddOperationDescriptor(ev_ccSearch,       '�����...', '����� �������� ��������', 'Ctrl+F');
evAddOperationDescriptor(ev_ccSearchAgain,  '��������� �����', '���������� ���������� �����/������', 'Ctrl+L');
evAddOperationDescriptor(ev_ccReplace,      '��������...', '����� �������� �������� � �������� ��� �� ������', 'Ctrl+R');
evAddOperationDescriptor(ev_ccSpellcheck,   '�������� ����������', '', 'F7');
{��� ������������:}
evAddOperationDescriptor(ev_ccJustifyLeft,  '��������� �����', '��������� �������� �����', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyRight, '��������� ������', '��������� �������� ������', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyCenter,'��������� �� ������', '��������� �������� �� ������', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyWidth, '��������� �� ������', '��������� �������� �� ������', '', true, ev_giJustify);
evAddOperationDescriptor(ev_ccJustifyPreformatted, '"������������������" �����', '', '', true, ev_giJustify);
{�������� ������:}
evAddOperationDescriptor(ev_ccBold,        '������', '������ �����', 'Ctrl+B', true);
evAddOperationDescriptor(ev_ccItalic,      '������', '����� ��������', 'Ctrl+I', true);
evAddOperationDescriptor(ev_ccUnderline,   '������������', '������������ �����', 'Ctrl+U', true);
evAddOperationDescriptor(ev_ccStrikeout,   '�������������', '������������� �����', '', true);
{$IFDEF Archi}
evAddOperationDescriptor(ev_ccSubscript,   '������ ������', '', '', true, ev_giFontIndex);
evAddOperationDescriptor(ev_ccSuperscript, '������� ������', '', '', true, ev_giFontIndex);
{$ELSE}
evAddOperationDescriptor(ev_ccSubscript,   '������ ������', '', 'Shift+Ctrl+=', true, ev_giFontIndex);
evAddOperationDescriptor(ev_ccSuperscript, '������� ������', '', 'Ctrl+=', true, ev_giFontIndex);
{$ENDIF}
evAddOperationDescriptor(ev_ccVisible,     '�������', '������� �����', '', true);
{�������� ��������:}
evAddOperationDescriptor(ev_ccNew,   '�����', '������� ����� ��������', 'Ctrl+N');
{$IFDEF EverestLite}
evAddOperationDescriptor(ev_ccOpen,  '�������...', '������� ��������', '');
{$ELSE}
evAddOperationDescriptor(ev_ccOpen,  '�������...', '������� ��������', 'Ctrl+O');
{$ENDIF EverestLite}
evAddOperationDescriptor(ev_ccGroup, '��������� ��������', '�������� � ������� ����������');
{�������� ����������:}
evAddOperationDescriptor(ev_ccSave,    '���������', '��������� ��������', 'Ctrl+S');
evAddOperationDescriptor(ev_ccSaveAs,  '��������� ���...', '��������� �������� ��� ������ ������');
evAddOperationDescriptor(ev_ccSaveAll, '��������� ���', '��������� ��� ���������');
{������:}
evAddOperationDescriptor(ev_ccPrint,   '������', '', 'Ctrl+P');
evAddOperationDescriptor(ev_ccPrintEx, '������...', '������ � ������� ��������');
{��������� �����������:}
evAddOperationDescriptor(ev_ccPrintPreview,      '�� ��������', '������������� �� �������� ��������', '', true, ev_giViewMode);
evAddOperationDescriptor(ev_ccShowSpecial,       '�����������', '���������� �����������', '', true);
evAddOperationDescriptor(ev_ccZoom,              '�������', '');
evAddOperationDescriptor(ev_ccPersistent,        'Persistent', 'Persistent-���������', '', true);
evAddOperationDescriptor(ev_ccWebStyle,          'Web-�����', 'Web-����� �����������', '', true, ev_giViewMode);
evAddOperationDescriptor(ev_ccDrawLines,         '���������', '��������� �����', '', true);
evAddOperationDescriptor(ev_ccShowDocumentParts, '��������� ���������', '���������� ��������� ���������', '', true);
evAddOperationDescriptor(ev_ccShowDocumentPart,  '���� ������', '�������� ����� ������', '', true);
{����������� ������:}
evAddOperationDescriptor(ev_ccHelpContents, '����������', '���������� �������');
evAddOperationDescriptor(ev_ccTopicSearch,  '�����', '����� �� �������');
evAddOperationDescriptor(ev_ccAbout,        '� ���������', '������� � ���������');
evAddOperationDescriptor(ev_ccHelpOnHelp,   '������� �� �������', '');
{�������� � ����������:}
evAddOperationDescriptor(ev_ccSelectAll,       '�������� ���', '', 'Ctrl+A');
evAddOperationDescriptor(ev_ccSelectPara,      '�������� ��������', '');
evAddOperationDescriptor(ev_ccSelectWord,      '�������� �����', '');
evAddOperationDescriptor(ev_ccHideSelection,   '����� ���������', '', 'Shift+Ctrl+A');
evAddOperationDescriptor(ev_ccBordersAndShade, '������� � �������...', '');
// �������
evAddOperationDescriptor(ev_ccInsertPageBreak, '������ ��������', '', 'Shift+Enter');
evAddOperationDescriptor(ev_ccInsertSectionBreak, '������ �������', '', 'Shift+Ctrl+Enter');
// ������
evAddOperationDescriptor(ev_ccBullet, '������', '', '', true, ev_giList);
evAddOperationDescriptor(ev_ccNumber, '���������', '', '', true, ev_giList);
evAddOperationDescriptor(ev_ccDecIndent, '��������� ������', '', '');
evAddOperationDescriptor(ev_ccIncIndent, '��������� ������', '', '');
evAddOperationDescriptor(ev_ccAlignWithSeparator, '�� �����������', '������������ ������ � ������� �� �����������', '', true);
{$EndIf evNeedDisp}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\Everest\ext\evExtActionsRes.pas initialization leave'); {$EndIf}
end.

