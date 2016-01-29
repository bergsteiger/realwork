{$IfNDef DocumentUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes
//
// ���������������� ���� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DocumentUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DocumentUserTypes_ = {abstract form} class(_DocumentUserTypes_Parent_)
  {* ���������������� ���� ��������� }
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure DftRelatedDocQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftRelatedDoc.OnQueryClose }
   procedure DftDocSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftDocSynchroView.OnQueryMaximized }
   procedure DftDocSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftDocSynchroView.OnQueryOpen }
   procedure DftDictSubEntryQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftDictSubEntry.OnQueryClose }
   procedure DftAnnotationQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftAnnotation.OnQueryClose }
   procedure DftTranslationQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftTranslation.OnQueryMaximized }
   procedure DftTranslationQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftTranslation.OnQueryOpen }
   procedure DftTranslationQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftTranslation.OnQueryClose }
   procedure DftMedicFirmSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftMedicFirmSynchroView.OnQueryMaximized }
   procedure DftMedicFirmSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftMedicFirmSynchroView.OnQueryOpen }
   procedure DftDrugSynchroViewQueryMaximized(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftDrugSynchroView.OnQueryMaximized }
   procedure DftDrugSynchroViewQueryOpen(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftDrugSynchroView.OnQueryOpen }
   procedure DftChronologyQueryClose(aSender: TObject); virtual; abstract;
     {* ���������� ������� dftChronology.OnQueryClose }
 end;//_DocumentUserTypes_
{$Else}

 _DocumentUserTypes_ = _DocumentUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DocumentUserTypes_imp}

