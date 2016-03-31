unit ddDocumentProperty;

// Модуль: "w:\common\components\rtl\Garant\dd\ddDocumentProperty.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddDocumentProperty" MUID: (51DBBE8A026A)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddPropertyObject
 , RTFtypes
 , k2Interfaces
;

const
 defPageWidth = 11906;
 defPageHeight = 16838;
 defHorisMargin = 1800;
 defVertMargin = rtfTwip;
 defCharSet = rtfAnsi;
 defTabValue = 720;
 defFontValue = 0;
 defxGutter = 0;

type
 TddDocumentProperty = class(TddPropertyObject)
  private
   f_CharSet: TrtfCharacterSet;
   f_CodePage: Integer;
   f_yaBottom: Integer;
   f_DefLang: Integer;
   f_DefTab: Integer;
   f_pgnStart: Integer;
   f_xaLeft: Integer;
   f_xaPage: Integer;
   f_xaRight: Integer;
   f_xGutter: Integer;
   f_yaPage: Integer;
   f_yaTop: Integer;
   f_Facingp: Boolean;
   f_FirstSpec: Boolean;
   f_Landscape: Boolean;
   f_DefFont: Integer;
  public
   procedure MergeWith(P: TddPropertyObject); override;
   procedure InheriteFrom(P: TddPropertyObject); override;
   procedure Write2Generator(const Generator: Ik2TagGenerator); override;
   procedure Reset; override;
   function Diff(P: TddPropertyObject;
    aForReader: Boolean): TddPropertyObject; override;
   constructor Create; override;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
   procedure Clear; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
  public
   property CharSet: TrtfCharacterSet
    read f_CharSet
    write f_CharSet;
   property CodePage: Integer
    read f_CodePage
    write f_CodePage;
   property yaBottom: Integer
    read f_yaBottom
    write f_yaBottom;
   property DefLang: Integer
    read f_DefLang
    write f_DefLang;
   property DefTab: Integer
    read f_DefTab
    write f_DefTab;
   property pgnStart: Integer
    read f_pgnStart
    write f_pgnStart;
   property xaLeft: Integer
    read f_xaLeft
    write f_xaLeft;
   property xaPage: Integer
    read f_xaPage
    write f_xaPage;
   property xaRight: Integer
    read f_xaRight
    write f_xaRight;
   property xGutter: Integer
    read f_xGutter
    write f_xGutter;
   property yaPage: Integer
    read f_yaPage
    write f_yaPage;
   property yaTop: Integer
    read f_yaTop
    write f_yaTop;
   property Facingp: Boolean
    read f_Facingp
    write f_Facingp;
   property FirstSpec: Boolean
    read f_FirstSpec
    write f_FirstSpec;
   property Landscape: Boolean
    read f_Landscape
    write f_Landscape;
   property DefFont: Integer
    read f_DefFont
    write f_DefFont;
 end;//TddDocumentProperty

implementation

uses
 l3ImplUses
 , ddRTFConst
 , l3Defaults
;

procedure TddDocumentProperty.MergeWith(P: TddPropertyObject);
//#UC START# *525E369F0158_51DBBE8A026A_var*
//#UC END# *525E369F0158_51DBBE8A026A_var*
begin
//#UC START# *525E369F0158_51DBBE8A026A_impl*
 Assert(False);
//#UC END# *525E369F0158_51DBBE8A026A_impl*
end;//TddDocumentProperty.MergeWith

procedure TddDocumentProperty.InheriteFrom(P: TddPropertyObject);
//#UC START# *525E37430345_51DBBE8A026A_var*
//#UC END# *525E37430345_51DBBE8A026A_var*
begin
//#UC START# *525E37430345_51DBBE8A026A_impl*
 Assert(False);
//#UC END# *525E37430345_51DBBE8A026A_impl*
end;//TddDocumentProperty.InheriteFrom

procedure TddDocumentProperty.Write2Generator(const Generator: Ik2TagGenerator);
//#UC START# *525E377B007E_51DBBE8A026A_var*
//#UC END# *525E377B007E_51DBBE8A026A_var*
begin
//#UC START# *525E377B007E_51DBBE8A026A_impl*
 Assert(False);
