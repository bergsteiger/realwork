unit l3IID;
 {* Объект-обертка вокруг GUID }

// Модуль: "w:\common\components\rtl\Garant\L3\l3IID.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

const
 ev_iidCursor: Tl3IID = (IID: 0);
  {* курсор объекта }
 ev_iidBlock: Tl3IID = (IID: 1);
  {* выделение части объекта }

type
 Tl3_IID = packed object
  public
   IID: Integer;
 end;//Tl3_IID

 Tl3IID = packed object(Tl3_IID)
  public
   function EQ: Boolean;
 end;//Tl3IID

 Tl3_GUID = packed object
  {* Объект-обертка вокруг GUID (без методов). }
  public
   IID: TGUID;
 end;//Tl3_GUID

 Tl3GUID = packed object(Tl3_GUID)
  {* Объект-обертка вокруг GUID. }
  public
   function EQ: Boolean; overload;
    {* сравнить совпадение GUID'ов. }
   function EQ: Boolean; overload;
    {* сравнить совпадение GUID'ов. }
   function SomeOf: Boolean;
    {* идентификатор один из GUIDs? }
 end;//Tl3GUID

 Tl3HResult = object
  {* Результат COM-операции }
  private
   f_Res: hResult;
    {* Собственно код результата }
  public
   function Ok: Boolean;
    {* Результат успешен }
   function Fail: Boolean;
    {* Результат неуспешен }
   procedure SetOk;
    {* Установить в S_Ok }
   procedure SetNoInterface;
    {* Установить в E_NoInterface }
   function Res: hResult;
    {* Собственно результат }
 end;//Tl3HResult

function Tl3GUID_C: Tl3GUID;
function Tl3HResult_C: Tl3HResult;

implementation

uses
 l3ImplUses
;

function Tl3GUID_C: Tl3GUID;
//#UC START# *4942795A0282_478CF8F202C7_var*
//#UC END# *4942795A0282_478CF8F202C7_var*
begin
//#UC START# *4942795A0282_478CF8F202C7_impl*
 Result.IID := anIID;
//#UC END# *4942795A0282_478CF8F202C7_impl*
end;//Tl3GUID_C

function Tl3HResult_C: Tl3HResult;
//#UC START# *49427EEF0016_49427DEE015B_var*
//#UC END# *49427EEF0016_49427DEE015B_var*
begin
//#UC START# *49427EEF0016_49427DEE015B_impl*
 Result.f_Res := aRes;
//#UC END# *49427EEF0016_49427DEE015B_impl*
end;//Tl3HResult_C

function Tl3IID.EQ: Boolean;
//#UC START# *478CF8B1002E_478CF8A20368_var*
//#UC END# *478CF8B1002E_478CF8A20368_var*
begin
//#UC START# *478CF8B1002E_478CF8A20368_impl*
 Result := (IID = anID.IID);
//#UC END# *478CF8B1002E_478CF8A20368_impl*
end;//Tl3IID.EQ

function Tl3GUID.EQ: Boolean;
 {* сравнить совпадение GUID'ов. }
//#UC START# *478CF90801FE_478CF8F202C7_var*
//#UC END# *478CF90801FE_478CF8F202C7_var*
begin
//#UC START# *478CF90801FE_478CF8F202C7_impl*
 Result := SysUtils.IsEqualGUID(IID, anID.IID);
//#UC END# *478CF90801FE_478CF8F202C7_impl*
end;//Tl3GUID.EQ

function Tl3GUID.EQ: Boolean;
 {* сравнить совпадение GUID'ов. }
//#UC START# *478CF919003A_478CF8F202C7_var*
//#UC END# *478CF919003A_478CF8F202C7_var*
begin
//#UC START# *478CF919003A_478CF8F202C7_impl*
 Result := SysUtils.IsEqualGUID(IID, anID);
//#UC END# *478CF919003A_478CF8F202C7_impl*
end;//Tl3GUID.EQ

function Tl3GUID.SomeOf: Boolean;
 {* идентификатор один из GUIDs? }
//#UC START# *478CF9A1010D_478CF8F202C7_var*
var
 i : Integer;
//#UC END# *478CF9A1010D_478CF8F202C7_var*
begin
//#UC START# *478CF9A1010D_478CF8F202C7_impl*
 Result := false;
 for i := Low(GUIDs) to High(GUIDs) do
  if SysUtils.IsEqualGUID(IID, GUIDs[i]) then
  begin
   Result := true;
   break;
  end;//SysUtils.IsEqualGUID
//#UC END# *478CF9A1010D_478CF8F202C7_impl*
end;//Tl3GUID.SomeOf

function Tl3HResult.Ok: Boolean;
 {* Результат успешен }
//#UC START# *49427EB903DB_49427DEE015B_var*
//#UC END# *49427EB903DB_49427DEE015B_var*
begin
//#UC START# *49427EB903DB_49427DEE015B_impl*
 Result := Succeeded(f_Res);
//#UC END# *49427EB903DB_49427DEE015B_impl*
end;//Tl3HResult.Ok

function Tl3HResult.Fail: Boolean;
 {* Результат неуспешен }
//#UC START# *49427ED200F2_49427DEE015B_var*
//#UC END# *49427ED200F2_49427DEE015B_var*
begin
//#UC START# *49427ED200F2_49427DEE015B_impl*
 Result := Failed(f_Res);
//#UC END# *49427ED200F2_49427DEE015B_impl*
end;//Tl3HResult.Fail

procedure Tl3HResult.SetOk;
 {* Установить в S_Ok }
//#UC START# *49427F5D038D_49427DEE015B_var*
//#UC END# *49427F5D038D_49427DEE015B_var*
begin
//#UC START# *49427F5D038D_49427DEE015B_impl*
 f_Res := S_Ok;
//#UC END# *49427F5D038D_49427DEE015B_impl*
end;//Tl3HResult.SetOk

procedure Tl3HResult.SetNoInterface;
 {* Установить в E_NoInterface }
//#UC START# *49427F6D03CB_49427DEE015B_var*
//#UC END# *49427F6D03CB_49427DEE015B_var*
begin
//#UC START# *49427F6D03CB_49427DEE015B_impl*
 f_Res := E_NoInterface; 
//#UC END# *49427F6D03CB_49427DEE015B_impl*
end;//Tl3HResult.SetNoInterface

function Tl3HResult.Res: hResult;
 {* Собственно результат }
//#UC START# *494283D90043_49427DEE015B_var*
//#UC END# *494283D90043_49427DEE015B_var*
begin
//#UC START# *494283D90043_49427DEE015B_impl*
 Result := f_Res;
//#UC END# *494283D90043_49427DEE015B_impl*
end;//Tl3HResult.Res

end.
