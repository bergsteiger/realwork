unit nsQuestionsWithChoices;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\nsQuestionsWithChoices.pas"
// ���������: "UtilityPack"
// ������� ������: "nsQuestionsWithChoices" MUID: (4F9BB14900E7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* ������������ ������ Questions }
 str_ChangedDocumentOnControl_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangedDocumentOnControl_SettingsCaption'; rValue : '�������� ��� ������ ����������� ��������� �� ��������');
  {* '�������� ��� ������ ����������� ��������� �� ��������' }
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

implementation

uses
 l3ImplUses
 , l3MessageID
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F9BB14900E7impl_uses*
 //#UC END# *4F9BB14900E7impl_uses*
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
 str_ChangedDocumentOnControl_SettingsCaption.Init;
 {* ������������� str_ChangedDocumentOnControl_SettingsCaption }
 str_ChangedDocumentOnControl.Init;
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Open);
 str_ChangedDocumentOnControl.AddChoice(str_ChangedDocumentOnControl_Choice_Compare);
 str_ChangedDocumentOnControl.SetSettingsCaption(str_ChangedDocumentOnControl_SettingsCaption);
 str_ChangedDocumentOnControl.SetDlgType(mtConfirmation);
 {* ������������� str_ChangedDocumentOnControl }
 str_SearchUnresolvedContext.Init;
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Back);
 str_SearchUnresolvedContext.AddChoice(str_SearchUnresolvedContext_Choice_Continue);
 str_SearchUnresolvedContext.SetDlgType(mtConfirmation);
 {* ������������� str_SearchUnresolvedContext }
 str_DropListToList.Init;
 str_DropListToList.AddChoice(str_DropListToList_Choice_Append);
 str_DropListToList.AddChoice(str_DropListToList_Choice_Copy);
 str_DropListToList.SetDlgType(mtConfirmation);
 {* ������������� str_DropListToList }
 str_mtNotGarantDomain.Init;
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Open);
 str_mtNotGarantDomain.AddChoice(str_mtNotGarantDomain_Choice_Stay);
 str_mtNotGarantDomain.SetDlgType(mtConfirmation);
 {* ������������� str_mtNotGarantDomain }
 str_EmptySearchResultInBaseList.Init;
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_Expand);
 str_EmptySearchResultInBaseList.AddChoice(str_EmptySearchResultInBaseList_Choice_AllBase);
 str_EmptySearchResultInBaseList.SetDlgType(mtConfirmation);
 {* ������������� str_EmptySearchResultInBaseList }
 str_AutologinDuplicate.Init;
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Back);
 str_AutologinDuplicate.AddChoice(str_AutologinDuplicate_Choice_Login);
 str_AutologinDuplicate.SetDlgType(mtWarning);
 {* ������������� str_AutologinDuplicate }
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

end.
