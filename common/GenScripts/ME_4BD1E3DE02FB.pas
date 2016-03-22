{$IfNDef DocumentUserTypes_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes.imp.pas"
// ���������: "VCMForm"
// ������� ������: "DocumentUserTypes" MUID: (4BD1E3DE02FB)
// ��� ����: "_DocumentUserTypes_"

{$Define DocumentUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _DocumentUserTypes_ = {abstract} class(_DocumentUserTypes_Parent_)
  {* ���������������� ���� ��������� }
  protected
   procedure dftRelatedDocQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftRelatedDoc.OnQueryClose }
   procedure dftDocSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftDocSynchroView.OnQueryMaximized }
   procedure dftDocSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftDocSynchroView.OnQueryOpen }
   procedure dftDictSubEntryQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftDictSubEntry.OnQueryClose }
   procedure dftAnnotationQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftAnnotation.OnQueryClose }
   procedure dftTranslationQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftTranslation.OnQueryMaximized }
   procedure dftTranslationQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftTranslation.OnQueryOpen }
   procedure dftTranslationQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftTranslation.OnQueryClose }
   procedure dftMedicFirmSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftMedicFirmSynchroView.OnQueryMaximized }
   procedure dftMedicFirmSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftMedicFirmSynchroView.OnQueryOpen }
   procedure dftDrugSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftDrugSynchroView.OnQueryMaximized }
   procedure dftDrugSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftDrugSynchroView.OnQueryOpen }
   procedure dftChronologyQueryClose(aSender: TObject); virtual; abstract;
    {* ���������� ������� dftChronology.OnQueryClose }
 end;//_DocumentUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_DocumentUserTypes_ = _DocumentUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else DocumentUserTypes_imp}

{$IfNDef DocumentUserTypes_imp_impl}

