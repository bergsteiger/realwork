unit NewGenRes;

interface

uses
 l3IntfUses
 , F1LikeRes
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 TNewGenMainPrimForm = class(TMainPrimForm)
 end;//TNewGenMainPrimForm
 
 // ut_Main
 
 MainFormDef = interface
  {* Идентификатор формы Main }
 end;//MainFormDef
 
 TMainForm = class(TNewGenMainPrimForm, MainFormDef)
  {* НЕ Роза }
 end;//TMainForm
 
 TvcmApplicationRef = TNewGenRes;
  {* Ссылка на приложение для DesignTime редакторов }
 
 TNewGenRes = class(TF1LikeRes)
 end;//TNewGenRes
 
implementation

uses
 l3ImplUses
 , StdRes
 , Forms
 , Windows
 , l3MessageID
 , evExtFormat
 , TtfwClassRef_Proxy
 , MainKeywordsPack
;

type
 Tkw_FormUserType_ut_Main = class(TtfwInteger)
  {* Слово словаря для типа формы ut_Main }
 end;//Tkw_FormUserType_ut_Main
 
end.
