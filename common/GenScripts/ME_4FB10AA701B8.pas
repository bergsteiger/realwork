unit ddTextParaString;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTextParaString.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Base
 , ddTextParagraph
;

type
 TddTextParaString = class(Tl3String)
  private
   f_TextPara: TddTextParagraph;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTextPara: TddTextParagraph); reintroduce;
   procedure NotifyDeletion(aPos: Integer;
    aLen: Integer); override;
 end;//TddTextParaString

implementation

uses
 l3ImplUses
 , ddTextSegment
;

constructor TddTextParaString.Create(const aTextPara: TddTextParagraph);
//#UC START# *4FB10BB001E3_4FB10AA701B8_var*
//#UC END# *4FB10BB001E3_4FB10AA701B8_var*
begin
//#UC START# *4FB10BB001E3_4FB10AA701B8_impl*
 inherited Create;
 f_TextPara := aTextPara;
//#UC END# *4FB10BB001E3_4FB10AA701B8_impl*
end;//TddTextParaString.Create

procedure TddTextParaString.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FB10AA701B8_var*
//#UC END# *479731C50290_4FB10AA701B8_var*
begin
//#UC START# *479731C50290_4FB10AA701B8_impl*
 f_TextPara := nil;
 inherited;
//#UC END# *479731C50290_4FB10AA701B8_impl*
end;//TddTextParaString.Cleanup

procedure TddTextParaString.NotifyDeletion(aPos: Integer;
 aLen: Integer);
//#UC START# *4FB10B1D016B_4FB10AA701B8_var*
var
 i         : Integer;
 l_Stop    : Integer;
 l_Start   : Integer;
 l_Segment : TddTextSegment;
//#UC END# *4FB10B1D016B_4FB10AA701B8_var*
begin
//#UC START# *4FB10B1D016B_4FB10AA701B8_impl*
 inherited;
 l_Stop := aPos + aLen;
 for i := 0 to f_TextPara.SegmentCount - 1 do
 begin
  l_Segment := f_TextPara.Segments[i];
  if l_Segment.Start >= l_Stop then
   l_Segment.Start := l_Segment.Start - aLen;
  if l_Segment.Stop >= l_Stop then
   l_Segment.Stop := l_Segment.Stop - aLen;
  if l_Segment.Start > l_Segment.Stop then
  begin
   l_Start := l_Segment.Start;
   l_Segment.Start := l_Segment.Stop;
   l_Segment.Stop := l_Start;
  end; // if l_Segment.Start > l_Segment.Stop then
 end; // for i := 0 to f_TextPara.SegmentList.Count - 1 do
//#UC END# *4FB10B1D016B_4FB10AA701B8_impl*
end;//TddTextParaString.NotifyDeletion

end.
