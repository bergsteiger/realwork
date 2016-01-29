unit tasSaveLoadProxy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/tasSaveLoadProxy.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::tasSaveLoadProxy
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  SearchUnit,
  l3Interfaces,
  l3TreeInterfaces,
  l3ProtoDataContainer
  ;

type
 ItasSaveLoadProcessor = interface(IUnknown)
   ['{3BF8A648-734F-42A0-89ED-6D697CC6BB8E}']
   procedure LoadFromQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree);
   function SaveToQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree): Boolean;
   function IsQuerySaved(const aQuery: IQuery): Boolean;
 end;//ItasSaveLoadProcessor

 TtasSaveLoadProxy = class(Tl3ProtoDataContainer)
 private
 // private fields
   f_Processor : ItasSaveLoadProcessor;
    {* Поле для свойства Processor}
 protected
 // property methods
   procedure pm_SetProcessor(const aValue: ItasSaveLoadProcessor);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   procedure LoadFromQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree);
   function SaveToQuery(const aQuery: IQuery;
     const aTag: Il3CString;
     const aTree: Il3SimpleTree): Boolean;
   function IsQuerySaved(const aQuery: IQuery): Boolean;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Processor: ItasSaveLoadProcessor
     read f_Processor
     write pm_SetProcessor;
 public
 // singleton factory method
   class function Instance: TtasSaveLoadProxy;
    {- возвращает экземпляр синглетона. }
 end;//TtasSaveLoadProxy

implementation

uses
  l3Base {a}
  ;


// start class TtasSaveLoadProxy

var g_TtasSaveLoadProxy : TtasSaveLoadProxy = nil;

procedure TtasSaveLoadProxyFree;
begin
 l3Free(g_TtasSaveLoadProxy);
end;

class function TtasSaveLoadProxy.Instance: TtasSaveLoadProxy;
begin
 if (g_TtasSaveLoadProxy = nil) then
 begin
  l3System.AddExitProc(TtasSaveLoadProxyFree);
  g_TtasSaveLoadProxy := Create;
 end;
 Result := g_TtasSaveLoadProxy;
end;


procedure TtasSaveLoadProxy.LoadFromQuery(const aQuery: IQuery;
  const aTag: Il3CString;
  const aTree: Il3SimpleTree);
//#UC START# *54F836C10315_54F8360D0043_var*
//#UC END# *54F836C10315_54F8360D0043_var*
begin
//#UC START# *54F836C10315_54F8360D0043_impl*
 if Assigned(f_Processor) then
  f_Processor.LoadFromQuery(aQuery, aTag, aTree);
//#UC END# *54F836C10315_54F8360D0043_impl*
end;//TtasSaveLoadProxy.LoadFromQuery

function TtasSaveLoadProxy.SaveToQuery(const aQuery: IQuery;
  const aTag: Il3CString;
  const aTree: Il3SimpleTree): Boolean;
//#UC START# *54F8399003BA_54F8360D0043_var*
//#UC END# *54F8399003BA_54F8360D0043_var*
begin
//#UC START# *54F8399003BA_54F8360D0043_impl*
 if Assigned(f_Processor) then
  Result := f_Processor.SaveToQuery(aQuery, aTag, aTree)
 else
  Result := False;
//#UC END# *54F8399003BA_54F8360D0043_impl*
end;//TtasSaveLoadProxy.SaveToQuery

function TtasSaveLoadProxy.IsQuerySaved(const aQuery: IQuery): Boolean;
//#UC START# *54F85E7203A1_54F8360D0043_var*
//#UC END# *54F85E7203A1_54F8360D0043_var*
begin
//#UC START# *54F85E7203A1_54F8360D0043_impl*
 if Assigned(f_Processor) then
  Result := f_Processor.IsQuerySaved(aQuery)
 else
  Result := False;
//#UC END# *54F85E7203A1_54F8360D0043_impl*
end;//TtasSaveLoadProxy.IsQuerySaved

procedure TtasSaveLoadProxy.pm_SetProcessor(const aValue: ItasSaveLoadProcessor);
//#UC START# *54F83673012A_54F8360D0043set_var*
//#UC END# *54F83673012A_54F8360D0043set_var*
begin
//#UC START# *54F83673012A_54F8360D0043set_impl*
 if Assigned(aValue) and Assigned(f_Processor) and (aValue <> f_Processor) then
  Assert(False);
 f_Processor := aValue;
//#UC END# *54F83673012A_54F8360D0043set_impl*
end;//TtasSaveLoadProxy.pm_SetProcessor

class function TtasSaveLoadProxy.Exists: Boolean;
 {-}
begin
 Result := g_TtasSaveLoadProxy <> nil;
end;//TtasSaveLoadProxy.Exists

procedure TtasSaveLoadProxy.Cleanup;
//#UC START# *479731C50290_54F8360D0043_var*
//#UC END# *479731C50290_54F8360D0043_var*
begin
//#UC START# *479731C50290_54F8360D0043_impl*
 f_Processor := nil;
 inherited;
//#UC END# *479731C50290_54F8360D0043_impl*
end;//TtasSaveLoadProxy.Cleanup

procedure TtasSaveLoadProxy.ClearFields;
 {-}
begin
 Processor := nil;
 inherited;
end;//TtasSaveLoadProxy.ClearFields

end.