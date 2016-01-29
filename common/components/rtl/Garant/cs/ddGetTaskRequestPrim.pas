unit ddGetTaskRequestPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddGetTaskRequestPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TddGetTaskRequestPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  askRequest,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddGetTaskRequestPrim = class(TaskRequest)
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public methods
   procedure SetTaskID(const aTaskID: AnsiString);
 end;//TddGetTaskRequestPrim
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  SysUtils,
  StrUtils,
  DateUtils,
  GetTaskRequest_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TddGetTaskRequestPrim

procedure TddGetTaskRequestPrim.SetTaskID(const aTaskID: AnsiString);
//#UC START# *53B684BC010C_53B6859A023A_var*
(*var
 l_Day, l_Month, l_Sec, l_MSec: Word;
 l_Pos, l_PredPos: Integer;*)
//#UC END# *53B684BC010C_53B6859A023A_var*
begin
//#UC START# *53B684BC010C_53B6859A023A_impl*
(* l_Pos := Pos('-', aTaskID);
 UserIDW := StrToIntDef(Copy(aTaskID, 1, Pred(l_Pos)), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Day := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Month := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_Pos := PosEx('-', aTaskID, l_PredPos);
 l_Sec := StrToIntDef(Copy(aTaskID, l_PredPos, l_Pos-l_PredPos), 0);
 l_PredPos := Succ(l_Pos);
 l_MSec := StrToIntDef(Copy(aTaskID, l_PredPos, Length(aTaskID)), 0);
 DateW := RecodeDate(Date, 2004, l_Month, l_Day);
 DateW := RecodeTime(Date, 0, 0, l_Sec, l_MSec);*)
 TaskID := aTaskID;
//#UC END# *53B684BC010C_53B6859A023A_impl*
end;//TddGetTaskRequestPrim.SetTaskID

class function TddGetTaskRequestPrim.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typGetTaskRequest;
end;//TddGetTaskRequestPrim.GetTaggedDataType

{$IfEnd} //not Nemesis

end.