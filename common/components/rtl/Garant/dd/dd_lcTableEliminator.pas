unit dd_lcTableEliminator;
{ Удаляет таблицы из текста }

{ $Id: dd_lcTableEliminator.pas,v 1.21 2014/04/07 09:34:04 lulin Exp $ }

// $Log: dd_lcTableEliminator.pas,v $
// Revision 1.21  2014/04/07 09:34:04  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.20  2014/04/03 17:10:43  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.19  2014/03/27 14:29:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.18  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.17  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.16  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.15  2013/10/18 14:11:37  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.14  2012/04/27 06:05:18  narry
// Забытые коммиты
//
// Revision 1.13  2011/12/07 07:12:41  narry
// Нестандартный вид номера в таблице дата-номер (309168209)
//
// Revision 1.12  2011/12/01 15:04:49  lulin
// - прибираемся за коллегой. Пока костыль.
//
// Revision 1.11  2011/12/01 11:34:56  narry
// Не выводим в лог во время тестов
//
// Revision 1.10  2011/11/22 15:06:22  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.9  2011/11/22 12:53:51  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.8  2011/11/18 12:47:54  narry
// Остается мусор в ФАСах, а в логе нет об этом записи (300027711)
//
// Revision 1.7  2011/11/09 10:41:24  narry
// Команды CVS
//

interface

uses
 k2TagTerminator, k2Types,
 l3Types, k2TagFilter, ddTypes, evdBufferedFilter, k2Interfaces,
 dd_lcTextFormatter2, dd_lcBaseFilter, k2TagGen,

 k2Base
 ;

type
 TlcTableEliminator = class(Tdd_lcBaseFilter)
 private
  f_CellCount: Integer;
 protected
  procedure CloseStructure(NeedUndo: Boolean); override;
    // internal methods
  function NeedTranslateChildToNext: Boolean; override;
 public
  procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure StartChild(TypeID: Tl3Type); override;
 end;

 TlcTableEliminator2 = class(Tdd_lcBaseFormatter)
 private
  f_CellCount: Integer;
  f_OnError: TddErrorEvent;
  f_RowCount: Integer;
  f_SkipTable: Boolean;
 protected
  function ParaTypeForFiltering: Tk2Type; override;
        {* - Определяет нужно ли сбрасывать Тег в трубу.  }
  procedure DoWritePara(aLeaf: Tl3Variant); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure BodyFinish; override;
  procedure BodyStart; override;
  procedure StartChild(TypeID: Tl3Type); override;
 published
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

const
 cMinCellCount : Integer = 10;


implementation

uses TextPara_Const, table_Const, TableRow_Const, TableCell_Const, k2Tags,
 FramePart_Const, l3Base, k2BaseTypes, Document_Const;

procedure TlcTableEliminator.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf(k2_typTextPara) then
 begin
  if (AtomIndex = k2_tiText) then
   Generator.AddAtomEx(AtomIndex, Value)
 end
 else
  inherited;
end;

procedure TlcTableEliminator.CloseStructure(NeedUndo: Boolean);
begin
 if CurrentType.IsKindOf(k2_typTable) then
  if f_CellCount > cMinCellCount then
   ErrorReaction('Удалена таблица со сложной структурой');
 inherited;
end;

function TlcTableEliminator.NeedTranslateChildToNext: Boolean;
begin
 with CurrentType do
  Result := not IsKindOf([k2_typTable, k2_typTableRow, k2_typTableCell]);
end;

procedure TlcTableEliminator.StartChild(TypeID: Tl3Type);
begin
 if TypeID.IsKindOf(k2_typTable) then
  f_CellCount:= 0
 else
 if TypeID.IsKindOf(k2_typTableCell) then
  Inc(f_CellCount);
 inherited;
end;


constructor TlcTableEliminator2.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 EnableRestoreText := False;
end;

function TlcTableEliminator2.ParaTypeForFiltering: Tk2Type;
begin
 Result := k2_typTable;
end;

procedure TlcTableEliminator2.DoWritePara(aLeaf: Tl3Variant);
var
 l_Gen: TlcTableEliminator;
begin
  if f_SkipTable then
  begin
   l_Gen:= TlcTableEliminator.Create(nil);
   try
    l_Gen.OnError:= OnError;
    l_Gen.Start;
    l_Gen.Generator:= Generator;
    l_Gen.StartChild(aLeaf.TagType);
    try
     aLeaf.WriteTag(l_Gen)
    finally
     l_Gen.Finish;
    end;
   finally
    l_Gen.Generator:= nil;
    l_Gen.Finish;
    l3Free(l_Gen);
   end;//try..finally
  end
  else
   inherited;
end;

procedure TlcTableEliminator2.BodyFinish;
begin
 inherited BodyFinish;
 f_SkipTable:= True;
end;

procedure TlcTableEliminator2.BodyStart;
begin
 inherited BodyStart;
 f_SkipTable:= False;
end;

procedure TlcTableEliminator2.StartChild(TypeID: Tl3Type);
begin
 if TypeID.IsKindOf(k2_typDocument) then
  f_SkipTable:= True
 else
 if TypeID.IsKindOf(k2_typTable) then
 begin
  f_RowCount:= 0;
  f_CellCount:= 0;
 end
 else
 if TypeID.IsKindOf(k2_typTableRow) then
  Inc(f_RowCount)
 else
 if TypeID.IsKindOf(k2_typTableCell) then
  Inc(f_CellCount);
 inherited;
end;

end.
