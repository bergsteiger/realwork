unit atFileIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atFileIterator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatFileIterator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  SysUtils,
  Contnrs,
  Masks
  ;

type
 TatFileIteratorBase = {abstract} class(TObject)
 protected
 // property methods
   function pm_GetAtEnd: Boolean; virtual; abstract;
   function pm_GetName: AnsiString; virtual; abstract;
   function pm_GetFullPath: AnsiString; virtual; abstract;
 public
 // public methods
   procedure MoveNext; virtual; abstract;
 public
 // public properties
   property AtEnd: Boolean
     read pm_GetAtEnd;
   property Name: AnsiString
     read pm_GetName;
   property FullPath: AnsiString
     read pm_GetFullPath;
 end;//TatFileIteratorBase

 TatSimpleFileIterator = class(TatFileIteratorBase)
 private
 // private fields
   f_FindRes : Integer;
   f_SearchRec : TSearchRec;
   f_Folder : AnsiString;
 private
 // private methods
   procedure SkipDots; virtual;
 protected
 // property methods
   function pm_GetIsFolder: Boolean; virtual;
 protected
 // realized methods
   function pm_GetAtEnd: Boolean; override;
   procedure MoveNext; override;
   function pm_GetName: AnsiString; override;
   function pm_GetFullPath: AnsiString; override;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(const aFolder: AnsiString;
    const aFileMask: AnsiString;
    const anAttrs: Integer); reintroduce; virtual;
 public
 // public properties
   property IsFolder: Boolean
     read pm_GetIsFolder;
 end;//TatSimpleFileIterator

 TatFileIterator = class(TatFileIteratorBase)
 private
 // private fields
   f_Attrs : Integer;
   f_InFolderIterators : TStack;
   f_Mask : TMask;
 private
 // private methods
   function IsOnGoodFile: Boolean; virtual;
 protected
 // property methods
   function pm_GetCurrent: TatSimpleFileIterator; virtual;
 protected
 // realized methods
   function pm_GetAtEnd: Boolean; override;
   procedure MoveNext; override;
   function pm_GetName: AnsiString; override;
   function pm_GetFullPath: AnsiString; override;
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(const aFolder: AnsiString;
    const aFileMask: AnsiString;
    const isRecursive: Boolean = true;
    const anAttributes: Integer = 0); reintroduce;
 private
 // private properties
   property Current: TatSimpleFileIterator
     read pm_GetCurrent;
 end;//TatFileIterator

implementation

// start class TatSimpleFileIterator

function TatSimpleFileIterator.pm_GetIsFolder: Boolean;
//#UC START# *50254F360175_50254F1703A1get_var*
//#UC END# *50254F360175_50254F1703A1get_var*
begin
//#UC START# *50254F360175_50254F1703A1get_impl*
  Result := (f_SearchRec.Attr AND faDirectory) = faDirectory;
//#UC END# *50254F360175_50254F1703A1get_impl*
end;//TatSimpleFileIterator.pm_GetIsFolder

constructor TatSimpleFileIterator.Create(const aFolder: AnsiString;
  const aFileMask: AnsiString;
  const anAttrs: Integer);
//#UC START# *50254F49027D_50254F1703A1_var*
//#UC END# *50254F49027D_50254F1703A1_var*
begin
//#UC START# *50254F49027D_50254F1703A1_impl*
  f_Folder := IncludeTrailingPathDelimiter(aFolder);
  f_FindRes := FindFirst(f_Folder + aFileMask, anAttrs, f_SearchRec);
  SkipDots;
//#UC END# *50254F49027D_50254F1703A1_impl*
end;//TatSimpleFileIterator.Create

procedure TatSimpleFileIterator.SkipDots;
//#UC START# *5025503C0123_50254F1703A1_var*
//#UC END# *5025503C0123_50254F1703A1_var*
begin
//#UC START# *5025503C0123_50254F1703A1_impl*
  if (NOT AtEnd) AND ((Name  = '.') OR (Name = '..')) then
    MoveNext;
//#UC END# *5025503C0123_50254F1703A1_impl*
end;//TatSimpleFileIterator.SkipDots

function TatSimpleFileIterator.pm_GetAtEnd: Boolean;
//#UC START# *50254E83033D_50254F1703A1get_var*
//#UC END# *50254E83033D_50254F1703A1get_var*
begin
//#UC START# *50254E83033D_50254F1703A1get_impl*
  Result := f_FindRes <> 0;
//#UC END# *50254E83033D_50254F1703A1get_impl*
end;//TatSimpleFileIterator.pm_GetAtEnd

procedure TatSimpleFileIterator.MoveNext;
//#UC START# *50254EA30348_50254F1703A1_var*
//#UC END# *50254EA30348_50254F1703A1_var*
begin
//#UC START# *50254EA30348_50254F1703A1_impl*
  f_FindRes := FindNext(f_SearchRec);
  SkipDots;
//#UC END# *50254EA30348_50254F1703A1_impl*
end;//TatSimpleFileIterator.MoveNext

function TatSimpleFileIterator.pm_GetName: AnsiString;
//#UC START# *50254EBC0127_50254F1703A1get_var*
//#UC END# *50254EBC0127_50254F1703A1get_var*
begin
//#UC START# *50254EBC0127_50254F1703A1get_impl*
  Result := f_SearchRec.Name;
//#UC END# *50254EBC0127_50254F1703A1get_impl*
end;//TatSimpleFileIterator.pm_GetName

