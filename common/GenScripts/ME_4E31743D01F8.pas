unit evDefaultStylesFontSizes;
 {* Размеры шрифтов для стилей по-умолчанию }

// Модуль: "w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizes.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evDefaultStylesFontSizesPrim1
 , l3Variant
;

type
 TevDefaultStylesFontSizes = class(TevDefaultStylesFontSizesPrim1)
  {* Размеры шрифтов для стилей по-умолчанию }
  private
   f_Saved: Boolean;
  public
   function FontSizeForTag(aTag: Tl3Variant): Integer;
   procedure SaveStylesFontSizes;
   function FontSizeForStyle(aStyle: Integer): Integer;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TevDefaultStylesFontSizes;
    {* Метод получения экземпляра синглетона TevDefaultStylesFontSizes }
 end;//TevDefaultStylesFontSizes

implementation

uses
 l3ImplUses
 , l3Math
 , evdStyles
 , l3MinMax
 , SysUtils
 , l3Base
 , k2Tags
 , evDef
 , evStyleInterface
 , evDefaultStylesFontSizesPrim
 , l3Types
;

var g_TevDefaultStylesFontSizes: TevDefaultStylesFontSizes = nil;
 {* Экземпляр синглетона TevDefaultStylesFontSizes }

procedure TevDefaultStylesFontSizesFree;
 {* Метод освобождения экземпляра синглетона TevDefaultStylesFontSizes }
begin
 l3Free(g_TevDefaultStylesFontSizes);
end;//TevDefaultStylesFontSizesFree

function TevDefaultStylesFontSizes.FontSizeForTag(aTag: Tl3Variant): Integer;
//#UC START# *4E317625032D_4E31743D01F8_var*
//#UC END# *4E317625032D_4E31743D01F8_var*
begin
//#UC START# *4E317625032D_4E31743D01F8_impl*
 Result := FontSizeForStyle(aTag.IntA[k2_tiStyle]);
//#UC END# *4E317625032D_4E31743D01F8_impl*
end;//TevDefaultStylesFontSizes.FontSizeForTag

procedure TevDefaultStylesFontSizes.SaveStylesFontSizes;
//#UC START# *4E317944036F_4E31743D01F8_var*
var
 l_S : TevStyleInterface;

 function DoStyle(aStyle: PObject; Index: Integer): Boolean;
 begin//DoStyle
  Result := true;
  Self.Add(TevDefaultStyleFontSize_C(l_S.Tag.IntA[k2_tiHandle], l_S.Font.Size));
 end;//DoStyle

//#UC END# *4E317944036F_4E31743D01F8_var*
begin
//#UC START# *4E317944036F_4E31743D01F8_impl*
 l_S := TevStyleInterface.Make;
 try
  l_S.IterateF(l3L2IA(@DoStyle));
 finally
  FreeAndNil(l_S);
 end;//try..finally
 f_Saved := true;
//#UC END# *4E317944036F_4E31743D01F8_impl*
end;//TevDefaultStylesFontSizes.SaveStylesFontSizes

function TevDefaultStylesFontSizes.FontSizeForStyle(aStyle: Integer): Integer;
//#UC START# *4E32AE440052_4E31743D01F8_var*
var
 l_Index : Integer;
 l_UserSize : Integer;
 l_NormalSize : Integer;
//#UC END# *4E32AE440052_4E31743D01F8_var*
begin
//#UC START# *4E32AE440052_4E31743D01F8_impl*
 if FindData(aStyle, l_Index) then
  Result := Items[l_Index].rFontSize
 else
  Result := def_FontSize;
 l_UserSize := TevStyleInterface.PrintAndExportFontSize;
 if (l_UserSize > 0) then
 begin
  if FindData(ev_saTxtNormalANSI, l_Index) then
   l_NormalSize := Items[l_Index].rFontSize
  else
   l_NormalSize := def_FontSize;
  Result := l3MulDiv(Result, l_UserSize, l_NormalSize);
  Result := Max(5, Result);
 end;//l_UserSize > 0
//#UC END# *4E32AE440052_4E31743D01F8_impl*
end;//TevDefaultStylesFontSizes.FontSizeForStyle

class function TevDefaultStylesFontSizes.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TevDefaultStylesFontSizes <> nil;
end;//TevDefaultStylesFontSizes.Exists

class function TevDefaultStylesFontSizes.Instance: TevDefaultStylesFontSizes;
 {* Метод получения экземпляра синглетона TevDefaultStylesFontSizes }
begin
 if (g_TevDefaultStylesFontSizes = nil) then
 begin
  l3System.AddExitProc(TevDefaultStylesFontSizesFree);
  g_TevDefaultStylesFontSizes := Create;
 end;
 Result := g_TevDefaultStylesFontSizes;
end;//TevDefaultStylesFontSizes.Instance

end.
