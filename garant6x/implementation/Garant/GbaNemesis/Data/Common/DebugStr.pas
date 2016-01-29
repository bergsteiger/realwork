Unit DebugStr;

// ��������� ���� ���������� ��������� �������� (Assert � ��.) �� ���� ������

interface

const
// Unit - dsUserList
  caUnknownUserNodeType = '����������� ��� ���� �������������';

// Unit - bsConvert
  caAdapterLanguageCHanged = '���� ��������� ������ ������������� ����� �� ��������';

// Unit - sdsDocInfo
  caRespCorrestUnsupported = '���� �������� ��� � ����� �� ��������������';
  caAnnotationNotFound = '� ��������� ������ ���� ���������, �� ������� �� �� �����';

// Unit - sdsDocument
  capDocumentEnter = '���� ��������_���������';

// Unit - dsDocumentList
  caINodeIndexPathToINodeBaseFailed = 'INodeBase �� INodeIndexPath �� ���� ��������.';
  caUnknownElementType = '�� ��������� ��� �������� ������.';

// Unit - sdsAttributeSelect
  caUninitializedFormsetData = '�� ���� ������������ ������ ��� ������������� ������.';

// Unit - cfStyleEditor
  caSettingsWithoutContainer = '��� ���������� ��� ��������';

// Unit - moSearch
  caUnknownFilterType = '�� ��������� ��� �������';

// Unit - nsConfiguration
  caNoActiveConfig = '��� �������� ������������';
  caNoSettings = '��� ��������';

// Unit - DataAdapter
  caWrongDllVersion = '����������� ������ ����������! ������ ���������� ���������� �� ���������� ���������';

// Unit - Document
  c_prDocument = '�������� ���������';
  c_prQueryCard = '�������� ������� 6.�';
  c_prListAfterSearch = '������ ����� ������';
  c_prMainMenu = '�������� ��������� ����';

// Unit - nsStreamDocument
  capDocumentExit = '����� ��������_���������';
  capDocumentReadTimeWOPipe = '����� ������ ��� ����� (desktop)';
  capDocumentBeforeReadTime = '����� �� ������ pm_GetDocument �� ���������� ������ �� ���������� �����';
  capDocumentReadWPipeTime = '%d ����� ������ �� �����';
  capDocumentAfterReadTime = '%d ����� ���������� ������ - ������� �� Sub � �.�.';

// Unit - SynchroViewContainer
  caUnsupported = '�� ��������������';

// Unit - TextForm
  caTextFormUpdateAdditionalFormsEnter = '���� � TTextForm.UpdateAditionalForms';
  caTextFormUpdateAdditionalFormsExit = '����� �� TTextForm.UpdateAditionalForms';
  caTextFormRelatedDocsUpdateEnter = '���� � RelatedDocsUpdate';
  caTextFormRelatedDocsUpdateExit = '����� �� RelatedDocsUpdate';

// Unit - nsApplication
  caWrongQueryParameters = '������������ ������ ���������� ��� �������� �������.';
  caUnknownQueryType = '����������� ��� ������� %s';

// Unit - nsQueryAttribute;
  caUnsuppotedAttributeType = '�� �������������� ��� ���������! ';
  caFieldNotAdded = '�� ���� ��������� ����! ';
  caFieldNotInitialized = '�� ���������������� ����! ';
  caUnknownControlType = '����������� ��� ��������!';

// Unit - Common
  caDataNotDefined = '��� �������� ���������� ���������� ������ IdeConsultation';

// Unit - sdsConsultation
  caConsultationNotReceived = '������������ �� ��������';
  caConsultationAnswerNotSet = '����� ������������ �� ���������';

// Unit - nsQueryUtils
  caQueryTypeIsNotDefined = '��� ������� �� ���������';

// Unit - dsConsultationMark
  caConsultationIsNotDefined = '������������ �� ����������, ����������� ' +
                               '������ �� ��������.';

