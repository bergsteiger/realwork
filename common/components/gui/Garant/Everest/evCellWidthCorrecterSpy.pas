unit evCellWidthCorrecterSpy;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evCellWidthCorrecterSpy.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::CellUtils::TevCellWidthCorrecterSpy
//
// ���������� ���������� ��� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Filer,
  l3ProtoObject
  ;

type
 IevCellsWidthCorrecterLogger = interface(IUnknown)
   ['{D6A90763-2ABA-44CF-9E08-78D3B6C5ACCD}']
   function OpenLog: AnsiString;
   procedure CloseLog(const aLogName: AnsiString);
 end;//IevCellsWidthCorrecterLogger

 TevCellLogData = record
   rCellID : Integer;
   rCellText : AnsiString;
   rOldWidth : Integer;
   rNewWidth : Integer;
 end;//TevCellLogData

 TevCellWidthCorrecterSpy = class(Tl3ProtoObject)
  {* ���������� ���������� ��� ������. }
 private
 // private fields
   f_Logger : IevCellsWidthCorrecterLogger;
   f_Filer : Tl3CustomFiler;
   f_LogName : AnsiString;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   class function Exists: Boolean;
   procedure SetLogger(const aLogger: IevCellsWidthCorrecterLogger);
   procedure RemoveLogger(const aLogger: IevCellsWidthCorrecterLogger);
   procedure StartSaveData;
   procedure EndSaveData;
   procedure SaveAlignmentData(const aCellLogData: TevCellLogData);
   procedure SaveRowData(anIndex: Integer;
     aOldRowWidth: Integer;
     aNewRowWidth: Integer);
   function NeedLog: Boolean;
 public
 // singleton factory method
   class function Instance: TevCellWidthCorrecterSpy;
    {- ���������� ��������� ����������. }
 end;//TevCellWidthCorrecterSpy

implementation

uses
  l3Base {a},
  l3Types,
  SysUtils,
  l3Chars,
  l3String,
  l3Interfaces
  ;


// start class TevCellWidthCorrecterSpy

var g_TevCellWidthCorrecterSpy : TevCellWidthCorrecterSpy = nil;

procedure TevCellWidthCorrecterSpyFree;
begin
 l3Free(g_TevCellWidthCorrecterSpy);
end;

class function TevCellWidthCorrecterSpy.Instance: TevCellWidthCorrecterSpy;
begin
 if (g_TevCellWidthCorrecterSpy = nil) then
 begin
  l3System.AddExitProc(TevCellWidthCorrecterSpyFree);
  g_TevCellWidthCorrecterSpy := Create;
 end;
 Result := g_TevCellWidthCorrecterSpy;
end;


class function TevCellWidthCorrecterSpy.Exists: Boolean;
//#UC START# *4FC704C00038_4FC701EC00C0_var*
//#UC END# *4FC704C00038_4FC701EC00C0_var*
begin
//#UC START# *4FC704C00038_4FC701EC00C0_impl*
 Result := g_TevCellWidthCorrecterSpy <> nil;
//#UC END# *4FC704C00038_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.Exists

procedure TevCellWidthCorrecterSpy.SetLogger(const aLogger: IevCellsWidthCorrecterLogger);
//#UC START# *4FC7078600A7_4FC701EC00C0_var*
//#UC END# *4FC7078600A7_4FC701EC00C0_var*
begin
//#UC START# *4FC7078600A7_4FC701EC00C0_impl*
 Assert(f_Logger = nil);
 f_Logger := aLogger;
//#UC END# *4FC7078600A7_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.SetLogger

procedure TevCellWidthCorrecterSpy.RemoveLogger(const aLogger: IevCellsWidthCorrecterLogger);
//#UC START# *4FC707B501FD_4FC701EC00C0_var*
//#UC END# *4FC707B501FD_4FC701EC00C0_var*
begin
//#UC START# *4FC707B501FD_4FC701EC00C0_impl*
 Assert(f_Logger = aLogger);
 f_Logger := nil;
//#UC END# *4FC707B501FD_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.RemoveLogger

