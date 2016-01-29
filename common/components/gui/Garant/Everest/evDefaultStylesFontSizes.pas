unit evDefaultStylesFontSizes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evDefaultStylesFontSizes.pas"
// Начат: 28.07.2011 18:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::StyleTable::TevDefaultStylesFontSizes
//
// Размеры шрифтов для стилей по-умолчанию
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  evDefaultStylesFontSizesPrim1,
  l3Variant
  ;

type
 TevDefaultStylesFontSizes = class(TevDefaultStylesFontSizesPrim1)
  {* Размеры шрифтов для стилей по-умолчанию }
 private
 // private fields
   f_Saved : Boolean;
 public
 // public methods
   function FontSizeForTag(aTag: Tl3Variant): Integer;
   procedure SaveStylesFontSizes;
   function FontSizeForStyle(aStyle: Integer): Integer;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TevDefaultStylesFontSizes;
    {- возвращает экземпляр синглетона. }
 end;//TevDefaultStylesFontSizes

implementation

uses
  l3Base {a},
  k2Tags,
  evDef,
  evStyleInterface,
  evDefaultStylesFontSizesPrim,
  l3Types,
  SysUtils,
  l3Math,
  evdStyles,
  l3MinMax
  ;


// start class TevDefaultStylesFontSizes

var g_TevDefaultStylesFontSizes : TevDefaultStylesFontSizes = nil;

procedure TevDefaultStylesFontSizesFree;
begin
 l3Free(g_TevDefaultStylesFontSizes);
end;

class function TevDefaultStylesFontSizes.Instance: TevDefaultStylesFontSizes;
begin
 if (g_TevDefaultStylesFontSizes = nil) then
 begin
  l3System.AddExitProc(TevDefaultStylesFontSizesFree);
  g_TevDefaultStylesFontSizes := Create;
 end;
 Result := g_TevDefaultStylesFontSizes;
end;


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
 {-}
begin
 Result := g_TevDefaultStylesFontSizes <> nil;
end;//TevDefaultStylesFontSizes.Exists

end.