unit evCustomEditorModelPart;

interface

uses
 l3IntfUses
 , evMultiSelectEditorWindow
;

type
 TevAllowParaType = (
  {* ����������� ���� ���������� }
  ev_aptTable
  , ev_aptSBS
  , ev_aptPicture
  , ev_aptFormula
  , ev_aptPageBreak
 );//TevAllowParaType
 
 TevAllowParaTypes = set of TevAllowParaType;
  {* ��������� ����� ����������� ���������� }
 
 TevCustomEditorModelPart = class(TevMultiSelectEditorWindow)
  {* ����� TevCustomEditor ����������� �� ������ }
 end;//TevCustomEditorModelPart
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
