unit evSectionImplementation;
{* Реализация интерфейса IevSection. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evSectionImplementation - }
{ Начат: 09.10.2000 12:39 }
{ $Id: evSectionImplementation.pas,v 1.35 2015/01/19 17:26:12 lulin Exp $ }

// $Log: evSectionImplementation.pas,v $
// Revision 1.35  2015/01/19 17:26:12  lulin
// {RequestLink:580710025}
//
// Revision 1.34  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.33  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.32  2009/06/25 12:57:30  lulin
// - вычищаем ненужный контекст.
//
// Revision 1.31  2009/06/01 16:07:31  lulin
// [$148574348].
//
// Revision 1.30  2009/04/06 17:51:26  lulin
// [$140837386]. №11.
//
// Revision 1.29  2009/02/24 15:37:48  lulin
// - <K>: 124453087.
//
// Revision 1.28  2008/06/16 13:55:03  lulin
// - рисуем схему EVD на модели.
//
// Revision 1.27  2008/05/08 16:10:55  lulin
// - изменения в рамках <K>: 90442475.
//
// Revision 1.26  2008/05/07 18:29:48  lulin
// - изменения в рамках <K>: 90441963.
//
// Revision 1.25  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.20.4.15  2007/09/14 13:26:06  lulin
// - объединил с веткой B_Tag_Clean.
//
// Revision 1.20.4.14.2.1  2007/09/12 15:23:01  lulin
// - избавляемся от метода, дублирующего функциональность получения атрибута.
//
// Revision 1.20.4.14  2007/09/06 09:37:37  lulin
// - переименовано свойство.
//
// Revision 1.20.4.13  2007/07/19 06:18:09  oman
// - fix: выпрямляем зависимости. Схема документа, теперь не зависит от Эвереста.
// (Не собиралась библиотека)
//
// Revision 1.20.4.12  2007/07/04 13:39:56  dinishev
// обновляемся после изменения раздела.
//
// Revision 1.20.4.11  2007/07/04 05:59:15  lulin
// - ориентация страницы переехала в более общий модуль.
//
// Revision 1.20.4.10  2007/01/05 14:37:19  lulin
// - cleanup.
//
// Revision 1.20.4.9  2006/08/02 10:51:53  lulin
// - объединил с веткой в которой боролся со скроллингом.
//
// Revision 1.20.4.8.14.2  2006/07/28 13:38:31  lulin
// - убрана операция переформатирования параграфа целиком.
//
// Revision 1.20.4.8.14.1  2006/07/24 17:57:51  lulin
// - имя метода убрано из комментариев - чтобы не находилось контекстным поиском.
//
// Revision 1.20.4.8  2005/12/26 13:26:48  lulin
// - bug fix: не всегда отображалось изменение комментариев (CQ OIT5-18865).
//
// Revision 1.20.4.7  2005/11/09 15:28:24  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.20.4.6  2005/11/08 10:11:05  lulin
// - метод переформатирования целиком перенесен на базовую форму.
//
// Revision 1.20.4.5  2005/11/08 06:39:37  lulin
// - с текстового параграфа и списка параграфов вычищены ненужные методы получения сложной формы параграфа.
//
// Revision 1.20.4.4  2005/11/07 15:12:21  lulin
// - на сложной форме появился метод переформатирования всей формы.
//
// Revision 1.20.4.3  2005/11/07 14:08:32  lulin
// - от безликих тегов переходим к параграфам.
//
// Revision 1.20.4.2  2005/05/24 14:50:01  lulin
// - готовим модуль evGraph к переезду в L3.
//
// Revision 1.20.4.1  2005/05/18 12:42:47  lulin
// - отвел новую ветку.
//
// Revision 1.18.2.2  2005/05/18 12:32:09  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.18.2.1  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.19.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.19.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.19  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.20  2005/04/28 15:03:38  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.19.2.2  2005/04/23 16:07:25  lulin
// - удален временный интерфейс Ik2TagBox.
//
// Revision 1.19.2.1  2005/04/21 14:46:55  lulin
// - избавляемся от обертки над тегами - теперь объекты посредством шаблонов сами реализуют интерфейс _Ik2Tag.
//
// Revision 1.19  2005/04/21 05:11:38  lulin
// - используем _Box (пока из-за постоянных преобразований туда и обратно - по скорости стало только хуже).
//
// Revision 1.18  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.17  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.16  2005/03/19 16:39:51  lulin
// - спрятаны ненужные методы.
//
// Revision 1.15  2005/03/16 17:04:21  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.14  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.13  2004/10/18 16:18:56  lulin
// - remove unit: evTagTools.
//
// Revision 1.12  2004/10/18 16:05:11  lulin
// - remove method: TevTag._UnformatAll.
// - new proc: evUnformatAllPara.
//
// Revision 1.11  2003/04/15 13:26:43  law
// - new unit: evUnits.
//
// Revision 1.10  2003/02/06 10:23:48  law
// - cleanup: используем код операции по умолчанию.
//
// Revision 1.9  2002/07/09 13:57:39  law
// - new unit: evMsgCode.
//
// Revision 1.8  2002/07/09 12:02:21  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.7  2001/07/16 08:43:35  law
// - comments: xHelpGen.
//
// Revision 1.6  2001/07/12 14:27:42  law
// - bug fix: не выставлялся признак Modified при изменении параметров секции (см. задачау №678).
//
// Revision 1.5  2001/04/20 14:03:52  law
// - cleanup: def_cm* => def_inch*, evCm2Pixel -> evCm2Inch.
//
// Revision 1.4  2001/04/16 11:44:41  law
// - new props: к параметрам раздела добавлена высота и ширина бумаги (A0..A5).
//
// Revision 1.3  2001/03/28 15:24:59  law
// - bug fix: сделан учет объединенных ячеек при удалении строки таблицы.
//
// Revision 1.2  2000/12/15 15:10:37  law
// - вставлены директивы Log.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Interfaces,

  k2Interfaces,
  k2Tags,
  k2ProcessorTagTool,

  evdTypes,
  evdDOM,

  evTypes,
  evInternalInterfaces
  ;

