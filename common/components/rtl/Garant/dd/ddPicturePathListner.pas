unit ddPicturePathListner;

// Модуль: "w:\common\components\rtl\Garant\dd\ddPicturePathListner.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddPicturePathListner" MUID: (52F8B15003A7)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3VCLStrings
 , l3ProtoObject
 , l3PicturePathService
;

const
 csPictureSubDir = 'ForPicture';

type
 TddPicturePathService = {final} class(Tl3ProtoObject, Il3PicturePathService)
  public
   procedure SetEnableSave(aValue: Boolean);
   procedure SetPDF4Etalon(aValue: Boolean);
   procedure AddPicturePath(const aPath: AnsiString);
   procedure SetTestName(const aName: AnsiString);
   class function Instance: TddPicturePathService;
    {* Метод получения экземпляра синглетона TddPicturePathService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TddPicturePathService

 TddPicturePathListner = class(Tl3SimpleObject)
  private
   f_PicturePath: Tl3Strings;
   f_PictureID: Integer;
   f_TestName: AnsiString;
    {* Имя текущего теста. }
   f_EnableSave: Boolean;
   f_PDF4Etalon: Boolean;
    {* Если выставлен в True, то генеритя PDF, удобный для сравнения (сжатие отсутствует, вырезаны бинартные потоки, даты создания и модификации зафиксированы). В противном случае, генерятся "настоящие" PDF. }
  private
   function GetUniqPictureName(aForRTF: Boolean): AnsiString;
  protected
   function pm_GetTestName: AnsiString;
   procedure pm_SetTestName(const aValue: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure AddPicturePath(const aPath: AnsiString);
   procedure Clear;
   function PathCount: Integer;
   function GetPath(anIndex: Integer): AnsiString;
   class function Exists: Boolean;
   function GetUniqPictureNameWithPath(aFormat: Integer;
    aForRTF: Boolean): AnsiString;
   function CorrectCVSPath(const aStartPath: AnsiString;
    const aOtherPath: AnsiString): AnsiString;
   class function Instance: TddPicturePathListner;
    {* Метод получения экземпляра синглетона TddPicturePathListner }
  public
   property TestName: AnsiString
    read pm_GetTestName
    write pm_SetTestName;
    {* Имя текущего теста. }
   property EnableSave: Boolean
    read f_EnableSave
    write f_EnableSave;
   property PDF4Etalon: Boolean
    read f_PDF4Etalon
    write f_PDF4Etalon;
    {* Если выставлен в True, то генеритя PDF, удобный для сравнения (сжатие отсутствует, вырезаны бинартные потоки, даты создания и модификации зафиксированы). В противном случае, генерятся "настоящие" PDF. }
 end;//TddPicturePathListner

implementation

uses
 l3ImplUses
 , SysUtils
 , ddConst
 , ddUtils
 , l3Base
;

var g_TddPicturePathService: TddPicturePathService = nil;
 {* Экземпляр синглетона TddPicturePathService }
var g_TddPicturePathListner: TddPicturePathListner = nil;
 {* Экземпляр синглетона TddPicturePathListner }

procedure TddPicturePathServiceFree;
 {* Метод освобождения экземпляра синглетона TddPicturePathService }
begin
 l3Free(g_TddPicturePathService);
end;//TddPicturePathServiceFree

procedure TddPicturePathListnerFree;
 {* Метод освобождения экземпляра синглетона TddPicturePathListner }
begin
 l3Free(g_TddPicturePathListner);
end;//TddPicturePathListnerFree

procedure TddPicturePathService.SetEnableSave(aValue: Boolean);
//#UC START# *4706AFD6D823_5524073901EA_var*
//#UC END# *4706AFD6D823_5524073901EA_var*
begin
//#UC START# *4706AFD6D823_5524073901EA_impl*
 TddPicturePathListner.Instance.EnableSave := aValue;
//#UC END# *4706AFD6D823_5524073901EA_impl*
end;//TddPicturePathService.SetEnableSave

procedure TddPicturePathService.SetPDF4Etalon(aValue: Boolean);
//#UC START# *86EACEE128F2_5524073901EA_var*
//#UC END# *86EACEE128F2_5524073901EA_var*
begin
//#UC START# *86EACEE128F2_5524073901EA_impl*
 TddPicturePathListner.Instance.PDF4Etalon := aValue;
//#UC END# *86EACEE128F2_5524073901EA_impl*
end;//TddPicturePathService.SetPDF4Etalon

procedure TddPicturePathService.AddPicturePath(const aPath: AnsiString);
//#UC START# *3FB12D269858_5524073901EA_var*
//#UC END# *3FB12D269858_5524073901EA_var*
begin
//#UC START# *3FB12D269858_5524073901EA_impl*
 TddPicturePathListner.Instance.AddPicturePath(aPath);
//#UC END# *3FB12D269858_5524073901EA_impl*
end;//TddPicturePathService.AddPicturePath

procedure TddPicturePathService.SetTestName(const aName: AnsiString);
//#UC START# *2DCD42915D2E_5524073901EA_var*
//#UC END# *2DCD42915D2E_5524073901EA_var*
begin
//#UC START# *2DCD42915D2E_5524073901EA_impl*
 TddPicturePathListner.Instance.TestName := aName;
//#UC END# *2DCD42915D2E_5524073901EA_impl*
end;//TddPicturePathService.SetTestName

class function TddPicturePathService.Instance: TddPicturePathService;
 {* Метод получения экземпляра синглетона TddPicturePathService }
begin
 if (g_TddPicturePathService = nil) then
 begin
  l3System.AddExitProc(TddPicturePathServiceFree);
  g_TddPicturePathService := Create;
 end;
 Result := g_TddPicturePathService;
end;//TddPicturePathService.Instance

class function TddPicturePathService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TddPicturePathService <> nil;
end;//TddPicturePathService.Exists

function TddPicturePathListner.pm_GetTestName: AnsiString;
//#UC START# *53354774005B_52F8B15003A7get_var*
//#UC END# *53354774005B_52F8B15003A7get_var*
begin
//#UC START# *53354774005B_52F8B15003A7get_impl*
 Result := f_TestName;
//#UC END# *53354774005B_52F8B15003A7get_impl*
end;//TddPicturePathListner.pm_GetTestName

procedure TddPicturePathListner.pm_SetTestName(const aValue: AnsiString);
//#UC START# *53354774005B_52F8B15003A7set_var*
//#UC END# *53354774005B_52F8B15003A7set_var*
begin
//#UC START# *53354774005B_52F8B15003A7set_impl*
 f_TestName := aValue;
//#UC END# *53354774005B_52F8B15003A7set_impl*
end;//TddPicturePathListner.pm_SetTestName

procedure TddPicturePathListner.AddPicturePath(const aPath: AnsiString);
//#UC START# *52F8B4E801C7_52F8B15003A7_var*
//#UC END# *52F8B4E801C7_52F8B15003A7_var*
begin
//#UC START# *52F8B4E801C7_52F8B15003A7_impl*
 if f_PicturePath = nil then
  f_PicturePath := Tl3Strings.MakeSorted;
 f_PicturePath.Add(aPath);
//#UC END# *52F8B4E801C7_52F8B15003A7_impl*
end;//TddPicturePathListner.AddPicturePath

procedure TddPicturePathListner.Clear;
//#UC START# *52F8B512004B_52F8B15003A7_var*
//#UC END# *52F8B512004B_52F8B15003A7_var*
begin
//#UC START# *52F8B512004B_52F8B15003A7_impl*
 f_PictureID := 0;
 f_EnableSave := False;
 f_PDF4Etalon :=False;
 if f_PicturePath <> nil then
  f_PicturePath.Clear;
//#UC END# *52F8B512004B_52F8B15003A7_impl*
end;//TddPicturePathListner.Clear

function TddPicturePathListner.PathCount: Integer;
//#UC START# *52F8B5270128_52F8B15003A7_var*
//#UC END# *52F8B5270128_52F8B15003A7_var*
begin
//#UC START# *52F8B5270128_52F8B15003A7_impl*
 Result := 0;
 if f_PicturePath <> nil then
  Result := f_PicturePath.Count;
//#UC END# *52F8B5270128_52F8B15003A7_impl*
end;//TddPicturePathListner.PathCount

function TddPicturePathListner.GetPath(anIndex: Integer): AnsiString;
//#UC START# *52F8B54903AD_52F8B15003A7_var*
//#UC END# *52F8B54903AD_52F8B15003A7_var*
begin
//#UC START# *52F8B54903AD_52F8B15003A7_impl*
 if f_PicturePath = nil then
  Result := ''
 else
  Result := f_PicturePath.Items[anIndex].AsString;
//#UC END# *52F8B54903AD_52F8B15003A7_impl*
end;//TddPicturePathListner.GetPath

class function TddPicturePathListner.Exists: Boolean;
begin
 Result := g_TddPicturePathListner <> nil;
end;//TddPicturePathListner.Exists

function TddPicturePathListner.GetUniqPictureName(aForRTF: Boolean): AnsiString;
//#UC START# *534BB10401D6_52F8B15003A7_var*
const
 carPictName: array [Boolean] of AnsiString = ('EvdPict%d', 'RtfPict%d');
//#UC END# *534BB10401D6_52F8B15003A7_var*
begin
//#UC START# *534BB10401D6_52F8B15003A7_impl*
 Result := Format(carPictName[aForRTF], [f_PictureID]);
 Inc(f_PictureID);
//#UC END# *534BB10401D6_52F8B15003A7_impl*
end;//TddPicturePathListner.GetUniqPictureName

function TddPicturePathListner.GetUniqPictureNameWithPath(aFormat: Integer;
 aForRTF: Boolean): AnsiString;
//#UC START# *53733795015A_52F8B15003A7_var*
//#UC END# *53733795015A_52F8B15003A7_var*
begin
//#UC START# *53733795015A_52F8B15003A7_impl*
 Result := GetOutputDirName4Test('', csPictureSubDir, TestName) + '\' + GetUniqPictureName(aForRTF) + PictExt[aFormat];
//#UC END# *53733795015A_52F8B15003A7_impl*
end;//TddPicturePathListner.GetUniqPictureNameWithPath

function TddPicturePathListner.CorrectCVSPath(const aStartPath: AnsiString;
 const aOtherPath: AnsiString): AnsiString;
//#UC START# *537DD7740336_52F8B15003A7_var*
//#UC END# *537DD7740336_52F8B15003A7_var*
begin
//#UC START# *537DD7740336_52F8B15003A7_impl*
 if Pos(csPictureSubDir, aOtherPath) > 0 then
  Result := GetOutputDirName4Test(aStartPath, csPictureSubDir, TestName)
 else
  Result := GetOutputDirName4Test(aStartPath, '', TestName);
//#UC END# *537DD7740336_52F8B15003A7_impl*
end;//TddPicturePathListner.CorrectCVSPath

class function TddPicturePathListner.Instance: TddPicturePathListner;
 {* Метод получения экземпляра синглетона TddPicturePathListner }
begin
 if (g_TddPicturePathListner = nil) then
 begin
  l3System.AddExitProc(TddPicturePathListnerFree);
  g_TddPicturePathListner := Create;
 end;
 Result := g_TddPicturePathListner;
end;//TddPicturePathListner.Instance

procedure TddPicturePathListner.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52F8B15003A7_var*
//#UC END# *479731C50290_52F8B15003A7_var*
begin
//#UC START# *479731C50290_52F8B15003A7_impl*
 l3Free(f_PicturePath);
 f_EnableSave := False;
 f_PDF4Etalon := False;
//#UC END# *479731C50290_52F8B15003A7_impl*
end;//TddPicturePathListner.Cleanup

procedure TddPicturePathListner.ClearFields;
begin
 TestName := '';
 inherited;
end;//TddPicturePathListner.ClearFields

initialization
 Tl3PicturePathService.Instance.Alien := TddPicturePathService.Instance;
 {* Регистрация TddPicturePathService }

end.
