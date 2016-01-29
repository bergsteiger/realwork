unit ddSectionRepairUtils;

{ $Id: ddSectionRepairUtils.pas,v 1.7 2014/03/28 06:53:30 dinishev Exp $ }

// $Log: ddSectionRepairUtils.pas,v $
// Revision 1.7  2014/03/28 06:53:30  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.6  2013/10/21 15:43:16  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.5  2013/10/21 10:31:05  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.4  2013/10/18 16:01:26  lulin
// - потихоньку избавл€емс€ от использовани€ идентификаторов типов тегов.
//
// Revision 1.3  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.2  2012/02/20 10:55:43  narry
// обновление
//
// Revision 1.1  2010/06/17 12:39:44  fireton
// - утилиты расстановки разделов
//

interface

uses
 Classes,
 l3Types,
 l3Variant,
 l3LongintList,

 k2Types,
 k2Prim,
 k2TagGen,
 k2StackGenerator,

 m3StorageInterfaces
 ;


type
// "Find Tables And Monospace" Filter
TddFTAMFilter = class(Tk2CustomStackGeneratorExEx)
private
 f_ParaSize: Integer;
 f_ParaStyle: Integer;
 f_TopicList: Im3StorageElementIDList;
    // internal fields
 f_WasOut: Bool;
        {-}
 procedure ReportDocID;
protected
 procedure StartChild(TypeID: Tl3VariantDef); override;
 procedure CloseStructure(NeedUndo: Bool); override;
 procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
    // property methods
 procedure pm_SetDocID(aValue: Long); override;
public
    // public methods
 constructor Create(aList: Im3StorageElementIDList; anOwner: Tk2TagGeneratorOwner = nil); reintroduce;
 class function SetTo(aList : Im3StorageElementIDList; var theGenerator : Tk2TagGenerator): Tk2TagGenerator; reintroduce;
 property TopicList: Im3StorageElementIDList read f_TopicList;
end;

// ¬ функцию передаЄтс€ список топиков. ≈сли список пустой, то поиск будет по всей базе, иначе только по тем топикам,
// что указаны. ≈сли расстановка разделов прошла успешно, то функци€ вернЄт True и в списке будут топики, реально
// скорректированные фильтром TddSectionRepairFilter.
function DoSectionRepair(const aBasePath: AnsiString; var theTopicList: Tl3LongintList;
                         aOnYeld: TNotifyEvent = nil; aOnProgress: Tl3ProgressProc = nil): Boolean;

implementation
uses
 SysUtils,
 l3Base,

 k2Base,
 k2Tags,

 evdStyles,
 evTextStyle_Const,

 m3StorageElementIDList,
 m3DBInterfaces,
 m3DB,

 ddSectionRepair,

 LeafPara_Const,
 Table_Const,
 SBS_Const, l3LongintListPrim;

constructor TddFTAMFilter.Create(aList: Im3StorageElementIDList; anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited Create(anOwner);
 f_TopicList := aList;
end;

procedure TddFTAMFilter.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 CT : Tk2Type;
 S  : Tl3CustomString;
begin
 inherited;
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typLeafPara) then
  begin                                           
   case AtomIndex of
    k2_tiStyle: f_ParaStyle := VariantAsInteger(k2_tiStyle, Value);
    k2_tiText : begin
                 S := VariantAsString(Value);
                 try
                  if not S.Empty then
                   f_ParaSize := S.Len;
                 finally
                   FreeAndNil(S);
                 end;
                end;
   end;
  end;
 end;
end;

procedure TddFTAMFilter.CloseStructure(NeedUndo: Bool);
var
 CT : Tk2Type;
begin
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typLeafPara) and
     ((f_ParaStyle = ev_saTxtNormalOEM) or (f_ParaStyle = ev_saANSIDOS)) and
     (f_ParaSize > 73) then
   ReportDocID;
 end;
 inherited;
end;

// start class TevInfoFilterEx

procedure TddFTAMFilter.pm_SetDocID(aValue: Long);
  //override;
  {-}
begin
 inherited;
 f_WasOut := False;
end;

procedure TddFTAMFilter.ReportDocID;
begin
 if f_TopicList <> nil then
  f_TopicList.Add(DocID);
 f_WasOut := True;
end;

class function TddFTAMFilter.SetTo(aList : Im3StorageElementIDList;  var theGenerator : Tk2TagGenerator): Tk2TagGenerator;
var
 l_Filter: TddFTAMFilter;
begin
 l_Filter := Create(aList);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNil(l_Filter);
 end;
 Result := theGenerator;
end;

procedure TddFTAMFilter.StartChild(TypeID: Tl3VariantDef);
var
 CT : Tk2Type;
begin
 inherited;
 if not f_WasOut then
 begin
  CT := CurrentType;
  if CT.IsKindOf(k2_typTable) AND not CT.IsKindOf(k2_typSBS) then
   ReportDocID;
  if (not f_WasOut) and CT.IsKindOf(k2_typLeafPara) then
  begin
   f_ParaStyle := ev_saEmpty;
   f_ParaSize  := 0;
  end;
 end;
end;

function DoSectionRepair(const aBasePath: AnsiString; var theTopicList: Tl3LongintList;
                         aOnYeld: TNotifyEvent = nil; aOnProgress: Tl3ProgressProc = nil): Boolean;
var
 l_DB    : Im3DB;
 l_Range : Im3DBRange;
 l_FTAMFilter: TddFTAMFilter;
 l_SectFilter: TddSectionRepairFilter;
 l_FoundList  : Im3StorageElementIDList;
 l_SEList: Im3StorageElementIDList;
 I : Integer;
begin
 Result := False;
 l_DB := Tm3DB.Make(aBasePath, aOnYeld, nil, aOnProgress);
 try
  l_FoundList := Tm3StorageElementIDList.MakeI;
  try
   l_FTAMFilter :=TddFTAMFilter.Create(l_FoundList);
   try
    // поиск докуметов дл€ обработки
    if theTopicList.Empty then
     l_Range := l_DB.AllFiles
    else
    begin
     l_SEList := Tm3StorageElementIDList.MakeI;
     for I := 0 to theTopicList.Hi do
      l_SEList.Add(theTopicList[I]);
     l_Range := l_DB.FilesInList(l_SEList);
     l_SEList := nil;
    end;
    try
     l_Range.Iterate(l_FTAMFilter, False, [m3_dsMain]);
    finally
     l_Range := nil;
    end;
   finally
    FreeAndNil(l_FTAMFilter);
   end;

   // собственно, обработка
   if not l_FoundList.Empty then
   begin
    l_SectFilter := TddSectionRepairFilter.Create;
    try
     l_Range := l_DB.FilesInList(l_FoundList);
     try
      l_Range.Iterate(l_SectFilter, True, [m3_dsMain]);
     finally
      l_Range := nil;
     end;
     theTopicList.Assign(l_SectFilter.WorkedDocs);
     Result := True;
    finally
     FreeAndNil(l_SectFilter);
    end;
   end
   else
   begin
    // обрабатывать нечего, возвращаем пустой результат
    theTopicList.Clear;
   end;
  finally
   l_FoundList := nil;
  end;
 finally
  l_DB := nil;
 end;
end;


end.