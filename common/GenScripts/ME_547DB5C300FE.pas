unit NOT_FINISHED_evCustomFont;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomFont.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 TevCustomFont = class(Il3FontInfo, Il3Font)
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
   function Get_ForeColor: Tl3Color;
   procedure Set_ForeColor(aValue: Tl3Color);
   function Get_BackColor: Tl3Color;
   procedure Set_BackColor(aValue: Tl3Color);
   function Get_Name: TFontName;
   procedure Set_Name(const aValue: TFontName);
   function Get_Pitch: TFontPitch;
   procedure Set_Pitch(aValue: TFontPitch);
   function Get_Size: Integer;
   procedure Set_Size(aValue: Integer);
   function Get_Index: Tl3FontIndex;
   procedure Set_Index(aValue: Tl3FontIndex);
   function Get_Style: TFontStyles;
   procedure Set_Style(aValue: TFontStyles);
   function Get_Bold: Boolean;
   procedure Set_Bold(aValue: Boolean);
   function Get_Italic: Boolean;
   procedure Set_Italic(aValue: Boolean);
   function Get_Underline: Boolean;
   procedure Set_Underline(aValue: Boolean);
   function Get_Strikeout: Boolean;
   procedure Set_Strikeout(aValue: Boolean);
   function AssignFont(Font: TFont): Boolean;
   procedure Assign2Font(const aFont: Il3Font);
   procedure Lock;
   procedure Unlock;
   function HF: hFont;
   function IsAtomic: Boolean;
    {* Строка для нанного шрифта представляет собой единый объект? }
   function FM: Il3FontMetrics;
    {* Метрики шрифта. }
 end;//TevCustomFont

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , FontWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TevCustomFont.Get_Size: Integer;
//#UC START# *46A60D7A02E4_547DB5C300FEget_var*
//#UC END# *46A60D7A02E4_547DB5C300FEget_var*
begin
//#UC START# *46A60D7A02E4_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60D7A02E4_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Size

function TevCustomFont.Get_Name: TFontName;
//#UC START# *46A60E2802E4_547DB5C300FEget_var*
//#UC END# *46A60E2802E4_547DB5C300FEget_var*
begin
//#UC START# *46A60E2802E4_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60E2802E4_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Name

function TevCustomFont.Get_Bold: Boolean;
//#UC START# *46A60E58013F_547DB5C300FEget_var*
//#UC END# *46A60E58013F_547DB5C300FEget_var*
begin
//#UC START# *46A60E58013F_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60E58013F_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Bold

function TevCustomFont.Get_Italic: Boolean;
//#UC START# *46A60E740045_547DB5C300FEget_var*
//#UC END# *46A60E740045_547DB5C300FEget_var*
begin
//#UC START# *46A60E740045_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60E740045_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Italic

function TevCustomFont.Get_Underline: Boolean;
//#UC START# *46A60EA6032C_547DB5C300FEget_var*
//#UC END# *46A60EA6032C_547DB5C300FEget_var*
begin
//#UC START# *46A60EA6032C_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60EA6032C_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Underline

function TevCustomFont.Get_Strikeout: Boolean;
//#UC START# *46A60EBF03BE_547DB5C300FEget_var*
//#UC END# *46A60EBF03BE_547DB5C300FEget_var*
begin
//#UC START# *46A60EBF03BE_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60EBF03BE_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Strikeout

function TevCustomFont.Get_ForeColor: Tl3Color;
//#UC START# *46A60ED90325_547DB5C300FEget_var*
//#UC END# *46A60ED90325_547DB5C300FEget_var*
begin
//#UC START# *46A60ED90325_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60ED90325_547DB5C300FEget_impl*
end;//TevCustomFont.Get_ForeColor

function TevCustomFont.Get_BackColor: Tl3Color;
//#UC START# *46A60EF300C9_547DB5C300FEget_var*
//#UC END# *46A60EF300C9_547DB5C300FEget_var*
begin
//#UC START# *46A60EF300C9_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60EF300C9_547DB5C300FEget_impl*
end;//TevCustomFont.Get_BackColor

function TevCustomFont.Get_Pitch: TFontPitch;
//#UC START# *46A60F63035F_547DB5C300FEget_var*
//#UC END# *46A60F63035F_547DB5C300FEget_var*
begin
//#UC START# *46A60F63035F_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60F63035F_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Pitch

function TevCustomFont.Get_Index: Tl3FontIndex;
//#UC START# *46A60F89031E_547DB5C300FEget_var*
//#UC END# *46A60F89031E_547DB5C300FEget_var*
begin
//#UC START# *46A60F89031E_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A60F89031E_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Index

