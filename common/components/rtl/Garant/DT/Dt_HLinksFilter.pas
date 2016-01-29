Unit Dt_HLinksFilter;

{ $Id: Dt_HLinksFilter.pas,v 1.7 2004/12/23 08:40:43 lulin Exp $ }
// $Log: Dt_HLinksFilter.pas,v $
// Revision 1.7  2004/12/23 08:40:43  lulin
// - вычищен ненужный модуль.
//
// Revision 1.6  2004/10/13 12:40:17  step
// bug fix
//
// Revision 1.5  2004/09/29 16:47:05  step
// добавлена проверка номеров документов
//
// Revision 1.4  2004/09/28 14:02:44  step
// замена структур на простые переменные, немного изменена логика разбора
//
// Revision 1.3  2004/09/27 13:11:32  step
// удалена THLinksFilter.StartChild
//
// Revision 1.2  2004/09/27 12:24:55  lulin
// - класс THLinksFilter поддерживает интерфейс Il3DocIDSource.
//
// Revision 1.1  2004/09/27 11:35:51  step
// занесено в CVS
//

{$I DtDefine.inc}

interface

uses
  Classes,

  l3InternalInterfaces,
  
  k2TagTerminator,
  k2TagFilter,

  l3Types,k2Types,Dt_Const,Dt_Types,Dt_Dict,Dt_Renum,l3Base, 
  l3DatLst,k2Base,k2TagGen,Dt_aTbl,Dt_TblCache
  ;

type
 ISubsProcessor = interface(IUnknown)
  ['{1E82CDF6-3101-4301-A7F5-802B2586ED18}']
  procedure Process(aDocId, aSubId: LongWord; aRealFlag: Byte; aName: PChar);
 end;

 IHLinksProcessor = interface(IUnknown)
  ['{5B89EBF2-3EB6-4C31-985D-24B5FA1E81E5}']
  procedure Process(aLinkId, aDocId, aDestDocId, aDestSubId: LongWord);
 end;

 IDocIdAuditor = interface(IUnknown)
  ['{02C4CC99-3668-499E-833F-F69D3AC590E6}']
  function IsValid(aDocId: Longint): Boolean;
 end;

 THLinksFilter = Class(Tk2TagFilter, Il3DocIDSource)
 private
  f_SubsProcessor: ISubsProcessor;
  f_HLinksProcessor: IHLinksProcessor;
  f_DocIdAuditor: IDocIdAuditor;
 protected
  f_SubId     : LongInt;
  f_SubName   : Tl3CustomString;
  f_SubFlag   : Boolean;

  f_DestDoc   : LongInt;
  f_DestSub   : LongInt;
  f_HLinkId   : LongInt;
  f_DocId     : LongInt;

  f_IgnoreCurrentDoc: Boolean;
 protected
 // interface methods
   // Il3DocID
      function  pm_GetDocID: Long;
      procedure pm_SetDocID(aValue: Long);
        {-}
 protected
  procedure   ProcessSub;
  procedure   ProcessHLink;
 public
  constructor Create(const aSubsProcessor: ISubsProcessor;
                     const aHLinksProcessor: IHLinksProcessor;
                     const aDocIdAuditor: IDocIdAuditor);
  procedure   Cleanup; override;
  procedure   CloseStream(NeedUndo : Boolean); override;
  procedure   StartChild(TypeID: Long); override;
  procedure   AddAtomEx(AtomIndex : Long; const Value : Tk2Variant); override;
  procedure   CloseStructure(NeedUndo : Bool); override;
 end;

implementation

uses
  l3String, k2Tags,Dt_Serv,Dt_Hyper,Dt_Err,SysUtils,l3Chars,l3Tree_TLB,
  l3Nodes,Dt_Link,l3Date,Dt_IFltr;

const
 c_BoolToByte: array[False..True] of Byte = (0, 1);

{ THLinksFilter }

function THLinksFilter.pm_GetDocID: Long;
  {-}
begin
 Result := f_DocID;
end;

procedure THLinksFilter.pm_SetDocID(aValue: Long);
  {-}
begin
 f_DocID := aValue;
 f_IgnoreCurrentDoc := (f_DocIdAuditor <> nil) and not f_DocIdAuditor.IsValid(f_DocID);
end;

procedure THLinksFilter.ProcessSub;
var
 l_Name: PAnsiChar;
begin
 if (f_SubsProcessor <> nil) and (f_DocId <> 0) and (f_SubId > 0) then
 begin
  if Assigned(f_SubName) then
   l_Name := f_SubName.St
  else
   l_Name := nil;

  f_SubsProcessor.Process(f_DocID,
                          f_SubId,
                          c_BoolToByte[f_SubFlag],
                          l_Name);
 end;
end;

