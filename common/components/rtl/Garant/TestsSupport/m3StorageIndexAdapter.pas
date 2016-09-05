unit m3StorageIndexAdapter;

// Модуль: "w:\common\components\rtl\Garant\TestsSupport\m3StorageIndexAdapter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StorageIndexAdapter" MUID: (4F19108601F3)

{$Include w:\common\components\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , SysUtils
 , l3Types
;

type
 Tm3StorageIndexAdapter = class(Tl3ProtoObject)
  private
   f_BaseName: TFileName;
   f_DirName: TFileName;
   {$If NOT Defined(nsTest)}
   f_PhaseStr: AnsiString;
   {$IfEnd} // NOT Defined(nsTest)
  protected
   procedure ClearFields; override;
  public
   procedure DoBuildIndex(aFilesMeter: Tl3ProgressProc);
   class function Instance: Tm3StorageIndexAdapter;
    {* Метод получения экземпляра синглетона Tm3StorageIndexAdapter }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property BaseName: TFileName
    read f_BaseName
    write f_BaseName;
   property DirName: TFileName
    read f_DirName
    write f_DirName;
   {$If NOT Defined(nsTest)}
   property PhaseStr: AnsiString
    read f_PhaseStr;
   {$IfEnd} // NOT Defined(nsTest)
 end;//Tm3StorageIndexAdapter

implementation

uses
 l3ImplUses
 , m4DBInterfaces
 , m4DB
 , l3FileUtils
 , m3StorageInterfaces
 , l3Base
 //#UC START# *4F19108601F3impl_uses*
 //#UC END# *4F19108601F3impl_uses*
;

var g_Tm3StorageIndexAdapter: Tm3StorageIndexAdapter = nil;
 {* Экземпляр синглетона Tm3StorageIndexAdapter }

procedure Tm3StorageIndexAdapterFree;
 {* Метод освобождения экземпляра синглетона Tm3StorageIndexAdapter }
begin
 l3Free(g_Tm3StorageIndexAdapter);
end;//Tm3StorageIndexAdapterFree

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
  //l_DB.Start(m3_saReadWrite);
  l_DB.Start(m3_saRead);
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

class function Tm3StorageIndexAdapter.Instance: Tm3StorageIndexAdapter;
 {* Метод получения экземпляра синглетона Tm3StorageIndexAdapter }
begin
 if (g_Tm3StorageIndexAdapter = nil) then
 begin
  l3System.AddExitProc(Tm3StorageIndexAdapterFree);
  g_Tm3StorageIndexAdapter := Create;
 end;
 Result := g_Tm3StorageIndexAdapter;
end;//Tm3StorageIndexAdapter.Instance

class function Tm3StorageIndexAdapter.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tm3StorageIndexAdapter <> nil;
end;//Tm3StorageIndexAdapter.Exists

procedure Tm3StorageIndexAdapter.ClearFields;
begin
 BaseName := '';
 DirName := '';
{$If NOT Defined(nsTest)}
 f_PhaseStr := '';
{$IfEnd} // NOT Defined(nsTest)
 inherited;
end;//Tm3StorageIndexAdapter.ClearFields

end.
