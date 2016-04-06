unit csTasksHelpers;

// Модуль: "w:\common\components\rtl\Garant\cs\csTasksHelpers.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csTasksHelpers" MUID: (54A247D202B0)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , evdTasksHelpers
 , Classes
 , csProcessTask
 , l3Variant
;

type
 ReplacementFileHelper = interface
  ['{F8F4240B-F6FA-4A16-9D97-F74A37E37C6B}']
  function Get_Name: AnsiString;
  procedure Set_Name(const aValue: AnsiString);
  property Name: AnsiString
   read Get_Name
   write Set_Name;
 end;//ReplacementFileHelper

 AdditionalFilesHelper = interface(StringListHelper)
  ['{BFED0922-1466-47EF-ACB3-538D574F74ED}']
  procedure ChangeName(anIndex: Integer;
   const aValue: AnsiString);
 end;//AdditionalFilesHelper

 SourceFilesHelper = interface(AdditionalFilesHelper)
  ['{D13DC0D8-257A-4B1F-90CD-0DD2B70AD91A}']
  function Get_AdditionalFiles(anIndex: Integer): AdditionalFilesHelper;
  property AdditionalFiles[anIndex: Integer]: AdditionalFilesHelper
   read Get_AdditionalFiles;
 end;//SourceFilesHelper

 TasksListHelper = interface
  ['{DF143907-E670-49ED-9AEE-69F243C108E3}']
  function Get_Count: Integer;
  procedure Add(anItem: TddProcessTask);
  function MakeTask(anIndex: Integer;
   const aTaskFolder: AnsiString): TddProcessTask;
  property Count: Integer
   read Get_Count;
 end;//TasksListHelper

 TAdditionalFilesHelper = class(TAbstractStringListHelper, AdditionalFilesHelper)
  protected
   procedure DoAdd(const anItem: AnsiString); override;
   function DoGetStrings(anIndex: Integer): AnsiString; override;
   procedure ChangeName(anIndex: Integer;
    const aValue: AnsiString);
  public
   class function Make(aValue: Tl3Tag): AdditionalFilesHelper; reintroduce;
 end;//TAdditionalFilesHelper

 TSourceFilesHelper = class(TAdditionalFilesHelper, SourceFilesHelper)
  private
   procedure CheckNSRC(anIndex: Integer;
    const anItem: AnsiString);
  protected
   function NeedCheckNSRC: Boolean; virtual;
   function Get_AdditionalFiles(anIndex: Integer): AdditionalFilesHelper;
   procedure DoAdd(const anItem: AnsiString); override;
  public
   class function Make(aValue: Tl3Tag): SourceFilesHelper; reintroduce;
 end;//TSourceFilesHelper

 TTasksListHelper = class(TevdTagHelper, TasksListHelper)
  protected
   function Get_Count: Integer;
   procedure Add(anItem: TddProcessTask);
   function MakeTask(anIndex: Integer;
    const aTaskFolder: AnsiString): TddProcessTask;
  public
   class function Make(aValue: Tl3Tag): TasksListHelper; reintroduce;
 end;//TTasksListHelper

 TReplacementFileHelper = class(TSourceFilesHelper, ReplacementFileHelper)
  protected
   function Get_Name: AnsiString;
   procedure Set_Name(const aValue: AnsiString);
   function NeedCheckNSRC: Boolean; override;
  public
   class function Make(aValue: Tl3Tag): ReplacementFileHelper; reintroduce;
 end;//TReplacementFileHelper
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , PlainFile_Const
 , File_Const
 , evNSRCConst
 , l3Base
 , l3Stream
 , SysUtils
 , l3Types
 , ddSegmentScanner
 , StrUtils
 , l3String
 , l3FileUtils
 , l3Const
 , ddNSRCSegments
 , ProcessTask_Const
;

const
 cPicToken = ev_NSRCFormula + 'pic:';
 cObjToken = '!OBJPATH ';
 cTopicToken = '!TOPIC ';
 cObjTopicToken = '!OBJTOPIC ';

class function TAdditionalFilesHelper.Make(aValue: Tl3Tag): AdditionalFilesHelper;
var
 l_Inst : TAdditionalFilesHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAdditionalFilesHelper.Make

procedure TAdditionalFilesHelper.DoAdd(const anItem: AnsiString);
//#UC START# *53EDDCE10317_54B3B12C007B_var*
var
 l_File : Tl3Tag;
//#UC END# *53EDDCE10317_54B3B12C007B_var*
begin
//#UC START# *53EDDCE10317_54B3B12C007B_impl*
 l_File := k2_typPlainFile.MakeTag.AsObject;
 l_File.StrA[k2_attrName] := anItem;
 Value.AddChild(l_File);
//#UC END# *53EDDCE10317_54B3B12C007B_impl*
end;//TAdditionalFilesHelper.DoAdd