procedure THLinksFilter.ProcessHLink;
begin
 if (f_HLinksProcessor <> nil)
  //and (f_HLinkId <> 0)
  and (f_DocID <> 0)
  and (f_DestDoc <> 0) then
 begin
  f_HLinksProcessor.Process(f_HLinkId,
                            f_DocID,
                            f_DestDoc,
                            f_DestSub);
 end;
end;

constructor THLinksFilter.Create(const aSubsProcessor: ISubsProcessor;
                                 const aHLinksProcessor: IHLinksProcessor;
                                 const aDocIdAuditor: IDocIdAuditor);
begin
 inherited Create;

 f_SubsProcessor := aSubsProcessor;
 f_HLinksProcessor := aHLinksProcessor;
 f_DocIdAuditor := aDocIdAuditor;

 f_SubId := 0;
 f_HLinkId := 0;
 f_DestDoc := 0;
 f_DestSub := 0;
end;

procedure THLinksFilter.Cleanup;
begin
 f_SubsProcessor := nil;
 f_HLinksProcessor := nil;
 f_DocIdAuditor := nil;

 inherited;
end;

procedure THLinksFilter.AddAtomEx(AtomIndex : Long; const Value : Tk2Variant);
begin
 if not f_IgnoreCurrentDoc then
 begin
  // ловим HLink.Id
  if TopType[0].InheritsFrom(k2_idHyperLink)
   and (AtomIndex = k2_tiHandle) then
  begin
   if (Value.Kind = k2_vkInteger) then
    f_HLinkId := LongInt(Value.AsInteger)
   else
    ConvertErrorEx(Value.Kind);
  end

  // ловим HLink.DestDoc и HLink.DestSub
  else if TopType[1].InheritsFrom(k2_idHyperLink)
        and TopType[0].InheritsFrom(k2_idAddress) then
  begin
   if (AtomIndex = k2_tiDocID) then
    if (Value.Kind = k2_vkInteger) then
     f_DestDoc := TDocID(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind)
   else
    if (AtomIndex = k2_tiSubID) then
     if (Value.Kind = k2_vkInteger) then
      f_DestSub := TSubID(Value.AsInteger)
     else
      ConvertErrorEx(Value.Kind);
  end

  // ловим Sub.SubId, Sub.SubName, Sub.RealFlag
  else if TopType[0].InheritsFrom(k2_idSub)
        and not TopType[0].InheritsFrom(k2_idDocumentSub)
        and not TopType[0].InheritsFrom(k2_idDocument) then
  begin
   if (AtomIndex = k2_tiHandle) then
   begin
    if (Value.Kind = k2_vkInteger) then
     f_SubId := TSubID(Value.AsInteger)
    else
     ConvertErrorEx(Value.Kind);
   end
   else if (AtomIndex = k2_tiShortName) then
   begin
    if (Value.Kind = k2_vkString) then
    begin
     l3Set(f_SubName, Value.AsString);
     f_SubName.CodePage := cp_ANSI;
     f_SubFlag := True;
    end
    else
     ConvertErrorEx(Value.Kind);
   end
   else if (AtomIndex = k2_tiName) then
   begin
    if (Value.Kind = k2_vkString) then
    begin
     l3Set(f_SubName, Value.AsString);
     f_SubName.CodePage := cp_ANSI;
     f_SubFlag := False;
    end
    else
     ConvertErrorEx(Value.Kind);
   end;
  end;
 end; // if not Ignore

 Generator.AddAtomEx(AtomIndex, Value);
end;

procedure THLinksFilter.CloseStructure(NeedUndo : Bool);
begin
 try
  if not f_IgnoreCurrentDoc then
  begin
   if TopType[0].InheritsFrom(k2_idSub)
    and not TopType[0].InheritsFrom(k2_idDocumentSub)
    and not TopType[0].InheritsFrom(k2_idDocument) then
   begin
    ProcessSub;

    f_SubId := 0;
    l3Free(f_SubName);
   end
   else if TopType[0].InheritsFrom(k2_idHyperLink) then
   begin
    f_HLinkId := 0;
   end
   else if (f_HLinkId <> 0)
    and TopType[0].InheritsFrom(k2_idAddress)
    and TopType[1].InheritsFrom(k2_idHyperLink) then
   begin
    ProcessHLink;

    f_DestDoc := 0;
    f_DestSub := 0;
   end;
  end; // if not Ignore
 finally
  inherited;
 end;
end;

procedure THLinksFilter.CloseStream(NeedUndo : Boolean);
begin
 inherited;

 f_SubId := 0;
 l3Free(f_SubName);

 f_DestDoc := 0;
 f_DestSub := 0;
 f_HLinkId := 0;

 f_IgnoreCurrentDoc := False;
end;

procedure THLinksFilter.StartChild(TypeID: Long);
begin
 inherited;

 if TopType[0].InheritsFrom(k2_idAddress) then
 begin
  f_DestDoc := 0;
  f_DestSub := 0;
 end;
end;

end.

