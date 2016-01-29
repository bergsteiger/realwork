unit d2sFilter;

interface

uses ddHeaderFilter, k2Interfaces, Classes, k2TagGen;

type
 Td2sFilter = class(TddHeaderFilter)
 private
  f_Participants: TStrings;
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Tag); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner); override;
  procedure Cleanup; override;
 end;

implementation

uses k2Tags, k2Base, SysUtils;

constructor Td2sFilter.Create(anOwner: Tk2TagGeneratorOwner);
begin
 inherited;
 f_Participants:= TStringList.Create;
 TStringList(f_Participants).Sorted:= True;
end;

procedure Td2sFilter.BeforeFlushHeader(aHeaderRoot: Tl3Tag);
var
 i: Integer;
 l_PartStr: String;
 l_Part: Tl3Tag;
begin
 if aHeaderRoot.Attr[k2_tiCaseDocParticipants].IsValid then
 begin
  f_Participants.Clear;
  aHeaderRoot.AttrW[k2_tiName, nil]:= k2NullTag;
  // накапливаем участников. ¬сех повторных занул€ем
  i:= 0;
  while i < aHeaderRoot.Attr[k2_tiCaseDocParticipants].ChildrenCount do
  begin
   l_Part:= aHeaderRoot.Attr[k2_tiCaseDocParticipants].Child[i];
   l_PartStr:= Format('%d=%s', [l_Part.IntA[k2_tiType], l_Part.StrA[k2_tiName]]);
   if f_Participants.IndexOf(l_partStr) = -1 then
   begin
    f_participants.Add(l_PartStr);
    Inc(i);
   end
   else
   begin
    aHeaderRoot.Attr[k2_tiCaseDocParticipants].DeleteChild(i)
   end;
  end; // while
 end; // Isvalid
end;

procedure Td2sFilter.Cleanup;
begin
 FreeAndNil(f_Participants);
 inherited;
end;

end.
