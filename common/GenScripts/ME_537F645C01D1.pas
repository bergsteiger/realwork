unit CsReplyProceduresPrim;
 {* Класс для регистрации "ответных процедур" сервера для запросов от клиента }

// Модуль: "w:\common\components\rtl\Garant\cs\CsReplyProceduresPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsReplyProceduresPrim" MUID: (537F645C01D1)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
 , CsProcWithIdList
 , SysUtils
 , CsProcWithId
 , CsQueryTypes
;

type
 TCsReplyProceduresPrim = {abstract} class(TCsObject)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента }
  protected
   f_List: TCsProcWithIdList;
   f_Synchronizer: TMultiReadExclusiveWriteSynchronizer;
  protected
   function ListItemBy(aQueryId: TCsQueryId): TCsProcWithId;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   function ProcBy(aQueryId: TCsQueryId): TCsReplyProc;
 end;//TCsReplyProceduresPrim
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , TypInfo
 , l3Base
;

constructor TCsReplyProceduresPrim.Create;
//#UC START# *53959A720000_537F645C01D1_var*
//#UC END# *53959A720000_537F645C01D1_var*
begin
//#UC START# *53959A720000_537F645C01D1_impl*
 inherited;
 f_List := TCsProcWithIdList.Create;
 f_Synchronizer := TMultiReadExclusiveWriteSynchronizer.Create;
//#UC END# *53959A720000_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.Create

function TCsReplyProceduresPrim.ListItemBy(aQueryId: TCsQueryId): TCsProcWithId;
//#UC START# *53959ABC03D4_537F645C01D1_var*
var
 I: Integer;
//#UC END# *53959ABC03D4_537F645C01D1_var*
begin
//#UC START# *53959ABC03D4_537F645C01D1_impl*
 Result := nil;
 for I := 0 to f_List.Count - 1 do
  if (f_List[I].QueryId = aQueryId) then
  begin
   Result := f_List[I];
   Break;
  end;//f_List[I].QueryId = aQueryId
//#UC END# *53959ABC03D4_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.ListItemBy

function TCsReplyProceduresPrim.ProcBy(aQueryId: TCsQueryId): TCsReplyProc;
//#UC START# *53959B1400E0_537F645C01D1_var*
var
 l_ProcWithId: TCsProcWithId;
//#UC END# *53959B1400E0_537F645C01D1_var*
begin
//#UC START# *53959B1400E0_537F645C01D1_impl*
 f_Synchronizer.BeginRead;
 try
  l_ProcWithId := ListItemBy(aQueryId);
  if l_ProcWithId <> nil then
   Result := l_ProcWithId.Proc
  else
   Result := nil;
 finally
  f_Synchronizer.EndRead;
 end;//try..finally
//#UC END# *53959B1400E0_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.ProcBy

procedure TCsReplyProceduresPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_537F645C01D1_var*
//#UC END# *479731C50290_537F645C01D1_var*
begin
//#UC START# *479731C50290_537F645C01D1_impl*
 FreeAndNil(f_Synchronizer);
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.Cleanup
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
