unit ddTextSegmentQueue;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/ddTextSegmentQueue.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::Writers::TddTextSegmentQueue
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  ddTextSegment,
  ddTextSegmentsList
  ;

type
 TddTextSegmentQueue = class(TddTextSegmentsList)
 private
 // private fields
   f_HyperlinkIndex : Integer;
   f_BraceCount : Integer;
    {* Поле для свойства BraceCount}
 private
 // private methods
   procedure ClearHyperlinkID(const aSeg: TddTextSegment);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // overridden public methods
   procedure Clear; override;
 public
 // public methods
   function Pop: TddTextSegment;
   procedure Push(const aTextSegment: TddTextSegment);
   procedure IncBraceCount(aValue: Integer);
   procedure DecBraceCount(aValue: Integer);
   function PopLast: TddTextSegment;
   function GetHyperlink: TddTextSegment;
   procedure MoveHyperlinkToBottom;
     {* Переместить гиперссылку в конец очереди. }
 public
 // public properties
   property BraceCount: Integer
     read f_BraceCount;
 end;//TddTextSegmentQueue

implementation

uses
  ddHyperlink
  ;

// start class TddTextSegmentQueue

procedure TddTextSegmentQueue.ClearHyperlinkID(const aSeg: TddTextSegment);
//#UC START# *52DE1ECE0311_52DCDDEE0371_var*
//#UC END# *52DE1ECE0311_52DCDDEE0371_var*
begin
//#UC START# *52DE1ECE0311_52DCDDEE0371_impl*
 if (aSeg <> nil) and aSeg.IsHyperlink then
  f_HyperlinkIndex := -1;
//#UC END# *52DE1ECE0311_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.ClearHyperlinkID

function TddTextSegmentQueue.Pop: TddTextSegment;
//#UC START# *52DCDE4E003E_52DCDDEE0371_var*
//#UC END# *52DCDE4E003E_52DCDDEE0371_var*
begin
//#UC START# *52DCDE4E003E_52DCDDEE0371_impl*
 Result := First;
 ClearHyperlinkID(Result);
 Delete(0);
 if f_HyperlinkIndex > -1 then
  Dec(f_HyperlinkIndex);
//#UC END# *52DCDE4E003E_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.Pop

procedure TddTextSegmentQueue.Push(const aTextSegment: TddTextSegment);
//#UC START# *52DCDE6801A9_52DCDDEE0371_var*
var
 l_Index: Integer;
//#UC END# *52DCDE6801A9_52DCDDEE0371_var*
begin
//#UC START# *52DCDE6801A9_52DCDDEE0371_impl*
 if aTextSegment <> nil then
 begin
  l_Index := Add(aTextSegment);
  if aTextSegment.IsHyperlink then
   f_HyperlinkIndex := l_Index;
 end; // if aTextSegment <> nil then
//#UC END# *52DCDE6801A9_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.Push

procedure TddTextSegmentQueue.IncBraceCount(aValue: Integer);
//#UC START# *52DCDEEE0039_52DCDDEE0371_var*
//#UC END# *52DCDEEE0039_52DCDDEE0371_var*
begin
//#UC START# *52DCDEEE0039_52DCDDEE0371_impl*
 Inc(f_BraceCount, aValue);
//#UC END# *52DCDEEE0039_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.IncBraceCount

procedure TddTextSegmentQueue.DecBraceCount(aValue: Integer);
//#UC START# *52DCDF030006_52DCDDEE0371_var*
//#UC END# *52DCDF030006_52DCDDEE0371_var*
begin
//#UC START# *52DCDF030006_52DCDDEE0371_impl*
 Dec(f_BraceCount, aValue);
//#UC END# *52DCDF030006_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.DecBraceCount

function TddTextSegmentQueue.PopLast: TddTextSegment;
//#UC START# *52DD04AD0004_52DCDDEE0371_var*
//#UC END# *52DD04AD0004_52DCDDEE0371_var*
begin
//#UC START# *52DD04AD0004_52DCDDEE0371_impl*
 Result := Last;
 ClearHyperlinkID(Result);
 Self.DeleteLast;
//#UC END# *52DD04AD0004_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.PopLast

function TddTextSegmentQueue.GetHyperlink: TddTextSegment;
//#UC START# *52DE04E903A9_52DCDDEE0371_var*
//#UC END# *52DE04E903A9_52DCDDEE0371_var*
begin
//#UC START# *52DE04E903A9_52DCDDEE0371_impl*
 if f_HyperlinkIndex = -1 then
  Result := nil
 else
  Result := Items[f_HyperlinkIndex];
//#UC END# *52DE04E903A9_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.GetHyperlink

procedure TddTextSegmentQueue.MoveHyperlinkToBottom;
//#UC START# *52DE217B02CB_52DCDDEE0371_var*
//#UC END# *52DE217B02CB_52DCDDEE0371_var*
begin
//#UC START# *52DE217B02CB_52DCDDEE0371_impl*
 if f_HyperlinkIndex > -1 then
 begin
  Exchange(f_HyperlinkIndex, Count - 1);
  f_HyperlinkIndex := Count - 1;
 end; // if f_HyperlinkIndex > -1 then
//#UC END# *52DE217B02CB_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.MoveHyperlinkToBottom

procedure TddTextSegmentQueue.Cleanup;
//#UC START# *479731C50290_52DCDDEE0371_var*
//#UC END# *479731C50290_52DCDDEE0371_var*
begin
//#UC START# *479731C50290_52DCDDEE0371_impl*
 f_BraceCount := 0;
 f_HyperlinkIndex := -1;
 inherited;
//#UC END# *479731C50290_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.Cleanup

procedure TddTextSegmentQueue.InitFields;
//#UC START# *47A042E100E2_52DCDDEE0371_var*
//#UC END# *47A042E100E2_52DCDDEE0371_var*
begin
//#UC START# *47A042E100E2_52DCDDEE0371_impl*
 inherited;
 f_BraceCount := 0;
 f_HyperlinkIndex := -1;
//#UC END# *47A042E100E2_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.InitFields

procedure TddTextSegmentQueue.Clear;
//#UC START# *47B1C16D0188_52DCDDEE0371_var*
//#UC END# *47B1C16D0188_52DCDDEE0371_var*
begin
//#UC START# *47B1C16D0188_52DCDDEE0371_impl*
 inherited;
 f_BraceCount := 0;
 f_HyperlinkIndex := -1;
//#UC END# *47B1C16D0188_52DCDDEE0371_impl*
end;//TddTextSegmentQueue.Clear

end.