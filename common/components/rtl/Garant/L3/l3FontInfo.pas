unit l3FontInfo;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FontInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3FontInfo" MUID: (5786531B02BD)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
 , Graphics
;

type
 Tl3FontInfo = class(Tl3CProtoObject, Il3FontInfo)
  private
   f_Font: TFont;
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
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create(aFont: TFont); reintroduce;
   class function Make(aFont: TFont): Il3FontInfo; reintroduce;
 end;//Tl3FontInfo

implementation

uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoScripts)}
 , FontWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *5786531B02BDimpl_uses*
 //#UC END# *5786531B02BDimpl_uses*
;

constructor Tl3FontInfo.Create(aFont: TFont);
//#UC START# *578653EC01D9_5786531B02BD_var*
//#UC END# *578653EC01D9_5786531B02BD_var*
begin
//#UC START# *578653EC01D9_5786531B02BD_impl*
 inherited Create;
 f_Font := TFont.Create;
 f_Font.Assign(aFont);
//#UC END# *578653EC01D9_5786531B02BD_impl*
end;//Tl3FontInfo.Create

class function Tl3FontInfo.Make(aFont: TFont): Il3FontInfo;
var
 l_Inst : Tl3FontInfo;
begin
 l_Inst := Create(aFont);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3FontInfo.Make

function Tl3FontInfo.Get_Size: Integer;
//#UC START# *46A60D7A02E4_5786531B02BDget_var*
//#UC END# *46A60D7A02E4_5786531B02BDget_var*
begin
//#UC START# *46A60D7A02E4_5786531B02BDget_impl*
 Result := f_Font.Size;
//#UC END# *46A60D7A02E4_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Size

function Tl3FontInfo.Get_Name: TFontName;
//#UC START# *46A60E2802E4_5786531B02BDget_var*
//#UC END# *46A60E2802E4_5786531B02BDget_var*
begin
//#UC START# *46A60E2802E4_5786531B02BDget_impl*
 Result := f_Font.Name;
//#UC END# *46A60E2802E4_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Name

function Tl3FontInfo.Get_Bold: Boolean;
//#UC START# *46A60E58013F_5786531B02BDget_var*
//#UC END# *46A60E58013F_5786531B02BDget_var*
begin
//#UC START# *46A60E58013F_5786531B02BDget_impl*
 Result := (fsBold in f_Font.Style);
//#UC END# *46A60E58013F_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Bold

function Tl3FontInfo.Get_Italic: Boolean;
//#UC START# *46A60E740045_5786531B02BDget_var*
//#UC END# *46A60E740045_5786531B02BDget_var*
begin
//#UC START# *46A60E740045_5786531B02BDget_impl*
 Result := (fsItalic in f_Font.Style);
//#UC END# *46A60E740045_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Italic

function Tl3FontInfo.Get_Underline: Boolean;
//#UC START# *46A60EA6032C_5786531B02BDget_var*
//#UC END# *46A60EA6032C_5786531B02BDget_var*
begin
//#UC START# *46A60EA6032C_5786531B02BDget_impl*
 Result := (fsUnderline in f_Font.Style);
//#UC END# *46A60EA6032C_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Underline

function Tl3FontInfo.Get_Strikeout: Boolean;
//#UC START# *46A60EBF03BE_5786531B02BDget_var*
//#UC END# *46A60EBF03BE_5786531B02BDget_var*
begin
//#UC START# *46A60EBF03BE_5786531B02BDget_impl*
 Result := (fsStrikeout in f_Font.Style);
//#UC END# *46A60EBF03BE_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Strikeout

function Tl3FontInfo.Get_ForeColor: Tl3Color;
//#UC START# *46A60ED90325_5786531B02BDget_var*
//#UC END# *46A60ED90325_5786531B02BDget_var*
begin
//#UC START# *46A60ED90325_5786531B02BDget_impl*
 Result := f_Font.Color;
//#UC END# *46A60ED90325_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_ForeColor

function Tl3FontInfo.Get_BackColor: Tl3Color;
//#UC START# *46A60EF300C9_5786531B02BDget_var*
//#UC END# *46A60EF300C9_5786531B02BDget_var*
begin
//#UC START# *46A60EF300C9_5786531B02BDget_impl*
 Result := clNone;
//#UC END# *46A60EF300C9_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_BackColor

function Tl3FontInfo.Get_Pitch: TFontPitch;
//#UC START# *46A60F63035F_5786531B02BDget_var*
//#UC END# *46A60F63035F_5786531B02BDget_var*
begin
//#UC START# *46A60F63035F_5786531B02BDget_impl*
 Result := f_Font.Pitch;
//#UC END# *46A60F63035F_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Pitch

function Tl3FontInfo.Get_Index: Tl3FontIndex;
//#UC START# *46A60F89031E_5786531B02BDget_var*
//#UC END# *46A60F89031E_5786531B02BDget_var*
begin
//#UC START# *46A60F89031E_5786531B02BDget_impl*
 Result := l3_fiNone;
//#UC END# *46A60F89031E_5786531B02BDget_impl*
end;//Tl3FontInfo.Get_Index

procedure Tl3FontInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5786531B02BD_var*
//#UC END# *479731C50290_5786531B02BD_var*
begin
//#UC START# *479731C50290_5786531B02BD_impl*
 FreeAndNil(f_Font);
 inherited;
//#UC END# *479731C50290_5786531B02BD_impl*
end;//Tl3FontInfo.Cleanup

procedure Tl3FontInfo.InitFields;
//#UC START# *47A042E100E2_5786531B02BD_var*
//#UC END# *47A042E100E2_5786531B02BD_var*
begin
//#UC START# *47A042E100E2_5786531B02BD_impl*
 inherited;
//#UC END# *47A042E100E2_5786531B02BD_impl*
end;//Tl3FontInfo.InitFields

end.