function TAdditionalFilesHelper.DoGetStrings(anIndex: Integer): AnsiString;
//#UC START# *53F1FD130157_54B3B12C007B_var*
//#UC END# *53F1FD130157_54B3B12C007B_var*
begin
//#UC START# *53F1FD130157_54B3B12C007B_impl*
 Result := Value.Child[anIndex].StrA[k2_attrName];
//#UC END# *53F1FD130157_54B3B12C007B_impl*
end;//TAdditionalFilesHelper.DoGetStrings

procedure TAdditionalFilesHelper.ChangeName(anIndex: Integer;
 const aValue: AnsiString);
//#UC START# *54B7ABF7033F_54B3B12C007B_var*
//#UC END# *54B7ABF7033F_54B3B12C007B_var*
begin
//#UC START# *54B7ABF7033F_54B3B12C007B_impl*
 Value.Child[anIndex].StrW[k2_attrName, nil] := aValue;
//#UC END# *54B7ABF7033F_54B3B12C007B_impl*
end;//TAdditionalFilesHelper.ChangeName

class function TSourceFilesHelper.Make(aValue: Tl3Tag): SourceFilesHelper;
var
 l_Inst : TSourceFilesHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSourceFilesHelper.Make

function TSourceFilesHelper.NeedCheckNSRC: Boolean;
//#UC START# *54B3C3F4029A_53BFCD060366_var*
//#UC END# *54B3C3F4029A_53BFCD060366_var*
begin
//#UC START# *54B3C3F4029A_53BFCD060366_impl*
 Result := True;
//#UC END# *54B3C3F4029A_53BFCD060366_impl*
end;//TSourceFilesHelper.NeedCheckNSRC

procedure TSourceFilesHelper.CheckNSRC(anIndex: Integer;
 const anItem: AnsiString);
//#UC START# *54B3C6080134_53BFCD060366_var*
var
 l_Stream: Tl3TextStream;
 l_Scanner: TddSegmentScanner;
 l_Folder: AnsiString;
 l_IDX: Integer;
 l_S: Tl3String;
 l_PicPos: Integer;
 l_Text: AnsiString;
 l_ObjFileName: AnsiString;
 l_Checked: Boolean;
