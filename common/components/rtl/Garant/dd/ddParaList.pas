unit ddParaList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddParaList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddParaList" MUID: (5268FE7A0253)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddDocumentAtomList
 , ddTypes
 , ddCustomDestination
 , k2Interfaces
;

type
 TddParaList = class(TddDocumentAtom)
  private
   f_ListType: TddListType;
   f_OrderType: TddOrderType;
   f_OrderStart: Integer;
   f_Multilevel: Boolean;
  public
   f_List: TddDocumentAtomList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddList(aList: TddParaList);
   procedure AddPara;
   procedure CloseLevel;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   constructor Create(aDetination: TddCustomDestination); override;
   function GetLastPara: TddDocumentAtom; override;
  public
   property ListType: TddListType
    read f_ListType
    write f_ListType;
   property OrderType: TddOrderType
    read f_OrderType
    write f_OrderType;
   property OrderStart: Integer
    read f_OrderStart
    write f_OrderStart;
   property Multilevel: Boolean
    read f_Multilevel;
 end;//TddParaList

implementation

uses
 l3ImplUses
 , ddTextParagraph
 , l3Base
 , SysUtils
 , l3String
 //#UC START# *5268FE7A0253impl_uses*
 //#UC END# *5268FE7A0253impl_uses*
;

procedure TddParaList.AddList(aList: TddParaList);
//#UC START# *526907090237_5268FE7A0253_var*
//#UC END# *526907090237_5268FE7A0253_var*
begin
//#UC START# *526907090237_5268FE7A0253_impl*
 f_List.Add(aList);
 f_Multilevel:= True;
//#UC END# *526907090237_5268FE7A0253_impl*
end;//TddParaList.AddList

procedure TddParaList.AddPara;
//#UC START# *52690727025D_5268FE7A0253_var*
var
  l_P: TddTextParagraph;
//#UC END# *52690727025D_5268FE7A0253_var*
begin
//#UC START# *52690727025D_5268FE7A0253_impl*
  l_P:= TddTextParagraph.Create(nil);
  try
   l_P.PAP.xaFirst:= -100;
   l_P.PAP.xaLeft:= 1000;

   f_List.Add(l_P);
  finally
   FreeAndNil(l_P);
  end;
//#UC END# *52690727025D_5268FE7A0253_impl*
end;//TddParaList.AddPara

procedure TddParaList.CloseLevel;
//#UC START# *5269074203DE_5268FE7A0253_var*
//#UC END# *5269074203DE_5268FE7A0253_var*
begin
//#UC START# *5269074203DE_5268FE7A0253_impl*
  if f_MultiLevel then
    f_MultiLevel:= False;
//#UC END# *5269074203DE_5268FE7A0253_impl*
end;//TddParaList.CloseLevel

procedure TddParaList.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_5268FE7A0253_var*
var
  l_A: TddDocumentAtom;
  i: Integer;
  S: ShortString;
//#UC END# *518A504F00F5_5268FE7A0253_var*
begin
//#UC START# *518A504F00F5_5268FE7A0253_impl*
  for i:= 0 to f_List.Hi do
  begin
    l_A:= f_List[i];
    if l_A.IsTextPara then
    begin
      if ListType = ltOrdered then
      begin
        case OrderType of
          otCapitalLetters : S:= Chr(Ord('A')+i+OrderStart)+' ';
          otSmallLetters   : S:= Chr(Ord('a')+i+OrderStart)+' ';
          otLargeRoman     : ;
          otSmallRoman     : ;
          otNumbers        : S:= IntToStr(i+OrderStart+1) + ' ';
        end;
      end
      else
       S := '-  ';
      TddTextParagraph(l_A).Text.Insert(l3PCharLen(S), 0, 1);
    end;
    l_A.Write2Generator(Generator, aNeedProcessRow, LiteVersion);
  end;
//#UC END# *518A504F00F5_5268FE7A0253_impl*
end;//TddParaList.Write2Generator

procedure TddParaList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5268FE7A0253_var*
//#UC END# *479731C50290_5268FE7A0253_var*
begin
//#UC START# *479731C50290_5268FE7A0253_impl*
  FreeAndNil(f_List);
  inherited;
//#UC END# *479731C50290_5268FE7A0253_impl*
end;//TddParaList.Cleanup

constructor TddParaList.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_5268FE7A0253_var*
//#UC END# *51E91BA80051_5268FE7A0253_var*
begin
//#UC START# *51E91BA80051_5268FE7A0253_impl*
 inherited Create(aDetination);
 f_List       := TddDocumentAtomList.Make;
 f_ListType   := ltUnordered;
 f_OrderType  := otNumbers;
 f_OrderStart := 0;
 f_Multilevel := False;
//#UC END# *51E91BA80051_5268FE7A0253_impl*
end;//TddParaList.Create

function TddParaList.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_5268FE7A0253_var*
//#UC END# *5268DBC503E2_5268FE7A0253_var*
begin
//#UC START# *5268DBC503E2_5268FE7A0253_impl*
 if f_List.Count > 0 then
 begin
  if f_List.Last.IsTextPara then
   Result := f_List.Last
  else
   Result := TddParaList(f_List.Last).GetLastPara;
 end
 else
  Result := nil;    
//#UC END# *5268DBC503E2_5268FE7A0253_impl*
end;//TddParaList.GetLastPara

end.
