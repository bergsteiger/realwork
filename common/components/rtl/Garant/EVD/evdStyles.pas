unit evdStyles;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/evdStyles.pas"
// �����: 21.04.1997 18:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EVD::Styles
//
// �������������� ������ ��������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

const
  { �������������� ������ ��������� ����������. }
 ev_saEmpty = 0;
  { "������" ��������. }
 ev_saTxtNormalANSI = -1;
  { ����������. }
 ev_saTxtNormalOEM = -2;
  { ���������� (OEM). }
 ev_saTxtHeader1 = -3;
  { ��������� 1. }
 ev_saTxtHeader2 = -4;
  { ��������� 2. }
 ev_saTxtHeader3 = -5;
  { ��������� 3. }
 ev_saTxtHeader4 = -6;
  { ��������� 4. }
 ev_saTxtOutOfDate = -7;
  { ������� ����. }
 ev_saHyperLink = -8;
  { �������������� ������. }
 ev_saTxtComment = -9;
  { �����������. }
 ev_saColorSelection = -10;
  { �������� ���������. }
 ev_saHyperLinkCont = -11;
  { ����������� ������. }
 ev_saANSIDOS = -12;
  { ������������. }
 ev_saFoundWords = -13;
  { ��������� �����. }
 ev_saNormalNote = -14;
  { ���������� (�������). }
 ev_saArticleHeader = -15;
  { ��������� ������. }
 ev_saToLeft = -16;
  { �������� �����. }
 ev_saNormalTable = -17;
  { ���������� ��� ������. }
 ev_saNormalSBSLeft = -18;
  { ���������� ��� ����� ������ SBS. }
 ev_saNormalSBSRight = -19;
  { ���������� ��� ������ ������ SBS. }
 ev_saNormalTableList = -20;
  { ���������� ��� ������� � ���� ������. }
 ev_saTechComment = -21;
  { ����������� �����������. }
 ev_saVersionInfo = -22;
  { ���������� � ������. }
 ev_saUserComment = -23;
  { ����������� ������������ (��� ������� 6�). }
 ev_saContents = -24;
  { ���������� (��� ������� 6�). }
 ev_saNotApplied = -25;
  { �� ������� � ����. }
 ev_saDictEntry = -26;
  { ��������� ������. }
 ev_saHFLeft = -27;
  { ���������� (�����). }
 ev_saHFRight = -28;
  { ���������� (������). }
 ev_saMainMenu = -29;
  { �������� ����. }
 ev_saNormalAnno = -30;
  { ���������� ��� ���������. }
 ev_saMainMenuConstPath = -31;
  { ����� ��������� ����, ���������� �����. }
 ev_saMainMenuChangePath = -32;
  { ����� ��������� ����, ���������� �����. }
 ev_saMainMenuHeader = -33;
  { ��������� ��������� ����. }
 ev_saMainMenuInteractiveHeader = -34;
  { ��������� ��������� ����, ���������� ��������������. }
 ev_saObject = -35;
  { ������-�����, ��� ��������� ���������. }
 ev_saMistake = -36;
  { ����� � ���������. }
 ev_saEnclosureHeader = -37;
  { ��������� ����������. }
 ev_saInterface = -38;
  { ����� ��� ������������ ��������� }
 ev_saActiveHyperlink = -39;
  { �������� ����������� }
 ev_saCenteredTable = -40;
  { �������������� � ������� }
 ev_saAddedText = -41;
  { ����������� �����. [$152961076] }
 ev_saDeletedText = -42;
  { �������� �����. [$152961076] }
 ev_saChatHeaderSender = -43;
  { ��������� ������������ ��������� [$152408792] }
 ev_saChatHeaderRecipient = -44;
  { ��������� ���������� ��������� [$152408792] }
 ev_saHLE1 = -45;
  { ����������� ��������� }
 ev_saHLE2 = -46;
  { ���� ����������? }
 ev_saHLE3 = -47;
  { ��������: ������������������! }
 ev_saHLE4 = -48;
  { ��������: ��������!! }
 ev_saHLE5 = -49;
  { ����������. }
 ev_saHLE6 = -50;
  { ������. }
 ev_saColorSelectionForBaseSearch = - 51;
 ev_saChangesInfo = -52;
  { ���������� �� ���������� }
 ev_saItalicColorSelectionForBaseSearch = -53;
 ev_saHeaderForChangesInfo = -54;
  { ��������� ���������� �� ���������� � ��������� }
 ev_saFooterForChangesInfo = -55;
  { "������" ��� ���������� �� ���������� � ��������� }
 ev_saTextForChangesInfo = -56;
  { ����� ���������� �� ���������� � ��������� }
 ev_saSubHeaderForChangesInfo = -57;
  { ������������ ��� ���������� �� ���������� � ��������� }
 ev_saControlsBlockHeader = -58;
  { ��������� ������ ��������� }
 ev_saCloakHeader = -59;
  { ��������� ��������������� ����� �������� }
 ev_saLinkToPublication = -60;
  { ������ �� ����������� ���������� }
 ev_saUnderlinedText = -61;
  { ����� � ������ ������ }
 ev_saDialogs = -62;
  { ����� �������� }
 ev_saEditionInterval = -63;
  { �������� �������� �������� }
 ev_saEdition = -64;
  { �������� }
 ev_saEditionNumber = -65;
  { ���������� ����� �������� }
 ev_saNodeGroupHeader = -66;
  { ��������� ������ �������� }
 ev_saTOC = -67;
  { ���������� }
 ev_saAttention = -68;
 ev_saWriteToUs = -69;
  { �������� ��� }
 ev_saTxtNormalAACSeeAlso = -70;
  { ����� �� (��. �����) }
 ev_saHeaderAACLeftWindow = -71;
  { ��������� �� (����� ����) }
 ev_saHeaderAACRightWindow = -72;
  { ��������� �� (������ ����) }
 ev_saContextAACRightWindows = -73;
  { ��-���������� (������ ����) }
 ev_saFormulaInAAC = -74;
 ev_saSnippet = -75;
  { �������� ������� ������ }
 ev_saTwoColorTable = -76;
  { ����������� �������. }
 ev_saBoldSelection = -77;
  { ��������� ������. }
 ev_saAbolishedDocumentLink = -78;
 ev_saVisitedDocumentInList = -79;
 ev_saVisitedSnippetInList = -80;
 ev_saNewsConfigHyperlink = -81;
  { ����� ����������� ��� ��������� ��������� �����. }
 ev_saExpandedText = -82;
  { ����� '��������������� �����' }
 ev_saAACLeftHyperlink = -83;

