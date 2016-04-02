unit atSharedBuffer;
 {* Класс для создания буфера памяти, общего для нескольких процессов на одной машине. }

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atSharedBuffer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatSharedBuffer" MUID: (491D776401B4)

interface

uses
 l3IntfUses
 , l3_Base
 , Windows
;

type
 TatSharedBuffer = class(Tl3_Base)
  {* Класс для создания буфера памяти, общего для нескольких процессов на одной машине. }
  private
   f_FileMapping: THandle;
   f_MappingAddress: Pointer;
   f_Size: LongWord;
    {* Размер буфера. }
  protected
   function pm_GetValue: Pointer; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aName: AnsiString;
    aSize: LongWord); reintroduce;
  public
   property Value: Pointer
    read pm_GetValue;
    {* Указатель на буфер. }
   property Size: LongWord
    read f_Size;
    {* Размер буфера. }
 end;//TatSharedBuffer

implementation

uses
 l3ImplUses
 , SysUtils
;

function TatSharedBuffer.pm_GetValue: Pointer;
//#UC START# *491D881000F6_491D776401B4get_var*
//#UC END# *491D881000F6_491D776401B4get_var*
begin
//#UC START# *491D881000F6_491D776401B4get_impl*
  Result := f_MappingAddress;
//#UC END# *491D881000F6_491D776401B4get_impl*
end;//TatSharedBuffer.pm_GetValue

constructor TatSharedBuffer.Create(const aName: AnsiString;
 aSize: LongWord);
//#UC START# *491D78AD03E4_491D776401B4_var*
  var
    isNewMapping : boolean;
//#UC END# *491D78AD03E4_491D776401B4_var*
begin
//#UC START# *491D78AD03E4_491D776401B4_impl*
  inherited Create;
  f_Size := aSize;
  // создаем отображение в файл подкачки
  f_FileMapping := CreateFileMapping(
    $FFFFFFFF, nil, PAGE_READWRITE OR SEC_COMMIT, 0, f_Size, PAnsiChar('{5D573166-D8D3-4419-97CE-83DDF40C9831}_' + aName)
  );
  isNewMapping := (GetLastError() = 0); // если бы уже существовало, то GetLastError возвратил бы ERROR_ALREADY_EXISTS
  if (f_FileMapping = 0) then
    Raise Exception.Create('Вызов CreateFileMapping не удался!');
  // теперь мапим в адресное пространство
  f_MappingAddress := MapViewOfFile(f_FileMapping, FILE_MAP_ALL_ACCESS, 0, 0, f_Size);
  if (f_MappingAddress = nil) then
    Raise Exception.Create('Вызов MapViewOfFile не удался!');
  if isNewMapping then
    FillChar(f_MappingAddress^, f_Size, 0);
//#UC END# *491D78AD03E4_491D776401B4_impl*
end;//TatSharedBuffer.Create

procedure TatSharedBuffer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_491D776401B4_var*
//#UC END# *479731C50290_491D776401B4_var*
begin
//#UC START# *479731C50290_491D776401B4_impl*
  UnmapViewOfFile(f_MappingAddress);
  CloseHandle(f_FileMapping);
  inherited;
//#UC END# *479731C50290_491D776401B4_impl*
end;//TatSharedBuffer.Cleanup

end.
