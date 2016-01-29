unit evdTopicFileSplitter;

{ $Id: evdTopicFileSplitter.pas,v 1.1 2014/07/16 10:39:23 fireton Exp $ }

interface
uses
 k2TagGen,
 k2FileGenerator,
 k2TagFilter,

 l3Variant;

type
 TevdTopicFileSplitter = class(Tk2TagFilter)
 private
  f_FileGenerator: Tk2CustomFileGenerator;
  f_Index        : Integer;
  f_BaseFilename : AnsiString;
 private
  function GetNextFilename: AnsiString;
 public
  constructor Create(const aFileGenerator : Tk2CustomFileGenerator;
                           aBaseFileName  : AnsiString);
  class function SetTo(var   theGenerator   : Tk2TagGenerator;
                       const aFileGenerator : Tk2CustomFileGenerator;
                             aBaseFileName  : AnsiString): Pointer;
  procedure StartChild(TypeID: Tl3VariantDef); override;
 end;


implementation
uses
 SysUtils,

 l3Base,
 l3Filer,

 Document_Const;

constructor TevdTopicFileSplitter.Create(const aFileGenerator : Tk2CustomFileGenerator;
                                               aBaseFileName  : AnsiString);
begin
 inherited Create;
 f_BaseFilename := aBaseFilename;
 f_FileGenerator := aFileGenerator;
end;

function TevdTopicFileSplitter.GetNextFilename: AnsiString;
var
 l_Ext: AnsiString;
begin
 Inc(f_Index);
 l_Ext := ExtractFileExt(f_BaseFilename);
 Result := ChangeFileExt(f_BaseFilename, '_' + IntToStr(f_Index) + l_Ext);
end;

class function TevdTopicFileSplitter.SetTo(var   theGenerator   : Tk2TagGenerator;
                                           const aFileGenerator : Tk2CustomFileGenerator;
                                                 aBaseFileName  : AnsiString): Pointer;
var
 l_Filter: TevdTopicFileSplitter;
begin
 l_Filter := Create(aFileGenerator, aBaseFilename);
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  FreeAndNil(l_Filter);
 end;
 Result := theGenerator;
end;

procedure TevdTopicFileSplitter.StartChild(TypeID: Tl3VariantDef);
begin
 if TypeID = k2_typDocument then
 begin
  if f_FileGenerator.Filer.Opened then
   f_FileGenerator.Filer.Close;
  Tl3CustomDOSFiler(f_FileGenerator.Filer).FileName := GetNextFilename;
  f_FileGenerator.Filer.Open;
 end;
 inherited;
end;


end.