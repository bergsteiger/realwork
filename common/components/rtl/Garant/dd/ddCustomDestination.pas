unit ddCustomDestination;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddCustomDestination.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddCustomDestination
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3ProtoObject,
  rtfListTable,
  ddRTFProperties,
  ddTypes
  ;

type
 TddCustomDestination = class(Tl3ProtoObject)
 protected
 // property methods
   function pm_GetLiteVersion: Boolean; virtual;
   function pm_GetIdenticalRowWidths: Boolean; virtual;
 public
 // public methods
   function GetStyle(aStyleID: Integer): TddStyleEntry; virtual;
   function GetList(aListID: Integer;
     out aWasRestart: Boolean): TrtfList; virtual;
   function GetClearBorderType: TddClearBoder;
   procedure BeforeCloseParagraph(const aDocAtom: TObject); virtual; abstract;
   function GetMinPictureWidth: Integer; virtual;
   function GetMinPictureHeight: Integer; virtual;
 public
 // public properties
   property LiteVersion: Boolean
     read pm_GetLiteVersion;
   property IdenticalRowWidths: Boolean
     read pm_GetIdenticalRowWidths;
 end;//TddCustomDestination

implementation

// start class TddCustomDestination

function TddCustomDestination.GetStyle(aStyleID: Integer): TddStyleEntry;
//#UC START# *51E8D73F0187_51E9189F024D_var*
//#UC END# *51E8D73F0187_51E9189F024D_var*
begin
//#UC START# *51E8D73F0187_51E9189F024D_impl*
 Result := nil;
//#UC END# *51E8D73F0187_51E9189F024D_impl*
end;//TddCustomDestination.GetStyle

function TddCustomDestination.GetList(aListID: Integer;
  out aWasRestart: Boolean): TrtfList;
//#UC START# *51E8D6CF03A1_51E9189F024D_var*
//#UC END# *51E8D6CF03A1_51E9189F024D_var*
begin
//#UC START# *51E8D6CF03A1_51E9189F024D_impl*
 Result := nil;
 aWasRestart := False;
//#UC END# *51E8D6CF03A1_51E9189F024D_impl*
end;//TddCustomDestination.GetList

function TddCustomDestination.GetClearBorderType: TddClearBoder;
//#UC START# *525E6EA20250_51E9189F024D_var*
//#UC END# *525E6EA20250_51E9189F024D_var*
begin
//#UC START# *525E6EA20250_51E9189F024D_impl*
 Result := dd_cbNeedFrame;
//#UC END# *525E6EA20250_51E9189F024D_impl*
end;//TddCustomDestination.GetClearBorderType

function TddCustomDestination.GetMinPictureWidth: Integer;
//#UC START# *56023DD202B1_51E9189F024D_var*
//#UC END# *56023DD202B1_51E9189F024D_var*
begin
//#UC START# *56023DD202B1_51E9189F024D_impl*
 Result := 0;
//#UC END# *56023DD202B1_51E9189F024D_impl*
end;//TddCustomDestination.GetMinPictureWidth

function TddCustomDestination.GetMinPictureHeight: Integer;
//#UC START# *56023E6B0397_51E9189F024D_var*
//#UC END# *56023E6B0397_51E9189F024D_var*
begin
//#UC START# *56023E6B0397_51E9189F024D_impl*
 Result := 0;
//#UC END# *56023E6B0397_51E9189F024D_impl*
end;//TddCustomDestination.GetMinPictureHeight

function TddCustomDestination.pm_GetLiteVersion: Boolean;
//#UC START# *51E929770128_51E9189F024Dget_var*
//#UC END# *51E929770128_51E9189F024Dget_var*
begin
//#UC START# *51E929770128_51E9189F024Dget_impl*
 Result := False;
//#UC END# *51E929770128_51E9189F024Dget_impl*
end;//TddCustomDestination.pm_GetLiteVersion

function TddCustomDestination.pm_GetIdenticalRowWidths: Boolean;
//#UC START# *56163B3F02FE_51E9189F024Dget_var*
//#UC END# *56163B3F02FE_51E9189F024Dget_var*
begin
//#UC START# *56163B3F02FE_51E9189F024Dget_impl*
 Result := False;
//#UC END# *56163B3F02FE_51E9189F024Dget_impl*
end;//TddCustomDestination.pm_GetIdenticalRowWidths

end.