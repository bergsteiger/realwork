unit dd_lcParticipantsNormalizeFilter;

{ $Id: dd_lcParticipantsNormalizeFilter.pas,v 1.7 2014/04/08 17:13:30 lulin Exp $ }

// $Log: dd_lcParticipantsNormalizeFilter.pas,v $
// Revision 1.7  2014/04/08 17:13:30  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.6  2014/04/08 06:13:38  fireton
// - не собиралось
//
// Revision 1.5  2013/10/25 09:20:24  fireton
// - переделки под изменения в k2
//
// Revision 1.4  2013/04/25 10:18:09  fireton
// - не собиралось: последствия переименования Char в AnsiChar
//
// Revision 1.3  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.2  2012/07/16 10:43:55  fireton
// - bug fix
//
// Revision 1.1  2012/05/03 06:10:19  fireton
// - initial commit
//

interface
uses
 Classes,

 l3Types,

 k2Prim,
 k2Types,
 k2TagFilter,
 k2Interfaces,

 evdBufferedFilter,

 ddRTFReader;

type
 TlclcParticipantsNormalizeFilter = class(TevdBufferedFilter)
 private
  procedure AnalyzeAndFlushParticipants;
 protected
  function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
  function NeedStartBuffering(aID: Integer): Boolean; override;
 public
  procedure CloseStructure(NeedUndo: Bool); override;
 end;

implementation

uses
 SysUtils,

 l3Base,
 l3Interfaces,
 l3ProtoObject,
 l3InterfaceList,
 l3String,

 DT_Types,

 k2TagGen,
 k2Tags,
 Participant_Const,

 ddParticipantsUtils;

type
 IlcParticipant = interface
 ['{1995F53A-2810-4793-8D27-C6C120193BEA}']
  function pm_GetName: Il3CString;
  function pm_GetNormalizedName: Il3CString;
  function pm_GetParticipantType: TlcParticipantType;
  property Name: Il3CString read pm_GetName;
  property NormalizedName: Il3CString read pm_GetNormalizedName;
  property ParticipantType: TlcParticipantType read pm_GetParticipantType;
 end;

 TlcParticipant = class(Tl3ProtoObject, IlcParticipant)
 private
  f_Name : Il3CString;
  f_Normalizedname: Il3CString;
  f_Type: TlcParticipantType;
  function pm_GetName: Il3CString;
  function pm_GetNormalizedName: Il3CString;
  function pm_GetParticipantType: TlcParticipantType;
 public
  class function Make(const aName, aNormName: Il3CString; aType: TlcParticipantType): IlcParticipant;
 end;

procedure TlclcParticipantsNormalizeFilter.AnalyzeAndFlushParticipants;
var
 l_Root: Tl3Variant;
 I,J   : Integer;
 l_Found: Boolean;
 l_ParticipantTag: Tl3Variant;
 l_NormName: Il3CString;
 l_List: Tl3InterfaceList;
 l_Name: Il3CString;
 l_Participant: IlcParticipant;
 l_Type: TlcParticipantType;
begin
 l_Root := f_Buffer.Tags.Top^.Box;
 if l_Root.IsValid then
 begin
  l_List := Tl3InterfaceList.Make;
  try
   for I := 0 to Pred(l_Root.ChildrenCount) do
   begin
    l_ParticipantTag := l_Root.Child[I];
    l_Name := l3CStr(l_ParticipantTag.PCharLenA[k2_tiName]);
    l_NormName := NormalizeParticipant(l_Name);
    l_Type := TlcParticipantType(l_ParticipantTag.IntA[k2_tiType]);
    l_Found := False;
    for J := 0 to l_List.Count - 1 do
    begin
     l_Participant := l_List.Items[J] as IlcParticipant;
     if l3Same(l_NormName, l_Participant.NormalizedName) and (l_Type = l_Participant.ParticipantType) then
     begin
      l_Found := True;
      Break;
     end;
    end;
    if not l_Found then
     l_List.Add(TlcParticipant.Make(l_Name, l_NormName, l_Type));
   end;

   if l_List.Count > 0 then
   begin
    Generator.StartTag(k2_tiCaseDocParticipants);
    try
     for J := 0 to l_List.Count - 1 do
     begin
      l_Participant := l_List.Items[J] as IlcParticipant;
      Generator.StartChild(k2_typParticipant);
      try
       Generator.AddStringAtom(k2_tiName, l_Participant.Name.AsWStr);
       Generator.AddIntegerAtom(k2_tiType, Ord(l_Participant.ParticipantType));
      finally
       Generator.Finish;
      end;
     end;
    finally
     Generator.Finish;
    end;
   end;
  finally
   FreeAndNil(l_List);
  end;
 end;
end;

procedure TlclcParticipantsNormalizeFilter.CloseStructure(NeedUndo: Bool);
begin
 if TopObject[0].IsProp and (TopObject[0].AsProp.TagIndex = k2_tiCaseDocParticipants) then
  AnalyzeAndFlushParticipants;
 inherited;
end;

function TlclcParticipantsNormalizeFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
begin
 Result := False;
end;

function TlclcParticipantsNormalizeFilter.NeedStartBuffering(aID: Integer): Boolean;
begin
 Result := (aID = k2_tiCaseDocParticipants);
end;

class function TlcParticipant.Make(const aName, aNormName: Il3CString; aType: TlcParticipantType): IlcParticipant;
var
 l_P: TlcParticipant;
begin
 l_P := TlcParticipant.Create;
 try
  l_P.f_Name := aName;
  l_P.f_NormalizedName := aNormName;
  l_P.f_Type := aType;
  Result := l_P;
 finally
  FreeAndNil(l_P);
 end;
end;

function TlcParticipant.pm_GetName: Il3CString;
begin
 Result := f_Name;
end;

function TlcParticipant.pm_GetNormalizedName: Il3CString;
begin
 Result := f_NormalizedName;
end;

function TlcParticipant.pm_GetParticipantType: TlcParticipantType;
begin
 Result := f_Type;
end;

end.
