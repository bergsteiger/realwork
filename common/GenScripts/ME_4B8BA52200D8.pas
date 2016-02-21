unit nevInterfaces;

// ������: "w:\common\components\gui\Garant\Everest\new\nevInterfaces.pas"
// ���������: "UtilityPack"

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ TnevMiscMessages }
 str_nevmmSaveText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSaveText'; rValue : '���������� ������');
  {* '���������� ������' }
 str_nevmmSaveFormattedText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSaveFormattedText'; rValue : '���������� ������ � ������� "%s"');
  {* '���������� ������ � ������� "%s"' }
 str_nevmmReference: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmReference'; rValue : '�������: %s');
  {* '�������: %s' }
 str_nevmmPageCounter: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmPageCounter'; rValue : '�������� %d �� %d');
  {* '�������� %d �� %d' }
 str_nevmmDocumentCount: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmDocumentCount'; rValue : '�������� %d �� %d');
  {* '�������� %d �� %d' }
 str_nevmmDocumentCountInt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmDocumentCountInt'; rValue : '�������� %d �� %d, �������� %d');
  {* '�������� %d �� %d, �������� %d' }
 str_nevmmComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmComment'; rValue : ' ��� ����������� ');
  {* ' ��� ����������� ' }
 str_nevmmReplace: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmReplace'; rValue : '������');
  {* '������' }
 str_nevmmFragment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmFragment'; rValue : '%s (��������)');
  {* '%s (��������)' }
 str_nevmmSearch: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmSearch'; rValue : '�����');
  {* '�����' }
 str_nevmmLongOperation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmLongOperation'; rValue : '����������� ���������� ��������...');
  {* '����������� ���������� ��������...' }
 str_nevmmCommentFolder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmCommentFolder'; rValue : ' ��� ����������� ');
  {* ' ��� ����������� ' }
 str_nevmmAnnotation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmAnnotation'; rValue : '���������: %s');
  {* '���������: %s' }
 str_nevmmChronology: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmChronology'; rValue : '���������� ��������� ����: %s');
  {* '���������� ��������� ����: %s' }
 str_nevmmTranslation: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmTranslation'; rValue : '�������: %s');
  {* '�������: %s' }
 str_nevmmJurorComment: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmJurorComment'; rValue : ' ����������� ������� ');
  {* ' ����������� ������� ' }
 str_nevmmJurorCommentDecorate: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmJurorCommentDecorate'; rValue : '����������� �������');
  {* '����������� �������' }
 str_nevmmTOC: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmTOC'; rValue : '����������');
  {* '����������' }
 str_nevmmPageCounterNew: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmmPageCounterNew'; rValue : '����� ���������� � ������: %d');
  {* '����� ���������� � ������: %d' }
 {* ������������ ������ TnevTextFormats }
 str_nevtfANSI: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfANSI'; rValue : 'ANSI-�����');
  {* 'ANSI-�����' }
 str_nevtfUnicode: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfUnicode'; rValue : 'Unicode-�����');
  {* 'Unicode-�����' }
 str_nevtfOEM: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfOEM'; rValue : 'OEM-�����');
  {* 'OEM-�����' }
 {$If Defined(evMyEditor)}
 str_nevtfThyEditor: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfThyEditor'; rValue : '����� ���������');
  {* '����� ���������' }
 {$IfEnd} // Defined(evMyEditor)
 {$If Defined(Nemesis)}
 str_nevtfGarant: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfGarant'; rValue : '�������� �������');
  {* '�������� �������' }
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 str_nevtfEverestBin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfEverestBin'; rValue : '������� (binary)');
  {* '������� (binary)' }
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 str_nevtfEverest: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfEverest'; rValue : '�������');
  {* '�������' }
 {$IfEnd} // NOT Defined(Nemesis)
 str_nevtfRtf: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevtfRtf'; rValue : 'RTF');
  {* 'RTF' }
 {* ������������ ������ TnevPrintMessages }
 str_nevpmTimeLeft: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmTimeLeft'; rValue : ', %d ������ ��������');
  {* ', %d ������ ��������' }
 str_nevpmCounting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmCounting'; rValue : '������� ����� �������... %d (~%d)');
  {* '������� ����� �������... %d (~%d)' }
 str_nevpmPreparing: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPreparing'; rValue : '���������� ��������� ������... %d ������� ������������');
  {* '���������� ��������� ������... %d ������� ������������' }
 str_nevpmPreparingExt: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPreparingExt'; rValue : '���������� ��������� ������... %d ������� �� %s%d ������������');
  {* '���������� ��������� ������... %d ������� �� %s%d ������������' }
 str_nevpmPrinting: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmPrinting'; rValue : '������ ���������');
  {* '������ ���������' }
 str_nevpmDocumentList: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmDocumentList'; rValue : '������ ����������');
  {* '������ ����������' }
 str_nevpmDefaultColontitul: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmDefaultColontitul'; rValue : '%s �������: %s ���������: %s');
  {* '%s �������: %s ���������: %s' }
 str_nevpmUndefinedSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmUndefinedSize'; rValue : '�� ���������');
  {* '�� ���������' }
 str_nevpmUndefinedTopic: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmUndefinedTopic'; rValue : '�� ���������');
  {* '�� ���������' }
 str_nevpmProcessText: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmProcessText'; rValue : '��������� ������');
  {* '��������� ������' }
 str_nevpmProcessPreview: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevpmProcessPreview'; rValue : '��������� ��������� ������');
  {* '��������� ��������� ������' }
 {* ������������ ������ TnevCommentParaHint }
 str_nevcphExpand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphExpand'; rValue : '���������� �����������');
  {* '���������� �����������' }
 str_nevcphCollapse: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphCollapse'; rValue : '�������� �����������');
  {* '�������� �����������' }
 str_nevcphSelect: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphSelect'; rValue : '�������� �����������');
  {* '�������� �����������' }
 str_nevcphMove: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphMove'; rValue : '����������� �����������');
  {* '����������� �����������' }
 str_nevcphChangeTopBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphChangeTopBorder'; rValue : '�������� ������� ������� �����������');
  {* '�������� ������� ������� �����������' }
 str_nevcphChangeBottomBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphChangeBottomBorder'; rValue : '�������� ������ ������� �����������');
  {* '�������� ������ ������� �����������' }
 str_nevcphProperties: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevcphProperties'; rValue : '�������� �����������');
  {* '�������� �����������' }
 {* ������������ ������ TnevMemoContextMenu }
 str_nevmcmUndo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmUndo'; rValue : '��������');
  {* '��������' }
 str_nevmcmCut: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmCut'; rValue : '��������');
  {* '��������' }
 str_nevmcmCopy: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmCopy'; rValue : '����������');
  {* '����������' }
 str_nevmcmPaste: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmPaste'; rValue : '��������');
  {* '��������' }
 str_nevmcmDelete: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmcmDelete'; rValue : '�������');
  {* '�������' }
 {* ������������ ������ TnevDocumentPartHint }
 str_nevdphExpand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphExpand'; rValue : '���������� ����');
  {* '���������� ����' }
 str_nevdphCollapse: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphCollapse'; rValue : '�������� ����');
  {* '�������� ����' }
 str_nevdphSelect: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphSelect'; rValue : '�������� ����');
  {* '�������� ����' }
 str_nevdphMove: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphMove'; rValue : '����������� ����');
  {* '����������� ����' }
 str_nevdphChangeTopBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphChangeTopBorder'; rValue : '�������� ������� ������� �����');
  {* '�������� ������� ������� �����' }
 str_nevdphChangeBottomBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphChangeBottomBorder'; rValue : '�������� ������ ������� �����');
  {* '�������� ������ ������� �����' }
 str_nevdphProperties: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevdphProperties'; rValue : '�������� �����');
  {* '�������� �����' }
 {* ������������ ������ TnevMiscHotspotHints }
 str_nevmhhBlockParams: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhBlockParams'; rValue : '��������� �������.');
  {* '��������� �������.' }
 str_nevmhhTableCell: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableCell'; rValue : '������ �������');
  {* '������ �������' }
 str_nevmhhTableSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableSize'; rValue : '������ �������');
  {* '������ �������' }
 str_nevmhhColumnSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhColumnSize'; rValue : '������ �������');
  {* '������ �������' }
 str_nevmhhTableColumn: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableColumn'; rValue : '������� �������');
  {* '������� �������' }
 str_nevmhhTableRow: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhTableRow'; rValue : '������ �������');
  {* '������ �������' }
 str_nevmhhLeftHyperlinkBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhLeftHyperlinkBorder'; rValue : '����� ������� ������');
  {* '����� ������� ������' }
 str_nevmhhRightHyperlinkBorder: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhhRightHyperlinkBorder'; rValue : '������ ������� ������');
  {* '������ ������� ������' }
 {* ������������ ������ TnevMarkerHint }
 str_nevmhLeftIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhLeftIndent'; rValue : '����� ������');
  {* '����� ������' }
 str_nevmhRightIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRightIndent'; rValue : '������ ������');
  {* '������ ������' }
 str_nevmhRedLineIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRedLineIndent'; rValue : '������ ������� ������');
  {* '������ ������� ������' }
 str_nevmhCellSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhCellSize'; rValue : '������ ������');
  {* '������ ������' }
 str_nevmhTableIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhTableIndent'; rValue : '������ �������');
  {* '������ �������' }
 str_nevmhPaperSize: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhPaperSize'; rValue : '������ ������');
  {* '������ ������' }
 str_nevmhLeftDocMargin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhLeftDocMargin'; rValue : '����� ����');
  {* '����� ����' }
 str_nevmhRightDocMargin: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhRightDocMargin'; rValue : '������ ����');
  {* '������ ����' }
 str_nevmhTabIndent: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nevmhTabIndent'; rValue : '�� �����������');
  {* '�� �����������' }

