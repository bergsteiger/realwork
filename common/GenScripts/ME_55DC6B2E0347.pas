unit ddNSRCSegments;

// Модуль: "w:\common\components\rtl\Garant\dd\ddNSRCSegments.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddNSRCSegments" MUID: (55DC6B2E0347)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3CustomString
 , k2Interfaces
 , segTargetList
;

type
 TsegSegment = class(Tl3ProtoObject)
  private
   f_Start: Integer;
  public
   property Start: Integer
    read f_Start
    write f_Start;
 end;//TsegSegment

 TsegTextSegment = class(TsegSegment)
  private
   f_Finish: Integer;
  public
   property Finish: Integer
    read f_Finish
    write f_Finish;
 end;//TsegTextSegment

 TsegDecorSegment = class(TsegTextSegment)
  private
   f_Decor: AnsiString;
  protected
   procedure ClearFields; override;
  public
   property Decor: AnsiString
    read f_Decor
    write f_Decor;
 end;//TsegDecorSegment

 TddNSRCStackItem = class(Tl3ProtoObject)
  private
   f_ColorSelection: Boolean;
   f_HLContinue: Boolean;
   f_Comment: Boolean;
   f_Hidden: Boolean;
   f_OutOfDate: Boolean;
   f_NotApplied: Boolean;
   f_WithText: Boolean;
   f_Start: Integer;
   f_Decor: AnsiString;
  protected
   procedure ClearFields; override;
  public
   constructor Create(aDecor: TsegDecorSegment); reintroduce;
   function IsOn(Ch: AnsiChar): Boolean;
  public
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
   f_ColorSelection: Boolean;
   f_HLContinue: Boolean;
   f_Comment: Boolean;
   f_Hidden: Boolean;
   f_OutOfDate: Boolean;
   f_NotApplied: Boolean;
  private
   procedure GetFromStackItem(StackItem: TddNSRCStackItem);
  public
   constructor Create(aDecor: TsegDecorSegment;
    anItem: TddNSRCStackItem;
    aFinish: Integer); reintroduce;
   procedure SaveToGenerator(aText: Tl3CustomString;
    const aGenerator: Ik2TagGenerator);
  public
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
   f_Targets: TsegTargetList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   procedure Add(aDocID: Integer;
    aSubID: Integer);
  public
   property Targets: TsegTargetList
    read f_Targets;
 end;//TsegHyperLink

 TsegObject = class(TsegSegment)
 end;//TsegObject

 TsegPicture = class(TsegObject)
  private
   f_BaseLineOffset: Integer;
   f_DocID: Integer;
   f_DPI: Integer;
   f_Height: Integer;
   f_Width: Integer;
   f_FileName: AnsiString;
  protected
   procedure ClearFields; override;
  public
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
   f_Text: AnsiString;
  protected
   procedure ClearFields; override;
  public
   property Text: AnsiString
    read f_Text
    write f_Text;
 end;//TsegFormula

implementation

uses
 l3ImplUses
 , ddSegmentScanner
 , evNSRCConst
 , k2Tags
 , TextSegment_Const
 , evdStyles
 , Math
 , SysUtils
 , segTarget
;

procedure TsegDecorSegment.ClearFields;
begin
 Decor := '';
 inherited;
end;//TsegDecorSegment.ClearFields

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

procedure TddNSRCStackItem.ClearFields;
begin
 Decor := '';
 inherited;
end;//TddNSRCStackItem.ClearFields

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55DC6C030388_var*
//#UC END# *479731C50290_55DC6C030388_var*
begin
//#UC START# *479731C50290_55DC6C030388_impl*
 FreeAndNil(f_Targets);
 inherited;
//#UC END# *479731C50290_55DC6C030388_impl*
end;//TsegHyperLink.Cleanup

procedure TsegPicture.ClearFields;
begin
 FileName := '';
 inherited;
end;//TsegPicture.ClearFields

procedure TsegFormula.ClearFields;
begin
 Text := '';
 inherited;
end;//TsegFormula.ClearFields

end.
