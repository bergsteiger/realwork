unit l3IID;
 {* ������-������� ������ GUID }

// ������: "w:\common\components\rtl\Garant\L3\l3IID.pas"
// ���������: "Interfaces"
// ������� ������: "l3IID" MUID: (478CF8070260)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tl3_IID = packed object
  public
   IID: Integer;
 end;//Tl3_IID

 Tl3IID = packed object(Tl3_IID)
  public
   function EQ(const anID: Tl3_IID): Boolean;
 end;//Tl3IID

 Tl3_GUID = packed object
  {* ������-������� ������ GUID (��� �������). }
  public
   IID: TGUID;
 end;//Tl3_GUID

 Tl3GUID = packed object(Tl3_GUID)
  {* ������-������� ������ GUID. }
  public
   function EQ(const anID: Tl3_GUID): Boolean; overload;
    {* �������� ���������� GUID'��. }
   function EQ(const anID: TGUID): Boolean; overload;
    {* �������� ���������� GUID'��. }
   function SomeOf(const GUIDs: array of TGUID): Boolean;
    {* ������������� ���� �� GUIDs? }
 end;//Tl3GUID

 Tl3HResult = object
  {* ��������� COM-�������� }
  private
   f_Res: hResult;
    {* ���������� ��� ���������� }
  public
   function Ok: Boolean;
    {* ��������� ������� }
   function Fail: Boolean;
    {* ��������� ��������� }
   procedure SetOk;
    {* ���������� � S_Ok }
   procedure SetNoInterface;
    {* ���������� � E_NoInterface }
   function Res: hResult;
    {* ���������� ��������� }
 end;//Tl3HResult

const
 ev_iidCursor: Tl3IID = (IID: 0);
  {* ������ ������� }
 ev_iidBlock: Tl3IID = (IID: 1);
  {* ��������� ����� ������� }

function Tl3GUID_C(const anIID: TGUID): Tl3GUID;
function Tl3HResult_C(aRes: hResult): Tl3HResult;

implementation

uses
 l3ImplUses
 , Windows
 , SysUtils
;

function Tl3GUID_C(const anIID: TGUID): Tl3GUID;
//#UC START# *4942795A0282_478CF8F202C7_var*
//#UC END# *4942795A0282_478CF8F202C7_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4942795A0282_478CF8F202C7_impl*
 Result.IID := anIID;
//#UC END# *4942795A0282_478CF8F202C7_impl*
end;//Tl3GUID_C

function Tl3HResult_C(aRes: hResult): Tl3HResult;
//#UC START# *49427EEF0016_49427DEE015B_var*
//#UC END# *49427EEF0016_49427DEE015B_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49427EEF0016_49427DEE015B_impl*
 Result.f_Res := aRes;
//#UC END# *49427EEF0016_49427DEE015B_impl*
end;//Tl3HResult_C

function Tl3IID.EQ(const anID: Tl3_IID): Boolean;
//#UC START# *478CF8B1002E_478CF8A20368_var*
//#UC END# *478CF8B1002E_478CF8A20368_var*
begin
//#UC START# *478CF8B1002E_478CF8A20368_impl*
 Result := (IID = anID.IID);
//#UC END# *478CF8B1002E_478CF8A20368_impl*
end;//Tl3IID.EQ

function Tl3GUID.EQ(const anID: Tl3_GUID): Boolean;
 {* �������� ���������� GUID'��. }
//#UC START# *478CF90801FE_478CF8F202C7_var*
//#UC END# *478CF90801FE_478CF8F202C7_var*
begin
//#UC START# *478CF90801FE_478CF8F202C7_impl*
 Result := SysUtils.IsEqualGUID(IID, anID.IID);
//#UC END# *478CF90801FE_478CF8F202C7_impl*
end;//Tl3GUID.EQ

function Tl3GUID.EQ(const anID: TGUID): Boolean;
 {* �������� ���������� GUID'��. }
//#UC START# *478CF919003A_478CF8F202C7_var*
//#UC END# *478CF919003A_478CF8F202C7_var*
begin
//#UC START# *478CF919003A_478CF8F202C7_impl*
 Result := SysUtils.IsEqualGUID(IID, anID);
//#UC END# *478CF919003A_478CF8F202C7_impl*
end;//Tl3GUID.EQ

function Tl3GUID.SomeOf(const GUIDs: array of TGUID): Boolean;
 {* ������������� ���� �� GUIDs? }
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
 {* ��������� ������� }
//#UC START# *49427EB903DB_49427DEE015B_var*
//#UC END# *49427EB903DB_49427DEE015B_var*
begin
//#UC START# *49427EB903DB_49427DEE015B_impl*
 Result := Succeeded(f_Res);
//#UC END# *49427EB903DB_49427DEE015B_impl*
end;//Tl3HResult.Ok

function Tl3HResult.Fail: Boolean;
 {* ��������� ��������� }
//#UC START# *49427ED200F2_49427DEE015B_var*
//#UC END# *49427ED200F2_49427DEE015B_var*
begin
//#UC START# *49427ED200F2_49427DEE015B_impl*
 Result := Failed(f_Res);
//#UC END# *49427ED200F2_49427DEE015B_impl*
end;//Tl3HResult.Fail

procedure Tl3HResult.SetOk;
 {* ���������� � S_Ok }
//#UC START# *49427F5D038D_49427DEE015B_var*
//#UC END# *49427F5D038D_49427DEE015B_var*
begin
//#UC START# *49427F5D038D_49427DEE015B_impl*
 f_Res := S_Ok;
//#UC END# *49427F5D038D_49427DEE015B_impl*
end;//Tl3HResult.SetOk

procedure Tl3HResult.SetNoInterface;
 {* ���������� � E_NoInterface }
//#UC START# *49427F6D03CB_49427DEE015B_var*
//#UC END# *49427F6D03CB_49427DEE015B_var*
begin
//#UC START# *49427F6D03CB_49427DEE015B_impl*
 f_Res := E_NoInterface; 
//#UC END# *49427F6D03CB_49427DEE015B_impl*
end;//Tl3HResult.SetNoInterface

function Tl3HResult.Res: hResult;
 {* ���������� ��������� }
//#UC START# *494283D90043_49427DEE015B_var*
//#UC END# *494283D90043_49427DEE015B_var*
begin
//#UC START# *494283D90043_49427DEE015B_impl*
 Result := f_Res;
//#UC END# *494283D90043_49427DEE015B_impl*
end;//Tl3HResult.Res

end.
