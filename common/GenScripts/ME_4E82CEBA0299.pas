unit kwVcmHistoryDeleteBackItem;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmHistoryDeleteBackItem = class(TtfwRegisterableWord)
  {* ������� ���� ������� ������� �� ������ Back.
 *������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttribute
 Ok
 OnTest
 vcm:history:DeleteBackItem
[code] }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmHistoryDeleteBackItem
 
implementation

uses
 l3ImplUses
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
