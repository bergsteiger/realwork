unit evCustomEditorModelPart;

interface

uses
 l3IntfUses
 , evMultiSelectEditorWindow
;

type
 TevAllowParaType = (
  {* Разрешённые типы параграфов }
  ev_aptTable
  , ev_aptSBS
  , ev_aptPicture
  , ev_aptFormula
  , ev_aptPageBreak
 );//TevAllowParaType
 
 TevAllowParaTypes = set of TevAllowParaType;
  {* Множество типов разрешённых параграфов }
 
 TevCustomEditorModelPart = class(TevMultiSelectEditorWindow)
  {* Часть TevCustomEditor перенесённая на модель }
 end;//TevCustomEditorModelPart
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