{$IfNDef DocumentUserTypes_imp_impl}
{$Define DocumentUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { ������������ ������ dftNoneLocalConstants }
  str_dftNoneCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftNoneCaption'; rValue : '��������');
   { ��������� ����������������� ���� "��������" }

var
   { ������������ ������ dftDocumentLocalConstants }
  str_dftDocumentCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentCaption'; rValue : '�����');
   { ��������� ����������������� ���� "�����" }
  str_dftDocumentSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocumentSettingsCaption'; rValue : '��������: ����� ���������');
   { ��������� ����������������� ���� "�����" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftRelatedDocLocalConstants }
  str_dftRelatedDocCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocCaption'; rValue : '�������');
   { ��������� ����������������� ���� "�������" }
  str_dftRelatedDocSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocSettingsCaption'; rValue : '��������: ������� � ���������');
   { ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftDocSynchroViewLocalConstants }
  str_dftDocSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewCaption'; rValue : '����� ��������� (���������� ��������)');
   { ��������� ����������������� ���� "����� ��������� (���������� ��������)" }
  str_dftDocSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDocSynchroViewSettingsCaption'; rValue : '���������� ��������: ����� ���������');
   { ��������� ����������������� ���� "����� ��������� (���������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftRelatedSynchroViewLocalConstants }
  str_dftRelatedSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewCaption'; rValue : '������� � ��������� (���������� ��������)');
   { ��������� ����������������� ���� "������� � ��������� (���������� ��������)" }
  str_dftRelatedSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedSynchroViewSettingsCaption'; rValue : '���������� ��������: ������� � ���������');
   { ��������� ����������������� ���� "������� � ��������� (���������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftDictEntryLocalConstants }
  str_dftDictEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntryCaption'; rValue : '����� ��������� ������');
   { ��������� ����������������� ���� "����� ��������� ������" }
  str_dftDictEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictEntrySettingsCaption'; rValue : '�������� �������: ����� ��������� ������');
   { ��������� ����������������� ���� "����� ��������� ������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftDictSubEntryLocalConstants }
  str_dftDictSubEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntryCaption'; rValue : '������� ��������� ������');
   { ��������� ����������������� ���� "������� ��������� ������" }
  str_dftDictSubEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDictSubEntrySettingsCaption'; rValue : '�������� �������: ������� ��������� ������');
   { ��������� ����������������� ���� "������� ��������� ������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAnnotationLocalConstants }
  str_dftAnnotationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationCaption'; rValue : '���������');
   { ��������� ����������������� ���� "���������" }
  str_dftAnnotationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSettingsCaption'; rValue : '��������: �������������� ����������');
   { ��������� ����������������� ���� "���������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAutoreferatAfterSearchLocalConstants }
  str_dftAutoreferatAfterSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchCaption'; rValue : '�����. ����� ��������� ����������������');
   { ��������� ����������������� ���� "�����. ����� ��������� ����������������" }
  str_dftAutoreferatAfterSearchSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatAfterSearchSettingsCaption'; rValue : '��������: �����. ����� ��������� ����������������');
   { ��������� ����������������� ���� "�����. ����� ��������� ����������������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftConsultationLocalConstants }
  str_dftConsultationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationCaption'; rValue : '������������');
   { ��������� ����������������� ���� "������������" }
  str_dftConsultationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftConsultationSettingsCaption'; rValue : '��������: ������������');
   { ��������� ����������������� ���� "������������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftTranslationLocalConstants }
  str_dftTranslationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationCaption'; rValue : '�������');
   { ��������� ����������������� ���� "�������" }
  str_dftTranslationSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTranslationSettingsCaption'; rValue : '��������: �������');
   { ��������� ����������������� ���� "�������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAnnotationSynchroViewLocalConstants }
  str_dftAnnotationSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewCaption'; rValue : '��������� (���������� ��������)');
   { ��������� ����������������� ���� "��������� (���������� ��������)" }
  str_dftAnnotationSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAnnotationSynchroViewSettingsCaption'; rValue : '���������� ��������: �������������� ����������');
   { ��������� ����������������� ���� "��������� (���������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftTipsLocalConstants }
  str_dftTipsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsCaption'; rValue : '����� ���');
   { ��������� ����������������� ���� "����� ���" }
  str_dftTipsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftTipsSettingsCaption'; rValue : '����� ���: ����� ������');
   { ��������� ����������������� ���� "����� ���" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftMedDictEntryLocalConstants }
  str_dftMedDictEntryCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntryCaption'; rValue : '�������� ������������ �������');
   { ��������� ����������������� ���� "�������� ������������ �������" }
  str_dftMedDictEntrySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedDictEntrySettingsCaption'; rValue : '������� ����������� ��������: �������� ������������ �������');
   { ��������� ����������������� ���� "�������� ������������ �������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAutoreferatLocalConstants }
  str_dftAutoreferatCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatCaption'; rValue : '�����. ��� ��������� �����');
   { ��������� ����������������� ���� "�����. ��� ��������� �����" }
  str_dftAutoreferatSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAutoreferatSettingsCaption'; rValue : '��������: �����. ��� ��������� �����');
   { ��������� ����������������� ���� "�����. ��� ��������� �����" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftDrugLocalConstants }
  str_dftDrugCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugCaption'; rValue : '�������� ���������');
   { ��������� ����������������� ���� "�������� ���������" }

var
   { ������������ ������ dftMedicFirmLocalConstants }
  str_dftMedicFirmCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmCaption'; rValue : '�������� �����');
   { ��������� ����������������� ���� "�������� �����" }

var
   { ������������ ������ dftMedicFirmSynchroViewLocalConstants }
  str_dftMedicFirmSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewCaption'; rValue : '�������� ����� (���������� ��������)');
   { ��������� ����������������� ���� "�������� ����� (���������� ��������)" }
  str_dftMedicFirmSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftMedicFirmSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� �����');
   { ��������� ����������������� ���� "�������� ����� (���������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftDrugSynchroViewLocalConstants }
  str_dftDrugSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewCaption'; rValue : '�������� ��������� (���������� ��������)');
   { ��������� ����������������� ���� "�������� ��������� (���������� ��������)" }
  str_dftDrugSynchroViewSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewSettingsCaption'; rValue : '���������� ��������: �������� ���������');
   { ��������� ����������������� ���� "�������� ��������� (���������� ��������)" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAACLeftLocalConstants }
  str_dftAACLeftCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftCaption'; rValue : '����� ����� ������������ �������');
   { ��������� ����������������� ���� "����� ����� ������������ �������" }
  str_dftAACLeftSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACLeftSettingsCaption'; rValue : '����� ����� ������������ �������');
   { ��������� ����������������� ���� "����� ����� ������������ �������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAACRightLocalConstants }
  str_dftAACRightCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightCaption'; rValue : '������ ����� ������������ �������');
   { ��������� ����������������� ���� "������ ����� ������������ �������" }
  str_dftAACRightSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACRightSettingsCaption'; rValue : '������ ����� ������������ �������');
   { ��������� ����������������� ���� "������ ����� ������������ �������" ��� ��������� ������� ������������ }

var
   { ������������ ������ dftAACContentsLeftLocalConstants }
  str_dftAACContentsLeftCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsLeftCaption'; rValue : '����� ����� ���������� ������������ �������');
   { ��������� ����������������� ���� "����� ����� ���������� ������������ �������" }

var
   { ������������ ������ dftAACContentsRightLocalConstants }
  str_dftAACContentsRightCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftAACContentsRightCaption'; rValue : '������ ����� ���������� ������������ �������');
   { ��������� ����������������� ���� "������ ����� ���������� ������������ �������" }

var
   { ������������ ������ dftChronologyLocalConstants }
  str_dftChronologyCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologyCaption'; rValue : '���������� ��������� ����');
   { ��������� ����������������� ���� "���������� ��������� ����" }
  str_dftChronologySettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologySettingsCaption'; rValue : '��������: ���������� ��������� ����');
   { ��������� ����������������� ���� "���������� ��������� ����" ��� ��������� ������� ������������ }

// start class _DocumentUserTypes_

procedure _DocumentUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(dftNoneName,
  str_dftNoneCaption,
  str_dftNoneCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftNoneName
 with AddUsertype(dftDocumentName,
  str_dftDocumentCaption,
  str_dftDocumentSettingsCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDocumentName
 with AddUsertype(dftRelatedDocName,
  str_dftRelatedDocCaption,
  str_dftRelatedDocSettingsCaption,
  false,
  20,
  30,
  dftAnnotationName,
  nil,
  nil,
  DftRelatedDocQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftRelatedDocName
 with AddUsertype(dftDocSynchroViewName,
  str_dftDocSynchroViewCaption,
  str_dftDocSynchroViewSettingsCaption,
  true,
  30,
  -1,
  '',
  DftDocSynchroViewQueryMaximized,
  DftDocSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDocSynchroViewName
 with AddUsertype(dftRelatedSynchroViewName,
  str_dftRelatedSynchroViewCaption,
  str_dftRelatedSynchroViewSettingsCaption,
  false,
  30,
  -1,
  dftAnnotationSynchroViewName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftRelatedSynchroViewName
 with AddUsertype(dftDictEntryName,
  str_dftDictEntryCaption,
  str_dftDictEntrySettingsCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDictEntryName
 with AddUsertype(dftDictSubEntryName,
  str_dftDictSubEntryCaption,
  str_dftDictSubEntrySettingsCaption,
  true,
  21,
  -1,
  '',
  nil,
  nil,
  DftDictSubEntryQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDictSubEntryName
 with AddUsertype(dftAnnotationName,
  str_dftAnnotationCaption,
  str_dftAnnotationSettingsCaption,
  true,
  143,
  35,
  '',
  nil,
  nil,
  DftAnnotationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAnnotationName
 with AddUsertype(dftAutoreferatAfterSearchName,
  str_dftAutoreferatAfterSearchCaption,
  str_dftAutoreferatAfterSearchSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAutoreferatAfterSearchName
 with AddUsertype(dftConsultationName,
  str_dftConsultationCaption,
  str_dftConsultationSettingsCaption,
  true,
  155,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftConsultationName
 with AddUsertype(dftTranslationName,
  str_dftTranslationCaption,
  str_dftTranslationSettingsCaption,
  true,
  167,
  110,
  '',
  DftTranslationQueryMaximized,
  DftTranslationQueryOpen,
  DftTranslationQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftTranslationName
 with AddUsertype(dftAnnotationSynchroViewName,
  str_dftAnnotationSynchroViewCaption,
  str_dftAnnotationSynchroViewSettingsCaption,
  true,
  143,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAnnotationSynchroViewName
 with AddUsertype(dftTipsName,
  str_dftTipsCaption,
  str_dftTipsSettingsCaption,
  true,
  175,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftTipsName
 with AddUsertype(dftMedDictEntryName,
  str_dftMedDictEntryCaption,
  str_dftMedDictEntrySettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedDictEntryName
 with AddUsertype(dftAutoreferatName,
  str_dftAutoreferatCaption,
  str_dftAutoreferatSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAutoreferatName
 with AddUsertype(dftDrugName,
  str_dftDrugCaption,
  str_dftDrugCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDrugName
 with AddUsertype(dftMedicFirmName,
  str_dftMedicFirmCaption,
  str_dftMedicFirmCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedicFirmName
 with AddUsertype(dftMedicFirmSynchroViewName,
  str_dftMedicFirmSynchroViewCaption,
  str_dftMedicFirmSynchroViewSettingsCaption,
  true,
  -1,
  -1,
  '',
  DftMedicFirmSynchroViewQueryMaximized,
  DftMedicFirmSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftMedicFirmSynchroViewName
 with AddUsertype(dftDrugSynchroViewName,
  str_dftDrugSynchroViewCaption,
  str_dftDrugSynchroViewSettingsCaption,
  true,
  -1,
  -1,
  '',
  DftDrugSynchroViewQueryMaximized,
  DftDrugSynchroViewQueryOpen,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftDrugSynchroViewName
 with AddUsertype(dftAACLeftName,
  str_dftAACLeftCaption,
  str_dftAACLeftSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftAACLeftName
 with AddUsertype(dftAACRightName,
  str_dftAACRightCaption,
  str_dftAACRightSettingsCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACRightName
 with AddUsertype(dftAACContentsLeftName,
  str_dftAACContentsLeftCaption,
  str_dftAACContentsLeftCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACContentsLeftName
 with AddUsertype(dftAACContentsRightName,
  str_dftAACContentsRightCaption,
  str_dftAACContentsRightCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
  CanHaveToolbars := false;
 end;//with AddUsertype(dftAACContentsRightName
 with AddUsertype(dftChronologyName,
  str_dftChronologyCaption,
  str_dftChronologySettingsCaption,
  true,
  211,
  130,
  dftRelatedDocName,
  nil,
  nil,
  DftChronologyQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(dftChronologyName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  DocumentUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_dftNoneCaption
 str_dftNoneCaption.Init;
// ������������� str_dftDocumentCaption
 str_dftDocumentCaption.Init;
// ������������� str_dftDocumentSettingsCaption
 str_dftDocumentSettingsCaption.Init;
// ������������� str_dftRelatedDocCaption
 str_dftRelatedDocCaption.Init;
// ������������� str_dftRelatedDocSettingsCaption
 str_dftRelatedDocSettingsCaption.Init;
// ������������� str_dftDocSynchroViewCaption
 str_dftDocSynchroViewCaption.Init;
// ������������� str_dftDocSynchroViewSettingsCaption
 str_dftDocSynchroViewSettingsCaption.Init;
// ������������� str_dftRelatedSynchroViewCaption
 str_dftRelatedSynchroViewCaption.Init;
// ������������� str_dftRelatedSynchroViewSettingsCaption
 str_dftRelatedSynchroViewSettingsCaption.Init;
// ������������� str_dftDictEntryCaption
 str_dftDictEntryCaption.Init;
// ������������� str_dftDictEntrySettingsCaption
 str_dftDictEntrySettingsCaption.Init;
// ������������� str_dftDictSubEntryCaption
 str_dftDictSubEntryCaption.Init;
// ������������� str_dftDictSubEntrySettingsCaption
 str_dftDictSubEntrySettingsCaption.Init;
// ������������� str_dftAnnotationCaption
 str_dftAnnotationCaption.Init;
// ������������� str_dftAnnotationSettingsCaption
 str_dftAnnotationSettingsCaption.Init;
// ������������� str_dftAutoreferatAfterSearchCaption
 str_dftAutoreferatAfterSearchCaption.Init;
// ������������� str_dftAutoreferatAfterSearchSettingsCaption
 str_dftAutoreferatAfterSearchSettingsCaption.Init;
// ������������� str_dftConsultationCaption
 str_dftConsultationCaption.Init;
// ������������� str_dftConsultationSettingsCaption
 str_dftConsultationSettingsCaption.Init;
// ������������� str_dftTranslationCaption
 str_dftTranslationCaption.Init;
// ������������� str_dftTranslationSettingsCaption
 str_dftTranslationSettingsCaption.Init;
// ������������� str_dftAnnotationSynchroViewCaption
 str_dftAnnotationSynchroViewCaption.Init;
// ������������� str_dftAnnotationSynchroViewSettingsCaption
 str_dftAnnotationSynchroViewSettingsCaption.Init;
// ������������� str_dftTipsCaption
 str_dftTipsCaption.Init;
// ������������� str_dftTipsSettingsCaption
 str_dftTipsSettingsCaption.Init;
// ������������� str_dftMedDictEntryCaption
 str_dftMedDictEntryCaption.Init;
// ������������� str_dftMedDictEntrySettingsCaption
 str_dftMedDictEntrySettingsCaption.Init;
// ������������� str_dftAutoreferatCaption
 str_dftAutoreferatCaption.Init;
// ������������� str_dftAutoreferatSettingsCaption
 str_dftAutoreferatSettingsCaption.Init;
// ������������� str_dftDrugCaption
 str_dftDrugCaption.Init;
// ������������� str_dftMedicFirmCaption
 str_dftMedicFirmCaption.Init;
// ������������� str_dftMedicFirmSynchroViewCaption
 str_dftMedicFirmSynchroViewCaption.Init;
// ������������� str_dftMedicFirmSynchroViewSettingsCaption
 str_dftMedicFirmSynchroViewSettingsCaption.Init;
// ������������� str_dftDrugSynchroViewCaption
 str_dftDrugSynchroViewCaption.Init;
// ������������� str_dftDrugSynchroViewSettingsCaption
 str_dftDrugSynchroViewSettingsCaption.Init;
// ������������� str_dftAACLeftCaption
 str_dftAACLeftCaption.Init;
// ������������� str_dftAACLeftSettingsCaption
 str_dftAACLeftSettingsCaption.Init;
// ������������� str_dftAACRightCaption
 str_dftAACRightCaption.Init;
// ������������� str_dftAACRightSettingsCaption
 str_dftAACRightSettingsCaption.Init;
// ������������� str_dftAACContentsLeftCaption
 str_dftAACContentsLeftCaption.Init;
// ������������� str_dftAACContentsRightCaption
 str_dftAACContentsRightCaption.Init;
// ������������� str_dftChronologyCaption
 str_dftChronologyCaption.Init;
// ������������� str_dftChronologySettingsCaption
 str_dftChronologySettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf DocumentUserTypes_imp_impl}
{$EndIf DocumentUserTypes_imp}
