unit NOT_COMPLETED_nsQuestionsWithChoices;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\NOT_COMPLETED_nsQuestionsWithChoices.pas"
// ���������: "UtilityPack"
// ������� ������: "nsQuestionsWithChoices" MUID: (4F9BB14900E7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3MessageID
 , l3StringIDEx
;

const
 {* ������������ ������ Questions }
 str_ChangedDocumentOnControl: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl'; rValue : '� �������� �� �������� ������� ���������. �������� ��������:');
  {* '� �������� �� �������� ������� ���������. �������� ��������:' }
 str_SearchUnresolvedContext: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext'; rValue : '� ������� ���� �����, ����� �� ������� ����� �� ���� ����������� ����������: {color:Red}{italic:true}%s{italic}{color}.');
  {* '� ������� ���� �����, ����� �� ������� ����� �� ���� ����������� ����������: [color:Red][italic:true]%s[italic][color].' }
 str_DropListToList: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'DropListToList'; rValue : '���������� ��������:');
  {* '���������� ��������:' }
 str_mtNotGarantDomain: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain'; rValue : '������� �� ������� ������');
  {* '������� �� ������� ������' }
 str_EmptySearchResultInBaseList: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList'; rValue : '����� � ������� (�����������) ������ �� ��� ����������� �� ��������� ���� �������. �������� �������� ��� ����������� ������:');
  {* '����� � ������� (�����������) ������ �� ��� ����������� �� ��������� ���� �������. �������� �������� ��� ����������� ������:' }
 str_AutologinDuplicate: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate'; rValue : '������������ � ����� ������ ��� ����������. �������� �����:');
  {* '������������ � ����� ������ ��� ����������. �������� �����:' }
 str_ChangedDocumentOnControl_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_SettingsCaption'; rValue : '�������� ��� ������ ����������� ��������� �� ��������');

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 {* �������� ������ ��� ������� ChangedDocumentOnControl }
 str_ChangedDocumentOnControl_Choice_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Open'; rValue : '������� ����� ���������');
  {* '������� ����� ���������' }
 str_ChangedDocumentOnControl_Choice_Compare: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_Choice_Compare'; rValue : '�������� � ���������� ���������');
  {* '�������� � ���������� ���������' }
 {* �������� ������ ��� ������� SearchUnresolvedContext }
 str_SearchUnresolvedContext_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Back'; rValue : '��������� � �������� � ��������������� ������');
  {* '��������� � �������� � ��������������� ������' }
 str_SearchUnresolvedContext_Choice_Continue: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'SearchUnresolvedContext_Choice_Continue'; rValue : '���������� �����');
  {* '���������� �����' }
 {* �������� ������ ��� ������� DropListToList }
 str_DropListToList_Choice_Append: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Append'; rValue : '�������� � ������������ ������');
  {* '�������� � ������������ ������' }
 str_DropListToList_Choice_Copy: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DropListToList_Choice_Copy'; rValue : '���������� � ����� ������');
  {* '���������� � ����� ������' }
 {* �������� ������ ��� ������� mtNotGarantDomain }
 str_mtNotGarantDomain_Choice_Open: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Open'; rValue : '�������, ������ �� ������� �������� ');
  {* '�������, ������ �� ������� �������� ' }
 str_mtNotGarantDomain_Choice_Stay: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtNotGarantDomain_Choice_Stay'; rValue : '�� ����������');
  {* '�� ����������' }
 {* �������� ������ ��� ������� EmptySearchResultInBaseList }
 str_EmptySearchResultInBaseList_Choice_Expand: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_Expand'; rValue : '��������� ������� ������ �� ������� � ���������� ����� � ���');
  {* '��������� ������� ������ �� ������� � ���������� ����� � ���' }
 str_EmptySearchResultInBaseList_Choice_AllBase: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'EmptySearchResultInBaseList_Choice_AllBase'; rValue : '���������� ����� �� ����� ��������������� �����');
  {* '���������� ����� �� ����� ��������������� �����' }
 {* �������� ������ ��� ������� AutologinDuplicate }
 str_AutologinDuplicate_Choice_Back: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Back'; rValue : '��������� � ����������� ������ ������������, ������� ��������������� ������');
  {* '��������� � ����������� ������ ������������, ������� ��������������� ������' }
 str_AutologinDuplicate_Choice_Login: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'AutologinDuplicate_Choice_Login'; rValue : '����� � ������� � ���������� ���������������� �������, ����������� ��������� ��� ������������');
  {* '����� � ������� � ���������� ���������������� �������, ����������� ��������� ��� ������������' }

initialization
 str_ChangedDocumentOnControl_Choice_Open.Init;
 {* ������������� str_ChangedDocumentOnControl_Choice_Open }
 str_ChangedDocumentOnControl_Choice_Compare.Init;
 {* ������������� str_ChangedDocumentOnControl_Choice_Compare }
 str_SearchUnresolvedContext_Choice_Back.Init;
 {* ������������� str_SearchUnresolvedContext_Choice_Back }
 str_SearchUnresolvedContext_Choice_Continue.Init;
 {* ������������� str_SearchUnresolvedContext_Choice_Continue }
 str_DropListToList_Choice_Append.Init;
 {* ������������� str_DropListToList_Choice_Append }
 str_DropListToList_Choice_Copy.Init;
 {* ������������� str_DropListToList_Choice_Copy }
 str_mtNotGarantDomain_Choice_Open.Init;
 {* ������������� str_mtNotGarantDomain_Choice_Open }
 str_mtNotGarantDomain_Choice_Stay.Init;
 {* ������������� str_mtNotGarantDomain_Choice_Stay }
 str_EmptySearchResultInBaseList_Choice_Expand.Init;
 {* ������������� str_EmptySearchResultInBaseList_Choice_Expand }
 str_EmptySearchResultInBaseList_Choice_AllBase.Init;
 {* ������������� str_EmptySearchResultInBaseList_Choice_AllBase }
 str_AutologinDuplicate_Choice_Back.Init;
 {* ������������� str_AutologinDuplicate_Choice_Back }
 str_AutologinDuplicate_Choice_Login.Init;
 {* ������������� str_AutologinDuplicate_Choice_Login }
 str_ChangedDocumentOnControl.Init;
!!! Lost Message ini !!!
 {* ������������� str_ChangedDocumentOnControl }
 str_SearchUnresolvedContext.Init;
!!! Lost Message ini !!!
 {* ������������� str_SearchUnresolvedContext }
 str_DropListToList.Init;
!!! Lost Message ini !!!
 {* ������������� str_DropListToList }
 str_mtNotGarantDomain.Init;
!!! Lost Message ini !!!
 {* ������������� str_mtNotGarantDomain }
 str_EmptySearchResultInBaseList.Init;
!!! Lost Message ini !!!
 {* ������������� str_EmptySearchResultInBaseList }
 str_AutologinDuplicate.Init;
!!! Lost Message ini !!!
 {* ������������� str_AutologinDuplicate }
 str_ChangedDocumentOnControl_SettingsCaption.Init;
 {* ������������� str_ChangedDocumentOnControl_SettingsCaption }

end.
