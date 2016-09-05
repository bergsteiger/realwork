unit destWord6Number;
 {* Текст нумерации в стиле Word 6/95 }

// Модуль: "w:\common\components\rtl\Garant\dd\destWord6Number.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestWord6Number" MUID: (51DD081A0082)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestWord6Number = class(TddRTFDestination)
  {* Текст нумерации в стиле Word 6/95 }
  private
   f_ItemText: AnsiString;
  protected
   procedure ClearFields; override;
  public
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
    aState: TddRTFState); override;
  public
   property ItemText: AnsiString
    read f_ItemText
    write f_ItemText;
 end;//TdestWord6Number

implementation

uses
 l3ImplUses
 , destNorm
 //#UC START# *51DD081A0082impl_uses*
 //#UC END# *51DD081A0082impl_uses*
;

procedure TdestWord6Number.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51DD081A0082_var*
//#UC END# *5461BEC2017D_51DD081A0082_var*
begin
//#UC START# *5461BEC2017D_51DD081A0082_impl*
 if aNewDest is TdestNorm then
  (aNewDest as TdestNorm).WriteOldStyleItemText(aState, ItemText);
 Clear;
//#UC END# *5461BEC2017D_51DD081A0082_impl*
end;//TdestWord6Number.Close

procedure TdestWord6Number.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_51DD081A0082_var*
//#UC END# *54E1F08400F9_51DD081A0082_var*
begin
//#UC START# *54E1F08400F9_51DD081A0082_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51DD081A0082_impl*
end;//TdestWord6Number.WriteText

procedure TdestWord6Number.Clear;
//#UC START# *51D27A48038E_51DD081A0082_var*
//#UC END# *51D27A48038E_51DD081A0082_var*
begin
//#UC START# *51D27A48038E_51DD081A0082_impl*
 f_Itemtext := '';
//#UC END# *51D27A48038E_51DD081A0082_impl*
end;//TdestWord6Number.Clear

procedure TdestWord6Number.AddAnsiChar(aText: AnsiChar;
 aState: TddRTFState);
//#UC START# *51D27C0402E9_51DD081A0082_var*
//#UC END# *51D27C0402E9_51DD081A0082_var*
begin
//#UC START# *51D27C0402E9_51DD081A0082_impl*
 f_ItemText := f_Itemtext + aText;
//#UC END# *51D27C0402E9_51DD081A0082_impl*
end;//TdestWord6Number.AddAnsiChar

procedure TdestWord6Number.ClearFields;
begin
 ItemText := '';
 inherited;
end;//TdestWord6Number.ClearFields

end.
