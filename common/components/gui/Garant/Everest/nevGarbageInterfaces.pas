unit nevGarbageInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevGarbageInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::nevGarbageInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  afwInterfaces
  ;

(*
 MnevFontTool = PureMixIn
   function GetObjRealFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* получить шрифт объекта. }
   function GetObjIFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aParentFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* получить шрифт объекта. }
 end;//MnevFontTool
*)

type
 InevFontTool = interface(IafwFontCache)
  {* Кэш шрифтов. }
   ['{18AC2452-9182-4E5E-A089-AEDFDD334089}']
  // MnevFontTool
   function GetObjRealFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* получить шрифт объекта. }
   function GetObjIFont(const aView: InevViewMetrics;
    Para: Tl3Variant;
    IsSegment: Boolean;
    aParentFI: TnevFormatInfoPrim;
    CorrectItalic: Boolean = true): InevFont;
     {* получить шрифт объекта. }
 end;//InevFontTool

implementation

end.