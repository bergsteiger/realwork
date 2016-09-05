unit ddDocNameUpdateFilter;

{ $Id: ddDocNameUpdateFilter.pas,v 1.10 2016/06/16 05:40:04 lukyanets Exp $ }

// $Log: ddDocNameUpdateFilter.pas,v $
// Revision 1.10  2016/06/16 05:40:04  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.9  2015/11/25 14:01:46  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.8  2015/03/13 11:55:47  voba
// - локальное автосохранение документов
//
// Revision 1.7  2014/03/28 06:13:17  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.6  2013/10/21 15:43:16  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.4  2013/10/18 15:39:01  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.3  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.2  2011/06/10 11:52:40  voba
// - DocumentServer сделал функцией function DocumentServer(aFamily : TdaFamilyID), что бы отдельно Family не присваивать
//
// Revision 1.1  2010/11/12 15:18:50  fireton
// - проставляем ключевые темы в названии документа
//

interface
uses
 l3Types,
 l3Base,
 l3Variant,
 l3Interfaces,

 k2Types,
 k2TagFilter,
 k2Prim,

 DT_Types
 ;

type
 // Фильтр просматривает имя документа и вносит изменения в базу, если имя отличается от
 // существующего в базе
 TddDocNameUpdateFilter = class(Tk2TagFilter)
 private
  f_DocID: TDocID;
  f_Name : Tl3PrimString;
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  procedure Cleanup; override;
 public
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;

implementation
uses
 SysUtils,

 k2Tags,

 Document_Const,

 daSchemeConsts,

 DT_Const,
 dt_Record,
 DT_Serv,
 DT_LinkServ,
 DT_Doc
 ;

procedure TddDocNameUpdateFilter.Cleanup;
begin
 FreeAndNil(f_Name);
 inherited;
end;

procedure TddDocNameUpdateFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_OldName: AnsiString;
 l_Name: AnsiString;
 l_RNum: Longint;
 lDocRec : TdtRecord;
begin
 if CurrentType.IsKindOf(k2_typDocument) then
 begin
  case AtomIndex of
   k2_tiInternalHandle: f_DocID := Value.AsInteger;
   k2_tiName          : l3Set(f_Name, Value.AsString);
  end;

  if (f_DocID <> 0) and (f_Name <> nil) then
  begin
   lDocRec := InitRecord(DocumentServer(CurrentFamily).FileTbl);
   if lDocRec.FindByUniq(fId_Fld, f_DocID) then
   begin
    lDocRec.Get(True{hold});
    if lDocRec.GetStrField(fFName_Fld) <> f_Name.AsString then
    try
     lDocRec.FillField(fFName_Fld, [f_Name]);
     lDocRec.Update;
    finally
     lDocRec.Unlock;
    end;
   end; 
  end;
 end;
 inherited;
end;

procedure TddDocNameUpdateFilter.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID = k2_typDocument then
 begin
  f_DocID := 0;
  FreeAndNil(f_Name);
 end;
 inherited;
end;

end.