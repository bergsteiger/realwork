unit ddNSRCSub;

{$I ddDefine.inc}
{$I dtDefine.inc}

interface

uses
 l3ProtoObject,
 l3Base,

 k2TagGen,

 evdTypes
 ;

type
  TddNSRCSub = class(Tl3ProtoObject)
  private
   f_ANSICodePage: Integer;
   f_Attributes: Tk2TagGenerator;
   f_IsBlock: Boolean;
   f_IsValid: Boolean;
   f_ID: Longint;
   f_Name: Tl3String;
   f_LegalName: Boolean;
   f_ViewKind: TevBlockViewKind;
   f_Style: Longint;
   procedure pm_SetANSICodePage(const aValue: Integer);
(*   procedure pm_SetIsBlock(const Value: Boolean);*)
  protected
   procedure Cleanup; override;
  public
   constructor Create; //override;
   constructor MakeBlock(aAnsiCodePage: Integer);
   constructor MakeSub(aAnsiCodePage: Integer);
(*   procedure Clear;*)
   procedure MakeName(aText: Tl3String);

  public
   property ANSICodePage: Integer read f_ANSICodePage write pm_SetANSICodePage;
   property Generator: Tk2TagGenerator
    read f_Attributes;
   property IsBlock: Boolean read f_IsBlock {write pm_SetIsBlock};
   property IsValid: Boolean read f_IsValid write f_IsValid;
   property Name: Tl3String
    read f_Name
    write f_Name;
   property LegalName: Boolean
    read f_LegalName
    write f_LegalName;
   property Style: Longint read f_Style write f_Style;
   property ViewKind: TevBlockViewKind read f_ViewKind write f_ViewKind;
   property ID: Integer read f_ID write f_ID;
  end;//TddNSRCSub

implementation

uses
  l3Chars,

  k2DocumentBuffer,

  Document_Const
  ;

constructor TddNSRCSub.Create;
begin
 inherited Create;
 f_Name:= Tl3String.Create;
 f_Name.CodePage:= cp_OEMLite;
 f_IsValid:= False;
 f_LegalName:= True;
 f_Attributes:= Tk2DocumentBuffer.Create(nil);
 f_Attributes.Start;
 f_Attributes.StartChild(k2_typDocument);
 f_Style:= -1;
 f_ViewKind:= ev_bvkNone;
end;

constructor TddNSRCSub.MakeBlock(aAnsiCodePage: Integer);
begin
 Create;
 f_IsBlock := True;
 AnsiCodePage:= aAnsiCodePage;
end;

constructor TddNSRCSub.MakeSub(aAnsiCodePage: Integer);
begin
 Create;
 f_IsBlock := False;
 AnsiCodePage:= aAnsiCodePage;
end;

procedure TddNSRCSub.Cleanup;
begin
  l3Free(f_Name);
  if Generator.StreamOpened then
  begin
   Generator.Finish;
   if (Tk2DocumentBuffer(Generator).Root <> nil) AND
      Tk2DocumentBuffer(Generator).Root.IsValid then
    Generator.Finish;
   Tk2DocumentBuffer(Generator).Root:= nil;
  end;
  l3Free(f_attributes);
  inherited ;
end;

(*procedure TddNSRCSub.Clear;
begin
 ID:= -1;
 f_IsBlock:= False;
 f_LegalName:= True;
 Name.Clear;
 IsValid:= False;
 if Generator.StreamOpened then
 begin
  Generator.Finish;
  if (Tk2DocumentBuffer(Generator).Root <> nil) AND
     Tk2DocumentBuffer(Generator).Root.IsValid then
   Generator.Finish;
  Tk2DocumentBuffer(Generator).Root:= nil;
 end;
 f_Attributes.Start;
 f_Attributes.StartChild(k2_typDocument);
end;*)

const
 DummySubNameLen = 73;

procedure TddNSRCSub.MakeName(aText: Tl3String);
var
  j: Integer;
begin
  if Name.Empty and (aText <> nil) and not (aText.Empty) then
  begin
    LegalName:= False;
    Name.CodePage:= aText.CodePage;
    j:= 0;
    while (j < aText.Len) and (Name.Len < DummySubNameLen)do
    begin
      if (aText.Ch[j] <> #13) and (aText.Ch[j] >= #32) then
      begin
        if (aText.CodePage = cp_OEM) or (aText.CodePage = cp_OEMLite)then
        begin
          if not (aText.Ch[j] in cc_Frames) then
            Name.AsString:= Name.AsString+aText.Ch[j];
        end
        else
          Name.AsString:= Name.AsString+aText.Ch[j];
      end;
      inc(j);
    end;
    if (Name.Len = DummySubNameLen) and ((Name.Ch[Name.Len-1] <> ' ')
        or (Name.Ch[Name.Len-2] <> ' ')) then
    begin
      j:= Pred(DummySubNameLen);
      while (Name.Ch[j] <> ' ') and (j <> 0) do
        Dec(j);
      Name.Delete(j+1, DummySubNameLen);
    end;
    Name.Trim;
    Name.CodePage:= ANSICodePage;
  end;
end;

procedure TddNSRCSub.pm_SetANSICodePage(const aValue: Integer);
begin
 f_ANSICodePage := aValue;
 Name.CodePage:= AnsiCodePage;
end;

end.