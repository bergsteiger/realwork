unit ddExportFilerDispatcherElem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/PipeOut/ddExportFilerDispatcherElem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::dd::PipeOut::TddExportFilerDispatcherElem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
  l3Interfaces,
  l3Filer,
  l3ProtoObject,
  ddPipeOutInterfaces
  ;

type
 TddExportFilerDispatcherElem = class(Tl3ProtoObject, IddExportFilerDispatcherElem)
 private
 // private fields
   f_FileMask : Il3CString;
   f_PartSize : Integer;
   f_PartNum : Integer;
   f_CodePage : LongInt;
   f_RollBackPos : Int64;
   f_UpdateFiles : Boolean;
   f_Filer : Tl3DOSFiler;
 protected
 // realized methods
   function Get_Filer: Tl3CustomFiler;
   procedure RollBack;
     {* Сигнатура метода RollBack }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFileMask: Il3CString;
     aCodePage: Integer;
     aPartSize: Integer;
     aUpdateFiles: Boolean); reintroduce;
   class function Make(const aFileMask: Il3CString;
     aCodePage: Integer;
     aPartSize: Integer;
     aUpdateFiles: Boolean): IddExportFilerDispatcherElem; reintroduce;
     {* Сигнатура фабрики TddExportFilerDispatcherElem.Make }
 end;//TddExportFilerDispatcherElem

implementation

uses
  SysUtils,
  l3String,
  l3Types,
  Classes,
  l3Base
  ;

// start class TddExportFilerDispatcherElem

constructor TddExportFilerDispatcherElem.Create(const aFileMask: Il3CString;
  aCodePage: Integer;
  aPartSize: Integer;
  aUpdateFiles: Boolean);
//#UC START# *560A5C2D0282_560A5BC502D5_var*
//#UC END# *560A5C2D0282_560A5BC502D5_var*
begin
//#UC START# *560A5C2D0282_560A5BC502D5_impl*
  inherited Create;
  f_FileMask := aFileMask;
  f_PartSize := aPartSize;
  f_CodePage := aCodePage;
  f_UpdateFiles := aUpdateFiles;
//#UC END# *560A5C2D0282_560A5BC502D5_impl*
end;//TddExportFilerDispatcherElem.Create

class function TddExportFilerDispatcherElem.Make(const aFileMask: Il3CString;
  aCodePage: Integer;
  aPartSize: Integer;
  aUpdateFiles: Boolean): IddExportFilerDispatcherElem;
var
 l_Inst : TddExportFilerDispatcherElem;
begin
 l_Inst := Create(aFileMask, aCodePage, aPartSize, aUpdateFiles);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TddExportFilerDispatcherElem.Get_Filer: Tl3CustomFiler;
//#UC START# *5603F0260334_560A5BC502D5get_var*
var
 l_FileName: AnsiString;
//#UC END# *5603F0260334_560A5BC502D5get_var*
begin
//#UC START# *5603F0260334_560A5BC502D5get_impl*
 if (f_Filer = nil) or ((f_PartSize > 0) and (f_Filer.Size > f_PartSize)) then
 begin
  FreeAndNil(f_Filer);
  if f_PartSize > 0 then
  begin
   Inc(f_PartNum);
   l_FileName := l3Str(l3StringReplace(f_FileMask, cExportFileMaskPatterns[eptPartNum], l3PCharLen(IntToStr(f_PartNum)), [rfReplaceAll, rfIgnoreCase]));
  end
  else
   l_FileName := l3Str(f_FileMask);
  try
   if f_UpdateFiles and FileExists(l_FileName) then
    f_Filer := Tl3DOSFiler.Make(l_Filename, l3_fmAppend)
   else
    f_Filer := Tl3DOSFiler.Make(l_Filename, l3_fmWrite);
   // Файлер открываем два раза. Потому что неизвестно, будет ли этот файлер последним в выливке. А если будет - то труба
   // его закроет. И тогда не сработает логика удаления пустого файла в Cleanup.
   f_Filer.Open;
   f_Filer.Open;
   f_Filer.CodePage := f_CodePage;
  except
   on E: Exception do
    l3System.Msg2Log(cFilerOpenErrorMsg, [E.Message, l_FileName]);
  end;
 end;
 f_RollBackPos := f_Filer.Stream.Position;
 Result := f_Filer;
//#UC END# *5603F0260334_560A5BC502D5get_impl*
end;//TddExportFilerDispatcherElem.Get_Filer

procedure TddExportFilerDispatcherElem.RollBack;
//#UC START# *5616668C01A8_560A5BC502D5_var*
//#UC END# *5616668C01A8_560A5BC502D5_var*
begin
//#UC START# *5616668C01A8_560A5BC502D5_impl*
 if Assigned(f_Filer) then
 begin
  f_Filer.Stream.Position := f_RollBackPos;
  f_Filer.Seek(0, soEnd);
 end;
//#UC END# *5616668C01A8_560A5BC502D5_impl*
end;//TddExportFilerDispatcherElem.RollBack

procedure TddExportFilerDispatcherElem.Cleanup;
//#UC START# *479731C50290_560A5BC502D5_var*
//#UC END# *479731C50290_560A5BC502D5_var*
begin
//#UC START# *479731C50290_560A5BC502D5_impl*
 if Assigned(f_Filer) then
 begin
  try
   f_Filer.Flush;
   if f_Filer.Size = 0 then // если в файл ничего не записано, то файл надо удалить
   begin
    while f_Filer.Opened do
     f_Filer.Close;
    DeleteFile(f_Filer.FileName);
   end;
  finally
   FreeAndNil(f_Filer);
  end; // try...finally
 end;
 inherited;
//#UC END# *479731C50290_560A5BC502D5_impl*
end;//TddExportFilerDispatcherElem.Cleanup

end.