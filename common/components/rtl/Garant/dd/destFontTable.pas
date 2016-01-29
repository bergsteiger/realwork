unit destFontTable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destFontTable.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::RTFSupport::destFontTable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3StringList,
  ddRTFdestination,
  ddRTFProperties,
  ddRTFState,
  l3Base,
  RTFtypes,
  ddCustomRTFReader
  ;

type
 TddFontTable = class(Tl3StringList)
 protected
 // property methods
   function pm_GetFonts(anIndex: Integer): TddFontEntry;
   function pm_GetFontNames(anIndex: Integer): AnsiString;
 public
 // public properties
   property Fonts[anIndex: Integer]: TddFontEntry
     read pm_GetFonts;
   property FontNames[anIndex: Integer]: AnsiString
     read pm_GetFontNames;
 end;//TddFontTable

 TdestFontTable = class(TddRTFDestination)
 private
 // private fields
   f_Fonts : TddFontTable;
 protected
 // property methods
   function pm_GetCount: Integer;
   function pm_GetCurFont: TddFontEntry; virtual;
   function pm_GetItems(anIndex: Integer): TddFontEntry;
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure ApplyProperty(propType: TPropType;
     What: TIProp;
     Value: LongInt;
     aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
 public
 // public methods
   procedure AddFont;
   function FontByNumber(aNumber: Integer): TddFontEntry;
 public
 // public properties
   property Count: Integer
     read pm_GetCount;
   property CurFont: TddFontEntry
     read pm_GetCurFont;
   property Items[anIndex: Integer]: TddFontEntry
     read pm_GetItems;
     default;
 end;//TdestFontTable

implementation

uses
  SysUtils
  ;

// start class TddFontTable

function TddFontTable.pm_GetFonts(anIndex: Integer): TddFontEntry;
//#UC START# *54E194240104_54E1908B0336get_var*
var
 i: Integer;
//#UC END# *54E194240104_54E1908B0336get_var*
begin
//#UC START# *54E194240104_54E1908B0336get_impl*
 Result := nil;
 for i := 0 to Hi do
 begin
  if TddFontEntry(Items[I]).Number = anIndex then
  begin;
   Result := TddFontEntry(Items[I]);
   Break;
  end;
 end;
//#UC END# *54E194240104_54E1908B0336get_impl*
end;//TddFontTable.pm_GetFonts

function TddFontTable.pm_GetFontNames(anIndex: Integer): AnsiString;
//#UC START# *54E194A303CE_54E1908B0336get_var*
var
 l_F: TddFontEntry;
//#UC END# *54E194A303CE_54E1908B0336get_var*
begin
//#UC START# *54E194A303CE_54E1908B0336get_impl*
 l_F := Fonts[anIndex];
 if l_F = nil then
  Result := ''
 else
  Result := l_F.AsString;
//#UC END# *54E194A303CE_54E1908B0336get_impl*
end;//TddFontTable.pm_GetFontNames
// start class TdestFontTable

procedure TdestFontTable.AddFont;
//#UC START# *54E197950160_54E190B601EC_var*
var
 l_F: TddFontEntry;
//#UC END# *54E197950160_54E190B601EC_var*
begin
//#UC START# *54E197950160_54E190B601EC_impl*
 l_F := TddFontEntry.Create;
 try
  f_Fonts.Add(l_F);
 finally
  FreeAndNil(l_F);
 end;
//#UC END# *54E197950160_54E190B601EC_impl*
end;//TdestFontTable.AddFont

function TdestFontTable.FontByNumber(aNumber: Integer): TddFontEntry;
//#UC START# *54E197B702C1_54E190B601EC_var*
var
 i: Integer;
//#UC END# *54E197B702C1_54E190B601EC_var*
begin
//#UC START# *54E197B702C1_54E190B601EC_impl*
 Result := nil;
 for i := 0 to Pred(Count) do
 begin
  if Items[i].Number = aNumber then
  begin
   Result:= Items[i];
   Break;
  end;
 end;
//#UC END# *54E197B702C1_54E190B601EC_impl*
end;//TdestFontTable.FontByNumber

function TdestFontTable.pm_GetCount: Integer;
//#UC START# *54E195C3012F_54E190B601ECget_var*
//#UC END# *54E195C3012F_54E190B601ECget_var*
begin
//#UC START# *54E195C3012F_54E190B601ECget_impl*
 Result := f_Fonts.Count;
//#UC END# *54E195C3012F_54E190B601ECget_impl*
end;//TdestFontTable.pm_GetCount

function TdestFontTable.pm_GetCurFont: TddFontEntry;
//#UC START# *54E198280123_54E190B601ECget_var*
//#UC END# *54E198280123_54E190B601ECget_var*
begin
//#UC START# *54E198280123_54E190B601ECget_impl*
 if (f_Fonts = nil) or (f_Fonts.Count = 0) then
  Result := nil
 else
  Result := TddFontEntry(f_Fonts.Last);
//#UC END# *54E198280123_54E190B601ECget_impl*
end;//TdestFontTable.pm_GetCurFont

function TdestFontTable.pm_GetItems(anIndex: Integer): TddFontEntry;
//#UC START# *54E19857032C_54E190B601ECget_var*
//#UC END# *54E19857032C_54E190B601ECget_var*
begin
//#UC START# *54E19857032C_54E190B601ECget_impl*
 Result := TddFontEntry(f_Fonts[anIndex]);
//#UC END# *54E19857032C_54E190B601ECget_impl*
end;//TdestFontTable.pm_GetItems

procedure TdestFontTable.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_54E190B601EC_var*
//#UC END# *5461BEC2017D_54E190B601EC_var*
begin
//#UC START# *5461BEC2017D_54E190B601EC_impl*
//#UC END# *5461BEC2017D_54E190B601EC_impl*
end;//TdestFontTable.Close

procedure TdestFontTable.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_54E190B601EC_var*
//#UC END# *54E1F08400F9_54E190B601EC_var*
begin
//#UC START# *54E1F08400F9_54E190B601EC_impl*
 case aRDS of
  rdsFontTable :
    CurFont.JoinWith(aText);
  rdsPanose :
    CurFont.Panose.JoinWith(aText);
  rdsFalt :
    CurFont.Alternate.JoinWith(aText);
   else
    Assert(False); 
 end;
//#UC END# *54E1F08400F9_54E190B601EC_impl*
end;//TdestFontTable.WriteText

procedure TdestFontTable.Cleanup;
//#UC START# *479731C50290_54E190B601EC_var*
//#UC END# *479731C50290_54E190B601EC_var*
begin
//#UC START# *479731C50290_54E190B601EC_impl*
 FreeAndNil(f_Fonts);
 inherited Cleanup;
//#UC END# *479731C50290_54E190B601EC_impl*
end;//TdestFontTable.Cleanup

procedure TdestFontTable.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_54E190B601EC_var*
var
 l_CurFont: TddFontEntry;
//#UC END# *51D27C0402E9_54E190B601EC_var*
begin
//#UC START# *51D27C0402E9_54E190B601EC_impl*
 if aText <> ';' then
 begin
  l_CurFont := CurFont;
  if (l_CurFont <> nil) then
   l_CurFont.Append(aText);
 end; // if aText <> ';' then
//#UC END# *51D27C0402E9_54E190B601EC_impl*
end;//TdestFontTable.AddAnsiChar

procedure TdestFontTable.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_54E190B601EC_var*
var
 l_CurFont: TddFontEntry;
//#UC END# *51D27C3302EC_54E190B601EC_var*
begin
//#UC START# *51D27C3302EC_54E190B601EC_impl*
 l_CurFont := CurFont;
 if l_CurFont <> nil then
  l_CurFont.JoinWith(aText);
//#UC END# *51D27C3302EC_54E190B601EC_impl*
end;//TdestFontTable.AddString

procedure TdestFontTable.ApplyProperty(propType: TPropType;
  What: TIProp;
  Value: LongInt;
  aState: TddRTFState);
//#UC START# *51D27EC50388_54E190B601EC_var*
var
 l_CurFont: TddFontEntry;
//#UC END# *51D27EC50388_54E190B601EC_var*
begin
//#UC START# *51D27EC50388_54E190B601EC_impl*
 case What of
   ipropNumber:
     begin
      AddFont;
      l_CurFont := CurFont;
      if l_CurFont <> nil then
       l_CurFont.Number := Value;
     end;{ipropNumber}
   iproPAnsiCharSet:
     begin
       l_CurFont := CurFont;
       if l_CurFont <> nil then
        l_CurFont.CharSet := Value;
     end;{ipropNumber}
   ipropFontFamily:
     begin
       l_CurFont := CurFont;
       if l_CurFont <> nil then
        l_CurFont.Family := TFontFamily(Value);
     end;
   ipropFprq :
     begin
       l_CurFont := CurFont;
       if l_CurFont <> nil then
        l_CurFont.Pitch := Value;
     end;
 end;{case What};
//#UC END# *51D27EC50388_54E190B601EC_impl*
end;//TdestFontTable.ApplyProperty

constructor TdestFontTable.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_54E190B601EC_var*
//#UC END# *51E7C9DB0213_54E190B601EC_var*
begin
//#UC START# *51E7C9DB0213_54E190B601EC_impl*
 inherited Create(aRTFReader);
 f_Fonts := TddFontTable.Create;
//#UC END# *51E7C9DB0213_54E190B601EC_impl*
end;//TdestFontTable.Create

end.