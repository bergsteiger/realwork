unit evStatisticsFilter;
{* Фильтр для сбора статистики о документе. }

{ Библиотека "Эверест"         }
{ Автор: Люлин А.В. ©          }
{ Модуль: evStatisticsFilter - }
{ Начат: 27.03.2001 12:56      }
{ $Id: evStatisticsFilter.pas,v 1.19 2014/03/28 06:14:13 dinishev Exp $ }

// $Log: evStatisticsFilter.pas,v $
// Revision 1.19  2014/03/28 06:14:13  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.18  2013/10/21 15:42:58  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.17  2013/10/21 10:30:41  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2013/10/18 15:38:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2010/11/30 11:47:02  lulin
// {RequestLink:228688602}.
// - борьба с предупреждениями.
//
// Revision 1.14  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.13  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.10.8.3  2007/11/28 14:05:10  dinishev
// Не компилировалось
//
// Revision 1.10.8.2  2007/08/09 18:26:18  lulin
// - избавляемся от излишнего использования интерфейсов, т.к. переносимость может быть достигнута другими методами.
//
// Revision 1.10.8.1  2007/08/09 11:19:13  lulin
// - cleanup.
//
// Revision 1.10  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.9  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.8  2004/06/02 14:45:48  law
// - rename method: Tk2BaseStackGenerator.Atom2String -> VariantAsString.
// - сделан фильтр для сбора информации о документах со строками в кодировке _1252.
//
// Revision 1.7  2004/05/14 16:58:27  law
// - new units: k2TagTerminator, k2TagFilter.
//
// Revision 1.6  2004/05/14 14:28:50  law
// - change: TevVariant переименован в Tk2Variant и переехал в k2Types.
//
// Revision 1.5  2002/12/17 12:42:48  law
// - change: k2_idTableColumn переименовано в k2_idTableCell для большего соответстия смыслу тега.
//
// Revision 1.4  2002/09/18 08:06:10  voba
// - cleanup: удален параметр IsDefault.
//
// Revision 1.3  2001/04/10 15:21:50  law
// - new prop: добавлено свойство ClearForEachDocument.
//
// Revision 1.2  2001/04/03 13:44:59  law
// - new behavior: SBS-параграфы убраны из подсчета таблиц.
//
// Revision 1.1  2001/03/27 11:04:57  law
// - добавлен фильтр для сбора статистики о документе.
//

{$I evDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,

  k2Types,
  k2Prim,
  k2TagFilter
  ;

type
  TevStatisticsFilter = class(Tk2TagFilter)
   {* - фильтр для сбора статистики о документе. }
    private
    //internal fields
      f_TablesOpened   : Long;
    private
    //property fields
      f_CharCount      : Long;
      f_TableCharCount : Long;
      f_CellCount      : Long;
      f_ClearForEachDocument : Bool;
    protected
    //property methdos
      function pm_GetInTable: Bool;
        {-}
    protected
    //internal methods
      procedure OpenStream;
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure ClearStatistics;
        {-}
    public
    //public properties
      property CharCount: Long
        read f_CharCount;
        {* - количество символов в тексте. }
      property TableCharCount: Long
        read f_TableCharCount;
        {* - количество символов в таблицах. }
      property CellCount: Long
        read f_CellCount;
        {* - количество ячеек таблиц. }
      property InTable: Bool
        read pm_GetInTable;
        {* - в таблице? }
      property ClearForEachDocument: Bool
        read f_ClearForEachDocument
        write f_ClearForEachDocument
        default false;
        {* - очищать ли статистику для каждого документа? }
  end;//TevStatisticsFilter

implementation

uses
  k2Interfaces,
  k2Tags,
  k2Base,

  Document_Const,
  Table_Const,
  SBS_Const,
  TableCell_Const
  ;

// start class TevStatisticsFilter

procedure TevStatisticsFilter.OpenStream;
  //override;
  {-}
begin
 inherited;
 ClearStatistics;
end;

procedure TevStatisticsFilter.ClearStatistics;
  {-}
begin
 f_CharCount := 0;
 f_TableCharCount := 0;
 f_CellCount := 0;
end;

procedure TevStatisticsFilter.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
var
 CT : Tk2Type;
begin
 inherited;
 CT := CurrentType;
 if ClearForEachDocument then begin
  if CT.IsKindOf(k2_typDocument) then begin
   ClearStatistics;
   Exit;
  end;//..k2_idDocument..
 end;//ClearForEachDocument
 if CT.IsKindOf(k2_typTable) AND not CT.IsKindOf(k2_typSBS) then
  Inc(f_TablesOpened)
 else if InTable AND CT.IsKindOf(k2_typTableCell) then
  Inc(f_CellCount);
end;

procedure TevStatisticsFilter.CloseStructure(NeedUndo: Bool);
  //override;
  {-вызывается на закрывающуюся скобку}
var
 CT : Tk2Type;
begin
 CT := CurrentType;
 if CT.IsKindOf(k2_typTable) AND not CT.IsKindOf(k2_typSBS) then
  Dec(f_TablesOpened);
 inherited;
end;

function TevStatisticsFilter.pm_GetInTable: Bool;
  {-}
begin
 Result := (f_TablesOpened > 0);
end;

procedure TevStatisticsFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
var
 S : Tl3CustomString;
begin
 inherited;
 if (AtomIndex = k2_tiText) then begin
  S := VariantAsString(Value);
  try
   if not S.Empty then begin
    if InTable then
     Inc(f_TableCharCount, S.Len)
    else
     Inc(f_CharCount, S.Len);
   end;//not S.Empty
  finally
   l3Free(S);
  end;//try..finally
 end;//AtomIndex = k2_tiText
end;
  
end.

