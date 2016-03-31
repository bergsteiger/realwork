unit ddCustomRTFReader;
 {* Попытка разделить TddRTFReader на две части, чтобы используемые в нем классы могли знать об нем. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddCustomRTFReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCustomRTFReader" MUID: (51E7BF4200C0)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddLowLevelRTF
 , rtfListTable
 , Graphics
 , ddRTFProperties
 , ddDocumentAtom
 , RTFtypes
 , ddPicture
;

type
 TddCustomRTFReader = {final} class(TddRTFParser)
  {* Попытка разделить TddRTFReader на две части, чтобы используемые в нем классы могли знать об нем. }
  private
   f_SkipPicture: Boolean;
    {* Флаг для пропуска картинки в процессе чтения. }
   f_EnablePictures: Boolean;
    {* Читать картинки. }
   f_ReadWMFIfExists: Boolean;
    {* Читать WMF-файлы, вместо растровых картинок (если такое возможно) }
   f_NextFootnoteNumber: Integer;
   f_MinPicWidth: Integer;
    {* Если у картники меньше ширина, то такая картинка не добавляется в документ. }
   f_MinPicHeight: Integer;
    {* Если у картники меньше высота, то такая картинка не добавляется в документ. }
   f_IdenticalRowWidths: Boolean;
    {* Делать ширину ячеек одинаковой (дополняя справа ячейками без границ). Для вставки в комментарии. }
   f_ReadURL: Boolean;
    {* Читать гиперссылки. Ссылка добавляется в поле URL. }
  protected
   procedure pm_SetMinPicWidth(aValue: Integer); virtual;
   procedure pm_SetMinPicHeight(aValue: Integer);
   procedure pm_SetIdenticalRowWidths(aValue: Boolean);
   procedure pm_SetReadURL(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function ListByID(aID: Integer;
    out aWasRestart: Boolean): TrtfList; virtual;
   function ColorByIndex(anIndex: Integer): TColor; virtual;
   function StyleByNumber(aNumber: Integer): TddStyleEntry; virtual;
   function GetFonts(anID: Integer): TddFontEntry; virtual;
   procedure BeforeClosePara(const aPara: TddDocumentAtom;
    var aNewStyle: Integer); virtual; abstract;
   function NeedSkip(aPicture: TddPicture): TRTFPictureSkip;
   procedure IncNextFootnoteNumber;
   procedure AddFooterHyperlink; virtual; abstract;
   procedure FootNoteSymbol; virtual; abstract;
  public
   property SkipPicture: Boolean
    read f_SkipPicture
    write f_SkipPicture;
    {* Флаг для пропуска картинки в процессе чтения. }
   property EnablePictures: Boolean
    read f_EnablePictures
    write f_EnablePictures;
    {* Читать картинки. }
   property ReadWMFIfExists: Boolean
    read f_ReadWMFIfExists
    write f_ReadWMFIfExists;
    {* Читать WMF-файлы, вместо растровых картинок (если такое возможно) }
   property NextFootnoteNumber: Integer
    read f_NextFootnoteNumber
    write f_NextFootnoteNumber;
   property MinPicWidth: Integer
    read f_MinPicWidth
    write pm_SetMinPicWidth;
    {* Если у картники меньше ширина, то такая картинка не добавляется в документ. }
   property MinPicHeight: Integer
    read f_MinPicHeight
    write pm_SetMinPicHeight;
    {* Если у картники меньше высота, то такая картинка не добавляется в документ. }
   property IdenticalRowWidths: Boolean
    read f_IdenticalRowWidths
    write pm_SetIdenticalRowWidths;
    {* Делать ширину ячеек одинаковой (дополняя справа ячейками без границ). Для вставки в комментарии. }
   property ReadURL: Boolean
    read f_ReadURL
    write pm_SetReadURL;
    {* Читать гиперссылки. Ссылка добавляется в поле URL. }
 end;//TddCustomRTFReader

implementation

uses
 l3ImplUses
 , ddConst
;

procedure TddCustomRTFReader.pm_SetMinPicWidth(aValue: Integer);
//#UC START# *56023F490306_51E7BF4200C0set_var*
//#UC END# *56023F490306_51E7BF4200C0set_var*
begin
//#UC START# *56023F490306_51E7BF4200C0set_impl*
 f_MinPicWidth := aValue;
//#UC END# *56023F490306_51E7BF4200C0set_impl*
end;//TddCustomRTFReader.pm_SetMinPicWidth

procedure TddCustomRTFReader.pm_SetMinPicHeight(aValue: Integer);
//#UC START# *56023F7A0028_51E7BF4200C0set_var*
//#UC END# *56023F7A0028_51E7BF4200C0set_var*
begin
//#UC START# *56023F7A0028_51E7BF4200C0set_impl*
 f_MinPicHeight := aValue;
//#UC END# *56023F7A0028_51E7BF4200C0set_impl*
end;//TddCustomRTFReader.pm_SetMinPicHeight

procedure TddCustomRTFReader.pm_SetIdenticalRowWidths(aValue: Boolean);
//#UC START# *56162C9F01E8_51E7BF4200C0set_var*
//#UC END# *56162C9F01E8_51E7BF4200C0set_var*
begin
//#UC START# *56162C9F01E8_51E7BF4200C0set_impl*
 f_IdenticalRowWidths := aValue;
//#UC END# *56162C9F01E8_51E7BF4200C0set_impl*
end;//TddCustomRTFReader.pm_SetIdenticalRowWidths

procedure TddCustomRTFReader.pm_SetReadURL(aValue: Boolean);
//#UC START# *56A86CFB0055_51E7BF4200C0set_var*
//#UC END# *56A86CFB0055_51E7BF4200C0set_var*
begin
//#UC START# *56A86CFB0055_51E7BF4200C0set_impl*
 f_ReadURL := aValue;
//#UC END# *56A86CFB0055_51E7BF4200C0set_impl*
end;//TddCustomRTFReader.pm_SetReadURL

function TddCustomRTFReader.ListByID(aID: Integer;
 out aWasRestart: Boolean): TrtfList;
//#UC START# *51E7C1E90092_51E7BF4200C0_var*
//#UC END# *51E7C1E90092_51E7BF4200C0_var*
begin
//#UC START# *51E7C1E90092_51E7BF4200C0_impl*
 aWasRestart := False;
 Result := nil;
//#UC END# *51E7C1E90092_51E7BF4200C0_impl*
end;//TddCustomRTFReader.ListByID

function TddCustomRTFReader.ColorByIndex(anIndex: Integer): TColor;
//#UC START# *51E7CF130368_51E7BF4200C0_var*
//#UC END# *51E7CF130368_51E7BF4200C0_var*
begin
//#UC START# *51E7CF130368_51E7BF4200C0_impl*
 Result := 0;
//#UC END# *51E7CF130368_51E7BF4200C0_impl*
end;//TddCustomRTFReader.ColorByIndex

function TddCustomRTFReader.StyleByNumber(aNumber: Integer): TddStyleEntry;
//#UC START# *51E7CF89008F_51E7BF4200C0_var*
//#UC END# *51E7CF89008F_51E7BF4200C0_var*
begin
//#UC START# *51E7CF89008F_51E7BF4200C0_impl*
 Result := nil;
//#UC END# *51E7CF89008F_51E7BF4200C0_impl*
end;//TddCustomRTFReader.StyleByNumber

function TddCustomRTFReader.GetFonts(anID: Integer): TddFontEntry;
//#UC START# *51E7CFC002AA_51E7BF4200C0_var*
//#UC END# *51E7CFC002AA_51E7BF4200C0_var*
begin
//#UC START# *51E7CFC002AA_51E7BF4200C0_impl*
 Result := nil;
//#UC END# *51E7CFC002AA_51E7BF4200C0_impl*
end;//TddCustomRTFReader.GetFonts

function TddCustomRTFReader.NeedSkip(aPicture: TddPicture): TRTFPictureSkip;
//#UC START# *54E32B7D034A_51E7BF4200C0_var*
var
 l_Format: Integer;
//#UC END# *54E32B7D034A_51E7BF4200C0_var*
begin
//#UC START# *54E32B7D034A_51E7BF4200C0_impl*
 l_Format := aPicture.Format;
 if not f_SkipPicture and (aPicture.Format > 0) and f_EnablePictures then
  Result := rtf_psNo
 else
  if f_EnablePictures and f_SkipPicture then
   if (l_Format = pictWMF) and f_ReadWMFIfExists then
    Result := rtf_psWMF
   else
    Result := rtf_psYes
  else
   Result := rtf_psYes;
//#UC END# *54E32B7D034A_51E7BF4200C0_impl*
end;//TddCustomRTFReader.NeedSkip

procedure TddCustomRTFReader.IncNextFootnoteNumber;
//#UC START# *55012D100317_51E7BF4200C0_var*
//#UC END# *55012D100317_51E7BF4200C0_var*
begin
//#UC START# *55012D100317_51E7BF4200C0_impl*
 Inc(f_NextFootnoteNumber);
//#UC END# *55012D100317_51E7BF4200C0_impl*
end;//TddCustomRTFReader.IncNextFootnoteNumber

procedure TddCustomRTFReader.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51E7BF4200C0_var*
//#UC END# *479731C50290_51E7BF4200C0_var*
begin
//#UC START# *479731C50290_51E7BF4200C0_impl*
 inherited;
 f_SkipPicture := False;
 f_EnablePictures := False;
 f_ReadWMFIfExists := False;
 f_IdenticalRowWidths := False;
 f_MinPicWidth := ddDefMinimumPicWidth;
 f_MinPicHeight := ddDefMinimumPicHeight;
//#UC END# *479731C50290_51E7BF4200C0_impl*
end;//TddCustomRTFReader.Cleanup

procedure TddCustomRTFReader.InitFields;
//#UC START# *47A042E100E2_51E7BF4200C0_var*
//#UC END# *47A042E100E2_51E7BF4200C0_var*
begin
//#UC START# *47A042E100E2_51E7BF4200C0_impl*
 f_SkipPicture := False;
 f_EnablePictures := False;
 f_ReadWMFIfExists := False;
 f_IdenticalRowWidths := False;
 f_MinPicWidth := ddDefMinimumPicWidth;
 f_MinPicHeight := ddDefMinimumPicHeight;
 inherited;
//#UC END# *47A042E100E2_51E7BF4200C0_impl*
end;//TddCustomRTFReader.InitFields

end.
