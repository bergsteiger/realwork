unit eeDocumentTool;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocumentTool.pas"
// Стереотип: "SimpleClass"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3Tool
 , eeInterfacesEx
;

type
 TeeDocumentTool = class(Tl3Tool)
  protected
   function pm_GetDocument: IeeDocumentEx;
  public
   constructor Create(const aDocument: IeeDocumentEx); reintroduce;
  public
   property Document: IeeDocumentEx
    read pm_GetDocument;
 end;//TeeDocumentTool
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

function TeeDocumentTool.pm_GetDocument: IeeDocumentEx;
//#UC START# *5487171F0251_54817DBA01BEget_var*
//#UC END# *5487171F0251_54817DBA01BEget_var*
begin
//#UC START# *5487171F0251_54817DBA01BEget_impl*
 Result := IeeToolOwner(f_Owner) as IeeDocumentEx;
//#UC END# *5487171F0251_54817DBA01BEget_impl*
end;//TeeDocumentTool.pm_GetDocument

constructor TeeDocumentTool.Create(const aDocument: IeeDocumentEx);
//#UC START# *548717AB01C5_54817DBA01BE_var*
//#UC END# *548717AB01C5_54817DBA01BE_var*
begin
//#UC START# *548717AB01C5_54817DBA01BE_impl*
 inherited Create(aDocument as IeeToolOwner);
//#UC END# *548717AB01C5_54817DBA01BE_impl*
end;//TeeDocumentTool.Create
{$IfEnd} // Defined(Nemesis)

end.
