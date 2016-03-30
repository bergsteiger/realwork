unit ddRTFdestination;

// Модуль: "w:\common\components\rtl\Garant\dd\ddRTFdestination.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddRTFdestination" MUID: (5190A37F0134)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddCustomDestination
 , RTFtypes
 , ddCustomRTFReader
 , ddRTFState
 , l3Base
 , k2Interfaces
;

type
 TddRTFDestination = class(TddCustomDestination)
  private
   f_RDS: TRDS;
  protected
   f_CustomRTFReader: TddCustomRTFReader;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function pm_GetLiteVersion: Boolean; override;
   function pm_GetIdenticalRowWidths: Boolean; override;
  public
   procedure Clear; virtual;
   procedure AddAnsiChar(aText: AnsiChar;
    aState: TddRTFState); virtual;
   procedure AddString(aText: Tl3String;
    aState: TddRTFState); virtual;
   procedure AddUnicodeChar(aText: Word;
    aState: TddRTFState); virtual;
   procedure ApplyProperty(propType: TPropType;
    What: TIProp;
    Value: LongInt;
    aState: TddRTFState); virtual;
   procedure ParseSymbol(Symbol: Integer;
    propType: TPropType;
    aState: TddRTFState); virtual;
   procedure Write(const aGenerator: Ik2TagGenerator); virtual;
   procedure WriteText(aText: Tl3String;
    aState: TddRTFState); overload; virtual;
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); virtual; abstract;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); overload; virtual; abstract;
   function ReadData: Boolean; virtual;
   procedure FlushBuffer(aState: TddRTFState); virtual;
   constructor Create(aRTFReader: TddCustomRTFReader); reintroduce; virtual;
   procedure BeforeCloseParagraph(const aDocAtom: TObject;
    var aNewStyle: Integer); override;
   function GetMinPictureWidth: Integer; override;
   function GetMinPictureHeight: Integer; override;
  public
   property RDS: TRDS
    read f_RDS
    write f_RDS;
 end;//TddRTFDestination

implementation

uses
 l3ImplUses
;

procedure TddRTFDestination.Clear;
//#UC START# *51D27A48038E_51D276C40106_var*
//#UC END# *51D27A48038E_51D276C40106_var*
begin
//#UC START# *51D27A48038E_51D276C40106_impl*
//#UC END# *51D27A48038E_51D276C40106_impl*
end;//TddRTFDestination.Clear

procedure TddRTFDestination.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_51D276C40106_var*
//#UC END# *51D27C0402E9_51D276C40106_var*
begin
//#UC START# *51D27C0402E9_51D276C40106_impl*
//#UC END# *51D27C0402E9_51D276C40106_impl*
end;//TddRTFDestination.AddAnsiChar

