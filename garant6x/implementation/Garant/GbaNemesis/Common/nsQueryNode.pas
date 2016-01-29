unit nsQueryNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsQueryNode.pas"
// Начат: 21.10.2009 19:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsQueryNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SearchUnit,
  l3Tree_TLB,
  MainMenuDomainInterfaces,
  nsWrapperNode,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsQueryNode = class(TnsWrapperNode, InsQueryNode)
 private
 // private fields
   f_Query : IQuery;
   f_DocCount : Integer;
 protected
 // realized methods
   function pm_GetQuery: IQuery;
   function pm_GetDocCount: Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 public
 // public methods
   constructor Create(const aQuery: IQuery); reintroduce;
   class function Make(const aQuery: IQuery): Il3Node; reintroduce;
 end;//TnsQueryNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  IOUnit,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsQueryNode

constructor TnsQueryNode.Create(const aQuery: IQuery);
//#UC START# *4ADF274E0033_4ADDF50A00E2_var*
var
 l_Str : IString;
//#UC END# *4ADF274E0033_4ADDF50A00E2_var*
begin
//#UC START# *4ADF274E0033_4ADDF50A00E2_impl*
 inherited Create;
 if not Assigned(aQuery) then
  Exit;
 // Query
 f_Query := aQuery;
 // Name
 aQuery.GetName(l_Str);
 try
  pm_SetName(nsWStr(l_Str));
 finally
  l_Str := nil;
 end;{try..finally}
 // Comment
 aQuery.GetComment(l_Str);
 try
  pm_SetComment(nsWStr(l_Str));
 finally
  l_Str := nil;
 end;{try..finally}
 // DocCount
 try
  f_DocCount := aQuery.GetCount;
 except
  on EQueryNotExecuted do
   f_DocCount := 0;
 end;{try..except}
//#UC END# *4ADF274E0033_4ADDF50A00E2_impl*
end;//TnsQueryNode.Create

class function TnsQueryNode.Make(const aQuery: IQuery): Il3Node;
var
 l_Inst : TnsQueryNode;
begin
 l_Inst := Create(aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsQueryNode.pm_GetQuery: IQuery;
//#UC START# *49904E96037F_4ADDF50A00E2get_var*
//#UC END# *49904E96037F_4ADDF50A00E2get_var*
begin
//#UC START# *49904E96037F_4ADDF50A00E2get_impl*
 Result := f_Query;
//#UC END# *49904E96037F_4ADDF50A00E2get_impl*
end;//TnsQueryNode.pm_GetQuery

function TnsQueryNode.pm_GetDocCount: Integer;
//#UC START# *49904EAB0281_4ADDF50A00E2get_var*
//#UC END# *49904EAB0281_4ADDF50A00E2get_var*
begin
//#UC START# *49904EAB0281_4ADDF50A00E2get_impl*
 Result := f_DocCount;
//#UC END# *49904EAB0281_4ADDF50A00E2get_impl*
end;//TnsQueryNode.pm_GetDocCount

procedure TnsQueryNode.Cleanup;
//#UC START# *479731C50290_4ADDF50A00E2_var*
//#UC END# *479731C50290_4ADDF50A00E2_var*
begin
//#UC START# *479731C50290_4ADDF50A00E2_impl*
 f_Query := nil;
 inherited;
//#UC END# *479731C50290_4ADDF50A00E2_impl*
end;//TnsQueryNode.Cleanup

function TnsQueryNode.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_4ADDF50A00E2_var*
//#UC END# *4A60B23E00C3_4ADDF50A00E2_var*
begin
//#UC START# *4A60B23E00C3_4ADDF50A00E2_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
 begin
  if (f_Query = nil) then
   Result.SetNOINTERFACE
  else
   Result := Tl3HResult_C(f_Query.QueryInterface(IID.IID, Obj));
 end;
//#UC END# *4A60B23E00C3_4ADDF50A00E2_impl*
end;//TnsQueryNode.COMQueryInterface

{$IfEnd} //not Admin AND not Monitorings

end.