unit ddNSRCSegments;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddNSRCSegments.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::NSRCReaderCore::ddNSRCSegments
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  k2Interfaces,
  l3CustomString,
  l3ProtoObject,
  segTargetList
  ;

type
 TsegSegment = class(Tl3ProtoObject)
 private
 // private fields
   f_Start : Integer;
    {* Поле для свойства Start}
 public
 // public properties
   property Start: Integer
     read f_Start
     write f_Start;
 end;//TsegSegment

 TsegTextSegment = class(TsegSegment)
 private
 // private fields
   f_Finish : Integer;
    {* Поле для свойства Finish}
 public
 // public properties
   property Finish: Integer
     read f_Finish
     write f_Finish;
 end;//TsegTextSegment

 TsegDecorSegment = class(TsegTextSegment)
 private
 // private fields
   f_Decor : AnsiString;
    {* Поле для свойства Decor}
 public
 // public properties
   property Decor: AnsiString
     read f_Decor
     write f_Decor;
 end;//TsegDecorSegment

 TddNSRCStackItem = class(Tl3ProtoObject)
 private
 // private fields
   f_ColorSelection : Boolean;
    {* Поле для свойства ColorSelection}
   f_HLContinue : Boolean;
    {* Поле для свойства HLContinue}
   f_Comment : Boolean;
    {* Поле для свойства Comment}
   f_Hidden : Boolean;
    {* Поле для свойства Hidden}
   f_OutOfDate : Boolean;
    {* Поле для свойства OutOfDate}
   f_NotApplied : Boolean;
    {* Поле для свойства NotApplied}
   f_WithText : Boolean;
    {* Поле для свойства WithText}
   f_Start : Integer;
    {* Поле для свойства Start}
   f_Decor : AnsiString;
    {* Поле для свойства Decor}
 public
 // public methods
   constructor Create(aDecor: TsegDecorSegment); reintroduce;
   function IsOn(Ch: AnsiChar): Boolean;
 public
 // public properties
   property ColorSelection: Boolean
     read f_ColorSelection
     write f_ColorSelection;
   property HLContinue: Boolean
     read f_HLContinue
     write f_HLContinue;
   property Comment: Boolean
     read f_Comment
     write f_Comment;
   property Hidden: Boolean
     read f_Hidden
     write f_Hidden;
   property OutOfDate: Boolean
     read f_OutOfDate
     write f_OutOfDate;
   property NotApplied: Boolean
     read f_NotApplied
     write f_NotApplied;
   property WithText: Boolean
     read f_WithText
     write f_WithText;
   property Start: Integer
     read f_Start
     write f_Start;
   property Decor: AnsiString
     read f_Decor
     write f_Decor;
 end;//TddNSRCStackItem

 TsegSeg = class(TsegDecorSegment)
 private
 // private fields
   f_ColorSelection : Boolean;
    {* Поле для свойства ColorSelection}
   f_HLContinue : Boolean;
    {* Поле для свойства HLContinue}
   f_Comment : Boolean;
    {* Поле для свойства Comment}
   f_Hidden : Boolean;
    {* Поле для свойства Hidden}
   f_OutOfDate : Boolean;
    {* Поле для свойства OutOfDate}
   f_NotApplied : Boolean;
    {* Поле для свойства NotApplied}
 private
 // private methods
   procedure GetFromStackItem(StackItem: TddNSRCStackItem);
 public
 // public methods
   constructor Create(aDecor: TsegDecorSegment;
     anItem: TddNSRCStackItem;
     aFinish: Integer); reintroduce;
   procedure SaveToGenerator(aText: Tl3CustomString;
     const aGenerator: Ik2TagGenerator);
 public
 // public properties
   property ColorSelection: Boolean
     read f_ColorSelection
     write f_ColorSelection;
   property HLContinue: Boolean
     read f_HLContinue
     write f_HLContinue;
   property Comment: Boolean
     read f_Comment
     write f_Comment;
   property Hidden: Boolean
     read f_Hidden
     write f_Hidden;
   property OutOfDate: Boolean
     read f_OutOfDate
     write f_OutOfDate;
   property NotApplied: Boolean
     read f_NotApplied
     write f_NotApplied;
 end;//TsegSeg

 TsegHyperLink = class(TsegTextSegment)
 private
 // private fields
   f_Targets : TsegTargetList;
    {* Поле для свойства Targets}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   procedure Add(aDocID: Integer;
     aSubID: Integer);
 public
 // public properties
   property Targets: TsegTargetList
     read f_Targets;
 end;//TsegHyperLink

 TsegObject = class(TsegSegment)
 end;//TsegObject

 TsegPicture = class(TsegObject)
 private
 // private fields
   f_BaseLineOffset : Integer;
    {* Поле для свойства BaseLineOffset}
   f_DocID : Integer;
    {* Поле для свойства DocID}
   f_DPI : Integer;
    {* Поле для свойства DPI}
   f_Height : Integer;
    {* Поле для свойства Height}
   f_Width : Integer;
    {* Поле для свойства Width}
   f_FileName : AnsiString;
    {* Поле для свойства FileName}
 public
 // public properties
   property BaseLineOffset: Integer
     read f_BaseLineOffset
     write f_BaseLineOffset;
   property DocID: Integer
     read f_DocID
     write f_DocID;
   property DPI: Integer
     read f_DPI
     write f_DPI;
   property Height: Integer
     read f_Height
     write f_Height;
   property Width: Integer
     read f_Width
     write f_Width;
   property FileName: AnsiString
     read f_FileName
     write f_FileName;
 end;//TsegPicture

 TsegFormula = class(TsegObject)
 private
 // private fields
   f_Text : AnsiString;
    {* Поле для свойства Text}
 public
 // public properties
   property Text: AnsiString
     read f_Text
     write f_Text;
 end;//TsegFormula

