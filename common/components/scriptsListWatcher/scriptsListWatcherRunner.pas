unit scriptsListWatcherRunner;

// ������: "w:\common\components\scriptsListWatcher\scriptsListWatcherRunner.pas"
// ���������: "SimpleClass"
// ������� ������: "TscriptsListWatcherRunner" MUID: (568140E2020B)

{$Include w:\common\components\scriptsListWatcher\scriptsListWatcher.inc}

interface

uses
 l3IntfUses
;

type
 TscriptsListWatcherRunner = class
  public
   class procedure Run;
 end;//TscriptsListWatcherRunner

implementation

uses
 l3ImplUses
 , l3Filer
 , l3Types
 , l3FileUtils
 , l3Base
 , SysUtils
 , l3String
 , Classes
 , Windows
 //#UC START# *568140E2020Bimpl_uses*
 //#UC END# *568140E2020Bimpl_uses*
;

class procedure TscriptsListWatcherRunner.Run;
//#UC START# *5681410002A8_568140E2020B_var*
const
 cSleep = 500;
var
 l_N : String;
 l_C : String;
 l_Num : Int64;

 procedure ProcessList;
 var
  l_In : Tl3CustomDosFiler;
  l_OutN : String;
  l_Out : Tl3CustomDosFiler;
  l_S : String;
 begin
  l_In := Tl3CustomDosFiler.Make(l_N, l3_fmExclusiveReadWrite, false);
  try
   l_In.Open;
   try
    Inc(l_Num);
    l_OutN := l_N + '.' + IntToStr(l_Num) + '.do.tmp';
    l_Out := Tl3CustomDosFiler.Make(l_OutN, l3_fmExclusiveWrite, false);
    try
     l_Out.Open;
     try
      while not l_In.EOF do
      begin
       l_S := l3Str(l_In.ReadLn);
       if (l_S <> '') then
        l_Out.WriteLn(l_S);
      end;//while not l_In.EOF
     finally
      l_Out.Close;
     end;//try..finally
    finally
     FreeAndNil(l_Out);
    end;//try..finally
    l_In.Stream.Seek(0, soBeginning);
    l_In.Stream.Size := 0;
    FreeAndNil(l_In);
    Sleep(cSleep);
    l_OutN := l_C + ' -list:' + l_OutN + ' ' + l_OutN;
    Windows.WinExec(PAnsiChar(l_OutN), {SW_HIDE}SW_SHOWNORMAL);
   finally
    l_In.Close;
   end;//try..finally
  finally
   FreeAndNil(l_In);
  end;//try..finally
  Sleep(2 * cSleep);
 end;//ProcessList

var
 l_FileSize : Int64;
 l_NewFileSize : Int64;
//#UC END# *5681410002A8_568140E2020B_var*
begin
//#UC START# *5681410002A8_568140E2020B_impl*
 l_N := ParamStr(1);
 if (l_N = '') then
  Exit;
 l_C := ParamStr(2);
 if (l_C = '') then
  Exit;
 l_Num := 0;
 while true do
 begin
  if FileExists(l_N) then
  begin
   l_FileSize := l3FileUtils.GetFileSize(l_N);
   if (l_FileSize > 0) then
   begin
    Sleep(2 * cSleep * 3);
    while true do
    // - ������ ����, ���� ���� �����
    begin
     l_NewFileSize := l3FileUtils.GetFileSize(l_N);
     if (l_NewFileSize <= l_FileSize) then
      break;
     Sleep(cSleep);
     l_FileSize := l_NewFileSize;
    end;//while true
    ProcessList;
    Sleep(2 * cSleep * 3);
   end;//GetFileSize(l_N) > 0
  end;//FileExists(l_N)
  Sleep(10 * cSleep);
 end;//while true
//#UC END# *5681410002A8_568140E2020B_impl*
end;//TscriptsListWatcherRunner.Run

end.
