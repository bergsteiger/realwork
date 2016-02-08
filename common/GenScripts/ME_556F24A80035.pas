unit l3ControlFontService;

// ������: "w:\common\components\rtl\Garant\L3\l3ControlFontService.pas"
// ���������: "Service"

{$Include l3Define.inc}

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Controls
 , l3CProtoObject
;

type
 Tl3ControlFontInfo = class(Tl3CProtoObject, Il3FontInfo)
  private
   f_Control: TControl;
  protected
   function Get_Size: Integer;
   function Get_Name: TFontName;
   function Get_Bold: Boolean;
   function Get_Italic: Boolean;
   function Get_Underline: Boolean;
   function Get_Strikeout: Boolean;
   function Get_ForeColor: Tl3Color;
   function Get_BackColor: Tl3Color;
   function Get_Pitch: TFontPitch;
   function Get_Index: Tl3FontIndex;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aControl: TControl); reintroduce;
   class function Make(aControl: TControl): Il3FontInfo; reintroduce;
 end;//Tl3ControlFontInfo

 (*
 Ml3ControlFontService = interface
  {* �������� ������� Tl3ControlFontService }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Ml3ControlFontService
 *)

 Il3ControlFontService = interface
  {* ��������� ������� Tl3ControlFontService }
  ['{04DBC214-58B9-46AE-ADC2-A02B5FFF1CE1}']
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//Il3ControlFontService

 Tl3ControlFontService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3ControlFontService;
    {* ���� ��� �������� Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3ControlFontService);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function GetFont(aControl: TControl): Il3FontInfo;
   class function Instance: Tl3ControlFontService;
    {* ����� ��������� ���������� ���������� Tl3ControlFontService }
  public
   property Alien: Il3ControlFontService
    write pm_SetAlien;
    {* ������� ���������� ������� Il3ControlFontService }
 end;//Tl3ControlFontService
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , Graphics
;

type
 TControlFriend = {abstract} class(TControl)
  {* ���� ��� TControl }
 end;//TControlFriend

var g_Tl3ControlFontService: Tl3ControlFontService = nil;
 {* ��������� ���������� Tl3ControlFontService }

procedure Tl3ControlFontServiceFree;
 {* ����� ������������ ���������� ���������� Tl3ControlFontService }
begin
 l3Free(g_Tl3ControlFontService);
end;//Tl3ControlFontServiceFree

constructor Tl3ControlFontInfo.Create(aControl: TControl);
//#UC START# *556F25D20367_556F25860097_var*
//#UC END# *556F25D20367_556F25860097_var*
begin
//#UC START# *556F25D20367_556F25860097_impl*
 inherited Create;
 f_Control := aControl;
//#UC END# *556F25D20367_556F25860097_impl*
end;//Tl3ControlFontInfo.Create

class function Tl3ControlFontInfo.Make(aControl: TControl): Il3FontInfo;
var
 l_Inst : Tl3ControlFontInfo;
begin
 l_Inst := Create(aControl);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3ControlFontInfo.Make

function Tl3ControlFontInfo.Get_Size: Integer;
//#UC START# *46A60D7A02E4_556F25860097get_var*
//#UC END# *46A60D7A02E4_556F25860097get_var*
begin
//#UC START# *46A60D7A02E4_556F25860097get_impl*
 Result := TControlFriend(f_Control).Font.Size;
//#UC END# *46A60D7A02E4_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Size

function Tl3ControlFontInfo.Get_Name: TFontName;
//#UC START# *46A60E2802E4_556F25860097get_var*
//#UC END# *46A60E2802E4_556F25860097get_var*
begin
//#UC START# *46A60E2802E4_556F25860097get_impl*
 Result := TControlFriend(f_Control).Font.Name;
//#UC END# *46A60E2802E4_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Name

function Tl3ControlFontInfo.Get_Bold: Boolean;
//#UC START# *46A60E58013F_556F25860097get_var*
//#UC END# *46A60E58013F_556F25860097get_var*
begin
//#UC START# *46A60E58013F_556F25860097get_impl*
 Result := (fsBold in TControlFriend(f_Control).Font.Style);
//#UC END# *46A60E58013F_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Bold

function Tl3ControlFontInfo.Get_Italic: Boolean;
//#UC START# *46A60E740045_556F25860097get_var*
//#UC END# *46A60E740045_556F25860097get_var*
begin
//#UC START# *46A60E740045_556F25860097get_impl*
 Result := (fsItalic in TControlFriend(f_Control).Font.Style);