implementation

uses
  evNSRCConst,
  ddSegmentScanner,
  k2Tags,
  TextSegment_Const,
  evdStyles,
  Math,
  SysUtils,
  segTarget
  ;

// start class TddNSRCStackItem

constructor TddNSRCStackItem.Create(aDecor: TsegDecorSegment);
//#UC START# *55DC6DFD00C0_55DC6B9F01BA_var*
//#UC END# *55DC6DFD00C0_55DC6B9F01BA_var*
begin
//#UC START# *55DC6DFD00C0_55DC6B9F01BA_impl*
 inherited Create;
 if (aDecor = nil) then
  Decor := ''
 else
  Decor := aDecor.Decor;
//#UC END# *55DC6DFD00C0_55DC6B9F01BA_impl*
end;//TddNSRCStackItem.Create

function TddNSRCStackItem.IsOn(Ch: AnsiChar): Boolean;
//#UC START# *55DC6E1E0111_55DC6B9F01BA_var*
//#UC END# *55DC6E1E0111_55DC6B9F01BA_var*
begin
//#UC START# *55DC6E1E0111_55DC6B9F01BA_impl*
 case Ch of
  ev_NSRCHeader:
   Result:= ColorSelection;
  ev_NSRCHyperlinkCont:
   Result:= HLContinue;
  ev_NSRCComment:
   Result:= Comment;
  ev_NSRCInvisible:
   Result:= Hidden;
  ev_NSRCOutOfDate:
   Result:= OutOfDate;
  ev_NSRCNotApplied:
   Result:= NotApplied;
  else
   Result:= False;
 end;//case Ch
//#UC END# *55DC6E1E0111_55DC6B9F01BA_impl*
end;//TddNSRCStackItem.IsOn
// start class TsegSeg

procedure TsegSeg.GetFromStackItem(StackItem: TddNSRCStackItem);
//#UC START# *55DC71A50112_55DC6BEF02A6_var*
//#UC END# *55DC71A50112_55DC6BEF02A6_var*
begin
//#UC START# *55DC71A50112_55DC6BEF02A6_impl*
 if (StackItem <> nil) then
 begin
   ColorSelection := StackItem.ColorSelection;
   HLContinue := StackItem.HLContinue;
   Comment := StackItem.Comment;
   Hidden := StackItem.Hidden;
   OutOfDate := StackItem.OutOfDate;
   NotApplied := StackItem.NotApplied;
   Decor := StackItem.Decor;
 end;//StackItem <> nil
//#UC END# *55DC71A50112_55DC6BEF02A6_impl*
end;//TsegSeg.GetFromStackItem

