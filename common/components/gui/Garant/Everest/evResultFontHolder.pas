unit evResultFontHolder;

// Модуль: "w:\common\components\gui\Garant\Everest\evResultFontHolder.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevResultFontHolder" MUID: (4E68E533026D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , evResultFontInterfaces
 , evResultFont
 , l3Interfaces
 , l3Core
 , l3Variant
;

type
 TevResultFontHolder = class(Tl3CProtoObject, IevResultFont)
  private
   f_Font: TevResultFontEx;
  protected
   function Get_Font: PevResultFontEx;
   procedure Clear;
   function AsFont(aCorrectItalic: Boolean;
    aCheckNew: Boolean): Il3Font;
   procedure AddStyledTag(aTag: Tl3Variant);
   function GetItem(anIndex: Integer): PInteger;
   procedure SetItem(anIndex: Integer;
    aValue: Integer);
   function IsTransparent(anIndex: Integer): Boolean;
   procedure AddTag(aTag: Tl3Variant);
   procedure AddFont(const aFont: IevResultFont);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   constructor Create; reintroduce;
   class function Make: IevResultFont; reintroduce;
 end;//TevResultFontHolder

implementation

uses
 l3ImplUses
 , k2Const
 //#UC START# *4E68E533026Dimpl_uses*
 //#UC END# *4E68E533026Dimpl_uses*
;

constructor TevResultFontHolder.Create;
//#UC START# *4E68E5AB0093_4E68E533026D_var*
//#UC END# *4E68E5AB0093_4E68E533026D_var*
begin
//#UC START# *4E68E5AB0093_4E68E533026D_impl*
 inherited Create;
//#UC END# *4E68E5AB0093_4E68E533026D_impl*
end;//TevResultFontHolder.Create

class function TevResultFontHolder.Make: IevResultFont;
var
 l_Inst : TevResultFontHolder;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevResultFontHolder.Make

function TevResultFontHolder.Get_Font: PevResultFontEx;
//#UC START# *4E68E52102C7_4E68E533026Dget_var*
//#UC END# *4E68E52102C7_4E68E533026Dget_var*
begin
//#UC START# *4E68E52102C7_4E68E533026Dget_impl*
 Result := @f_Font;
//#UC END# *4E68E52102C7_4E68E533026Dget_impl*
end;//TevResultFontHolder.Get_Font

procedure TevResultFontHolder.Clear;
//#UC START# *4E68E60C03BD_4E68E533026D_var*
//#UC END# *4E68E60C03BD_4E68E533026D_var*
begin
//#UC START# *4E68E60C03BD_4E68E533026D_impl*
 f_Font.Clear;
//#UC END# *4E68E60C03BD_4E68E533026D_impl*
end;//TevResultFontHolder.Clear

function TevResultFontHolder.AsFont(aCorrectItalic: Boolean;
 aCheckNew: Boolean): Il3Font;
//#UC START# *4E68E62D01A6_4E68E533026D_var*
//#UC END# *4E68E62D01A6_4E68E533026D_var*
begin
//#UC START# *4E68E62D01A6_4E68E533026D_impl*
 Result := f_Font.AsFont(aCorrectItalic, aCheckNew);
//#UC END# *4E68E62D01A6_4E68E533026D_impl*
end;//TevResultFontHolder.AsFont

procedure TevResultFontHolder.AddStyledTag(aTag: Tl3Variant);
//#UC START# *4E68ECE500E0_4E68E533026D_var*
//#UC END# *4E68ECE500E0_4E68E533026D_var*
begin
//#UC START# *4E68ECE500E0_4E68E533026D_impl*
 f_Font.AddStyledTag(aTag);
//#UC END# *4E68ECE500E0_4E68E533026D_impl*
end;//TevResultFontHolder.AddStyledTag

function TevResultFontHolder.GetItem(anIndex: Integer): PInteger;
//#UC START# *4E68EF1101EB_4E68E533026D_var*
//#UC END# *4E68EF1101EB_4E68E533026D_var*
begin
//#UC START# *4E68EF1101EB_4E68E533026D_impl*
 Result := f_Font.GetItem(anIndex);
//#UC END# *4E68EF1101EB_4E68E533026D_impl*
end;//TevResultFontHolder.GetItem

procedure TevResultFontHolder.SetItem(anIndex: Integer;
 aValue: Integer);
//#UC START# *4E68F1250350_4E68E533026D_var*
//#UC END# *4E68F1250350_4E68E533026D_var*
begin
//#UC START# *4E68F1250350_4E68E533026D_impl*
 f_Font.SetItem(anIndex, nil, aValue);
//#UC END# *4E68F1250350_4E68E533026D_impl*
end;//TevResultFontHolder.SetItem

function TevResultFontHolder.IsTransparent(anIndex: Integer): Boolean;
//#UC START# *4E68F2C100C6_4E68E533026D_var*
var
 l_SizePtr : PInteger;
//#UC END# *4E68F2C100C6_4E68E533026D_var*
begin
//#UC START# *4E68F2C100C6_4E68E533026D_impl*
 l_SizePtr := GetItem(anIndex);
 Result := (l_SizePtr <> nil) AND (l_SizePtr^ = k2_TransparentValue);
//#UC END# *4E68F2C100C6_4E68E533026D_impl*
end;//TevResultFontHolder.IsTransparent

procedure TevResultFontHolder.AddTag(aTag: Tl3Variant);
//#UC START# *4E68F40E0197_4E68E533026D_var*
//#UC END# *4E68F40E0197_4E68E533026D_var*
begin
//#UC START# *4E68F40E0197_4E68E533026D_impl*
 f_Font.AddTag(aTag);
//#UC END# *4E68F40E0197_4E68E533026D_impl*
end;//TevResultFontHolder.AddTag

procedure TevResultFontHolder.AddFont(const aFont: IevResultFont);
//#UC START# *4E68F4EB016A_4E68E533026D_var*
//#UC END# *4E68F4EB016A_4E68E533026D_var*
begin
//#UC START# *4E68F4EB016A_4E68E533026D_impl*
 f_Font.AddFont(aFont.Font^);
//#UC END# *4E68F4EB016A_4E68E533026D_impl*
end;//TevResultFontHolder.AddFont

procedure TevResultFontHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4E68E533026D_var*
//#UC END# *479731C50290_4E68E533026D_var*
begin
//#UC START# *479731C50290_4E68E533026D_impl*
 f_Font.Clear;
 inherited;
//#UC END# *479731C50290_4E68E533026D_impl*
end;//TevResultFontHolder.Cleanup

procedure TevResultFontHolder.InitFields;
//#UC START# *47A042E100E2_4E68E533026D_var*
//#UC END# *47A042E100E2_4E68E533026D_var*
begin
//#UC START# *47A042E100E2_4E68E533026D_impl*
 inherited;
 f_Font.Init;
//#UC END# *47A042E100E2_4E68E533026D_impl*
end;//TevResultFontHolder.InitFields

end.
