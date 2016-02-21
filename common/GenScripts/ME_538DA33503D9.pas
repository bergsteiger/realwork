unit CsQueryRequesterTool;

// Модуль: "w:\common\components\rtl\Garant\cs\CsQueryRequesterTool.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsQueryTypes
 , CsCommon
 , CsDataPipe
 , CsQueryRequester
;

type
 TCsQueryRequesterTool = class
  public
   class function ExecuteQuery(aQueryId: TCsQueryId;
    aClientID: TCsClientId;
    aPipe: TCsDataPipe;
    aQueryProc: TCsQueryProc;
    aWrite2Log: Boolean): Boolean;
 end;//TCsQueryRequesterTool
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , CsConst
 , TypInfo
;

class function TCsQueryRequesterTool.ExecuteQuery(aQueryId: TCsQueryId;
 aClientID: TCsClientId;
 aPipe: TCsDataPipe;
 aQueryProc: TCsQueryProc;
 aWrite2Log: Boolean): Boolean;
//#UC START# *538DA34E03C3_538DA33503D9_var*
//#UC END# *538DA34E03C3_538DA33503D9_var*
begin
//#UC START# *538DA34E03C3_538DA33503D9_impl*
 aPipe.WriteInteger(Integer(c_CsVersion));
 aPipe.WriteInteger(Integer(aClientID));
 aPipe.WriteInteger(Integer(Ord(aQueryId)));

 if aWrite2Log then
  l3System.Msg2Log('Отправка: %s'#13#10, [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
 if Assigned(aQueryProc) then
 begin
  aQueryProc(aPipe);
  Result := true;
 end//Assigned(aQueryProc)
 else
 begin
  Result := false;
  if aQUeryID <> qtLogout then
   l3System.Msg2Log('CsQueryRequesterTool - Не задан обработчик');
 end;
//#UC END# *538DA34E03C3_538DA33503D9_impl*
end;//TCsQueryRequesterTool.ExecuteQuery
{$IfEnd} // NOT Defined(Nemesis)

end.
