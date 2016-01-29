unit evTableColumnsIterator;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evTableColumnsIterator - }
{ Начат: 29.10.2003 18:52 }
{ $Id: evTableColumnsIterator.pas,v 1.14 2015/01/19 17:26:12 lulin Exp $ }

// $Log: evTableColumnsIterator.pas,v $
// Revision 1.14  2015/01/19 17:26:12  lulin
// {RequestLink:580710025}
//
// Revision 1.13  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.12  2014/04/07 17:56:59  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.11  2009/07/23 13:42:11  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.10  2009/04/06 17:51:26  lulin
// [$140837386]. №11.
//
// Revision 1.9  2008/04/10 14:34:05  lulin
// - <K>: 89098970.
//
// Revision 1.8  2007/12/05 16:00:14  lulin
// - cleanup.
//
// Revision 1.7  2007/12/04 12:47:05  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.6.8.3  2007/11/28 15:34:52  dinishev
// Корректная работа с колонками таблицы
//
// Revision 1.6.8.2  2007/08/21 12:43:17  lulin
// - избавляемся от предупреждений компилятора.
//
// Revision 1.6.8.1  2005/11/09 15:28:25  lulin
// - базовые интерфейсы перенесены в правильный модуль.
//
// Revision 1.6  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.5  2005/03/21 16:28:16  lulin
// - переходим к _Ik2Tag.
//
// Revision 1.4  2005/03/21 06:44:53  lulin
// - убраны ненужные методы.
//
// Revision 1.3  2005/03/10 07:05:11  lulin
// - от Tk2AtomR переходим к _Ik2Tag.
//
// Revision 1.2  2004/11/04 15:22:04  lulin
// - bug fix: не компилировалась библиотека Print Engine.
//
// Revision 1.1  2003/10/29 16:50:49  law
// - new interface: IedColumnsIterator.
//

{$Include evDefine.inc }

interface

uses
  l3Interfaces,
  l3Types,
  l3Base,

  k2Interfaces,
  k2InternalInterfaces,
  k2ProcessorTagTool,

  evEditorInterfaces,

  nevTools
  ;

{$IfDef evNeedEditableCursors}
type
  TevColumnsIterator = class(Tk2ProcessorTagTool, IedColumnsIterator)
    private
    // internal fields
      f_Index      : Long;
      f_StartCell  : Long;
      f_FinishCell : Long;
      f_View       : InevView;
    private
    // interface methods  
      function First: IedColumn;
        {* - Возвращает первый столбец и начинает перебор. }
      function Next: IedColumn;
        {* - Возвращает следующий столбец или nil, если перебор закончен. }
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    //public methods
      constructor Create(const aView : InevView;
                         aPara      : Tl3Variant;
                         const aProcessor : InevProcessor;
                         aStartIndex      : Long;
                         aFinishIndex     : Long);
        reintroduce;
        {-}
        {* - Конструктор:
              aPara - строка таблицы.
              aProcessor - процессор операций. }
      class function Make(const aView : InevView;
                          aPara      : Tl3Variant;
                          const aProcessor : InevProcessor;
                          aStartIndex      : Long = 0;
                          aFinishIndex     : Long = High(Long)): IedColumnsIterator;
        reintroduce;                  
        {* - Конструктор:
              aPara - строка таблицы.
              aProcessor - процессор операций. }
  end;//TevColumnsIterator
{$EndIf evNeedEditableCursors}  

implementation

uses
  l3MinMax,

  evTableColumn
  ;

{$IfDef evNeedEditableCursors}
// start class TevColumnsIterator

constructor TevColumnsIterator.Create(const aView : InevView;
                                      aPara      : Tl3Variant;
                                      const aProcessor : InevProcessor;
                                      aStartIndex      : Long;
                                      aFinishIndex     : Long);
  //reintroduce;
  {* - Конструктор:
        aPara - строка таблицы.
        aProcessor - процессор операций. }
begin
 inherited Create(aPara, aProcessor);
 f_View := aView;
 f_StartCell := Max(0, aStartIndex);
 if (TagInst = nil) then
  f_FinishCell := -1
 else
  f_FinishCell := Min(aFinishIndex, Pred(TagInst.ChildrenCount));
end;

class function TevColumnsIterator.Make(const aView : InevView;
                                       aPara      : Tl3Variant;
                                       const aProcessor : InevProcessor;
                                       aStartIndex      : Long = 0;
                                       aFinishIndex     : Long = High(Long)): IedColumnsIterator;
  {* - Конструктор:
        aPara - строка таблицы.
        aProcessor - процессор операций. }
var
 l_Self : TevColumnsIterator;
begin
 l_Self := Create(aView, aPara, aProcessor, aStartIndex, aFinishIndex);
 try
  Result := l_Self;
 finally
  l3Free(l_Self);
 end;//try..finally
end;

procedure TevColumnsIterator.Cleanup;
  //override;
  {-}
begin
 f_View := nil;
 f_Index := f_StartCell;
 inherited;
end;

function TevColumnsIterator.First: IedColumn;
  {* - Возвращает первый столбец и начинает перебор. }
begin
 f_Index := f_StartCell;
 Result := Next;
end;

function TevColumnsIterator.Next: IedColumn;
  {* - Возвращает следующий столбец или nil, если перебор закончен. }
begin
 if (TagInst = nil) OR (f_Index > f_FinishCell) then
  Result := nil
 else
 begin
  Result := TevColumn.Make(f_View, TagInst, f_Index, Processor);
  Inc(f_Index);
 end;//TagInst = nil
end;
{$EndIf evNeedEditableCursors}

end.