{$Define DocumentUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* ������������ ������ dftNoneLocalConstants }
 str_dftNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftNoneCaption'; rValue : '��������');
  {* ��������� ����������������� ���� "��������" }
 {* ������������ ������ dftDocumentLocalConstants }
 str_dftDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentCaption'; rValue : '�����');
  {* ��������� ����������������� ���� "�����" }
 str_dftDocumentSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentSettingsCaption'; rValue : '��������: ����� ���������');
  {* ��������� ����������������� ���� "�����" ��� ��������� ������� ������������ }
 {* ������������ ������ dftRelatedDocLocalConstants }
 str_dftRelatedDocCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocCaption'; rValue : '�������');
  {* ��������� ����������������� ���� "�������" }
 str_dftRelatedDocSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocSettingsCaption'; rValue : '��������: ������� � ���������');
  {* ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftDocSynchroViewLocalConstants }
 str_dftDocSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewCaption'; rValue : '����� ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "����� ��������� (���������� ��������)" }
 str_dftDocSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewSettingsCaption'; rValue : '���������� ��������: ����� ���������');
  {* ��������� ����������������� ���� "����� ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ dftRelatedSynchroViewLocalConstants }
 str_dftRelatedSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewCaption'; rValue : '������� � ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "������� � ��������� (���������� ��������)" }
 str_dftRelatedSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewSettingsCaption'; rValue : '���������� ��������: ������� � ���������');
  {* ��������� ����������������� ���� "������� � ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ dftDictEntryLocalConstants }
 str_dftDictEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntryCaption'; rValue : '����� ��������� ������');
  {* ��������� ����������������� ���� "����� ��������� ������" }
 str_dftDictEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntrySettingsCaption'; rValue : '�������� �������: ����� ��������� ������');
  {* ��������� ����������������� ���� "����� ��������� ������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftDictSubEntryLocalConstants }
 str_dftDictSubEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntryCaption'; rValue : '������� ��������� ������');
  {* ��������� ����������������� ���� "������� ��������� ������" }
 str_dftDictSubEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntrySettingsCaption'; rValue : '�������� �������: ������� ��������� ������');
  {* ��������� ����������������� ���� "������� ��������� ������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAnnotationLocalConstants }
 str_dftAnnotationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationCaption'; rValue : '���������');
  {* ��������� ����������������� ���� "���������" }
 str_dftAnnotationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSettingsCaption'; rValue : '��������: �������������� ����������');
  {* ��������� ����������������� ���� "���������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAutoreferatAfterSearchLocalConstants }
 str_dftAutoreferatAfterSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchCaption'; rValue : '�����. ����� ��������� ����������������');
  {* ��������� ����������������� ���� "�����. ����� ��������� ����������������" }
 str_dftAutoreferatAfterSearchSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchSettingsCaption'; rValue : '��������: �����. ����� ��������� ����������������');
  {* ��������� ����������������� ���� "�����. ����� ��������� ����������������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftConsultationLocalConstants }
 str_dftConsultationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationCaption'; rValue : '������������');
  {* ��������� ����������������� ���� "������������" }
 str_dftConsultationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationSettingsCaption'; rValue : '��������: ������������');
  {* ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftTranslationLocalConstants }
 str_dftTranslationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationCaption'; rValue : '�������');
  {* ��������� ����������������� ���� "�������" }
 str_dftTranslationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationSettingsCaption'; rValue : '��������: �������');
  {* ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAnnotationSynchroViewLocalConstants }
 str_dftAnnotationSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewCaption'; rValue : '��������� (���������� ��������)');
  {* ��������� ����������������� ���� "��������� (���������� ��������)" }
 str_dftAnnotationSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewSettingsCaption'; rValue : '���������� ��������: �������������� ����������');
  {* ��������� ����������������� ���� "��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ dftTipsLocalConstants }
 str_dftTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsCaption'; rValue : '����� ���');
  {* ��������� ����������������� ���� "����� ���" }
 str_dftTipsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsSettingsCaption'; rValue : '����� ���: ����� ������');
  {* ��������� ����������������� ���� "����� ���" ��� ��������� ������� ������������ }
 {* ������������ ������ dftMedDictEntryLocalConstants }
 str_dftMedDictEntryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntryCaption'; rValue : '�������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" }
 str_dftMedDictEntrySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntrySettingsCaption'; rValue : '������� ����������� ��������: �������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAutoreferatLocalConstants }
 str_dftAutoreferatCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatCaption'; rValue : '�����. ��� ��������� �����');
  {* ��������� ����������������� ���� "�����. ��� ��������� �����" }
 str_dftAutoreferatSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatSettingsCaption'; rValue : '��������: �����. ��� ��������� �����');
  {* ��������� ����������������� ���� "�����. ��� ��������� �����" ��� ��������� ������� ������������ }
 {* ������������ ������ dftDrugLocalConstants }
 str_dftDrugCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugCaption'; rValue : '�������� ���������');
  {* ��������� ����������������� ���� "�������� ���������" }
 {* ������������ ������ dftMedicFirmLocalConstants }
 str_dftMedicFirmCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmCaption'; rValue : '�������� �����');
  {* ��������� ����������������� ���� "�������� �����" }
 {* ������������ ������ dftMedicFirmSynchroViewLocalConstants }
 str_dftMedicFirmSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewCaption'; rValue : '�������� ����� (���������� ��������)');
  {* ��������� ����������������� ���� "�������� ����� (���������� ��������)" }
 str_dftMedicFirmSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� �����');
  {* ��������� ����������������� ���� "�������� ����� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ dftDrugSynchroViewLocalConstants }
 str_dftDrugSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewCaption'; rValue : '�������� ��������� (���������� ��������)');
  {* ��������� ����������������� ���� "�������� ��������� (���������� ��������)" }
 str_dftDrugSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� ���������');
  {* ��������� ����������������� ���� "�������� ��������� (���������� ��������)" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAACLeftLocalConstants }
 str_dftAACLeftCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftCaption'; rValue : '����� ����� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ������������ �������" }
 str_dftAACLeftSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftSettingsCaption'; rValue : '����� ����� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ������������ �������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAACRightLocalConstants }
 str_dftAACRightCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightCaption'; rValue : '������ ����� ������������ �������');
  {* ��������� ����������������� ���� "������ ����� ������������ �������" }
 str_dftAACRightSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightSettingsCaption'; rValue : '������ ����� ������������ �������');
  {* ��������� ����������������� ���� "������ ����� ������������ �������" ��� ��������� ������� ������������ }
 {* ������������ ������ dftAACContentsLeftLocalConstants }
 str_dftAACContentsLeftCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsLeftCaption'; rValue : '����� ����� ���������� ������������ �������');
  {* ��������� ����������������� ���� "����� ����� ���������� ������������ �������" }
 {* ������������ ������ dftAACContentsRightLocalConstants }
 str_dftAACContentsRightCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsRightCaption'; rValue : '������ ����� ���������� ������������ �������');
  {* ��������� ����������������� ���� "������ ����� ���������� ������������ �������" }
 {* ������������ ������ dftChronologyLocalConstants }
 str_dftChronologyCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologyCaption'; rValue : '���������� ��������� ����');
  {* ��������� ����������������� ���� "���������� ��������� ����" }
 str_dftChronologySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologySettingsCaption'; rValue : '��������: ���������� ��������� ����');
  {* ��������� ����������������� ���� "���������� ��������� ����" ��� ��������� ������� ������������ }

{$Else DocumentUserTypes_imp_impl}

 str_dftNoneCaption.Init;
 {* ������������� str_dftNoneCaption }
 str_dftDocumentCaption.Init;
 {* ������������� str_dftDocumentCaption }
 str_dftDocumentSettingsCaption.Init;
 {* ������������� str_dftDocumentSettingsCaption }
 str_dftRelatedDocCaption.Init;
 {* ������������� str_dftRelatedDocCaption }
 str_dftRelatedDocSettingsCaption.Init;
 {* ������������� str_dftRelatedDocSettingsCaption }
 str_dftDocSynchroViewCaption.Init;
 {* ������������� str_dftDocSynchroViewCaption }
 str_dftDocSynchroViewSettingsCaption.Init;
 {* ������������� str_dftDocSynchroViewSettingsCaption }
 str_dftRelatedSynchroViewCaption.Init;
 {* ������������� str_dftRelatedSynchroViewCaption }
 str_dftRelatedSynchroViewSettingsCaption.Init;
 {* ������������� str_dftRelatedSynchroViewSettingsCaption }
 str_dftDictEntryCaption.Init;
 {* ������������� str_dftDictEntryCaption }
 str_dftDictEntrySettingsCaption.Init;
 {* ������������� str_dftDictEntrySettingsCaption }
 str_dftDictSubEntryCaption.Init;
 {* ������������� str_dftDictSubEntryCaption }
 str_dftDictSubEntrySettingsCaption.Init;
 {* ������������� str_dftDictSubEntrySettingsCaption }
 str_dftAnnotationCaption.Init;
 {* ������������� str_dftAnnotationCaption }
 str_dftAnnotationSettingsCaption.Init;
 {* ������������� str_dftAnnotationSettingsCaption }
 str_dftAutoreferatAfterSearchCaption.Init;
 {* ������������� str_dftAutoreferatAfterSearchCaption }
 str_dftAutoreferatAfterSearchSettingsCaption.Init;
 {* ������������� str_dftAutoreferatAfterSearchSettingsCaption }
 str_dftConsultationCaption.Init;
 {* ������������� str_dftConsultationCaption }
 str_dftConsultationSettingsCaption.Init;
 {* ������������� str_dftConsultationSettingsCaption }
 str_dftTranslationCaption.Init;
 {* ������������� str_dftTranslationCaption }
 str_dftTranslationSettingsCaption.Init;
 {* ������������� str_dftTranslationSettingsCaption }
 str_dftAnnotationSynchroViewCaption.Init;
 {* ������������� str_dftAnnotationSynchroViewCaption }
 str_dftAnnotationSynchroViewSettingsCaption.Init;
 {* ������������� str_dftAnnotationSynchroViewSettingsCaption }
 str_dftTipsCaption.Init;
 {* ������������� str_dftTipsCaption }
 str_dftTipsSettingsCaption.Init;
 {* ������������� str_dftTipsSettingsCaption }
 str_dftMedDictEntryCaption.Init;
 {* ������������� str_dftMedDictEntryCaption }
 str_dftMedDictEntrySettingsCaption.Init;
 {* ������������� str_dftMedDictEntrySettingsCaption }
 str_dftAutoreferatCaption.Init;
 {* ������������� str_dftAutoreferatCaption }
 str_dftAutoreferatSettingsCaption.Init;
 {* ������������� str_dftAutoreferatSettingsCaption }
 str_dftDrugCaption.Init;
 {* ������������� str_dftDrugCaption }
 str_dftMedicFirmCaption.Init;
 {* ������������� str_dftMedicFirmCaption }
 str_dftMedicFirmSynchroViewCaption.Init;
 {* ������������� str_dftMedicFirmSynchroViewCaption }
 str_dftMedicFirmSynchroViewSettingsCaption.Init;
 {* ������������� str_dftMedicFirmSynchroViewSettingsCaption }
 str_dftDrugSynchroViewCaption.Init;
 {* ������������� str_dftDrugSynchroViewCaption }
 str_dftDrugSynchroViewSettingsCaption.Init;
 {* ������������� str_dftDrugSynchroViewSettingsCaption }
 str_dftAACLeftCaption.Init;
 {* ������������� str_dftAACLeftCaption }
 str_dftAACLeftSettingsCaption.Init;
 {* ������������� str_dftAACLeftSettingsCaption }
 str_dftAACRightCaption.Init;
 {* ������������� str_dftAACRightCaption }
 str_dftAACRightSettingsCaption.Init;
 {* ������������� str_dftAACRightSettingsCaption }
 str_dftAACContentsLeftCaption.Init;
 {* ������������� str_dftAACContentsLeftCaption }
 str_dftAACContentsRightCaption.Init;
 {* ������������� str_dftAACContentsRightCaption }
 str_dftChronologyCaption.Init;
 {* ������������� str_dftChronologyCaption }
 str_dftChronologySettingsCaption.Init;
 {* ������������� str_dftChronologySettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf DocumentUserTypes_imp_impl}

{$EndIf DocumentUserTypes_imp}

