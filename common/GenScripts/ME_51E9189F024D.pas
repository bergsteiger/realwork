unit ddCustomDestination;

// Модуль: "w:\common\components\rtl\Garant\dd\ddCustomDestination.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddRTFProperties
 , rtfListTable
 , ddTypes
;

type
 TddCustomDestination = class(Tl3ProtoObject)
  protected
   function pm_GetLiteVersion: Boolean; virtual;
   function pm_GetIdenticalRowWidths: Boolean; virtual;
  public
   function GetStyle(aStyleID: Integer): TddStyleEntry; virtual;
   function GetList(aListID: Integer;
    out aWasRestart: Boolean): TrtfList; virtual;
   function GetClearBorderType: TddClearBoder;
   procedure BeforeCloseParagraph(const aDocAtom: TObject;
    var aNewStyle: Integer); virtual; abstract;
   function GetMinPictureWidth: Integer; virtual;
   function GetMinPictureHeight: Integer; virtual;
   function NextTextPara(const anCurrent: TObject): TObject; virtual;
  public
   property LiteVersion: Boolean
    read pm_GetLiteVersion;
   property IdenticalRowWidths: Boolean
    read pm_GetIdenticalRowWidths;
 end;//TddCustomDestination

implementation

uses
 l3ImplUses
;

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

function TddCustomDestination.NextTextPara(const anCurrent: TObject): TObject;
//#UC START# *5658453300F6_51E9189F024D_var*
//#UC END# *5658453300F6_51E9189F024D_var*
begin
//#UC START# *5658453300F6_51E9189F024D_impl*
 Result := nil;
//#UC END# *5658453300F6_51E9189F024D_impl*
end;//TddCustomDestination.NextTextPara

end.