function TevCustomFont.Get_ForeColor: Tl3Color;
//#UC START# *46A610780340_547DB5C300FEget_var*
//#UC END# *46A610780340_547DB5C300FEget_var*
begin
//#UC START# *46A610780340_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610780340_547DB5C300FEget_impl*
end;//TevCustomFont.Get_ForeColor

procedure TevCustomFont.Set_ForeColor(aValue: Tl3Color);
//#UC START# *46A610780340_547DB5C300FEset_var*
//#UC END# *46A610780340_547DB5C300FEset_var*
begin
//#UC START# *46A610780340_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610780340_547DB5C300FEset_impl*
end;//TevCustomFont.Set_ForeColor

function TevCustomFont.Get_BackColor: Tl3Color;
//#UC START# *46A6108E017F_547DB5C300FEget_var*
//#UC END# *46A6108E017F_547DB5C300FEget_var*
begin
//#UC START# *46A6108E017F_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6108E017F_547DB5C300FEget_impl*
end;//TevCustomFont.Get_BackColor

procedure TevCustomFont.Set_BackColor(aValue: Tl3Color);
//#UC START# *46A6108E017F_547DB5C300FEset_var*
//#UC END# *46A6108E017F_547DB5C300FEset_var*
begin
//#UC START# *46A6108E017F_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6108E017F_547DB5C300FEset_impl*
end;//TevCustomFont.Set_BackColor

function TevCustomFont.Get_Name: TFontName;
//#UC START# *46A610AF012C_547DB5C300FEget_var*
//#UC END# *46A610AF012C_547DB5C300FEget_var*
begin
//#UC START# *46A610AF012C_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610AF012C_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Name

procedure TevCustomFont.Set_Name(const aValue: TFontName);
//#UC START# *46A610AF012C_547DB5C300FEset_var*
//#UC END# *46A610AF012C_547DB5C300FEset_var*
begin
//#UC START# *46A610AF012C_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610AF012C_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Name

function TevCustomFont.Get_Pitch: TFontPitch;
//#UC START# *46A610E10084_547DB5C300FEget_var*
//#UC END# *46A610E10084_547DB5C300FEget_var*
begin
//#UC START# *46A610E10084_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610E10084_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Pitch

procedure TevCustomFont.Set_Pitch(aValue: TFontPitch);
//#UC START# *46A610E10084_547DB5C300FEset_var*
//#UC END# *46A610E10084_547DB5C300FEset_var*
begin
//#UC START# *46A610E10084_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A610E10084_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Pitch

function TevCustomFont.Get_Size: Integer;
//#UC START# *46A6111000F9_547DB5C300FEget_var*
//#UC END# *46A6111000F9_547DB5C300FEget_var*
begin
//#UC START# *46A6111000F9_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6111000F9_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Size

procedure TevCustomFont.Set_Size(aValue: Integer);
//#UC START# *46A6111000F9_547DB5C300FEset_var*
//#UC END# *46A6111000F9_547DB5C300FEset_var*
begin
//#UC START# *46A6111000F9_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6111000F9_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Size

function TevCustomFont.Get_Index: Tl3FontIndex;
//#UC START# *46A61136020C_547DB5C300FEget_var*
//#UC END# *46A61136020C_547DB5C300FEget_var*
begin
//#UC START# *46A61136020C_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A61136020C_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Index

procedure TevCustomFont.Set_Index(aValue: Tl3FontIndex);
//#UC START# *46A61136020C_547DB5C300FEset_var*
//#UC END# *46A61136020C_547DB5C300FEset_var*
begin
//#UC START# *46A61136020C_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A61136020C_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Index

function TevCustomFont.Get_Style: TFontStyles;
//#UC START# *46A6127B0282_547DB5C300FEget_var*
//#UC END# *46A6127B0282_547DB5C300FEget_var*
begin
//#UC START# *46A6127B0282_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6127B0282_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Style

procedure TevCustomFont.Set_Style(aValue: TFontStyles);
//#UC START# *46A6127B0282_547DB5C300FEset_var*
//#UC END# *46A6127B0282_547DB5C300FEset_var*
begin
//#UC START# *46A6127B0282_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6127B0282_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Style

function TevCustomFont.Get_Bold: Boolean;
//#UC START# *46A6129101E3_547DB5C300FEget_var*
//#UC END# *46A6129101E3_547DB5C300FEget_var*
begin
//#UC START# *46A6129101E3_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6129101E3_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Bold