type
 TevStandardStyle = ev_saEnclosureHeader..ev_saTxtNormalANSI;
  {* ���, ������������ �������� ����������� ������. }

 TevStandardStylesNSRC = -High(TevStandardStyle)..-Low(TevStandardStyle);

 TevStandardCachedStyle = ev_saNewsConfigHyperlink..ev_saTxtNormalANSI;

 TevStandardStylesP = -High(TevStandardCachedStyle)..-Low(TevStandardCachedStyle);

 TevStandardStyles = set of TevStandardStylesP;
  {* ���, ������������ ��������� �� ��������� ����������� ������. }

const
  { ����� ��� Standard }
 StandardNames : array [0..83] of PAnsiChar = (
  'Empty'
  { ��� ��� Empty }
  , 'TxtNormalANSI'
  { ��� ��� TxtNormalANSI }
  , 'TxtNormalOEM'
  { ��� ��� TxtNormalOEM }
  , 'TxtHeader1'
  { ��� ��� TxtHeader1 }
  , 'TxtHeader2'
  { ��� ��� TxtHeader2 }
  , 'TxtHeader3'
  { ��� ��� TxtHeader3 }
  , 'TxtHeader4'
  { ��� ��� TxtHeader4 }
  , 'TxtOutOfDate'
  { ��� ��� TxtOutOfDate }
  , 'HyperLink'
  { ��� ��� HyperLink }
  , 'TxtComment'
  { ��� ��� TxtComment }
  , 'ColorSelection'
  { ��� ��� ColorSelection }
  , 'HyperLinkCont'
  { ��� ��� HyperLinkCont }
  , 'ANSIDOS'
  { ��� ��� ANSIDOS }
  , 'FoundWords'
  { ��� ��� FoundWords }
  , 'NormalNote'
  { ��� ��� NormalNote }
  , 'ArticleHeader'
  { ��� ��� ArticleHeader }
  , 'ToLeft'
  { ��� ��� ToLeft }
  , 'NormalTable'
  { ��� ��� NormalTable }
  , 'NormalSBSLeft'
  { ��� ��� NormalSBSLeft }
  , 'NormalSBSRight'
  { ��� ��� NormalSBSRight }
  , 'NormalTableList'
  { ��� ��� NormalTableList }
  , 'TechComment'
  { ��� ��� TechComment }
  , 'VersionInfo'
  { ��� ��� VersionInfo }
  , 'UserComment'
  { ��� ��� UserComment }
  , 'Contents'
  { ��� ��� Contents }
  , 'NotApplied'
  { ��� ��� NotApplied }
  , 'DictEntry'
  { ��� ��� DictEntry }
  , 'HFLeft'
  { ��� ��� HFLeft }
  , 'HFRight'
  { ��� ��� HFRight }
  , 'MainMenu'
  { ��� ��� MainMenu }
  , 'NormalAnno'
  { ��� ��� NormalAnno }
  , 'MainMenuConstPath'
  { ��� ��� MainMenuConstPath }
  , 'MainMenuChangePath'
  { ��� ��� MainMenuChangePath }
  , 'MainMenuHeader'
  { ��� ��� MainMenuHeader }
  , 'MainMenuInteractiveHeader'
  { ��� ��� MainMenuInteractiveHeader }
  , 'Object'
  { ��� ��� Object }
  , 'Mistake'
  { ��� ��� Mistake }
  , 'EnclosureHeader'
  { ��� ��� EnclosureHeader }
  , 'Interface'
  { ��� ��� Interface }
  , 'ActiveHyperlink'
  { ��� ��� ActiveHyperlink }
  , 'CenteredTable'
  { ��� ��� CenteredTable }
  , 'AddedText'
  { ��� ��� AddedText }
  , 'DeletedText'
  { ��� ��� DeletedText }
  , 'ChatHeaderSender'
  { ��� ��� ChatHeaderSender }
  , 'ChatHeaderRecipient'
  { ��� ��� ChatHeaderRecipient }
  , 'HLE1'
  { ��� ��� HLE1 }
  , 'HLE2'
  { ��� ��� HLE2 }
  , 'HLE3'
  { ��� ��� HLE3 }
  , 'HLE4'
  { ��� ��� HLE4 }
  , 'HLE5'
  { ��� ��� HLE5 }
  , 'HLE6'
  { ��� ��� HLE6 }
  , 'ColorSelectionForBaseSearch'
  { ��� ��� ColorSelectionForBaseSearch }
  , 'ChangesInfo'
  { ��� ��� ChangesInfo }
  , 'ItalicColorSelectionForBaseSearch'
  { ��� ��� ItalicColorSelectionForBaseSearch }
  , 'HeaderForChangesInfo'
  { ��� ��� HeaderForChangesInfo }
  , 'FooterForChangesInfo'
  { ��� ��� FooterForChangesInfo }
  , 'TextForChangesInfo'
  { ��� ��� TextForChangesInfo }
  , 'SubHeaderForChangesInfo'
  { ��� ��� SubHeaderForChangesInfo }
  , 'ControlsBlockHeader'
  { ��� ��� ControlsBlockHeader }
  , 'CloakHeader'
  { ��� ��� CloakHeader }
  , 'LinkToPublication'
  { ��� ��� LinkToPublication }
  , 'UnderlinedText'
  { ��� ��� UnderlinedText }
  , 'Dialogs'
  { ��� ��� Dialogs }
  , 'EditionInterval'
  { ��� ��� EditionInterval }
  , 'Edition'
  { ��� ��� Edition }
  , 'EditionNumber'
  { ��� ��� EditionNumber }
  , 'NodeGroupHeader'
  { ��� ��� NodeGroupHeader }
  , 'TOC'
  { ��� ��� TOC }
  , 'Attention'
  { ��� ��� Attention }
  , 'WriteToUs'
  { ��� ��� WriteToUs }
  , 'TxtNormalAACSeeAlso'
  { ��� ��� TxtNormalAACSeeAlso }
  , 'HeaderAACLeftWindow'
  { ��� ��� HeaderAACLeftWindow }
  , 'HeaderAACRightWindow'
  { ��� ��� HeaderAACRightWindow }
  , 'ContextAACRightWindows'
  { ��� ��� ContextAACRightWindows }
  , 'FormulaInAAC'
  { ��� ��� FormulaInAAC }
  , 'Snippet'
  { ��� ��� Snippet }
  , 'TwoColorTable'
  { ��� ��� TwoColorTable }
  , 'BoldSelection'
  { ��� ��� BoldSelection }
  , 'AbolishedDocumentLink'
  { ��� ��� AbolishedDocumentLink }
  , 'VisitedDocumentInList'
  { ��� ��� VisitedDocumentInList }
  , 'VisitedSnippetInList'
  { ��� ��� VisitedSnippetInList }
  , 'NewsConfigHyperlink'
  { ��� ��� NewsConfigHyperlink }
  , 'ExpandedText'
  { ��� ��� ExpandedText }
  , 'AACLeftHyperlink'
  { ��� ��� AACLeftHyperlink }
 );//StandardNames

implementation

end.