unit Outliner_Form;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , vtOutlinerControl
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_OutlinerForm
 
 OutlinerFormFormDef = interface
  {* ������������� ����� OutlinerForm }
 end;//OutlinerFormFormDef
 
 TOutlinerFormForm = class(TvcmEntityForm, OutlinerFormFormDef)
  {* ����� ��� ������������ ������ }
 end;//TOutlinerFormForm
 
implementation

uses
 l3ImplUses
 , Controls
 , TtfwClassRef_Proxy
 , l3MessageID
 , OutlinerFormKeywordsPack
;

type
 Tkw_FormUserType_ut_OutlinerForm = class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_OutlinerForm }
 end;//Tkw_FormUserType_ut_OutlinerForm
 
end.