procedure TddRTFDestination.AddString(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *51D27C3302EC_51D276C40106_var*
//#UC END# *51D27C3302EC_51D276C40106_var*
begin
//#UC START# *51D27C3302EC_51D276C40106_impl*
//#UC END# *51D27C3302EC_51D276C40106_impl*
end;//TddRTFDestination.AddString

procedure TddRTFDestination.AddUnicodeChar(aText: Word;
 aState: TddRTFState);
//#UC START# *51D27DFA0308_51D276C40106_var*
//#UC END# *51D27DFA0308_51D276C40106_var*
begin
//#UC START# *51D27DFA0308_51D276C40106_impl*
//#UC END# *51D27DFA0308_51D276C40106_impl*
end;//TddRTFDestination.AddUnicodeChar

procedure TddRTFDestination.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_51D276C40106_var*
//#UC END# *51D27EC50388_51D276C40106_var*
begin
//#UC START# *51D27EC50388_51D276C40106_impl*
//#UC END# *51D27EC50388_51D276C40106_impl*
end;//TddRTFDestination.ApplyProperty

procedure TddRTFDestination.ParseSymbol(Symbol: Integer;
 propType: TPropType;
 aState: TddRTFState);
//#UC START# *51E8CFEF027A_51D276C40106_var*
//#UC END# *51E8CFEF027A_51D276C40106_var*
begin
//#UC START# *51E8CFEF027A_51D276C40106_impl*
//#UC END# *51E8CFEF027A_51D276C40106_impl*
end;//TddRTFDestination.ParseSymbol

procedure TddRTFDestination.Write(const aGenerator: Ik2TagGenerator);
//#UC START# *51E8D04603DF_51D276C40106_var*
//#UC END# *51E8D04603DF_51D276C40106_var*
begin
//#UC START# *51E8D04603DF_51D276C40106_impl*
//#UC END# *51E8D04603DF_51D276C40106_impl*
end;//TddRTFDestination.Write

procedure TddRTFDestination.WriteText(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *51E8D0710060_51D276C40106_var*
//#UC END# *51E8D0710060_51D276C40106_var*
begin
//#UC START# *51E8D0710060_51D276C40106_impl*
//#UC END# *51E8D0710060_51D276C40106_impl*
end;//TddRTFDestination.WriteText

function TddRTFDestination.ReadData: Boolean;
//#UC START# *550913790257_51D276C40106_var*
//#UC END# *550913790257_51D276C40106_var*
begin
//#UC START# *550913790257_51D276C40106_impl*
 Result := True;
//#UC END# *550913790257_51D276C40106_impl*
end;//TddRTFDestination.ReadData

procedure TddRTFDestination.FlushBuffer(aState: TddRTFState);
//#UC START# *55F1787803BB_51D276C40106_var*
//#UC END# *55F1787803BB_51D276C40106_var*
begin
//#UC START# *55F1787803BB_51D276C40106_impl*
 
//#UC END# *55F1787803BB_51D276C40106_impl*
end;//TddRTFDestination.FlushBuffer

constructor TddRTFDestination.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51D276C40106_var*
//#UC END# *51E7C9DB0213_51D276C40106_var*
begin
//#UC START# *51E7C9DB0213_51D276C40106_impl*
 inherited Create;
 f_CustomRTFReader := aRTFReader;
//#UC END# *51E7C9DB0213_51D276C40106_impl*
end;//TddRTFDestination.Create

procedure TddRTFDestination.BeforeCloseParagraph(const aDocAtom: TObject;
 var aNewStyle: Integer);
//#UC START# *534F9B57003E_51D276C40106_var*
//#UC END# *534F9B57003E_51D276C40106_var*
begin
//#UC START# *534F9B57003E_51D276C40106_impl*
//#UC END# *534F9B57003E_51D276C40106_impl*
end;//TddRTFDestination.BeforeCloseParagraph

procedure TddRTFDestination.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51D276C40106_var*
//#UC END# *479731C50290_51D276C40106_var*
begin
//#UC START# *479731C50290_51D276C40106_impl*
 f_CustomRTFReader := nil;
 inherited;
//#UC END# *479731C50290_51D276C40106_impl*
end;//TddRTFDestination.Cleanup

function TddRTFDestination.pm_GetLiteVersion: Boolean;
//#UC START# *51E929770128_51D276C40106get_var*
//#UC END# *51E929770128_51D276C40106get_var*
begin
//#UC START# *51E929770128_51D276C40106get_impl*
 Result := f_CustomRTFReader.LiteVersion;
//#UC END# *51E929770128_51D276C40106get_impl*
end;//TddRTFDestination.pm_GetLiteVersion

function TddRTFDestination.GetMinPictureWidth: Integer;
//#UC START# *56023DD202B1_51D276C40106_var*
//#UC END# *56023DD202B1_51D276C40106_var*
begin
//#UC START# *56023DD202B1_51D276C40106_impl*
 Result := f_CustomRTFReader.MinPicWidth;
//#UC END# *56023DD202B1_51D276C40106_impl*
end;//TddRTFDestination.GetMinPictureWidth

function TddRTFDestination.GetMinPictureHeight: Integer;
//#UC START# *56023E6B0397_51D276C40106_var*
//#UC END# *56023E6B0397_51D276C40106_var*
begin
//#UC START# *56023E6B0397_51D276C40106_impl*
 Result := f_CustomRTFReader.MinPicHeight;
//#UC END# *56023E6B0397_51D276C40106_impl*
end;//TddRTFDestination.GetMinPictureHeight

function TddRTFDestination.pm_GetIdenticalRowWidths: Boolean;
//#UC START# *56163B3F02FE_51D276C40106get_var*
//#UC END# *56163B3F02FE_51D276C40106get_var*
begin
//#UC START# *56163B3F02FE_51D276C40106get_impl*
 Result := f_CustomRTFReader.IdenticalRowWidths;
//#UC END# *56163B3F02FE_51D276C40106get_impl*
end;//TddRTFDestination.pm_GetIdenticalRowWidths

end.
