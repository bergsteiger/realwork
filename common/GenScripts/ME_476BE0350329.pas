unit evdStyles;
 {* �������������� ������ ��������� ����������. }

// ������: "w:\common\components\rtl\Garant\EVD\evdStyles.pas"
// ���������: "Interfaces"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* �������������� ������ ��������� ����������. }
 ev_saEmpty = 0;
  {* "������" ��������. }
 ev_saTxtNormalANSI = -1;
  {* ����������. }
 ev_saTxtNormalOEM = -2;
  {* ���������� (OEM). }
 ev_saTxtHeader1 = -3;
  {* ��������� 1. }
 ev_saTxtHeader2 = -4;
  {* ��������� 2. }
 ev_saTxtHeader3 = -5;
  {* ��������� 3. }
 ev_saTxtHeader4 = -6;
  {* ��������� 4. }
 ev_saTxtOutOfDate = -7;
  {* ������� ����. }
 ev_saHyperLink = -8;
  {* �������������� ������. }
 ev_saTxtComment = -9;
  {* �����������. }
 ev_saColorSelection = -10;
  {* �������� ���������. }
 ev_saHyperLinkCont = -11;
  {* ����������� ������. }
 ev_saANSIDOS = -12;
  {* ������������. }
 ev_saFoundWords = -13;
  {* ��������� �����. }
 ev_saNormalNote = -14;
  {* ���������� (�������). }
 ev_saArticleHeader = -15;
  {* ��������� ������. }
 ev_saToLeft = -16;
  {* �������� �����. }
 ev_saNormalTable = -17;
  {* ���������� ��� ������. }
 ev_saNormalSBSLeft = -18;
  {* ���������� ��� ����� ������ SBS. }
 ev_saNormalSBSRight = -19;
  {* ���������� ��� ������ ������ SBS. }
 ev_saNormalTableList = -20;
  {* ���������� ��� ������� � ���� ������. }
 ev_saTechComment = -21;
  {* ����������� �����������. }
 ev_saVersionInfo = -22;
  {* ���������� � ������. }
 ev_saUserComment = -23;
  {* ����������� ������������ (��� ������� 6�). }
 ev_saContents = -24;
  {* ���������� (��� ������� 6�). }
 ev_saNotApplied = -25;
  {* �� ������� � ����. }
 ev_saDictEntry = -26;
  {* ��������� ������. }
 ev_saHFLeft = -27;
  {* ���������� (�����). }
 ev_saHFRight = -28;
  {* ���������� (������). }
 ev_saMainMenu = -29;
  {* �������� ����. }
 ev_saNormalAnno = -30;
  {* ���������� ��� ���������. }
 ev_saMainMenuConstPath = -31;
  {* ����� ��������� ����, ���������� �����. }
 ev_saMainMenuChangePath = -32;
  {* ����� ��������� ����, ���������� �����. }
 ev_saMainMenuHeader = -33;
  {* ��������� ��������� ����. }
 ev_saMainMenuInteractiveHeader = -34;
  {* ��������� ��������� ����, ���������� ��������������. }
 ev_saObject = -35;
  {* ������-�����, ��� ��������� ���������. }
 ev_saMistake = -36;
  {* ����� � ���������. }
 ev_saEnclosureHeader = -37;
  {* ��������� ����������. }
 ev_saInterface = -38;
  {* ����� ��� ������������ ��������� }
 ev_saActiveHyperlink = -39;
  {* �������� ����������� }
 ev_saCenteredTable = -40;
  {* �������������� � ������� }
 ev_saAddedText = -41;
  {* ����������� �����. [$152961076] }
 ev_saDeletedText = -42;
  {* �������� �����. [$152961076] }
 ev_saChatHeaderSender = -43;
  {* ��������� ������������ ��������� [$152408792] }
 ev_saChatHeaderRecipient = -44;
  {* ��������� ���������� ��������� [$152408792] }
 ev_saHLE1 = -45;
  {* ����������� ��������� }
 ev_saHLE2 = -46;
  {* ���� ����������? }
 ev_saHLE3 = -47;
  {* ��������: ������������������! }
 ev_saHLE4 = -48;
  {* ��������: ��������!! }
 ev_saHLE5 = -49;
  {* ����������. }
 ev_saHLE6 = -50;
  {* ������. }
 ev_saColorSelectionForBaseSearch = - 51;
 ev_saChangesInfo = -52;
  {* ���������� �� ���������� }
 ev_saItalicColorSelectionForBaseSearch = -53;
 ev_saHeaderForChangesInfo = -54;
  {* ��������� ���������� �� ���������� � ��������� }
 ev_saFooterForChangesInfo = -55;
  {* "������" ��� ���������� �� ���������� � ��������� }
 ev_saTextForChangesInfo = -56;
  {* ����� ���������� �� ���������� � ��������� }
 ev_saSubHeaderForChangesInfo = -57;
  {* ������������ ��� ���������� �� ���������� � ��������� }
 ev_saControlsBlockHeader = -58;
  {* ��������� ������ ��������� }
 ev_saCloakHeader = -59;
  {* ��������� ��������������� ����� �������� }
 ev_saLinkToPublication = -60;
  {* ������ �� ����������� ���������� }
 ev_saUnderlinedText = -61;
  {* ����� � ������ ������ }
 ev_saDialogs = -62;
  {* ����� �������� }
 ev_saEditionInterval = -63;
  {* �������� �������� �������� }
 ev_saEdition = -64;
  {* �������� }
 ev_saEditionNumber = -65;
  {* ���������� ����� �������� }
 ev_saNodeGroupHeader = -66;
  {* ��������� ������ �������� }
 ev_saTOC = -67;
  {* ���������� }
 ev_saAttention = -68;
 ev_saWriteToUs = -69;
  {* �������� ��� }
 ev_saTxtNormalAACSeeAlso = -70;
  {* ����� �� (��. �����) }
 ev_saHeaderAACLeftWindow = -71;
  {* ��������� �� (����� ����) }
 ev_saHeaderAACRightWindow = -72;
  {* ��������� �� (������ ����) }
 ev_saContextAACRightWindows = -73;
  {* ��-���������� (������ ����) }
 ev_saFormulaInAAC = -74;
 ev_saSnippet = -75;
  {* �������� ������� ������ }
 ev_saTwoColorTable = -76;
  {* ����������� �������. }
 ev_saBoldSelection = -77;
  {* ��������� ������. }
 ev_saAbolishedDocumentLink = -78;
 ev_saVisitedDocumentInList = -79;
 ev_saVisitedSnippetInList = -80;
 ev_saNewsConfigHyperlink = -81;
  {* ����� ����������� ��� ��������� ��������� �����. }
 ev_saExpandedText = -82;
  {* ����� '��������������� �����' }
 ev_saAACLeftHyperlink = -83;
 ev_saDocumentInList = -84;
 {* ����� ��� Standard }
 ev_Empty = 'Empty';
  {* ��� ��� Empty }
 ev_TxtNormalANSI = 'TxtNormalANSI';
  {* ��� ��� TxtNormalANSI }
 ev_TxtNormalOEM = 'TxtNormalOEM';
  {* ��� ��� TxtNormalOEM }
 ev_TxtHeader1 = 'TxtHeader1';
  {* ��� ��� TxtHeader1 }
 ev_TxtHeader2 = 'TxtHeader2';
  {* ��� ��� TxtHeader2 }
 ev_TxtHeader3 = 'TxtHeader3';
  {* ��� ��� TxtHeader3 }
 ev_TxtHeader4 = 'TxtHeader4';
  {* ��� ��� TxtHeader4 }
 ev_TxtOutOfDate = 'TxtOutOfDate';
  {* ��� ��� TxtOutOfDate }
 ev_HyperLink = 'HyperLink';
  {* ��� ��� HyperLink }
 ev_TxtComment = 'TxtComment';
  {* ��� ��� TxtComment }
 ev_ColorSelection = 'ColorSelection';
  {* ��� ��� ColorSelection }
 ev_HyperLinkCont = 'HyperLinkCont';
  {* ��� ��� HyperLinkCont }
 ev_ANSIDOS = 'ANSIDOS';
  {* ��� ��� ANSIDOS }
 ev_FoundWords = 'FoundWords';
  {* ��� ��� FoundWords }
 ev_NormalNote = 'NormalNote';
  {* ��� ��� NormalNote }
 ev_ArticleHeader = 'ArticleHeader';
  {* ��� ��� ArticleHeader }
 ev_ToLeft = 'ToLeft';
  {* ��� ��� ToLeft }
 ev_NormalTable = 'NormalTable';
  {* ��� ��� NormalTable }
 ev_NormalSBSLeft = 'NormalSBSLeft';
  {* ��� ��� NormalSBSLeft }
 ev_NormalSBSRight = 'NormalSBSRight';
  {* ��� ��� NormalSBSRight }
 ev_NormalTableList = 'NormalTableList';
  {* ��� ��� NormalTableList }
 ev_TechComment = 'TechComment';
  {* ��� ��� TechComment }
 ev_VersionInfo = 'VersionInfo';
  {* ��� ��� VersionInfo }
 ev_UserComment = 'UserComment';
  {* ��� ��� UserComment }
 ev_Contents = 'Contents';
  {* ��� ��� Contents }
 ev_NotApplied = 'NotApplied';
  {* ��� ��� NotApplied }
 ev_DictEntry = 'DictEntry';
  {* ��� ��� DictEntry }
 ev_HFLeft = 'HFLeft';
  {* ��� ��� HFLeft }
 ev_HFRight = 'HFRight';
  {* ��� ��� HFRight }
 ev_MainMenu = 'MainMenu';
  {* ��� ��� MainMenu }
 ev_NormalAnno = 'NormalAnno';
  {* ��� ��� NormalAnno }
 ev_MainMenuConstPath = 'MainMenuConstPath';
  {* ��� ��� MainMenuConstPath }
 ev_MainMenuChangePath = 'MainMenuChangePath';
  {* ��� ��� MainMenuChangePath }
 ev_MainMenuHeader = 'MainMenuHeader';
  {* ��� ��� MainMenuHeader }
 ev_MainMenuInteractiveHeader = 'MainMenuInteractiveHeader';
  {* ��� ��� MainMenuInteractiveHeader }
 ev_Object = 'Object';
  {* ��� ��� Object }
 ev_Mistake = 'Mistake';
  {* ��� ��� Mistake }
 ev_EnclosureHeader = 'EnclosureHeader';
  {* ��� ��� EnclosureHeader }
 ev_Interface = 'Interface';
  {* ��� ��� Interface }
 ev_ActiveHyperlink = 'ActiveHyperlink';
  {* ��� ��� ActiveHyperlink }
 ev_CenteredTable = 'CenteredTable';
  {* ��� ��� CenteredTable }
 ev_AddedText = 'AddedText';
  {* ��� ��� AddedText }
 ev_DeletedText = 'DeletedText';
  {* ��� ��� DeletedText }
 ev_ChatHeaderSender = 'ChatHeaderSender';
  {* ��� ��� ChatHeaderSender }
 ev_ChatHeaderRecipient = 'ChatHeaderRecipient';
  {* ��� ��� ChatHeaderRecipient }
 ev_HLE1 = 'HLE1';
  {* ��� ��� HLE1 }
 ev_HLE2 = 'HLE2';
  {* ��� ��� HLE2 }
 ev_HLE3 = 'HLE3';
  {* ��� ��� HLE3 }
 ev_HLE4 = 'HLE4';
  {* ��� ��� HLE4 }
 ev_HLE5 = 'HLE5';
  {* ��� ��� HLE5 }
 ev_HLE6 = 'HLE6';
  {* ��� ��� HLE6 }
 ev_ColorSelectionForBaseSearch = 'ColorSelectionForBaseSearch';
  {* ��� ��� ColorSelectionForBaseSearch }
 ev_ChangesInfo = 'ChangesInfo';
  {* ��� ��� ChangesInfo }
 ev_ItalicColorSelectionForBaseSearch = 'ItalicColorSelectionForBaseSearch';
  {* ��� ��� ItalicColorSelectionForBaseSearch }
 ev_HeaderForChangesInfo = 'HeaderForChangesInfo';
  {* ��� ��� HeaderForChangesInfo }
 ev_FooterForChangesInfo = 'FooterForChangesInfo';
  {* ��� ��� FooterForChangesInfo }
 ev_TextForChangesInfo = 'TextForChangesInfo';
  {* ��� ��� TextForChangesInfo }
 ev_SubHeaderForChangesInfo = 'SubHeaderForChangesInfo';
  {* ��� ��� SubHeaderForChangesInfo }
 ev_ControlsBlockHeader = 'ControlsBlockHeader';
  {* ��� ��� ControlsBlockHeader }
 ev_CloakHeader = 'CloakHeader';
  {* ��� ��� CloakHeader }
 ev_LinkToPublication = 'LinkToPublication';
  {* ��� ��� LinkToPublication }
 ev_UnderlinedText = 'UnderlinedText';
  {* ��� ��� UnderlinedText }
 ev_Dialogs = 'Dialogs';
  {* ��� ��� Dialogs }
 ev_EditionInterval = 'EditionInterval';
  {* ��� ��� EditionInterval }
 ev_Edition = 'Edition';
  {* ��� ��� Edition }
 ev_EditionNumber = 'EditionNumber';
  {* ��� ��� EditionNumber }
 ev_NodeGroupHeader = 'NodeGroupHeader';
  {* ��� ��� NodeGroupHeader }
 ev_TOC = 'TOC';
  {* ��� ��� TOC }
 ev_Attention = 'Attention';
  {* ��� ��� Attention }
 ev_WriteToUs = 'WriteToUs';
  {* ��� ��� WriteToUs }
 ev_TxtNormalAACSeeAlso = 'TxtNormalAACSeeAlso';
  {* ��� ��� TxtNormalAACSeeAlso }
 ev_HeaderAACLeftWindow = 'HeaderAACLeftWindow';
  {* ��� ��� HeaderAACLeftWindow }
 ev_HeaderAACRightWindow = 'HeaderAACRightWindow';
  {* ��� ��� HeaderAACRightWindow }
 ev_ContextAACRightWindows = 'ContextAACRightWindows';
  {* ��� ��� ContextAACRightWindows }
 ev_FormulaInAAC = 'FormulaInAAC';
  {* ��� ��� FormulaInAAC }
 ev_Snippet = 'Snippet';
  {* ��� ��� Snippet }
 ev_TwoColorTable = 'TwoColorTable';
  {* ��� ��� TwoColorTable }
 ev_BoldSelection = 'BoldSelection';
  {* ��� ��� BoldSelection }
 ev_AbolishedDocumentLink = 'AbolishedDocumentLink';
  {* ��� ��� AbolishedDocumentLink }
 ev_VisitedDocumentInList = 'VisitedDocumentInList';
  {* ��� ��� VisitedDocumentInList }
 ev_VisitedSnippetInList = 'VisitedSnippetInList';
  {* ��� ��� VisitedSnippetInList }
 ev_NewsConfigHyperlink = 'NewsConfigHyperlink';
  {* ��� ��� NewsConfigHyperlink }
 ev_ExpandedText = 'ExpandedText';
  {* ��� ��� ExpandedText }
 ev_AACLeftHyperlink = 'AACLeftHyperlink';
  {* ��� ��� AACLeftHyperlink }
 ev_DocumentInList = 'DocumentInList';
  {* ��� ��� DocumentInList }

type
 TevStandardStyle = EnclosureHeader .. TxtNormalANSI;
  {* ���, ������������ �������� ����������� ������. }

 TevStandardStylesNSRC = -High(TevStandardStyle) .. -Low(TevStandardStyle);

 TevStandardCachedStyle = NewsConfigHyperlink .. TxtNormalANSI;

 TevStandardStylesP = -High(TevStandardCachedStyle) .. -Low(TevStandardCachedStyle);

 TevStandardStyles = set of TevStandardStylesP;
  {* ���, ������������ ��������� �� ��������� ����������� ������. }

implementation

uses
 l3ImplUses
;

end.
