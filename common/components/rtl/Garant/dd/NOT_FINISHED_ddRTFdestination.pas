unit NOT_FINISHED_ddRTFdestination;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddRTFdestination.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::RTFSupport::ddRTFdestination
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

uses
  k2Interfaces,
  l3Base,
  RTFtypes,
  ddRTFState,
  ddCustomRTFReader,
  ddCustomDestination
  ;

type
 TddRTFDestination = class(TddCustomDestination)
 protected
 // realized methods
   procedure BeforeCloseParagraph(const aDocAtom: TObject); override;
 public
 // public methods
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
     aState: TddRTFState); virtual;
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); virtual; abstract;
   constructor Create(aRTFReader: TddCustomRTFReader); reintroduce; virtual;
 end;//TddRTFDestination

implementation

// start class TddRTFDestination

procedure TddRTFDestination.Clear;
//#UC START# *51D27A48038E_51D276C40106_var*
//#UC END# *51D27A48038E_51D276C40106_var*
begin
//#UC START# *51D27A48038E_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D27A48038E_51D276C40106_impl*
end;//TddRTFDestination.Clear

procedure TddRTFDestination.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_51D276C40106_var*
//#UC END# *51D27C0402E9_51D276C40106_var*
begin
//#UC START# *51D27C0402E9_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D27C0402E9_51D276C40106_impl*
end;//TddRTFDestination.AddAnsiChar

procedure TddRTFDestination.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_51D276C40106_var*
//#UC END# *51D27C3302EC_51D276C40106_var*
begin
//#UC START# *51D27C3302EC_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D27C3302EC_51D276C40106_impl*
end;//TddRTFDestination.AddString

procedure TddRTFDestination.AddUnicodeChar(aText: Word;
  aState: TddRTFState);
//#UC START# *51D27DFA0308_51D276C40106_var*
//#UC END# *51D27DFA0308_51D276C40106_var*
begin
//#UC START# *51D27DFA0308_51D276C40106_impl*
 !!! Needs to be implemented !!!
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
 !!! Needs to be implemented !!!
//#UC END# *51D27EC50388_51D276C40106_impl*
end;//TddRTFDestination.ApplyProperty

procedure TddRTFDestination.ParseSymbol(Symbol: Integer;
  propType: TPropType;
  aState: TddRTFState);
//#UC START# *51E8CFEF027A_51D276C40106_var*
//#UC END# *51E8CFEF027A_51D276C40106_var*
begin
//#UC START# *51E8CFEF027A_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E8CFEF027A_51D276C40106_impl*
end;//TddRTFDestination.ParseSymbol

procedure TddRTFDestination.Write(const aGenerator: Ik2TagGenerator);
//#UC START# *51E8D04603DF_51D276C40106_var*
//#UC END# *51E8D04603DF_51D276C40106_var*
begin
//#UC START# *51E8D04603DF_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E8D04603DF_51D276C40106_impl*
end;//TddRTFDestination.Write

procedure TddRTFDestination.WriteText(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51E8D0710060_51D276C40106_var*
//#UC END# *51E8D0710060_51D276C40106_var*
begin
//#UC START# *51E8D0710060_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E8D0710060_51D276C40106_impl*
end;//TddRTFDestination.WriteText

constructor TddRTFDestination.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51D276C40106_var*
//#UC END# *51E7C9DB0213_51D276C40106_var*
begin
//#UC START# *51E7C9DB0213_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *51E7C9DB0213_51D276C40106_impl*
end;//TddRTFDestination.Create

procedure TddRTFDestination.BeforeCloseParagraph(const aDocAtom: TObject);
//#UC START# *534F9B57003E_51D276C40106_var*
//#UC END# *534F9B57003E_51D276C40106_var*
begin
//#UC START# *534F9B57003E_51D276C40106_impl*
 !!! Needs to be implemented !!!
//#UC END# *534F9B57003E_51D276C40106_impl*
end;//TddRTFDestination.BeforeCloseParagraph

end.