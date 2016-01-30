unit nevGarbageInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\nevGarbageInterfaces.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBase
 , afwInterfaces
;

 (*
 MnevFontTool = interface
  function GetObjRealFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* получить шрифт объекта. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* получить шрифт объекта. }
 end;//MnevFontTool
 *)

type
 InevFontTool = interface(IafwFontCache)
  {* Кэш шрифтов. }
  ['{18AC2452-9182-4E5E-A089-AEDFDD334089}']
  function GetObjRealFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* получить шрифт объекта. }
  function GetObjIFont(const aView: InevViewMetrics;
   Para: Tl3Variant;
   IsSegment: Boolean;
   aParentFI: TnevFormatInfoPrim;
   CorrectItalic: Boolean = True): InevFont;
   {* получить шрифт объекта. }
 end;//InevFontTool

implementation

uses
 l3ImplUses
;

end.
