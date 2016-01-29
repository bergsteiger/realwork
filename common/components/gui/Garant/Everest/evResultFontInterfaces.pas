unit evResultFontInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evResultFontInterfaces.pas"
// Начат: 08.09.2011 19:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::evResultFont::evResultFontInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Interfaces,
  l3Core,
  evResultFont,
  l3Variant
  ;

type
 IevResultFont = interface(IUnknown)
   ['{C40D1EE4-2C8A-4010-852A-6314617C65FD}']
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
   property Font: PevResultFontEx
     read Get_Font;
 end;//IevResultFont

implementation

end.