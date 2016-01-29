unit NOT_FINISHED_ddParaList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_ddParaList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::ddCommon::TddParaList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

uses
  ddBase,
  ddDocumentAtom,
  ddDocumentAtomList,
  ddCustomDestination,
  k2Interfaces
  ;

type
 TddParaList = class(TddDocumentAtom)
 private
 // private fields
   f_ListType : TddListType;
    {* Поле для свойства ListType}
   f_OrderType : TddOrderType;
    {* Поле для свойства OrderType}
   f_OrderStart : Integer;
    {* Поле для свойства OrderStart}
   f_Multilevel : Boolean;
    {* Поле для свойства Multilevel}
 protected
 // realized methods
   procedure Write2Generator(const Generator: Ik2TagGenerator;
     aNeedProcessRow: Boolean;
     LiteVersion: Boolean); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(anOwner: TObject;
    aDetination: TddCustomDestination); override;
   function GetLastPara: TddDocumentAtom; override;
 public
 // public fields
   f_List : TddDocumentAtomList;
 public
 // public methods
   procedure AddList(aList: TddParaList);
   procedure AddPara;
   procedure CloseLevel;
 public
 // public properties
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

// start class TddParaList

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
  l_P:= TddTextParagraph.Create(nil, nil);
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
  LiteVersion: Boolean);
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
//#UC START# *479731C50290_5268FE7A0253_var*
//#UC END# *479731C50290_5268FE7A0253_var*
begin
//#UC START# *479731C50290_5268FE7A0253_impl*
  FreeAndNil(f_List);
  inherited;
//#UC END# *479731C50290_5268FE7A0253_impl*
end;//TddParaList.Cleanup

constructor TddParaList.Create(anOwner: TObject;
  aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_5268FE7A0253_var*
//#UC END# *51E91BA80051_5268FE7A0253_var*
begin
//#UC START# *51E91BA80051_5268FE7A0253_impl*
 inherited Create(anOwner, aDetination);
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