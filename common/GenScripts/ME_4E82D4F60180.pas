unit kwPopQueryCardAttributeSetWithLogicOperation;

interface

uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , l3Interfaces
 , nevBase
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeSetWithLogicOperation = class(TkwQueryCardFromStackWord)
  {* ��������� ������� � ���������� ��������� � ������� �������� �������.

*������:*
[code]
 ���::�����_�����_��������������_��������
 'AT_PHARM_NAME' '�������' Search:SetAttribute
 'AT_PHARM_ATC' 'A. ��������������� ����� � ����� �������' Search:SetAttribute
 1 'AT_PHARM_ATC' 'B. ��������� �������� �� ������������� � �����' Search:SetAttributeWithLogicOperation
 Ok
[code] }
  procedure DoModelImpl;
  procedure DoCard(const aCtx: TtfwContext;
   aCard: TevQueryCardEditor);
 end;//TkwPopQueryCardAttributeSetWithLogicOperation
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

end.