//#UC END# *54B3C6080134_53BFCD060366_var*
begin
//#UC START# *54B3C6080134_53BFCD060366_impl*
 if FileExists(anItem) then
 begin
  l_Folder := ExtractFilePath(anItem);
  l_Scanner := TddSegmentScanner.Create;
  try
   l_Stream:= Tl3TextStream.Create(anItem, l3_fmRead);
   try
    l_Checked := False;
    while not l_Stream.IsEOF do
    begin
     l_Text:= l_Stream.GetLine;
     if not l_Checked and (Trim(l_Text) <> '') and not AnsiStartsText(';', l_Text) then
     begin
      l_Checked := True;
      if not AnsiStartsText(cTopicToken, l_Text) and not AnsiStartsText(cObjTopicToken, l_Text) then
       Exit;
     end;
     if AnsiStartsText(cObjToken, l_Text) then
     begin // Теперь осталось скопировать файл с созданием каталога
      l_ObjFileName:= ConcatDirName(l_Folder, Copy(l_Text, Pos(' ', l_Text)+1, Length(l_Text)));
      if FileExists(l_ObjFileName) then
       Get_AdditionalFiles(anIndex).Add(l_ObjFileName)
      else
       l3System.Msg2Log(Format('Файл (%s), указанный в %s отсутствует', [cObjToken, l_ObjFileName]));
     end; // if Pos
     l_PicPos := l3Pos(l3CStr(l_Text), cPicToken);
     if l_PicPos <> l3NotFound then
     begin
      l_S := Tl3String.Make(l3PCharLen(Copy(l_Text, l_PicPos + 1, Length(l_Text))));
      try
       l_Scanner.Scan(l_S, False, #13);
      finally
       FreeAndNil(l_S);
      end;
      for l_IDX := 0 to l_Scanner.Objects.Count - 1 do
       if l_Scanner.Objects[l_IDX] is TsegPicture then
       begin
        l_ObjFileName:= ConcatDirName(l_Folder, TsegPicture(l_Scanner.Objects[l_IDX]).FileName);
        if FileExists(l_ObjFileName) then
         Get_AdditionalFiles(anIndex).Add(l_ObjFileName)
        else
         l3System.Msg2Log(Format('Файл (%s), указанный в Pic: отсутствует', [l_ObjFileName]));
       end;
     end;
    end; // while not l_Stream.IsEOF
   finally
    FreeAndNil(l_Stream);
   end;
  finally
   FreeAndNil(l_Scanner);
  end;
 end
 else
  l3System.Msg2Log(Format('Указанный файл (%s) отсутствует', [anItem]));
//#UC END# *54B3C6080134_53BFCD060366_impl*
end;//TSourceFilesHelper.CheckNSRC

function TSourceFilesHelper.Get_AdditionalFiles(anIndex: Integer): AdditionalFilesHelper;
//#UC START# *54B3BCB10348_53BFCD060366get_var*
//#UC END# *54B3BCB10348_53BFCD060366get_var*
begin
//#UC START# *54B3BCB10348_53BFCD060366get_impl*
 Result := TAdditionalFilesHelper.Make(Value.Child[anIndex].cAtom(k2_attrAdditionalFiles));
//#UC END# *54B3BCB10348_53BFCD060366get_impl*
end;//TSourceFilesHelper.Get_AdditionalFiles

procedure TSourceFilesHelper.DoAdd(const anItem: AnsiString);
//#UC START# *53EDDCE10317_53BFCD060366_var*
var
 l_File : Tl3Tag;
 l_IDX: Integer;
//#UC END# *53EDDCE10317_53BFCD060366_var*
begin
//#UC START# *53EDDCE10317_53BFCD060366_impl*
 l_File := k2_typFile.MakeTag.AsObject;
 l_File.StrA[k2_attrName] := anItem;
 l_IDX := Value.AddChild(l_File);
 if NeedCheckNSRC then
  CheckNSRC(l_IDX, anItem);
//#UC END# *53EDDCE10317_53BFCD060366_impl*
end;//TSourceFilesHelper.DoAdd

class function TTasksListHelper.Make(aValue: Tl3Tag): TasksListHelper;
var
 l_Inst : TTasksListHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TTasksListHelper.Make

function TTasksListHelper.Get_Count: Integer;
//#UC START# *570230A002CB_57022B6800F0get_var*
//#UC END# *570230A002CB_57022B6800F0get_var*
begin
//#UC START# *570230A002CB_57022B6800F0get_impl*
 Result := Value.ChildrenCount;
//#UC END# *570230A002CB_57022B6800F0get_impl*
end;//TTasksListHelper.Get_Count

procedure TTasksListHelper.Add(anItem: TddProcessTask);
//#UC START# *570230C7015F_57022B6800F0_var*
//#UC END# *570230C7015F_57022B6800F0_var*
begin
//#UC START# *570230C7015F_57022B6800F0_impl*
 Value.AddChild(anItem.TaggedData);
//#UC END# *570230C7015F_57022B6800F0_impl*
end;//TTasksListHelper.Add

function TTasksListHelper.MakeTask(anIndex: Integer;
 const aTaskFolder: AnsiString): TddProcessTask;
//#UC START# *570230E803CB_57022B6800F0_var*
//#UC END# *570230E803CB_57022B6800F0_var*
begin
//#UC START# *570230E803CB_57022B6800F0_impl*
 if (Value.ChildrenCount <= 0) then
  Result := nil
 else
  Result := TddProcessTask.MakeFromTaggedData(Value.Child[anIndex], aTaskFolder, False, False) as TddProcessTask;
//#UC END# *570230E803CB_57022B6800F0_impl*
end;//TTasksListHelper.MakeTask

class function TReplacementFileHelper.Make(aValue: Tl3Tag): ReplacementFileHelper;
var
 l_Inst : TReplacementFileHelper;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TReplacementFileHelper.Make

function TReplacementFileHelper.Get_Name: AnsiString;
//#UC START# *53C3A69D00D9_53C3A63C0315get_var*
//#UC END# *53C3A69D00D9_53C3A63C0315get_var*
begin
//#UC START# *53C3A69D00D9_53C3A63C0315get_impl*
 if (Value.ChildrenCount <= 0) then
  Result := ''
 else
  Result := Self.Get_Strings(0);
//#UC END# *53C3A69D00D9_53C3A63C0315get_impl*
end;//TReplacementFileHelper.Get_Name

procedure TReplacementFileHelper.Set_Name(const aValue: AnsiString);
//#UC START# *53C3A69D00D9_53C3A63C0315set_var*
//#UC END# *53C3A69D00D9_53C3A63C0315set_var*
begin
//#UC START# *53C3A69D00D9_53C3A63C0315set_impl*
 if (Get_Name <> aValue) then
 begin
  Value.DeleteChildren;
  Self.Add(aValue);
 end;//Get_Name <> aValue
//#UC END# *53C3A69D00D9_53C3A63C0315set_impl*
end;//TReplacementFileHelper.Set_Name

function TReplacementFileHelper.NeedCheckNSRC: Boolean;
//#UC START# *54B3C3F4029A_53C3A63C0315_var*
//#UC END# *54B3C3F4029A_53C3A63C0315_var*
begin
//#UC START# *54B3C3F4029A_53C3A63C0315_impl*
 Result := False;
//#UC END# *54B3C3F4029A_53C3A63C0315_impl*
end;//TReplacementFileHelper.NeedCheckNSRC
{$IfEnd} // NOT Defined(Nemesis)

end.
