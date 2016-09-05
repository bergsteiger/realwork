unit tasSaveLoadProxy;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\tasSaveLoadProxy.pas"
// ���������: "UtilityPack"
// ������� ������: "tasSaveLoadProxy" MUID: (54F835DA0012)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
 , l3ProtoDataContainer
;

type
 ItasSaveLoadProcessor = interface
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
   f_Processor: ItasSaveLoadProcessor;
  protected
   procedure pm_SetProcessor(const aValue: ItasSaveLoadProcessor);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   procedure LoadFromQuery(const aQuery: IQuery;
    const aTag: Il3CString;
    const aTree: Il3SimpleTree);
   function SaveToQuery(const aQuery: IQuery;
    const aTag: Il3CString;
    const aTree: Il3SimpleTree): Boolean;
   function IsQuerySaved(const aQuery: IQuery): Boolean;
   class function Instance: TtasSaveLoadProxy;
    {* ����� ��������� ���������� ���������� TtasSaveLoadProxy }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Processor: ItasSaveLoadProcessor
    read f_Processor
    write pm_SetProcessor;
 end;//TtasSaveLoadProxy

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *54F835DA0012impl_uses*
 //#UC END# *54F835DA0012impl_uses*
;

var g_TtasSaveLoadProxy: TtasSaveLoadProxy = nil;
 {* ��������� ���������� TtasSaveLoadProxy }

procedure TtasSaveLoadProxyFree;
 {* ����� ������������ ���������� ���������� TtasSaveLoadProxy }
begin
 l3Free(g_TtasSaveLoadProxy);
end;//TtasSaveLoadProxyFree

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

class function TtasSaveLoadProxy.Instance: TtasSaveLoadProxy;
 {* ����� ��������� ���������� ���������� TtasSaveLoadProxy }
begin
 if (g_TtasSaveLoadProxy = nil) then
 begin
  l3System.AddExitProc(TtasSaveLoadProxyFree);
  g_TtasSaveLoadProxy := Create;
 end;
 Result := g_TtasSaveLoadProxy;
end;//TtasSaveLoadProxy.Instance

class function TtasSaveLoadProxy.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtasSaveLoadProxy <> nil;
end;//TtasSaveLoadProxy.Exists

procedure TtasSaveLoadProxy.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_54F8360D0043_var*
//#UC END# *479731C50290_54F8360D0043_var*
begin
//#UC START# *479731C50290_54F8360D0043_impl*
 f_Processor := nil;
 inherited;
//#UC END# *479731C50290_54F8360D0043_impl*
end;//TtasSaveLoadProxy.Cleanup

procedure TtasSaveLoadProxy.ClearFields;
begin
 Processor := nil;
 inherited;
end;//TtasSaveLoadProxy.ClearFields

end.