// Unit - usUtils
  caUnknownUseCaseType = '�� ��������� ��� ����������.';

// Unit - bsConvert
  caUnknownConsultationMark = '�� ��������� ��� ������';
  caUnknownWordPosition = '�� ��������� ��� Tl3WordPosition';

// Unit - nsQueryUtils
type
 TnsNumberSufixes = (
  ns_nsTenth, // *10, *11, ... , *19,
  ns_nsSingle, // *1
  ns_nsFew, // *2, *3, *4
  ns_nsSome); // *5, *6, *7, *8, *9, *0

 TnsNumberSufixesArray = array [TnsNumberSufixes] of string;

const
  cseDocument: TnsNumberSufixesArray = (
   '����������',
   '��������',
   '���������',
   '����������');

  cseEdition: TnsNumberSufixesArray = (
   '��������',
   '��������',
   '��������',
   '��������');

  cseEntry: TnsNumberSufixesArray = (
   '���������',
   '���������',
   '���������',
   '���������');

  cseSinglePrefix = '������'; // ��� *1, ����� *11
  cseOtherPrefix = '�������';
  cseSingleFilterFound = '%s %d %s � �������������� ������� "%s".'#13'��������� ������?';
  cseManyFilterFound = '%s %d %s � �������������� %d ��������.'#13'��������� ������?';
  cseBuildList = '�������: %d %s, %d %s (%d %s � ��������� � ��������).'#13'��������� ������?';
  cseBuildListWOEdition = '�������: %d %s (%d %s � ���������).'#13'��������� ������?';
  cseBuildListWOEntry = '�������: %d %s, %d %s.'#13'��������� ������?';
  cseBuildListWOEditionWOEntry = '�������: %d %s.'#13'��������� ������?';

  cseBuildAutoReferat = '�������: %d %s, %d %s (%d %s � ��������� � ��������).'#13'��������� ����� ��������� ����������������?';
  cseBuildAutoReferatWOEdition = '�������: %d %s (%d %s � ���������).'#13'��������� ����� ��������� ����������������?';
  cseBuildAutoReferatWOEntry = '�������: %d %s, %d %s.'#13'��������� ����� ��������� ����������������?';
  cseBuildAutoReferatWOEditionWOEntry = '�������: %d %s.'#13'��������� ����� ��������� ����������������?';

  cseSingleFilterNotFound = '�� ���� ��������� �������� �� ������������� ������� "%s".'#13'��������� ������ ��� ����� ������� (%d %s, %d %s (%d %s � ��������� � ��������))?';
  cseSingleFilterNotFoundWOEdition = '�� ���� ��������� �������� �� ������������� ������� "%s".'#13'��������� ������ ��� ����� ������� (%d %s (%d %s � ���������))?';
  cseSingleFilterNotFoundWOEntry = '�� ���� ��������� �������� �� ������������� ������� "%s".'#13'��������� ������ ��� ����� ������� (%d %s, %d %s)?';
  cseSingleFilterNotFoundWOEditionWOEntry = '�� ���� ��������� �������� �� ������������� ������� "%s".'#13'��������� ������ ��� ����� ������� (%d %s)?';

  cseManyFilterNotFound = '�� ���� ��������� �������� �� ������������� �������� ��������.'#13'��������� ������ ��� ����� �������� (%d %s, %d %s (%d %s � ��������� � ��������))?';
  cseManyFilterNotFoundWOEdition = '�� ���� ��������� �������� �� ������������� �������� ��������.'#13'��������� ������ ��� ����� �������� (%d %s (%d %s � ���������))?';
  cseManyFilterNotFoundWOEntry = '�� ���� ��������� �������� �� ������������� �������� ��������.'#13'��������� ������ ��� ����� �������� (%d %s, %d %s)?';
  cseManyFilterNotFoundWOEditionWOEntry = '�� ���� ��������� �������� �� ������������� �������� ��������.'#13'��������� ������ ��� ����� �������� (%d %s)?';


implementation

end.