procedure TevCustomFont.Set_Bold(aValue: Boolean);
//#UC START# *46A6129101E3_547DB5C300FEset_var*
//#UC END# *46A6129101E3_547DB5C300FEset_var*
begin
//#UC START# *46A6129101E3_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6129101E3_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Bold

function TevCustomFont.Get_Italic: Boolean;
//#UC START# *46A612AF0038_547DB5C300FEget_var*
//#UC END# *46A612AF0038_547DB5C300FEget_var*
begin
//#UC START# *46A612AF0038_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612AF0038_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Italic

procedure TevCustomFont.Set_Italic(aValue: Boolean);
//#UC START# *46A612AF0038_547DB5C300FEset_var*
//#UC END# *46A612AF0038_547DB5C300FEset_var*
begin
//#UC START# *46A612AF0038_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612AF0038_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Italic

function TevCustomFont.Get_Underline: Boolean;
//#UC START# *46A612C302D6_547DB5C300FEget_var*
//#UC END# *46A612C302D6_547DB5C300FEget_var*
begin
//#UC START# *46A612C302D6_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612C302D6_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Underline

procedure TevCustomFont.Set_Underline(aValue: Boolean);
//#UC START# *46A612C302D6_547DB5C300FEset_var*
//#UC END# *46A612C302D6_547DB5C300FEset_var*
begin
//#UC START# *46A612C302D6_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612C302D6_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Underline

function TevCustomFont.Get_Strikeout: Boolean;
//#UC START# *46A612DC01F5_547DB5C300FEget_var*
//#UC END# *46A612DC01F5_547DB5C300FEget_var*
begin
//#UC START# *46A612DC01F5_547DB5C300FEget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612DC01F5_547DB5C300FEget_impl*
end;//TevCustomFont.Get_Strikeout

procedure TevCustomFont.Set_Strikeout(aValue: Boolean);
//#UC START# *46A612DC01F5_547DB5C300FEset_var*
//#UC END# *46A612DC01F5_547DB5C300FEset_var*
begin
//#UC START# *46A612DC01F5_547DB5C300FEset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A612DC01F5_547DB5C300FEset_impl*
end;//TevCustomFont.Set_Strikeout

function TevCustomFont.AssignFont(Font: TFont): Boolean;
//#UC START# *46A6154A01EE_547DB5C300FE_var*
//#UC END# *46A6154A01EE_547DB5C300FE_var*
begin
//#UC START# *46A6154A01EE_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6154A01EE_547DB5C300FE_impl*
end;//TevCustomFont.AssignFont

procedure TevCustomFont.Assign2Font(const aFont: Il3Font);
//#UC START# *46A6156000CD_547DB5C300FE_var*
//#UC END# *46A6156000CD_547DB5C300FE_var*
begin
//#UC START# *46A6156000CD_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6156000CD_547DB5C300FE_impl*
end;//TevCustomFont.Assign2Font

procedure TevCustomFont.Lock;
//#UC START# *46A6157B0361_547DB5C300FE_var*
//#UC END# *46A6157B0361_547DB5C300FE_var*
begin
//#UC START# *46A6157B0361_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6157B0361_547DB5C300FE_impl*
end;//TevCustomFont.Lock

procedure TevCustomFont.Unlock;
//#UC START# *46A6158C0275_547DB5C300FE_var*
//#UC END# *46A6158C0275_547DB5C300FE_var*
begin
//#UC START# *46A6158C0275_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A6158C0275_547DB5C300FE_impl*
end;//TevCustomFont.Unlock

function TevCustomFont.HF: hFont;
//#UC START# *46A615A10333_547DB5C300FE_var*
//#UC END# *46A615A10333_547DB5C300FE_var*
begin
//#UC START# *46A615A10333_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A615A10333_547DB5C300FE_impl*
end;//TevCustomFont.HF

function TevCustomFont.IsAtomic: Boolean;
 {* Строка для нанного шрифта представляет собой единый объект? }
//#UC START# *475E5BAD0198_547DB5C300FE_var*
//#UC END# *475E5BAD0198_547DB5C300FE_var*
begin
//#UC START# *475E5BAD0198_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *475E5BAD0198_547DB5C300FE_impl*
end;//TevCustomFont.IsAtomic

function TevCustomFont.FM: Il3FontMetrics;
 {* Метрики шрифта. }
//#UC START# *475E5BED0118_547DB5C300FE_var*
//#UC END# *475E5BED0118_547DB5C300FE_var*
begin
//#UC START# *475E5BED0118_547DB5C300FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *475E5BED0118_547DB5C300FE_impl*
end;//TevCustomFont.FM

end.
