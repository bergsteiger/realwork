unit evResultFontInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\evResultFontInterfaces.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evResultFontInterfaces" MUID: (4E68E4D40035)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evResultFont
 , l3Interfaces
 , l3Core
 , l3Variant
;

type
 IevResultFont = interface
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

uses
 l3ImplUses
 //#UC START# *4E68E4D40035impl_uses*
 //#UC END# *4E68E4D40035impl_uses*
;

end.
