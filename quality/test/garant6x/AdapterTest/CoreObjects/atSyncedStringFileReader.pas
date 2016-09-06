unit atSyncedStringFileReader;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atSyncedStringFileReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSyncedStringFileReader" MUID: (502A4763011B)

interface

uses
 l3IntfUses
 , atStringFileReader
 , atLockFile
;

type
 TatSyncedStringFileReader = class(TatStringFileReader)
  private
   f_LockFile: TatLockFile;
   f_SyncFile: AnsiString;
  public
   constructor Create(const aStringFile: AnsiString;
    const aSyncFile: AnsiString); reintroduce; virtual;
   destructor Destroy; override;
   function AcquireNext(out theString: AnsiString): Boolean; override;
   procedure Reset; override;
 end;//TatSyncedStringFileReader

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *502A4763011Bimpl_uses*
 //#UC END# *502A4763011Bimpl_uses*
;

constructor TatSyncedStringFileReader.Create(const aStringFile: AnsiString;
 const aSyncFile: AnsiString);
//#UC START# *502A49CD0158_502A4763011B_var*
//#UC END# *502A49CD0158_502A4763011B_var*
begin
//#UC START# *502A49CD0158_502A4763011B_impl*
  inherited Create(aStringFile);
  //
  f_SyncFile := aSyncFile;
  f_LockFile := TatLockFile.Create(f_SyncFile + '.lock_file');

  if f_LockFile.Acquire then
  try
    if FileExists(f_SyncFile) then
    begin
      f_StringsUsage.LoadFromFile(f_SyncFile);
      if f_StringsUsage.Size <> f_Strings.Count then // если файл со строками поменялся между запусками
        f_StringsUsage.Size := f_Strings.Count;
    end;  
    f_StringsUsage.SaveToFile(f_SyncFile);
  finally
    f_LockFile.Release;
  end;
//#UC END# *502A49CD0158_502A4763011B_impl*
end;//TatSyncedStringFileReader.Create

destructor TatSyncedStringFileReader.Destroy;
//#UC START# *48077504027E_502A4763011B_var*
//#UC END# *48077504027E_502A4763011B_var*
begin
//#UC START# *48077504027E_502A4763011B_impl*
  FreeAndNil(f_LockFile);
  //
  inherited;
//#UC END# *48077504027E_502A4763011B_impl*
end;//TatSyncedStringFileReader.Destroy

function TatSyncedStringFileReader.AcquireNext(out theString: AnsiString): Boolean;
//#UC START# *502A459F005A_502A4763011B_var*
//#UC END# *502A459F005A_502A4763011B_var*
begin
//#UC START# *502A459F005A_502A4763011B_impl*
  Result := false;
  //
  if f_LockFile.Acquire then
  try
    f_StringsUsage.LoadFromFile(f_SyncFile);

    Result := inherited AcquireNext(theString);

    if Result then
      f_StringsUsage.SaveToFile(f_SyncFile);
  finally
    f_LockFile.Release;
  end;
//#UC END# *502A459F005A_502A4763011B_impl*
end;//TatSyncedStringFileReader.AcquireNext

procedure TatSyncedStringFileReader.Reset;
//#UC START# *502AACD103A6_502A4763011B_var*
//#UC END# *502AACD103A6_502A4763011B_var*
begin
//#UC START# *502AACD103A6_502A4763011B_impl*
  if f_LockFile.Acquire then
  try
    f_StringsUsage.LoadFromFile(f_SyncFile);
    inherited Reset;
    f_StringsUsage.SaveToFile(f_SyncFile);    
  finally
    f_LockFile.Release;
  end;
//#UC END# *502AACD103A6_502A4763011B_impl*
end;//TatSyncedStringFileReader.Reset

end.
