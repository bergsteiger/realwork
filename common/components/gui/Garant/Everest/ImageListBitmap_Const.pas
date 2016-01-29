unit ImageListBitmap_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/ImageListBitmap_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ImageListBitmap
//
// Картинка из списка картинок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ImageListBitmap - "Картинка из списка картинок".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idImageListBitmap = 137;

function k2_typImageListBitmap: ImageListBitmapTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ImageListBitmap : ImageListBitmapTag = nil;

// start class ImageListBitmapTag

function k2_typImageListBitmap: ImageListBitmapTag;
begin
 if (g_ImageListBitmap = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ImageListBitmap := TevNativeSchema(Tk2TypeTable.GetInstance).t_ImageListBitmap;
 end;//g_ImageListBitmap = nil
 Result := g_ImageListBitmap;
end;

end.