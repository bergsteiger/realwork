unit ddGetTaskRequestPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\ddGetTaskRequestPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddGetTaskRequestPrim" MUID: (53B6859A023A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , askRequest
 , k2Base
;

type
 TddGetTaskRequestPrim = class(TaskRequest)
  public
   procedure SetTaskID(const aTaskID: AnsiString);
   class function GetTaggedDataType: Tk2Type; override;
 end;//TddGetTaskRequestPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , GetTaskRequest_Const
 , SysUtils
 , StrUtils
 , DateUtils
;

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
//#UC START# *53AC03EE01FD_53B6859A023A_var*
//#UC END# *53AC03EE01FD_53B6859A023A_var*
begin
//#UC START# *53AC03EE01FD_53B6859A023A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53B6859A023A_impl*
end;//TddGetTaskRequestPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
