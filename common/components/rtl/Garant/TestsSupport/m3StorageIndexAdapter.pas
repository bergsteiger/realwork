unit m3StorageIndexAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TestsSupport"
// ������: "w:/common/components/rtl/Garant/TestsSupport/m3StorageIndexAdapter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::TestsSupport::m3TetsSupport::Tm3StorageIndexAdapter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\l3Define.inc}

interface

uses
  l3Types,
  SysUtils,
  l3ProtoObject
  ;

type
 Tm3StorageIndexAdapter = class(Tl3ProtoObject)
 private
 // private fields
   f_BaseName : TFileName;
    {* ���� ��� �������� BaseName}
   f_DirName : TFileName;
    {* ���� ��� �������� DirName}
  {$If not defined(nsTest)}
   f_PhaseStr : AnsiString;
    {* ���� ��� �������� PhaseStr}
  {$IfEnd} //not nsTest
 protected
 // property methods
   {$If not defined(nsTest)}

   {$IfEnd} //not nsTest
 public
 // public methods
   procedure DoBuildIndex(aFilesMeter: Tl3ProgressProc);
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // public properties
   property BaseName: TFileName
     read f_BaseName
     write f_BaseName;
   property DirName: TFileName
     read f_DirName
     write f_DirName;
   {$If not defined(nsTest)}
   property PhaseStr: AnsiString
     read f_PhaseStr;
   {$IfEnd} //not nsTest
 public
 // singleton factory method
   class function Instance: Tm3StorageIndexAdapter;
    {- ���������� ��������� ����������. }
 end;//Tm3StorageIndexAdapter

implementation

uses
  l3Base {a},
  m4DBInterfaces,
  m4DB,
  l3FileUtils,
  m3StorageInterfaces
  ;


// start class Tm3StorageIndexAdapter

var g_Tm3StorageIndexAdapter : Tm3StorageIndexAdapter = nil;

procedure Tm3StorageIndexAdapterFree;
begin
 l3Free(g_Tm3StorageIndexAdapter);
end;

class function Tm3StorageIndexAdapter.Instance: Tm3StorageIndexAdapter;
begin
 if (g_Tm3StorageIndexAdapter = nil) then
 begin
  l3System.AddExitProc(Tm3StorageIndexAdapterFree);
  g_Tm3StorageIndexAdapter := Create;
 end;
 Result := g_Tm3StorageIndexAdapter;
end;


procedure Tm3StorageIndexAdapter.DoBuildIndex(aFilesMeter: Tl3ProgressProc);
//#UC START# *4F191143015F_4F19108601F3_var*
var
 l_DB : Im4DB;
//#UC END# *4F191143015F_4F19108601F3_var*
begin
//#UC START# *4F191143015F_4F19108601F3_impl*
 l_DB := Tm4DB.Make(ConcatDirName(f_DirName, f_BaseName),
                     //cbMakeCopy.Checked AND cbFromOld.Checked,
                     nil,//Yield,
                     nil,//FileMeter.ProgressProc_ev,
                     aFilesMeter,//FilesMeter.ProgressProc_ev,
                     nil,//FilesProcessed,
                     nil //lProgressor.FilesProcessedExProc//FilesProcessedEx
                     );

 try
  l_DB.Start(m3_saReadWrite);
  try
   {$IFNDEF nsTest}
   f_PhaseStr := 'Build index: %d/%d';
   {$ENDIF nsTest}   
   try
    l_DB.UpdateIndex;
   except
    on E : Exception do
    begin
     {$IFNDEF nsTest}
     Writeln('Exceptions : ' + E.Message);
     {$ENDIF nsTest}
     l3System.Exception2Log(E);
    end;
   end;
  finally
   l_DB.Finish;
  end;//try..finally
 finally
  l_DB := nil;
 end;//try..finally
//#UC END# *4F191143015F_4F19108601F3_impl*
end;//Tm3StorageIndexAdapter.DoBuildIndex

class function Tm3StorageIndexAdapter.Exists: Boolean;
 {-}
begin
 Result := g_Tm3StorageIndexAdapter <> nil;
end;//Tm3StorageIndexAdapter.Exists

end.