procedure TevCellWidthCorrecterSpy.StartSaveData;
//#UC START# *4FC708230066_4FC701EC00C0_var*
//#UC END# *4FC708230066_4FC701EC00C0_var*
begin
//#UC START# *4FC708230066_4FC701EC00C0_impl*
 if NeedLog then
 begin
  f_LogName := f_Logger.OpenLog;
  f_Filer := Tl3CustomDOSFiler.Make(f_LogName, l3_fmWrite);
  f_Filer.Open;
 end; // if NeedLog then
//#UC END# *4FC708230066_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.StartSaveData

procedure TevCellWidthCorrecterSpy.EndSaveData;
//#UC START# *4FC7085C00D7_4FC701EC00C0_var*
//#UC END# *4FC7085C00D7_4FC701EC00C0_var*
begin
//#UC START# *4FC7085C00D7_4FC701EC00C0_impl*
 if NeedLog then
 begin
  f_Filer.Close;
  FreeAndNil(f_Filer);
  f_Logger.CloseLog(f_LogName);
 end; // if NeedLog then
//#UC END# *4FC7085C00D7_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.EndSaveData

procedure TevCellWidthCorrecterSpy.SaveAlignmentData(const aCellLogData: TevCellLogData);
//#UC START# *4FC708720012_4FC701EC00C0_var*
var
 l_CStr     : Il3CString;
 l_PosEnter : Integer;
//#UC END# *4FC708720012_4FC701EC00C0_var*
begin
//#UC START# *4FC708720012_4FC701EC00C0_impl*
 if NeedLog then
 begin
  l_CStr := l3CStr(aCellLogData.rCellText);
  l3DeleteChars(l_CStr, [cc_SoftEnter, cc_HardEnter, cc_SoftSpace]);
  f_Filer.WriteLn(Format('������ � = %d, ����� = %s', [aCellLogData.rCellID, l3Str(l_CStr)]));
  f_Filer.WriteLn(Format('������ ������ = %d, ����� ������ = %d', [aCellLogData.rOldWidth, aCellLogData.rNewWidth]));
 end;
//#UC END# *4FC708720012_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.SaveAlignmentData

procedure TevCellWidthCorrecterSpy.SaveRowData(anIndex: Integer;
  aOldRowWidth: Integer;
  aNewRowWidth: Integer);
//#UC START# *4FC709AF00B7_4FC701EC00C0_var*
//#UC END# *4FC709AF00B7_4FC701EC00C0_var*
begin
//#UC START# *4FC709AF00B7_4FC701EC00C0_impl*
 if NeedLog then
 begin
  f_Filer.WriteLn(Format('����� � = %d', [anIndex]));
  f_Filer.WriteLn(Format('������ ������ = %d, ����� ������ = %d', [aOldRowWidth, aNewRowWidth]));
  f_Filer.WriteLn('');
 end;
//#UC END# *4FC709AF00B7_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.SaveRowData

function TevCellWidthCorrecterSpy.NeedLog: Boolean;
//#UC START# *4FC723F7027F_4FC701EC00C0_var*
//#UC END# *4FC723F7027F_4FC701EC00C0_var*
begin
//#UC START# *4FC723F7027F_4FC701EC00C0_impl*
 Result := f_Logger <> nil;
//#UC END# *4FC723F7027F_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.NeedLog

procedure TevCellWidthCorrecterSpy.Cleanup;
//#UC START# *479731C50290_4FC701EC00C0_var*
//#UC END# *479731C50290_4FC701EC00C0_var*
begin
//#UC START# *479731C50290_4FC701EC00C0_impl*
 FreeAndNil(f_Filer);
 f_LogName := '';
 inherited;
//#UC END# *479731C50290_4FC701EC00C0_impl*
end;//TevCellWidthCorrecterSpy.Cleanup

procedure TevCellWidthCorrecterSpy.ClearFields;
 {-}
begin
 f_Logger := nil;
 inherited;
end;//TevCellWidthCorrecterSpy.ClearFields

end.