implementation

uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_nevmmSaveText.Init;
 {* ������������� str_nevmmSaveText }
 str_nevmmSaveFormattedText.Init;
 {* ������������� str_nevmmSaveFormattedText }
 str_nevmmReference.Init;
 {* ������������� str_nevmmReference }
 str_nevmmPageCounter.Init;
 {* ������������� str_nevmmPageCounter }
 str_nevmmDocumentCount.Init;
 {* ������������� str_nevmmDocumentCount }
 str_nevmmDocumentCountInt.Init;
 {* ������������� str_nevmmDocumentCountInt }
 str_nevmmComment.Init;
 {* ������������� str_nevmmComment }
 str_nevmmReplace.Init;
 {* ������������� str_nevmmReplace }
 str_nevmmFragment.Init;
 {* ������������� str_nevmmFragment }
 str_nevmmSearch.Init;
 {* ������������� str_nevmmSearch }
 str_nevmmLongOperation.Init;
 {* ������������� str_nevmmLongOperation }
 str_nevmmCommentFolder.Init;
 {* ������������� str_nevmmCommentFolder }
 str_nevmmAnnotation.Init;
 {* ������������� str_nevmmAnnotation }
 str_nevmmChronology.Init;
 {* ������������� str_nevmmChronology }
 str_nevmmTranslation.Init;
 {* ������������� str_nevmmTranslation }
 str_nevmmJurorComment.Init;
 {* ������������� str_nevmmJurorComment }
 str_nevmmJurorCommentDecorate.Init;
 {* ������������� str_nevmmJurorCommentDecorate }
 str_nevmmTOC.Init;
 {* ������������� str_nevmmTOC }
 str_nevmmPageCounterNew.Init;
 {* ������������� str_nevmmPageCounterNew }
 str_nevtfANSI.Init;
 {* ������������� str_nevtfANSI }
 str_nevtfUnicode.Init;
 {* ������������� str_nevtfUnicode }
 str_nevtfOEM.Init;
 {* ������������� str_nevtfOEM }
{$If Defined(evMyEditor)}
 str_nevtfThyEditor.Init;
 {* ������������� str_nevtfThyEditor }
{$IfEnd} // Defined(evMyEditor)
{$If Defined(Nemesis)}
 str_nevtfGarant.Init;
 {* ������������� str_nevtfGarant }
{$IfEnd} // Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_nevtfEverestBin.Init;
 {* ������������� str_nevtfEverestBin }
{$IfEnd} // NOT Defined(Nemesis)
{$If NOT Defined(Nemesis)}
 str_nevtfEverest.Init;
 {* ������������� str_nevtfEverest }
{$IfEnd} // NOT Defined(Nemesis)
 str_nevtfRtf.Init;
 {* ������������� str_nevtfRtf }
 str_nevpmTimeLeft.Init;
 {* ������������� str_nevpmTimeLeft }
 str_nevpmCounting.Init;
 {* ������������� str_nevpmCounting }
 str_nevpmPreparing.Init;
 {* ������������� str_nevpmPreparing }
 str_nevpmPreparingExt.Init;
 {* ������������� str_nevpmPreparingExt }
 str_nevpmPrinting.Init;
 {* ������������� str_nevpmPrinting }
 str_nevpmDocumentList.Init;
 {* ������������� str_nevpmDocumentList }
 str_nevpmDefaultColontitul.Init;
 {* ������������� str_nevpmDefaultColontitul }
 str_nevpmUndefinedSize.Init;
 {* ������������� str_nevpmUndefinedSize }
 str_nevpmUndefinedTopic.Init;
 {* ������������� str_nevpmUndefinedTopic }
 str_nevpmProcessText.Init;
 {* ������������� str_nevpmProcessText }
 str_nevpmProcessPreview.Init;
 {* ������������� str_nevpmProcessPreview }
 str_nevcphExpand.Init;
 {* ������������� str_nevcphExpand }
 str_nevcphCollapse.Init;
 {* ������������� str_nevcphCollapse }
 str_nevcphSelect.Init;
 {* ������������� str_nevcphSelect }
 str_nevcphMove.Init;
 {* ������������� str_nevcphMove }
 str_nevcphChangeTopBorder.Init;
 {* ������������� str_nevcphChangeTopBorder }
 str_nevcphChangeBottomBorder.Init;
 {* ������������� str_nevcphChangeBottomBorder }
 str_nevcphProperties.Init;
 {* ������������� str_nevcphProperties }
 str_nevmcmUndo.Init;
 {* ������������� str_nevmcmUndo }
 str_nevmcmCut.Init;
 {* ������������� str_nevmcmCut }
 str_nevmcmCopy.Init;
 {* ������������� str_nevmcmCopy }
 str_nevmcmPaste.Init;
 {* ������������� str_nevmcmPaste }
 str_nevmcmDelete.Init;
 {* ������������� str_nevmcmDelete }
 str_nevdphExpand.Init;
 {* ������������� str_nevdphExpand }
 str_nevdphCollapse.Init;
 {* ������������� str_nevdphCollapse }
 str_nevdphSelect.Init;
 {* ������������� str_nevdphSelect }
 str_nevdphMove.Init;
 {* ������������� str_nevdphMove }
 str_nevdphChangeTopBorder.Init;
 {* ������������� str_nevdphChangeTopBorder }
 str_nevdphChangeBottomBorder.Init;
 {* ������������� str_nevdphChangeBottomBorder }
 str_nevdphProperties.Init;
 {* ������������� str_nevdphProperties }
 str_nevmhhBlockParams.Init;
 {* ������������� str_nevmhhBlockParams }
 str_nevmhhTableCell.Init;
 {* ������������� str_nevmhhTableCell }
 str_nevmhhTableSize.Init;
 {* ������������� str_nevmhhTableSize }
 str_nevmhhColumnSize.Init;
 {* ������������� str_nevmhhColumnSize }
 str_nevmhhTableColumn.Init;
 {* ������������� str_nevmhhTableColumn }
 str_nevmhhTableRow.Init;
 {* ������������� str_nevmhhTableRow }
 str_nevmhhLeftHyperlinkBorder.Init;
 {* ������������� str_nevmhhLeftHyperlinkBorder }
 str_nevmhhRightHyperlinkBorder.Init;
 {* ������������� str_nevmhhRightHyperlinkBorder }
 str_nevmhLeftIndent.Init;
 {* ������������� str_nevmhLeftIndent }
 str_nevmhRightIndent.Init;
 {* ������������� str_nevmhRightIndent }
 str_nevmhRedLineIndent.Init;
 {* ������������� str_nevmhRedLineIndent }
 str_nevmhCellSize.Init;
 {* ������������� str_nevmhCellSize }
 str_nevmhTableIndent.Init;
 {* ������������� str_nevmhTableIndent }
 str_nevmhPaperSize.Init;
 {* ������������� str_nevmhPaperSize }
 str_nevmhLeftDocMargin.Init;
 {* ������������� str_nevmhLeftDocMargin }
 str_nevmhRightDocMargin.Init;
 {* ������������� str_nevmhRightDocMargin }
 str_nevmhTabIndent.Init;
 {* ������������� str_nevmhTabIndent }

end.
