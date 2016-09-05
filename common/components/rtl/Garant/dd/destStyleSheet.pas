unit destStyleSheet;

// Модуль: "w:\common\components\rtl\Garant\dd\destStyleSheet.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "destStyleSheet" MUID: (54E1AE790108)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , l3StringList
 , ddRTFProperties
 , ddCustomRTFReader
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestStyleSheet = class(TddRTFDestination)
  private
   f_Styles: Tl3StringList;
  protected
   function pm_GetCount: Integer;
   function pm_GetCurStyle: TddStyleEntry;
   function pm_GetItems(anIndex: Integer): TddStyleEntry;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddStyle;
   function StyleByNumber(aNumber: Integer): TddStyleEntry;
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
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
   property Count: Integer
    read pm_GetCount;
   property CurStyle: TddStyleEntry
    read pm_GetCurStyle;
   property Items[anIndex: Integer]: TddStyleEntry
    read pm_GetItems;
    default;
 end;//TdestStyleSheet

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *54E1AE790108impl_uses*
 //#UC END# *54E1AE790108impl_uses*
;

function TdestStyleSheet.pm_GetCount: Integer;
//#UC START# *54E1B00102AB_54E1AEEC031Aget_var*
//#UC END# *54E1B00102AB_54E1AEEC031Aget_var*
begin
//#UC START# *54E1B00102AB_54E1AEEC031Aget_impl*
 Result := f_Styles.Count;
//#UC END# *54E1B00102AB_54E1AEEC031Aget_impl*
end;//TdestStyleSheet.pm_GetCount

function TdestStyleSheet.pm_GetCurStyle: TddStyleEntry;
//#UC START# *54E1B2610261_54E1AEEC031Aget_var*
//#UC END# *54E1B2610261_54E1AEEC031Aget_var*
begin
//#UC START# *54E1B2610261_54E1AEEC031Aget_impl*
 Result := TddStyleEntry(f_Styles.Last);
//#UC END# *54E1B2610261_54E1AEEC031Aget_impl*
end;//TdestStyleSheet.pm_GetCurStyle

function TdestStyleSheet.pm_GetItems(anIndex: Integer): TddStyleEntry;
//#UC START# *54E1B2770332_54E1AEEC031Aget_var*
//#UC END# *54E1B2770332_54E1AEEC031Aget_var*
begin
//#UC START# *54E1B2770332_54E1AEEC031Aget_impl*
 Result := TddStyleEntry(f_Styles[anIndex]);
//#UC END# *54E1B2770332_54E1AEEC031Aget_impl*
end;//TdestStyleSheet.pm_GetItems

procedure TdestStyleSheet.AddStyle;
//#UC START# *54E1BBAD0365_54E1AEEC031A_var*
var
 l_Style: TddStyleEntry;
//#UC END# *54E1BBAD0365_54E1AEEC031A_var*
begin
//#UC START# *54E1BBAD0365_54E1AEEC031A_impl*
 l_Style := TddStyleEntry.Create;
 try
  f_Styles.Add(l_Style);
 finally
  FreeAndNil(l_Style);
 end;
//#UC END# *54E1BBAD0365_54E1AEEC031A_impl*
end;//TdestStyleSheet.AddStyle

function TdestStyleSheet.StyleByNumber(aNumber: Integer): TddStyleEntry;
//#UC START# *54E1BBC00005_54E1AEEC031A_var*
var
 i: Integer;
//#UC END# *54E1BBC00005_54E1AEEC031A_var*
begin
//#UC START# *54E1BBC00005_54E1AEEC031A_impl*
 Result := nil;
 for i := 0 to Pred(Count) do
  if Items[i].Number = aNumber then
  begin
   Result := Items[i];
   Break;
  end;
//#UC END# *54E1BBC00005_54E1AEEC031A_impl*
end;//TdestStyleSheet.StyleByNumber

procedure TdestStyleSheet.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_54E1AEEC031A_var*
//#UC END# *5461BEC2017D_54E1AEEC031A_var*
begin
//#UC START# *5461BEC2017D_54E1AEEC031A_impl*
 if Self = aNewDest then
  CurStyle.CheckEvd;
//#UC END# *5461BEC2017D_54E1AEEC031A_impl*
end;//TdestStyleSheet.Close

procedure TdestStyleSheet.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_54E1AEEC031A_var*
//#UC END# *54E1F08400F9_54E1AEEC031A_var*
begin
//#UC START# *54E1F08400F9_54E1AEEC031A_impl*
 WriteText(aText, aState); 
//#UC END# *54E1F08400F9_54E1AEEC031A_impl*
end;//TdestStyleSheet.WriteText

procedure TdestStyleSheet.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54E1AEEC031A_var*
//#UC END# *479731C50290_54E1AEEC031A_var*
begin
//#UC START# *479731C50290_54E1AEEC031A_impl*
 FreeAndNil(f_Styles);
 inherited Cleanup;
//#UC END# *479731C50290_54E1AEEC031A_impl*
end;//TdestStyleSheet.Cleanup

procedure TdestStyleSheet.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_54E1AEEC031A_var*
//#UC END# *51D27C0402E9_54E1AEEC031A_var*
begin
//#UC START# *51D27C0402E9_54E1AEEC031A_impl*
 if (CurStyle <> nil) and (aText <> ';') then
  CurStyle.Append(aText);
//#UC END# *51D27C0402E9_54E1AEEC031A_impl*
end;//TdestStyleSheet.AddAnsiChar

procedure TdestStyleSheet.AddString(aText: Tl3String;
 aState: TddRTFState);
//#UC START# *51D27C3302EC_54E1AEEC031A_var*
//#UC END# *51D27C3302EC_54E1AEEC031A_var*
begin
//#UC START# *51D27C3302EC_54E1AEEC031A_impl*
 if CurStyle <> nil then
  CurStyle.JoinWith(aText);
//#UC END# *51D27C3302EC_54E1AEEC031A_impl*
end;//TdestStyleSheet.AddString

procedure TdestStyleSheet.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_54E1AEEC031A_var*
//#UC END# *51D27EC50388_54E1AEEC031A_var*
begin
//#UC START# *51D27EC50388_54E1AEEC031A_impl*
 with CurStyle do
 begin
   case What of
    ipropParaStyle :
      begin
        StyleDef:= sdParagraph;
        Number:= Value;
      end;
    iproPAnsiCharStyle :
      begin
        StyleDef:= sdCharacter;
        Number:= Value;
      end;
    ipropsectStyle :
      begin
        StyleDef:= sdSection;
        Number:= Value;
      end;
    ipropLang:
     CHP.Language:= Value;
    ipropkeycode : ;
    ipropkeys : ;
    ipropkey : ;
    ipropadditive : ;
    ipropbased : ;
    ipropnext : ;
    ipropautoupd : ;
    iprophidden : ;
    iproppersonal : ;
    ipropcompose : ;
    ipropreply : ;
   end; {case What}
 end; { if };
//#UC END# *51D27EC50388_54E1AEEC031A_impl*
end;//TdestStyleSheet.ApplyProperty

constructor TdestStyleSheet.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_54E1AEEC031A_var*
//#UC END# *51E7C9DB0213_54E1AEEC031A_var*
begin
//#UC START# *51E7C9DB0213_54E1AEEC031A_impl*
 inherited Create(aRTFReader);
 f_Styles := Tl3StringList.Create;
//#UC END# *51E7C9DB0213_54E1AEEC031A_impl*
end;//TdestStyleSheet.Create

end.
