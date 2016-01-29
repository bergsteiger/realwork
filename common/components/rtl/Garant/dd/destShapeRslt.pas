unit destShapeRslt;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/destShapeRslt.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::RTFSupport::TdestShapeRslt
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  destNorm,
  ddRTFState,
  ddRTFShape,
  l3Base,
  RTFtypes
  ;

type
 TdestShapeRslt = class(TdestNorm)
 protected
 // overridden protected methods
   function CanAddTable: Boolean; override;
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure AddUnicodeChar(aText: Word;
     aState: TddRTFState); override;
   procedure ParseSymbol(Symbol: Integer;
     propType: TPropType;
     aState: TddRTFState); override;
 public
 // public methods
   procedure Apply2Shape(aState: TddRTFState;
     aShape: TddRTFShape);
 end;//TdestShapeRslt

implementation

uses
  ddPicture
  ;

// start class TdestShapeRslt

procedure TdestShapeRslt.Apply2Shape(aState: TddRTFState;
  aShape: TddRTFShape);
//#UC START# *559CC87403BA_5575752B029E_var*
//#UC END# *559CC87403BA_5575752B029E_var*
begin
//#UC START# *559CC87403BA_5575752B029E_impl*
 if GetParagraphsCount > 0 then
 begin
  aShape.AddPicture(TddPicture(Paragraph[0]), aState);
  Clear;
 end; // if (aNewDest.RDS <> aOldDest.RDS) then*)
//#UC END# *559CC87403BA_5575752B029E_impl*
end;//TdestShapeRslt.Apply2Shape

procedure TdestShapeRslt.Clear;
//#UC START# *51D27A48038E_5575752B029E_var*
//#UC END# *51D27A48038E_5575752B029E_var*
begin
//#UC START# *51D27A48038E_5575752B029E_impl*
 ParagraphsClear;
 inherited;
//#UC END# *51D27A48038E_5575752B029E_impl*
end;//TdestShapeRslt.Clear

procedure TdestShapeRslt.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_5575752B029E_var*
//#UC END# *51D27C0402E9_5575752B029E_var*
begin
//#UC START# *51D27C0402E9_5575752B029E_impl*
//#UC END# *51D27C0402E9_5575752B029E_impl*
end;//TdestShapeRslt.AddAnsiChar

procedure TdestShapeRslt.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_5575752B029E_var*
//#UC END# *51D27C3302EC_5575752B029E_var*
begin
//#UC START# *51D27C3302EC_5575752B029E_impl*
//#UC END# *51D27C3302EC_5575752B029E_impl*
end;//TdestShapeRslt.AddString

procedure TdestShapeRslt.AddUnicodeChar(aText: Word;
  aState: TddRTFState);
//#UC START# *51D27DFA0308_5575752B029E_var*
//#UC END# *51D27DFA0308_5575752B029E_var*
begin
//#UC START# *51D27DFA0308_5575752B029E_impl*
//#UC END# *51D27DFA0308_5575752B029E_impl*
end;//TdestShapeRslt.AddUnicodeChar

procedure TdestShapeRslt.ParseSymbol(Symbol: Integer;
  propType: TPropType;
  aState: TddRTFState);
//#UC START# *51E8CFEF027A_5575752B029E_var*
//#UC END# *51E8CFEF027A_5575752B029E_var*
begin
//#UC START# *51E8CFEF027A_5575752B029E_impl*
//#UC END# *51E8CFEF027A_5575752B029E_impl*
end;//TdestShapeRslt.ParseSymbol

function TdestShapeRslt.CanAddTable: Boolean;
//#UC START# *559516AA0098_5575752B029E_var*
//#UC END# *559516AA0098_5575752B029E_var*
begin
//#UC START# *559516AA0098_5575752B029E_impl*
 Result := False;
//#UC END# *559516AA0098_5575752B029E_impl*
end;//TdestShapeRslt.CanAddTable

end.