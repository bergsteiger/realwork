Unit Dt_HeaderGen;

{ $Id: Dt_HeaderGen.pas,v 1.2 2006/04/03 13:59:10 fireton Exp $}

// $Log: Dt_HeaderGen.pas,v $
// Revision 1.2  2006/04/03 13:59:10  fireton
// - add: TDocHeaderFixFilter
//
// Revision 1.1  2006/03/24 14:36:33  fireton
// - initial commit
//

{$I DtDefine.inc}

interface
uses
 Classes,

 l3Types,

 k2Types,
 k2TagFilter,

 Dt_Types,
 Dt_Renum;

Type
 TDocHeaderGenerator = class(Tk2TagFilter)
  private
   f_MainDocID: TDocID;
  protected
   f_Family        : TFamilyID;
   f_ReNumTbl      : TReNumTbl;
   procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  public
   Constructor Create(anOwner : TComponent; aFamily : TFamilyID); reintroduce;
   property MainDocID: TDocID read f_MainDocID write f_MainDocID;
 end;

 // Фильтр для отрезания ненужных Name, ShortName и ExternalHandle
 TDocHeaderFixFilter = class(Tk2TagFilter)
 protected
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
 end;

implementation
uses
 k2Tags,

 Dt_Const,
 Dt_Serv,
 Dt_Doc;


Constructor TDocHeaderGenerator.Create(anOwner : TComponent;
                                       aFamily : TFamilyID);
Begin
 Inherited Create(anOwner);
 f_Family := aFamily;
 f_ReNumTbl := GlobalHtServer.ReNumTbl[f_Family];
 f_ReNumTbl.UpdateInterval := 0;
 f_MainDocID := -1;
end;

procedure TDocHeaderGenerator.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 l_DocID : TDocID;

 procedure WriteExtHandle;
 var
  l_ExtID : TDocID;
 begin
  l_ExtID:=f_ReNumTbl.ConvertToImportNumber(l_DocID);
  if l_ExtID > -1 then
   Generator.AddIntegerAtom(k2_tiExternalHandle, l_ExtID);
 end;

 procedure WriteDocHeader;
 var
  l_CardRec : TExpCardRec;
 begin
  FillChar(l_CardRec, SizeOf(TExpCardRec), #0);
  DocumentServer.Family := f_Family;
  DocumentServer.FileTbl.GetExpCard(l_DocID, @l_CardRec);

  WriteExtHandle;

  if l_CardRec.InternalType <> Ord(dtDictEntry) then
   Generator.AddIntegerAtom(k2_tiType,l_CardRec.InternalType);

  if TUserType(l_CardRec.Flag) <> utNone then
   Generator.AddIntegerAtom(k2_tiUserType, l_CardRec.Flag);

  if l_CardRec.ShortName <> '' then
  begin
   if l_CardRec.InternalType <> Ord(dtDictEntry) then
    Generator.AddStringAtom(k2_tiShortName, l_CardRec.ShortName);
  end;

  if l_CardRec.FullName <> '' then
   Generator.AddStringAtom(k2_tiName,l_CardRec.FullName);

  Generator.AddIntegerAtom(k2_tiPriceLevel,l_CardRec.Status);

  if l_CardRec.PriorFlag then
   Generator.AddIntegerAtom(k2_tiPriority,l_CardRec.Priority);

  if l_CardRec.SortDate <> 0 then
   Generator.AddIntegerAtom(k2_tiSortDate,l_CardRec.SortDate);

  if l_CardRec.Related <> 0 then
   Generator.AddIntegerAtom(k2_tiRelExternalHandle, l_CardRec.Related);

  if l_CardRec.VerLink <> 0 then
   Generator.AddIntegerAtom(k2_tiExternalVerLink, l_CardRec.VerLink);
 end;

 procedure WriteRelHeader;
 begin
  WriteExtHandle;
  Generator.AddIntegerAtom(k2_tiType, Integer(dtRelText));
 end;

 procedure ProcessDocAndRel;
 begin
  if TopType[0].InheritsFrom(k2_idAnnoTopic) then
   WriteExtHandle
  else
   if TopType[0].InheritsFrom(k2_idDocument) then
   begin
    if l_DocID = f_MainDocID then
     WriteDocHeader
    else
     WriteRelHeader;
   end;
 end;

begin
 inherited;
 if AtomIndex = k2_tiInternalHandle then
 begin
  if (Value.Kind=k2_vkInteger) then
  begin
   l_DocID := TDocID(Value.AsInteger);
   if l_DocID <> -1 then
    ProcessDocAndRel;
  end
  else
   ConvertErrorEx(Value.Kind)
 end;
end;

procedure TDocHeaderFixFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if ((AtomIndex = k2_tiName) or (AtomIndex = k2_tiShortName) or (AtomIndex = k2_tiExternalHandle)) and
    (TopType[0].InheritsFrom(k2_idDocument) or TopType[0].InheritsFrom(k2_idAnnoTopic)) then
  Exit
 else
  inherited;
end;


end.

