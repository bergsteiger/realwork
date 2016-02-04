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
 StandardNames: array [0 .. 85] of PAnsiChar = ('Empty'
 , 'TxtNormalANSI'
 , 'TxtNormalOEM'
 , 'TxtHeader1'
 , 'TxtHeader2'
 , 'TxtHeader3'
 , 'TxtHeader4'
 , 'TxtOutOfDate'
 , 'HyperLink'
 , 'TxtComment'
 , 'ColorSelection'
 , 'HyperLinkCont'
 , 'ANSIDOS'
 , 'FoundWords'
 , 'NormalNote'
 , 'ArticleHeader'
 , 'ToLeft'
 , 'NormalTable'
 , 'NormalSBSLeft'
 , 'NormalSBSRight'
 , 'NormalTableList'
 , 'TechComment'
 , 'VersionInfo'
 , 'UserComment'
 , 'Contents'
 , 'NotApplied'
 , 'DictEntry'
 , 'HFLeft'
 , 'HFRight'
 , 'MainMenu'
 , 'NormalAnno'
 , 'MainMenuConstPath'
 , 'MainMenuChangePath'
 , 'MainMenuHeader'
 , 'MainMenuInteractiveHeader'
 , 'Object'
 , 'Mistake'
 , 'EnclosureHeader'
 , 'Interface'
 , 'ActiveHyperlink'
 , 'CenteredTable'
 , 'AddedText'
 , 'DeletedText'
 , 'ChatHeaderSender'
 , 'ChatHeaderRecipient'
 , 'HLE1'
 , 'HLE2'
 , 'HLE3'
 , 'HLE4'
 , 'HLE5'
 , 'HLE6'
 , 'ColorSelectionForBaseSearch'
 , 'ChangesInfo'
 , 'ItalicColorSelectionForBaseSearch'
 , 'HeaderForChangesInfo'
 , 'FooterForChangesInfo'
 , 'TextForChangesInfo'
 , 'SubHeaderForChangesInfo'
 , 'ControlsBlockHeader'
 , 'CloakHeader'
 , 'LinkToPublication'
 , 'UnderlinedText'
 , 'Dialogs'
 , 'EditionInterval'
 , 'Edition'
 , 'EditionNumber'
 , 'NodeGroupHeader'
 , 'TOC'
 , 'Attention'
 , 'WriteToUs'
 , 'TxtNormalAACSeeAlso'
 , 'HeaderAACLeftWindow'
 , 'HeaderAACRightWindow'
 , 'ContextAACRightWindows'
 , 'FormulaInAAC'
 , 'Snippet'
 , 'TwoColorTable'
 , 'BoldSelection'
 , 'AbolishedDocumentLink'
 , 'VisitedDocumentInList'
 , 'VisitedSnippetInList'
 , 'NewsConfigHyperlink'
 , 'ExpandedText'
 , 'AACLeftHyperlink'
 , 'DocumentInList'
 );

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
