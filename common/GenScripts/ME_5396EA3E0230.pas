unit atOperationEnv;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atOperationEnv.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatOperationEnv" MUID: (5396EA3E0230)

interface

uses
 l3IntfUses
 , Classes
;

const
 ENV_CURRENT_FILE_PATH: AnsiString = '%CURRENT_FILE_PATH%';
 ENV_CURRENT_FILE_DIR: AnsiString = '%CURRENT_FILE_DIR%';
 ENV_CURRENT_FILE_NAME: AnsiString = '%CURRENT_FILE_NAME%';
 ENV_F1_USER_NAME: AnsiString = '%F1_USER_NAME%';

type
 TatOperationEnv = class(TObject)
  private
   f_VarList: TStringList;
  protected
   function pm_GetEnvVar(const aName: AnsiString): AnsiString;
   procedure pm_SetEnvVar(const aName: AnsiString;
    const aValue: AnsiString);
  public
   function ExpandString(const aString: AnsiString): AnsiString; virtual;
   constructor Create; reintroduce;
   class function Instance: TatOperationEnv;
    {* Метод получения экземпляра синглетона TatOperationEnv }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   destructor Destroy; override;
  public
   property EnvVar[const aName: AnsiString]: AnsiString
    read pm_GetEnvVar
    write pm_SetEnvVar;
 end;//TatOperationEnv

implementation

uses
 l3ImplUses
 , StrUtils
 , SysUtils
 , l3Base
;

var g_TatOperationEnv: TatOperationEnv = nil;
 {* Экземпляр синглетона TatOperationEnv }

procedure TatOperationEnvFree;
 {* Метод освобождения экземпляра синглетона TatOperationEnv }
begin
 l3Free(g_TatOperationEnv);
end;//TatOperationEnvFree

function TatOperationEnv.pm_GetEnvVar(const aName: AnsiString): AnsiString;
//#UC START# *5396EBFF012A_5396EA3E0230get_var*
//#UC END# *5396EBFF012A_5396EA3E0230get_var*
begin
//#UC START# *5396EBFF012A_5396EA3E0230get_impl*
  Result := f_VarList.Values[aName];
//#UC END# *5396EBFF012A_5396EA3E0230get_impl*
end;//TatOperationEnv.pm_GetEnvVar

procedure TatOperationEnv.pm_SetEnvVar(const aName: AnsiString;
 const aValue: AnsiString);
//#UC START# *5396EBFF012A_5396EA3E0230set_var*
  var
    l_Value : String;
//#UC END# *5396EBFF012A_5396EA3E0230set_var*
begin
//#UC START# *5396EBFF012A_5396EA3E0230set_impl*
  l_Value := aValue;
  
  if aName = ENV_CURRENT_FILE_PATH then
     l_Value := ExpandFileName(l_Value);
     
  f_VarList.Values[aName] := l_Value;
//#UC END# *5396EBFF012A_5396EA3E0230set_impl*
end;//TatOperationEnv.pm_SetEnvVar

function TatOperationEnv.ExpandString(const aString: AnsiString): AnsiString;
//#UC START# *5396EC3D006D_5396EA3E0230_var*
  var
    i : Integer;
    l_Name, l_CFP : String;
//#UC END# *5396EC3D006D_5396EA3E0230_var*
begin
//#UC START# *5396EC3D006D_5396EA3E0230_impl*
  Result := aString;
  for i := 0 to f_VarList.Count-1 do
  begin
    l_Name := f_VarList.Names[i];
    if l_Name <> '' then
      Result := AnsiReplaceText(Result, l_Name, EnvVar[l_Name]);
  end;

  // отрабатываем вычисляемые переменные
  l_CFP := EnvVar[ENV_CURRENT_FILE_PATH];
  if l_CFP <> '' then
  begin
    if AnsiContainsText(Result, ENV_CURRENT_FILE_DIR) then
      Result := AnsiReplaceText(Result, ENV_CURRENT_FILE_DIR, ExtractFilePath(l_CFP));
    if AnsiContainsText(Result, ENV_CURRENT_FILE_NAME) then
      Result := AnsiReplaceText(Result, ENV_CURRENT_FILE_NAME, ExtractFileName(l_CFP));
  end;
//#UC END# *5396EC3D006D_5396EA3E0230_impl*
end;//TatOperationEnv.ExpandString

constructor TatOperationEnv.Create;
//#UC START# *5396F0310309_5396EA3E0230_var*
//#UC END# *5396F0310309_5396EA3E0230_var*
begin
//#UC START# *5396F0310309_5396EA3E0230_impl*
  inherited;
  //
  f_VarList := TStringList.Create;
  f_VarList.NameValueSeparator := '=';
  f_VarList.CaseSensitive := False;
  f_VarList.Duplicates := dupIgnore;
//#UC END# *5396F0310309_5396EA3E0230_impl*
end;//TatOperationEnv.Create

class function TatOperationEnv.Instance: TatOperationEnv;
 {* Метод получения экземпляра синглетона TatOperationEnv }
begin
 if (g_TatOperationEnv = nil) then
 begin
  l3System.AddExitProc(TatOperationEnvFree);
  g_TatOperationEnv := Create;
 end;
 Result := g_TatOperationEnv;
end;//TatOperationEnv.Instance

class function TatOperationEnv.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TatOperationEnv <> nil;
end;//TatOperationEnv.Exists

destructor TatOperationEnv.Destroy;
//#UC START# *48077504027E_5396EA3E0230_var*
//#UC END# *48077504027E_5396EA3E0230_var*
begin
//#UC START# *48077504027E_5396EA3E0230_impl*
  FreeAndNil(f_VarList);
  //
  inherited;
//#UC END# *48077504027E_5396EA3E0230_impl*
end;//TatOperationEnv.Destroy

end.