type
  TevSection = class(Tk2ProcessorTagTool, IevdSection)
   {* Реализация интерфейса IevdSection. }
    protected
    // property methods
      function  pm_GetPaperSize: TevdPaperSize;
      procedure pm_SetPaperSize(Value: TevdPaperSize);
        {-}
      function  pm_GetOrientation: TevPageOrientation;
      procedure pm_SetOrientation(Value: TevPageOrientation);
        {-}
  end;//TevSection

implementation

uses
  l3UnitsTools,
  
  evMsgCode,
  evSectionPara,
  evParaTools,

  nevTools
  ;

// start class TevSection  

function TevSection.pm_GetPaperSize: TevdPaperSize;
  {-}
begin
 Result := evGetPaperSize(TagInst.Attr[k2_tiParas]);
end;

procedure TevSection.pm_SetPaperSize(Value: TevdPaperSize);
  {-}
var
 l_Pack : InevOp;
begin
 l_Pack := Processor.StartOp;
 try
  with TagInst do
  begin
   if Value in [Low(evPageSizes) .. High(evPageSizes)] then 
   begin
    with cAtom(k2_tiParas) do 
    begin
     with evPageSizes[Value] do 
     begin
      IntW[k2_tiWidth, l_Pack] := l3Cm2Inch(X);
      IntW[k2_tiHeight, l_Pack] := l3Cm2Inch(Y);
     end;//with evPageSizes[
    end;//with cAtom(k2_tiParas)
   end;//Value in ..
  end;{with TagInst}
 finally
  l_Pack := nil;
 end;{try..finally}
end;

function TevSection.pm_GetOrientation: TevPageOrientation;
  {-}
begin
 with TagInst.Attr[k2_tiParas] do
  if IsValid then
   Result := TevPageOrientation(IntA[k2_tiOrientation])
  else
   Result := ev_poPortrait; 
end;

procedure TevSection.pm_SetOrientation(Value: TevPageOrientation);
  {-}
var
 l_Pack : InevOp;
begin
 l_Pack := Processor.StartOp;
 try
  TagInst.cAtom(k2_tiParas, l_Pack).IntW[k2_tiOrientation, l_Pack] := Ord(Value);
 finally
  l_Pack := nil;
 end;{try..finally}
end;

end.

