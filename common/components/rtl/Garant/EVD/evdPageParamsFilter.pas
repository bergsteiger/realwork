unit evdPageParamsFilter;
{* ƒобавл€ет в генератор параметры страницы. }

{ Ѕиблиотека "EVD"    }
{ Ќачал: ƒудко ƒ.¬.       }
{ ћодуль: evdPageParamsFilter - добавл€ет в "трубу" параметры страницы документа }
{ Ќачат: 20.01.2005 13:20 }
{ $Id: evdPageParamsFilter.pas,v 1.13 2013/10/21 15:43:12 lulin Exp $ }

// $Log: evdPageParamsFilter.pas,v $
// Revision 1.13  2013/10/21 15:43:12  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.12  2013/10/21 10:31:00  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.11  2013/10/18 14:11:31  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.10  2011/06/17 10:16:48  lulin
// {RequestLink:259892691}.
//
// Revision 1.9  2009/07/03 16:24:09  lulin
// - шаг к переходу от интерфейсов к объектам.
//
// Revision 1.8  2009/03/04 13:33:09  lulin
// - <K>: 137470629. √енерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.7  2009/01/29 15:53:12  lulin
// - <K>: 136254630.
//
// Revision 1.6  2008/03/28 12:14:42  lulin
// - рисуем модель в рамках <K>: 88081637.
//
// Revision 1.5  2008/01/25 10:29:21  oman
// - new: в фильтр параметров страницы подаем принтер (cq27281)
// - new: ѕровер€ем печатаемую область и бросаем исключение (cq27281)
//
// Revision 1.4  2007/08/09 18:58:46  lulin
// - не компилировалось.
//
// Revision 1.3  2007/08/09 18:05:28  lulin
// - избавл€емс€ от излишнего использовани€ интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.2  2006/09/11 12:25:28  narry
// - не передавалась высота страницы
//
// Revision 1.1  2005/06/23 13:26:05  lulin
// - фильтр параметров страницы переехал в папку EVD.
//
// Revision 1.7.8.1  2005/06/22 18:39:32  lulin
// - убраны ненужные зависимости.
//
// Revision 1.7  2005/03/31 08:47:13  lulin
// - bug fix: очередной раз отвалились параметры страницы (CQ OIT5-12977).
//
// Revision 1.6  2005/03/17 14:58:18  lulin
// - bug fix: в Preview/печати были паразитные отступы у вложенных документов (например в автореферате).
//
// Revision 1.5  2005/02/22 15:09:55  lulin
// - new behavior: кладем в документ всю информацию о параметрах страницы.
//
// Revision 1.4  2005/02/22 12:40:54  lulin
// - класс TevPageParamsFilter переведен на интерфейс IafwPageSetup.
//
// Revision 1.3  2005/02/22 12:27:39  lulin
// - рефакторинг работы с Tl3Point и Tl3Rect.
//
// Revision 1.2  2005/02/22 11:15:06  lulin
// - исправлено форматирование.
//
// Revision 1.1  2005/01/20 13:33:07  narry
// ƒобавл€ет в генератор параметры страницы
//