function TatSimpleFileIterator.pm_GetFullPath: AnsiString;
//#UC START# *50254EC702DF_50254F1703A1get_var*
//#UC END# *50254EC702DF_50254F1703A1get_var*
begin
//#UC START# *50254EC702DF_50254F1703A1get_impl*
  Result := f_Folder + Name;
//#UC END# *50254EC702DF_50254F1703A1get_impl*
end;//TatSimpleFileIterator.pm_GetFullPath

destructor TatSimpleFileIterator.Destroy;
//#UC START# *48077504027E_50254F1703A1_var*
//#UC END# *48077504027E_50254F1703A1_var*
begin
//#UC START# *48077504027E_50254F1703A1_impl*
  FindClose(f_SearchRec);
  inherited;
//#UC END# *48077504027E_50254F1703A1_impl*
end;//TatSimpleFileIterator.Destroy

function TatFileIterator.pm_GetCurrent: TatSimpleFileIterator;
//#UC START# *50255BD201D0_50254E240133get_var*
//#UC END# *50255BD201D0_50254E240133get_var*
begin
//#UC START# *50255BD201D0_50254E240133get_impl*
  Result := f_InFolderIterators.Peek;
//#UC END# *50255BD201D0_50254E240133get_impl*
end;//TatFileIterator.pm_GetCurrent

constructor TatFileIterator.Create(const aFolder: AnsiString;
  const aFileMask: AnsiString;
  const isRecursive: Boolean = true;
  const anAttributes: Integer = 0);
//#UC START# *50255C38035F_50254E240133_var*
//#UC END# *50255C38035F_50254E240133_var*
begin
//#UC START# *50255C38035F_50254E240133_impl*
  f_InFolderIterators := TStack.Create;

  if aFileMask <> '*' then
    f_Mask := TMask.Create(aFileMask)
  else
    f_Mask := nil;

  f_Attrs := anAttributes;
  if isRecursive then
    f_Attrs := f_Attrs or faDirectory;

  f_InFolderIterators.Push( TatSimpleFileIterator.Create(aFolder, '*', f_Attrs) ); // ����������� �� ����� ����� ����� � ������ �����
  if NOT IsOnGoodFile then
    MoveNext;
//#UC END# *50255C38035F_50254E240133_impl*
end;//TatFileIterator.Create

function TatFileIterator.IsOnGoodFile: Boolean;
//#UC START# *502B8CA80171_50254E240133_var*
//#UC END# *502B8CA80171_50254E240133_var*
begin
//#UC START# *502B8CA80171_50254E240133_impl*
  Result := (NOT Current.AtEnd) AND (NOT Current.IsFolder) AND ((f_Mask = nil) OR f_Mask.Matches(Current.Name));
//#UC END# *502B8CA80171_50254E240133_impl*
end;//TatFileIterator.IsOnGoodFile

function TatFileIterator.pm_GetAtEnd: Boolean;
//#UC START# *50254E83033D_50254E240133get_var*
//#UC END# *50254E83033D_50254E240133get_var*
begin
//#UC START# *50254E83033D_50254E240133get_impl*
  Result := (f_InFolderIterators.Count = 1) AND Current.AtEnd;
//#UC END# *50254E83033D_50254E240133get_impl*
end;//TatFileIterator.pm_GetAtEnd

procedure TatFileIterator.MoveNext;
//#UC START# *50254EA30348_50254E240133_var*
//#UC END# *50254EA30348_50254E240133_var*
begin
//#UC START# *50254EA30348_50254E240133_impl*
  repeat
    if Current.AtEnd then // ������� �� ��������� ������������� ����� � ��������� � ���������� ��������
      while Current.AtEnd AND (f_InFolderIterators.Count > 1) do
      begin
        Current.Free;
        f_InFolderIterators.Pop;
        Current.MoveNext;
      end
    else if Current.IsFolder then // ������� � ����� ���� �� ���������� ����
      while (NOT Current.AtEnd) AND Current.IsFolder do
        f_InFolderIterators.Push( TatSimpleFileIterator.Create(Current.FullPath, '*', f_Attrs) )
    else
      Current.MoveNext;
  until AtEnd OR IsOnGoodFile;
//#UC END# *50254EA30348_50254E240133_impl*
end;//TatFileIterator.MoveNext

function TatFileIterator.pm_GetName: AnsiString;
//#UC START# *50254EBC0127_50254E240133get_var*
//#UC END# *50254EBC0127_50254E240133get_var*
begin
//#UC START# *50254EBC0127_50254E240133get_impl*
  Result := Current.Name;
//#UC END# *50254EBC0127_50254E240133get_impl*
end;//TatFileIterator.pm_GetName

function TatFileIterator.pm_GetFullPath: AnsiString;
//#UC START# *50254EC702DF_50254E240133get_var*
//#UC END# *50254EC702DF_50254E240133get_var*
begin
//#UC START# *50254EC702DF_50254E240133get_impl*
  Result := Current.FullPath;
//#UC END# *50254EC702DF_50254E240133get_impl*
end;//TatFileIterator.pm_GetFullPath

destructor TatFileIterator.Destroy;
//#UC START# *48077504027E_50254E240133_var*
//#UC END# *48077504027E_50254E240133_var*
begin
//#UC START# *48077504027E_50254E240133_impl*
  while f_InFolderIterators.Count > 0 do
    TObject(f_InFolderIterators.Pop).Free;
  FreeAndNil(f_InFolderIterators);
  FreeAndNil(f_Mask);
  inherited;
//#UC END# *48077504027E_50254E240133_impl*
end;//TatFileIterator.Destroy

end.