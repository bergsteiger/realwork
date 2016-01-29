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
  {* Идентификатор формы OutlinerForm }
 end;//OutlinerFormFormDef
 
 TOutlinerFormForm = class(TvcmEntityForm, OutlinerFormFormDef)
  {* Форма для тестирования списка }
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
  {* Слово словаря для типа формы ut_OutlinerForm }
 end;//Tkw_FormUserType_ut_OutlinerForm
 
end.