{$Include evdDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Units,

  k2Types,
  k2Prim,
  k2Base,
  k2TagGen,
  k2TagFilter,

  afwInterfaces
  ;

type
 TevdPageParamsFilter = class(Tk2TagFilter)
  {* ƒобавл€ет в генератор параметры страницы. }
   private
    FBottom      : Integer;
    FLeft        : Integer;
    FOrientation : Tl3PageOrientation;
    FPageHeight  : Integer;
    FPageWidth   : Integer;
    FRight       : Integer;
    FTop         : Integer;
   protected
    procedure DoStartChild(TypeID: Tk2Type);
      override;
      {-}
    procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
      override;
      {-}
   public
    class function SetTo(const aPageSetup : IafwPageSetup;
                         const aPrinter: IafwPrinter;
                         var theGenerator : Tk2TagGenerator): Tk2TagGenerator;
      reintroduce;
      {-}
    class function SetToA4(var theGenerator : Tk2TagGenerator): Tk2TagGenerator;
      {-}
    property Bottom: Integer
      read FBottom
      write FBottom;
      {-}
    property Left: Integer
      read FLeft
      write FLeft;
      {-}
    property Orientation: Tl3PageOrientation
      read FOrientation
      write FOrientation;
      {-}
    property PageHeight: Integer
      read FPageHeight
      write FPageHeight;
      {-}
    property PageWidth: Integer
      read FPageWidth
      write FPageWidth;
      {-}
    property Right: Integer
      read FRight
      write FRight;
      {-}
    property Top: Integer
      read FTop
      write FTop;
      {-}
 end;//TevdPageParamsFilter

implementation

uses
  l3Printer,
  l3MinMax,
  l3Const,
  l3Defaults,
  
  k2Interfaces,
  k2Tags,

  evDef,
  evExcept,

  Document_Const
  ;

// start class TevdPageParamsFilter

procedure TevdPageParamsFilter.DoAddAtomEx(AtomIndex: Long; const Value:
    Tk2Variant);
var
 l_TT : Tk2TypePrim;    
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  if (AtomIndex = k2_tiWidth) then
   Exit;
   // - срезаем ширину
  if ((AtomIndex = k2_tiLeftIndent) OR (AtomIndex = k2_tiRightIndent)) then
  begin
   l_TT := TopType[1];
   if (l_TT = nil) OR l_TT.IsNull then
    // - срезаем отступы - только дл€ основного документа (дл€ автореферата)
    Exit;
  end;//AtomIndex = k2_tiLeftIndent..
 end;//CurrentType.IsKindOf(k2_typDocument)
 if (Generator <> nil) then
  Generator.AddAtomEx(AtomIndex, Value);
end;

procedure TevdPageParamsFilter.DoStartChild(TypeID: Tk2Type);

  function MangleCoord(aValue : Integer): Integer;
  begin
   Result := (aValue div 100) * 100;
  end;

var
 l_Width,
 l_Height : Integer;
 l_TT     : Tk2TypePrim;
begin
 inherited;
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  l_TT := TopType[1];
  if (l_TT = nil) OR l_TT.IsNull then
  // - учитываем, что это не вложенный документ (дл€ автореферата)
   if (Generator <> nil) then
   begin
    { ѕередаютс€ только Ўирина, Ћевый и ѕравый отступы. ƒл€ јльбомной ориентации
      вместо ширины передаетс€ высота }
    if FOrientation = l3_poLandscape then
    begin
     l_Width := FPageHeight;
     l_Height:= FPageWidth;
    end
    else
    begin
     l_Width := FPageWidth;
     l_Height:= FPageHeight;
    end;
    Generator.AddIntegerAtom(k2_tiWidth, MangleCoord(l_Width));
    Generator.AddIntegerAtom(k2_tiHeight, MangleCoord(l_Height));
    Generator.AddIntegerAtom(k2_tiLeftIndent, MangleCoord(FLeft));
    Generator.AddIntegerAtom(k2_tiRightIndent, MangleCoord(FRight));
    Generator.StartTag(k2_tiParas);
    try
     Generator.AddIntegerAtom(k2_tiWidth, MangleCoord(FPageWidth));
     Generator.AddIntegerAtom(k2_tiHeight, MangleCoord(FPageHeight));
     Generator.AddIntegerAtom(k2_tiLeftIndent, MangleCoord(FLeft));
     Generator.AddIntegerAtom(k2_tiRightIndent, MangleCoord(FRight));
     Generator.AddIntegerAtom(k2_tiSpaceBefore, MangleCoord(FTop));
     Generator.AddIntegerAtom(k2_tiSpaceAfter, MangleCoord(FBottom));
     Generator.AddIntegerAtom(k2_tiOrientation, Ord(FOrientation));
    finally
     Generator.Finish;
    end;//try..finally
   end;//Generator <> nil
 end;//CurrentType.IsKindOf(k2_typDocument)
end;

class function TevdPageParamsFilter.SetTo(const aPageSetup : IafwPageSetup;
                                         const aPrinter: IafwPrinter;
                                         var theGenerator : Tk2TagGenerator): Tk2TagGenerator;
var
 l_Printer: IafwPrinter;
begin
 if (aPageSetup = nil) then
  Result := theGenerator
 else
 begin
  Result := inherited SetTo(theGenerator);
  with (Result As TevdPageParamsFilter) do
  begin
   l_Printer := aPrinter;
   if l_Printer = nil then
    l_Printer := Tl3Printer.Make;
   with l_Printer.PaperExtent do
   begin
    PageWidth := X;
    PageHeight := Y;
   end;
   Left := aPageSetup.Margins.Left;
   Right := aPageSetup.Margins.Right;
   Top := aPageSetup.Margins.Top;
   Bottom := aPageSetup.Margins.Bottom;
   Orientation := aPageSetup.Orientation;

   if (Min(PageWidth, PageHeight) -
      (Top + Bottom)) <
      (def_inchMinPrintArea - l3Epsilon) then
    raise EevInvalidPrintMargins.Create(ev_warInvalidMargins);
  end; // with (Result As TevdPageParamsFilter)
 end;//aPageSetup = nil
end;

class function TevdPageParamsFilter.SetToA4(var theGenerator : Tk2TagGenerator): Tk2TagGenerator;
  {-}
begin
 Result := inherited SetTo(theGenerator);
 with (Result As TevdPageParamsFilter) do
 begin
  PageWidth := def_inchPaperWidth;
  PageHeight := def_inchPaperHeight;
  Left := def_inchPaperLeft;
  Right := def_inchPaperRight;
  Top := def_inchPaperTop;
  Bottom := def_inchPaperBottom;
  Orientation := l3_poPortrait;
  if (Min(PageWidth, PageHeight) -
     (Top + Bottom)) <
     (def_inchMinPrintArea - l3Epsilon) then
   raise EevInvalidPrintMargins.Create(ev_warInvalidMargins);
 end;//with (Result As TevdPageParamsFilter)
end;
  
end.
