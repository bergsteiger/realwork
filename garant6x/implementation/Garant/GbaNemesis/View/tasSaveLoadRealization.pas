unit tasSaveLoadRealization;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\tasSaveLoadRealization.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtasSaveLoadRealization" MUID: (54F83BC9036B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tasSaveLoadProxy
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
;

type
 TtasSaveLoadRealization = class(Tl3ProtoDataContainer, ItasSaveLoadProcessor)
  protected
   procedure LoadFromQuery(const aQuery: IQuery;
    const aTag: Il3CString;
    const aTree: Il3SimpleTree);
   function SaveToQuery(const aQuery: IQuery;
    const aTag: Il3CString;
    const aTree: Il3SimpleTree): Boolean;
   function IsQuerySaved(const aQuery: IQuery): Boolean;
  public
   class function Instance: TtasSaveLoadRealization;
    {* Метод получения экземпляра синглетона TtasSaveLoadRealization }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtasSaveLoadRealization
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsQueryUtils
 , SysUtils
 , l3Base
;

var g_TtasSaveLoadRealization: TtasSaveLoadRealization = nil;
 {* Экземпляр синглетона TtasSaveLoadRealization }

procedure TtasSaveLoadRealizationFree;
 {* Метод освобождения экземпляра синглетона TtasSaveLoadRealization }
begin
 l3Free(g_TtasSaveLoadRealization);
end;//TtasSaveLoadRealizationFree

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

class function TtasSaveLoadRealization.Instance: TtasSaveLoadRealization;
 {* Метод получения экземпляра синглетона TtasSaveLoadRealization }
begin
 if (g_TtasSaveLoadRealization = nil) then
 begin
  l3System.AddExitProc(TtasSaveLoadRealizationFree);
  g_TtasSaveLoadRealization := Create;
 end;
 Result := g_TtasSaveLoadRealization;
end;//TtasSaveLoadRealization.Instance

class function TtasSaveLoadRealization.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtasSaveLoadRealization <> nil;
end;//TtasSaveLoadRealization.Exists

initialization
//#UC START# *54F83BEF0258*
 TtasSaveLoadProxy.Instance.Processor := TtasSaveLoadRealization.Instance;
//#UC END# *54F83BEF0258*
{$IfEnd} // NOT Defined(Admin)

end.