constructor TsegSeg.Create(aDecor: TsegDecorSegment;
  anItem: TddNSRCStackItem;
  aFinish: Integer);
//#UC START# *55DC717E0248_55DC6BEF02A6_var*
//#UC END# *55DC717E0248_55DC6BEF02A6_var*
begin
//#UC START# *55DC717E0248_55DC6BEF02A6_impl*
 inherited Create;
 if (aDecor = nil) then
  Decor := ''
 else
  Decor := aDecor.Decor;
 Start := anItem.Start;
 GetFromStackItem(anItem);
 Finish := aFinish;
//#UC END# *55DC717E0248_55DC6BEF02A6_impl*
end;//TsegSeg.Create

procedure TsegSeg.SaveToGenerator(aText: Tl3CustomString;
  const aGenerator: Ik2TagGenerator);
//#UC START# *55DC71F002A2_55DC6BEF02A6_var*
//#UC END# *55DC71F002A2_55DC6BEF02A6_var*
begin
//#UC START# *55DC71F002A2_55DC6BEF02A6_impl*
 if Self.ColorSelection or Self.HLContinue or Self.Comment or
    Self.Hidden or Self.OutOfDate or Self.NotApplied or
    (Self.Decor <> '') then
 begin
  aGenerator.StartChild(k2_typTextSegment);
  try
   Self.Finish := Min(aText.Len, Self.Finish);
   if (Self.Decor = '') then
   begin
    if Self.ColorSelection then
      aGenerator.AddIntegerAtom(k2_tiStyle, ev_saColorSelection)
    else
    if Self.HLContinue then
      aGenerator.AddIntegerAtom(k2_tiStyle, ev_saHyperLinkCont)
    else
    if Self.Comment then
      aGenerator.AddIntegerAtom(k2_tiStyle, ev_saTxtComment)
    else
    if Self.OutOfDate then
      aGenerator.AddIntegerAtom(k2_tiStyle, ev_saTxtOutOfDate)
    else
    if Self.NotApplied then
      aGenerator.AddIntegerAtom(k2_tiStyle, ev_saNotApplied);
   end;//Self.Decor = ''
   if Self.Hidden then
     aGenerator.AddBoolAtom(k2_tiVisible, False);
   TddSegmentScanner.SaveDecor(k2_typTextSegment, Self.Decor, aGenerator);
   aGenerator.AddIntegerAtom(k2_tiStart, Self.Start);
   aGenerator.AddIntegerAtom(k2_tiFinish, Self.Finish);
  finally
   aGenerator.Finish;
  end;//try..finally
 end;//Self.ColorSelection or Self.HLContinue or Self.Comment or..
//#UC END# *55DC71F002A2_55DC6BEF02A6_impl*
end;//TsegSeg.SaveToGenerator
// start class TsegHyperLink

constructor TsegHyperLink.Create;
//#UC START# *55DC7BED0112_55DC6C030388_var*
//#UC END# *55DC7BED0112_55DC6C030388_var*
begin
//#UC START# *55DC7BED0112_55DC6C030388_impl*
 inherited;
 f_Targets := TsegTargetList.Create;
 Start := -1;
 Finish := -1;
//#UC END# *55DC7BED0112_55DC6C030388_impl*
end;//TsegHyperLink.Create

procedure TsegHyperLink.Add(aDocID: Integer;
  aSubID: Integer);
//#UC START# *55DC7C020089_55DC6C030388_var*
var
 T : TsegTarget;
//#UC END# *55DC7C020089_55DC6C030388_var*
begin
//#UC START# *55DC7C020089_55DC6C030388_impl*
 T := TsegTarget.Create(aDocID, aSubID);
 try
  Targets.Add(T);
 finally
  FreeAndNil(T);
 end;//try..finally
//#UC END# *55DC7C020089_55DC6C030388_impl*
end;//TsegHyperLink.Add

procedure TsegHyperLink.Cleanup;
//#UC START# *479731C50290_55DC6C030388_var*
//#UC END# *479731C50290_55DC6C030388_var*
begin
//#UC START# *479731C50290_55DC6C030388_impl*
 FreeAndNil(f_Targets);
 inherited;
//#UC END# *479731C50290_55DC6C030388_impl*
end;//TsegHyperLink.Cleanup
end.