//#UC END# *525E377B007E_51DBBE8A026A_impl*
end;//TddDocumentProperty.Write2Generator

procedure TddDocumentProperty.Reset;
//#UC START# *525E478A0232_51DBBE8A026A_var*
//#UC END# *525E478A0232_51DBBE8A026A_var*
begin
//#UC START# *525E478A0232_51DBBE8A026A_impl*
 Assert(False);
//#UC END# *525E478A0232_51DBBE8A026A_impl*
end;//TddDocumentProperty.Reset

function TddDocumentProperty.Diff(P: TddPropertyObject;
 aForReader: Boolean): TddPropertyObject;
//#UC START# *525E47E10065_51DBBE8A026A_var*
//#UC END# *525E47E10065_51DBBE8A026A_var*
begin
//#UC START# *525E47E10065_51DBBE8A026A_impl*
 Result := nil;
 Assert(False);
//#UC END# *525E47E10065_51DBBE8A026A_impl*
end;//TddDocumentProperty.Diff

constructor TddDocumentProperty.Create;
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_51DBBE8A026A_var*
//#UC END# *47914F960008_51DBBE8A026A_var*
begin
//#UC START# *47914F960008_51DBBE8A026A_impl*
 inherited Create;
 Clear;
//#UC END# *47914F960008_51DBBE8A026A_impl*
end;//TddDocumentProperty.Create

procedure TddDocumentProperty.Clear;
//#UC START# *518A13330058_51DBBE8A026A_var*
//#UC END# *518A13330058_51DBBE8A026A_var*
begin
//#UC START# *518A13330058_51DBBE8A026A_impl*
 inherited;
 xaPage:= defPageWidth;
 yaPage:= defPageHeight;
 xaLeft:= defHorisMargin;
 {$IFDEF Archi}
 xaRight:= defHorisMargin; 
 {$ELSE}
 xaRight:= def_inchPaperRight;
 {$ENDIF Archi}
 yaTop:= defVertMargin;
 yaBottom:= defVertMargin;
 xGutter:= defxGutter;
 CodePage:= langRussian;
 CharSet:= defCharSet;
 DefTab:= defTabValue;
 DefFont:= defxGutter;
//#UC END# *518A13330058_51DBBE8A026A_impl*
end;//TddDocumentProperty.Clear

procedure TddDocumentProperty.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_51DBBE8A026A_var*
//#UC END# *5301DFE6002C_51DBBE8A026A_var*
begin
//#UC START# *5301DFE6002C_51DBBE8A026A_impl*
 if (anOther Is TddDocumentProperty) then
 begin
  CharSet:= TddDocumentProperty(anOther).CharSet;
  CodePage:= TddDocumentProperty(anOther).Codepage;
  DefFont:= TddDocumentProperty(anOther).DefFont;
  DefLang:=  TddDocumentProperty(anOther).defLang;
  DefTab:= TddDocumentProperty(anOther).DefTab;
  Facingp:= TddDocumentProperty(anOther).Facingp;
  FirstSpec:= TddDocumentProperty(anOther).FirstSpec;
  Landscape:= TddDocumentProperty(anOther).Landscape;
  pgnStart:= TddDocumentProperty(anOther).pgnStart;
  xaLeft:= TddDocumentProperty(anOther).xaLeft;
  xaPage:= TddDocumentProperty(anOther).xaPage;
  xaRight:= TddDocumentProperty(anOther).xaRight;
  xGutter:= TddDocumentProperty(anOther).xGutter;
  yaBottom:= TddDocumentProperty(anOther).yaBottom;
  yaPage:=  TddDocumentProperty(anOther).yaPage;
  yaTop:= TddDocumentProperty(anOther).yaTop;
 end // if (anOther Is TddDocumentProperty) then
 else
  inherited AssignFrom(anOther);
//#UC END# *5301DFE6002C_51DBBE8A026A_impl*
end;//TddDocumentProperty.AssignFrom

end.
