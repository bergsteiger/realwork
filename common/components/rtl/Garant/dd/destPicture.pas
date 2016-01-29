unit destPicture;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destPicture.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestPicture
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  l3Filer,
  l3Parser,
  RTFtypes,
  destNorm,
  ddPicture,
  ddRTFState,
  ddCustomRTFReader,
  ddRTFdestination
  ;

type
 TdestPicture = class(TdestNorm)
 private
 // private methods
   procedure ApplyToPicture(aWhat: TIProp;
     aValue: LongInt);
   function Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
     {* Пытаемся передать обработку "знающим" объектам. }
   procedure TryToClearText(aParser: Tl3CustomParser);
   procedure AddHexData(const aHexStream: Tl3String);
 protected
 // property methods
   function pm_GetPicture: TddPicture; virtual;
 protected
 // overridden protected methods
   function CanAddTable: Boolean; override;
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure ApplyProperty(propType: TPropType;
     What: TIProp;
     Value: LongInt;
     aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
   function ReadData: Boolean; override;
 public
 // public properties
   property Picture: TddPicture
     read pm_GetPicture;
 end;//TdestPicture

implementation

uses
  SysUtils,
  ddConst,
  l3Interfaces
  ;

// start class TdestPicture

procedure TdestPicture.ApplyToPicture(aWhat: TIProp;
  aValue: LongInt);
//#UC START# *51E8E82F0299_51E8E771003A_var*
//#UC END# *51E8E82F0299_51E8E771003A_var*
begin
//#UC START# *51E8E82F0299_51E8E771003A_impl*
 case aWhat of
  ipropHeight  : Picture.Height:= aValue;
  ipropWidth   : Picture.Width:= aValue;
  ipropScaleX  : Picture.ScaleX:= aValue;
  ipropScaleY  : Picture.ScaleY:= aValue;
  ipropPicCropL: Picture.CropL:= aValue;
  ipropPicCropR: Picture.CropR:= aValue;
  ipropPicCropT: Picture.CropT:= aValue;
  ipropPicCropB: Picture.CropB:= aValue;
  ipropPicEMF: Picture.Format := pictEMF;
  ipropPicJPEG: Picture.Format := pictJPG;
  ipropPicPNG: Picture.Format := pictPNG;
  ipropPicWMF: Picture.Format := pictWMF;
  ipropBin: Picture.Try2ReadBinaryData(f_CustomRTFReader.Parser.Filer, aValue);
  iproppicw: Picture.WidthInPixels := aValue;
  iproppich: Picture.HeightInPixels := aValue;
 end;
//#UC END# *51E8E82F0299_51E8E771003A_impl*
end;//TdestPicture.ApplyToPicture

function TdestPicture.Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
//#UC START# *534658E901B6_51E8E771003A_var*
//#UC END# *534658E901B6_51E8E771003A_var*
begin
//#UC START# *534658E901B6_51E8E771003A_impl*
 Result := Picture.Try2ReadKnownPicture(aFiler);
//#UC END# *534658E901B6_51E8E771003A_impl*
end;//TdestPicture.Try2ReadKnownPicture

procedure TdestPicture.TryToClearText(aParser: Tl3CustomParser);
//#UC START# *54E46D5F0045_51E8E771003A_var*
//#UC END# *54E46D5F0045_51E8E771003A_var*
begin
//#UC START# *54E46D5F0045_51E8E771003A_impl*
 if not TextBuffer.Empty then
 begin
  aParser.Filer.UngetChars(TextBuffer.Len);
  TextBuffer.Clear;
 end; // if not Text.Empty then
 with Picture do
  if not Text.Empty then
  begin
   aParser.Filer.UngetChars(Text.Len);
   Text.Clear;
  end; // if not Text.Empty then
//#UC END# *54E46D5F0045_51E8E771003A_impl*
end;//TdestPicture.TryToClearText

procedure TdestPicture.AddHexData(const aHexStream: Tl3String);
//#UC START# *54E46DAF037C_51E8E771003A_var*
//#UC END# *54E46DAF037C_51E8E771003A_var*
begin
//#UC START# *54E46DAF037C_51E8E771003A_impl*
 Picture.AddHexData(aHexStream);
//#UC END# *54E46DAF037C_51E8E771003A_impl*
end;//TdestPicture.AddHexData

function TdestPicture.pm_GetPicture: TddPicture;
//#UC START# *51E8E7DC003B_51E8E771003Aget_var*
//#UC END# *51E8E7DC003B_51E8E771003Aget_var*
begin
//#UC START# *51E8E7DC003B_51E8E771003Aget_impl*
 Result := TddPicture(LastAtom);
//#UC END# *51E8E7DC003B_51E8E771003Aget_impl*
end;//TdestPicture.pm_GetPicture

procedure TdestPicture.Clear;
//#UC START# *51D27A48038E_51E8E771003A_var*
//#UC END# *51D27A48038E_51E8E771003A_var*
begin
//#UC START# *51D27A48038E_51E8E771003A_impl*
 inherited;
 Picture.Clear;
//#UC END# *51D27A48038E_51E8E771003A_impl*
end;//TdestPicture.Clear

procedure TdestPicture.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_51E8E771003A_var*
//#UC END# *51D27C3302EC_51E8E771003A_var*
begin
//#UC START# *51D27C3302EC_51E8E771003A_impl*
 Picture.AddText(aText);
//#UC END# *51D27C3302EC_51E8E771003A_impl*
end;//TdestPicture.AddString

procedure TdestPicture.ApplyProperty(propType: TPropType;
  What: TIProp;
  Value: LongInt;
  aState: TddRTFState);
//#UC START# *51D27EC50388_51E8E771003A_var*
//#UC END# *51D27EC50388_51E8E771003A_var*
begin
//#UC START# *51D27EC50388_51E8E771003A_impl*
 if propType = propPict then
  ApplyToPicture(What, Value)
 else
  inherited;
//#UC END# *51D27EC50388_51E8E771003A_impl*
end;//TdestPicture.ApplyProperty

constructor TdestPicture.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51E8E771003A_var*
var
 l_Picture: TddPicture;
//#UC END# *51E7C9DB0213_51E8E771003A_var*
begin
//#UC START# *51E7C9DB0213_51E8E771003A_impl*
 inherited Create(aRTFReader);
 l_Picture := TddPicture.Create(Self);
 try
  AddParagraph(l_Picture);
 finally
  FreeAndNil(l_Picture);
 end;
//#UC END# *51E7C9DB0213_51E8E771003A_impl*
end;//TdestPicture.Create

procedure TdestPicture.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51E8E771003A_var*
var
 l_NeedSkip: TRTFPictureSkip;
//#UC END# *5461BEC2017D_51E8E771003A_var*
begin
//#UC START# *5461BEC2017D_51E8E771003A_impl*
 l_NeedSkip := f_CustomRTFReader.NeedSkip(Picture);
 if (l_NeedSkip <> rtf_psYes) and (aNewDest is TdestNorm) then
  TdestNorm(aNewDest).AddPicture(Picture, aState, l_NeedSkip = rtf_psWMF);
 Clear;
 f_CustomRTFReader.SkipPicture := False;
//#UC END# *5461BEC2017D_51E8E771003A_impl*
end;//TdestPicture.Close

procedure TdestPicture.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51E8E771003A_var*
//#UC END# *54E1F08400F9_51E8E771003A_var*
begin
//#UC START# *54E1F08400F9_51E8E771003A_impl*
 Assert(False, 'Добавление картники из необычного места');
//#UC END# *54E1F08400F9_51E8E771003A_impl*
end;//TdestPicture.WriteText

function TdestPicture.ReadData: Boolean;
//#UC START# *550913790257_51E8E771003A_var*

 procedure lp_FinalAction;
 begin
  Result := True;
  f_CustomRTFReader.Parser.NextTokenSp;
 end;

 function lp_CheckEOF: Boolean;
 begin
  Result := f_CustomRTFReader.Parser.Filer.EOF;
  if Result then
  begin
   f_CustomRTFReader.Status := ecInvalidPicture;
   lp_FinalAction;
  end; // if Result then
 end;

var
 l_Str      : Tl3WString;
 l_KnonwData: Tl3String;
//#UC END# *550913790257_51E8E771003A_var*
begin
//#UC START# *550913790257_51E8E771003A_impl*
 Result := inherited ReadData;
 with f_CustomRTFReader.Parser.Filer do
 begin
  TryToClearText(f_CustomRTFReader.Parser);
  UngetC; // И текущий символ тоже нужно прочитать...
  l_KnonwData := Try2ReadKnownPicture(f_CustomRTFReader.Parser.Filer); // А попробуем-ка считать побыстрому...
  try
   if lp_CheckEOF then Exit;
   l_Str := ReadHexLn(cc_HexDigitalCharSetWithEnters, cc_RTFFinishLineChar); // Дочитываем хвост или читаем целиком...
   if lp_CheckEOF then Exit;
   if not f_CustomRTFReader.SkipHexData then // Надо бы "запилить" Filer для такого случая...
   begin
    if l_Str.SLen > 0 then
     if l_KnonwData = nil then
      l_KnonwData := Tl3String.Make(l_Str)
     else
      l_KnonwData.Append(l_Str);
    AddHexData(l_KnonwData);
   end; // if not l_WrongData and not f_CustomRTFReader.SkipHexData then
  finally
   l3Free(l_KnonwData);
  end;
  lp_FinalAction;
 end; // with Parser.Filer do
//#UC END# *550913790257_51E8E771003A_impl*
end;//TdestPicture.ReadData

function TdestPicture.CanAddTable: Boolean;
//#UC START# *559516AA0098_51E8E771003A_var*
//#UC END# *559516AA0098_51E8E771003A_var*
begin
//#UC START# *559516AA0098_51E8E771003A_impl*
 Result := False;
//#UC END# *559516AA0098_51E8E771003A_impl*
end;//TdestPicture.CanAddTable

end.