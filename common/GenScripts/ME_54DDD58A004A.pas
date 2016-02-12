unit destColorTable;

// Модуль: "w:\common\components\rtl\Garant\dd\destColorTable.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , ddRTFdestination
 , Graphics
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TddColorEntry = class(Tl3ProtoObject)
  private
   f_Blue: Byte;
    {* Поле для свойства Blue }
   f_Green: Byte;
    {* Поле для свойства Green }
   f_Red: Byte;
    {* Поле для свойства Red }
  protected
   function pm_GetColor: LongInt;
  public
   property Blue: Byte
    read f_Blue
    write f_Blue;
   property Green: Byte
    read f_Green
    write f_Green;
   property Red: Byte
    read f_Red
    write f_Red;
   property Color: LongInt
    read pm_GetColor;
 end;//TddColorEntry

 _ItemType_ = TddColorEntry;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddColorEntryList = class(_l3UncomparabeObjectRefList_)
 end;//TddColorEntryList

 TdestColorTable = class(TddRTFDestination)
  private
   f_Colors: TddColorEntryList;
   f_ColorEntry: TddColorEntry;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function ColorByIndex(aColorIndex: Integer): TColor;
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
    aState: TddRTFState); override;
   procedure ApplyProperty(propType: TPropType;
    What: TIProp;
    Value: LongInt;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
 end;//TdestColorTable

implementation

uses
 l3ImplUses
 , Windows
 , ddTypes
 , Math
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TddColorEntry.pm_GetColor: LongInt;
//#UC START# *54DDD6F2017F_54DDD5B90290get_var*
//#UC END# *54DDD6F2017F_54DDD5B90290get_var*
begin
//#UC START# *54DDD6F2017F_54DDD5B90290get_impl*
 Result:= RGB(RED, Green, Blue);
//#UC END# *54DDD6F2017F_54DDD5B90290get_impl*
end;//TddColorEntry.pm_GetColor

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_54DDD74E01E5_var*
//#UC END# *47B2C42A0163_54DDD74E01E5_var*
begin
//#UC START# *47B2C42A0163_54DDD74E01E5_impl*
 Assert(False);
//#UC END# *47B2C42A0163_54DDD74E01E5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_54DDD74E01E5_var*
//#UC END# *47B99D4503A2_54DDD74E01E5_var*
begin
//#UC START# *47B99D4503A2_54DDD74E01E5_impl*
 Result := 0;
 Assert(False);
//#UC END# *47B99D4503A2_54DDD74E01E5_impl*
end;//CompareExistingItems

type _Instance_R_ = TddColorEntryList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

function TdestColorTable.ColorByIndex(aColorIndex: Integer): TColor;
//#UC START# *54DDD8790277_54DDD793020C_var*
//#UC END# *54DDD8790277_54DDD793020C_var*
begin
//#UC START# *54DDD8790277_54DDD793020C_impl*
 Result := propUndefined;
 if InRange(aColorIndex, 0, f_Colors.Count - 1) then
  Result := f_Colors[aColorIndex].Color;
//#UC END# *54DDD8790277_54DDD793020C_impl*
end;//TdestColorTable.ColorByIndex

procedure TdestColorTable.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_54DDD793020C_var*
//#UC END# *5461BEC2017D_54DDD793020C_var*
begin
//#UC START# *5461BEC2017D_54DDD793020C_impl*
//#UC END# *5461BEC2017D_54DDD793020C_impl*
end;//TdestColorTable.Close

procedure TdestColorTable.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_54DDD793020C_var*
//#UC END# *54E1F08400F9_54DDD793020C_var*
begin
//#UC START# *54E1F08400F9_54DDD793020C_impl*
 WriteText(aText, aState);
//#UC END# *54E1F08400F9_54DDD793020C_impl*
end;//TdestColorTable.WriteText

procedure TdestColorTable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54DDD793020C_var*
//#UC END# *479731C50290_54DDD793020C_var*
begin
//#UC START# *479731C50290_54DDD793020C_impl*
 FreeAndNil(f_Colors);
 FreeAndNil(f_ColorEntry);
 inherited;
//#UC END# *479731C50290_54DDD793020C_impl*
end;//TdestColorTable.Cleanup

procedure TdestColorTable.Clear;
//#UC START# *51D27A48038E_54DDD793020C_var*
//#UC END# *51D27A48038E_54DDD793020C_var*
begin
//#UC START# *51D27A48038E_54DDD793020C_impl*
 f_Colors.Clear;
//#UC END# *51D27A48038E_54DDD793020C_impl*
end;//TdestColorTable.Clear

procedure TdestColorTable.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_54DDD793020C_var*
//#UC END# *51D27C0402E9_54DDD793020C_var*
begin
//#UC START# *51D27C0402E9_54DDD793020C_impl*
 if f_ColorEntry <> nil then
 begin
  f_Colors.Add(f_ColorEntry);
  FreeAndNil(f_ColorEntry);
 end; // f_ColorEntry <> nil
//#UC END# *51D27C0402E9_54DDD793020C_impl*
end;//TdestColorTable.AddAnsiChar

procedure TdestColorTable.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_54DDD793020C_var*
//#UC END# *51D27EC50388_54DDD793020C_var*
begin
//#UC START# *51D27EC50388_54DDD793020C_impl*
 if f_ColorEntry = nil then
  f_ColorEntry := TddColorEntry.Create;
 case What of
  ipropRed: f_ColorEntry.Red := Value;
  ipropGreen: f_ColorEntry.Green := Value;
  ipropBlue: f_ColorEntry.Blue := Value;
 end;
//#UC END# *51D27EC50388_54DDD793020C_impl*
end;//TdestColorTable.ApplyProperty

constructor TdestColorTable.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_54DDD793020C_var*
//#UC END# *51E7C9DB0213_54DDD793020C_var*
begin
//#UC START# *51E7C9DB0213_54DDD793020C_impl*
 inherited Create(aRTFReader);
 f_Colors := TddColorEntryList.Create; 
//#UC END# *51E7C9DB0213_54DDD793020C_impl*
end;//TdestColorTable.Create

end.
