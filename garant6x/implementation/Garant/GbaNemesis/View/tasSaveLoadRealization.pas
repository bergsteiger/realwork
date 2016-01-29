unit tasSaveLoadRealization;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$Strange"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/tasSaveLoadRealization.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$Strange::TreeAttributeSelectSaveLoadRealization::TtasSaveLoadRealization
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3ProtoDataContainer,
  tasSaveLoadProxy,
  SearchUnit,
  l3Interfaces,
  l3TreeInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TtasSaveLoadRealization = class(Tl3ProtoDataContainer, ItasSaveLoadProcessor)
 protected
 // realized methods
   procedure LoadFromQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree);
   function SaveToQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree): Boolean;
   function IsQuerySaved(const aQuery: IQuery): Boolean;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TtasSaveLoadRealization;
    {- возвращает экземпляр синглетона. }
 end;//TtasSaveLoadRealization
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  nsQueryUtils
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TtasSaveLoadRealization

var g_TtasSaveLoadRealization : TtasSaveLoadRealization = nil;

procedure TtasSaveLoadRealizationFree;
begin
 l3Free(g_TtasSaveLoadRealization);
end;

class function TtasSaveLoadRealization.Instance: TtasSaveLoadRealization;
begin
 if (g_TtasSaveLoadRealization = nil) then
 begin
  l3System.AddExitProc(TtasSaveLoadRealizationFree);
  g_TtasSaveLoadRealization := Create;
 end;
 Result := g_TtasSaveLoadRealization;
end;


class function TtasSaveLoadRealization.Exists: Boolean;
 {-}
begin
 Result := g_TtasSaveLoadRealization <> nil;
end;//TtasSaveLoadRealization.Exists

procedure TtasSaveLoadRealization.LoadFromQuery(const aQuery: IQuery;
  const aTag: Il3CString;
  const aTree: Il3SimpleTree);
//#UC START# *54F839B602DC_54F83BC9036B_var*
//#UC END# *54F839B602DC_54F83BC9036B_var*
begin
//#UC START# *54F839B602DC_54F83BC9036B_impl*
 LoadLogicFromQuery(aQuery, aTag, aTree);
//#UC END# *54F839B602DC_54F83BC9036B_impl*
end;//TtasSaveLoadRealization.LoadFromQuery

function TtasSaveLoadRealization.SaveToQuery(const aQuery: IQuery;
  const aTag: Il3CString;
  const aTree: Il3SimpleTree): Boolean;
//#UC START# *54F839D803D3_54F83BC9036B_var*
//#UC END# *54F839D803D3_54F83BC9036B_var*
begin
//#UC START# *54F839D803D3_54F83BC9036B_impl*
 Result := SaveLogicToQuery(aQuery, aTag, aTree);
//#UC END# *54F839D803D3_54F83BC9036B_impl*
end;//TtasSaveLoadRealization.SaveToQuery

function TtasSaveLoadRealization.IsQuerySaved(const aQuery: IQuery): Boolean;
//#UC START# *54F85E5A00B4_54F83BC9036B_var*
//#UC END# *54F85E5A00B4_54F83BC9036B_var*
begin
//#UC START# *54F85E5A00B4_54F83BC9036B_impl*
 Result := nsIsQuerySaved(aQuery);
//#UC END# *54F85E5A00B4_54F83BC9036B_impl*
end;//TtasSaveLoadRealization.IsQuerySaved

{$IfEnd} //not Admin

initialization
{$If not defined(Admin)}
//#UC START# *54F83BEF0258*
 TtasSaveLoadProxy.Instance.Processor := TtasSaveLoadRealization.Instance;
//#UC END# *54F83BEF0258*
{$IfEnd} //not Admin

end.