//#UC END# *46A60E740045_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Italic

function Tl3ControlFontInfo.Get_Underline: Boolean;
//#UC START# *46A60EA6032C_556F25860097get_var*
//#UC END# *46A60EA6032C_556F25860097get_var*
begin
//#UC START# *46A60EA6032C_556F25860097get_impl*
 Result := (fsUnderline in TControlFriend(f_Control).Font.Style);
//#UC END# *46A60EA6032C_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Underline

function Tl3ControlFontInfo.Get_Strikeout: Boolean;
//#UC START# *46A60EBF03BE_556F25860097get_var*
//#UC END# *46A60EBF03BE_556F25860097get_var*
begin
//#UC START# *46A60EBF03BE_556F25860097get_impl*
 Result := (fsStrikeout in TControlFriend(f_Control).Font.Style);
//#UC END# *46A60EBF03BE_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Strikeout

function Tl3ControlFontInfo.Get_ForeColor: Tl3Color;
//#UC START# *46A60ED90325_556F25860097get_var*
//#UC END# *46A60ED90325_556F25860097get_var*
begin
//#UC START# *46A60ED90325_556F25860097get_impl*
 Result := TControlFriend(f_Control).Font.Color;
//#UC END# *46A60ED90325_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_ForeColor

function Tl3ControlFontInfo.Get_BackColor: Tl3Color;
//#UC START# *46A60EF300C9_556F25860097get_var*
//#UC END# *46A60EF300C9_556F25860097get_var*
begin
//#UC START# *46A60EF300C9_556F25860097get_impl*
 Result := TControlFriend(f_Control).Color;
//#UC END# *46A60EF300C9_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_BackColor

function Tl3ControlFontInfo.Get_Pitch: TFontPitch;
//#UC START# *46A60F63035F_556F25860097get_var*
//#UC END# *46A60F63035F_556F25860097get_var*
begin
//#UC START# *46A60F63035F_556F25860097get_impl*
 Result := TControlFriend(f_Control).Font.Pitch;
//#UC END# *46A60F63035F_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Pitch

function Tl3ControlFontInfo.Get_Index: Tl3FontIndex;
//#UC START# *46A60F89031E_556F25860097get_var*
//#UC END# *46A60F89031E_556F25860097get_var*
begin
//#UC START# *46A60F89031E_556F25860097get_impl*
 Result := l3_fiNone;
//#UC END# *46A60F89031E_556F25860097get_impl*
end;//Tl3ControlFontInfo.Get_Index

procedure Tl3ControlFontInfo.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_556F25860097_var*
//#UC END# *479731C50290_556F25860097_var*
begin
//#UC START# *479731C50290_556F25860097_impl*
 f_Control := nil;
 inherited;
//#UC END# *479731C50290_556F25860097_impl*
end;//Tl3ControlFontInfo.Cleanup

procedure Tl3ControlFontService.pm_SetAlien(const aValue: Il3ControlFontService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3ControlFontService.pm_SetAlien

class function Tl3ControlFontService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3ControlFontService <> nil;
end;//Tl3ControlFontService.Exists

function Tl3ControlFontService.GetFont(aControl: TControl): Il3FontInfo;
//#UC START# *B31F486B3A13_556F24A80035_var*
//#UC END# *B31F486B3A13_556F24A80035_var*
begin
//#UC START# *B31F486B3A13_556F24A80035_impl*
 Result := nil;
 if (f_Alien <> nil) then
  Result := f_Alien.Getfont(aControl);
 if (Result = nil) then
  Result := Tl3ControlFontInfo.Make(aControl); 
//#UC END# *B31F486B3A13_556F24A80035_impl*
end;//Tl3ControlFontService.GetFont

class function Tl3ControlFontService.Instance: Tl3ControlFontService;
 {* ����� ��������� ���������� ���������� Tl3ControlFontService }
begin
 if (g_Tl3ControlFontService = nil) then
 begin
  l3System.AddExitProc(Tl3ControlFontServiceFree);
  g_Tl3ControlFontService := Create;
 end;
 Result := g_Tl3ControlFontService;
end;//Tl3ControlFontService.Instance

procedure Tl3ControlFontService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3ControlFontService.ClearFields
{$IfEnd} // NOT Defined(NoVCL)

end.
