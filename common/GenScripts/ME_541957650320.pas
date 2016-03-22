unit DataBaseTester;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\DataBaseTester.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TDataBaseTester" MUID: (541957650320)

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Classes
 , m3DBInterfaces
;

type
 TDataBaseTester = class(TThread)
  private
   f_DataPath: AnsiString;
   f_BasePath: AnsiString;
  private
   procedure DoBase(const aDB: Im3DB);
  protected
   procedure Execute; override;
  public
   constructor Create(CreateSuspended: Boolean;
    const aDataPath: AnsiString;
    const aBaseName: AnsiString); reintroduce;
 end;//TDataBaseTester
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , m3StorageInterfaces
 , l3Stream
 , l3FileUtils
 , m3DB
 , l3Base
;

constructor TDataBaseTester.Create(CreateSuspended: Boolean;
 const aDataPath: AnsiString;
 const aBaseName: AnsiString);
//#UC START# *541FFFCB03B7_541957650320_var*
//#UC END# *541FFFCB03B7_541957650320_var*
begin
//#UC START# *541FFFCB03B7_541957650320_impl*
 inherited Create(CreateSuspended);
 f_DataPath := aDataPath;
 f_BasePath := aBaseName;
//#UC END# *541FFFCB03B7_541957650320_impl*
end;//TDataBaseTester.Create

procedure TDataBaseTester.DoBase(const aDB: Im3DB);
//#UC START# *542003B40317_541957650320_var*

  procedure MakeCopy(const anIn : IStream; const anOut : IStream);
  var
   l_Read : Int64;
   l_Written : Int64;
  begin//MakeCopy
   if not (anIn.CopyTo(anOut, High(Int64), l_Read, l_Written) = S_OK) then
    Assert(false);
   Assert(l_Read = l_Written);
  end;//MakeCopy

var
 l_Index : Integer;

 function DocStream(anAccess : Tm3StoreAccess) : IStream;
 var
  l_Doc : Im3DBDocument;
 begin//DocStream
  l_Doc := aDB.GetDocument(l_Index);
  try
   Result := l_Doc.Open(anAccess);
  finally
   l_Doc := nil;
  end;//try..finally
  l_Index := l_Index + 2;
 end;//DocStream

 function DoFile(const aFileName: string): Boolean;
 var
  l_SOut : IStream;
  l_SIn  : Tl3NamedFileStream;
 begin//DoFile
  Result := true;
  l_SOut := DocStream(m3_saReadWrite);
  try
   l_SIn := Tl3NamedFileStream.Create(aFileName, l3_fmRead);
   try
    MakeCopy(l_SIn, l_SOut);
   finally
    FreeAndNil(l_SIn);
   end;//try..finally
  finally
   l_SOut := nil;
  end;//try..finally
 end;//DoFile

var
 l_Folder : String;
 
 procedure ProcessFilesF(var aProc : Pointer);
 const
  cMask = '*';
 begin//ProcessFilesF
  try
   ProcessFilesWithMask(l_Folder, cMask, TFileProcessingFunc(aProc));
  finally
   l3FreeLocalStub(aProc);
  end;//try..finally
 end;//ProcessFilesF

var
 i           : Integer;
 l_DB        : Im3DB;
 l_FPStub    : Pointer;
 l_DBName    : String;
 l_DBNameNew : String;
//#UC END# *542003B40317_541957650320_var*
begin
//#UC START# *542003B40317_541957650320_impl*
 l_Folder := f_DataPath;
 l_Index := 1;
 for i := 0 to 1000 do
 begin
  l_FPStub := l3LocalStub(@DoFile);
  ProcessFilesF(l_FPStub);
 end; // for i := 0 to 1000 do
 aDB.Update;
//#UC END# *542003B40317_541957650320_impl*
end;//TDataBaseTester.DoBase

procedure TDataBaseTester.Execute;
//#UC START# *4FFFDF740099_541957650320_var*
var
 l_DB: Im3DB;
//#UC END# *4FFFDF740099_541957650320_var*
begin
//#UC START# *4FFFDF740099_541957650320_impl*
 l_DB := Tm3DB.Make(f_BasePath);
 try
  l_DB.Start(m3_saReadWrite);
  try
   DoBase(l_DB);
  finally
   l_DB.Finish;
  end;//try..finally
 finally
  l_DB := nil;
 end;//try..finally
//#UC END# *4FFFDF740099_541957650320_impl*
end;//TDataBaseTester.Execute
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
