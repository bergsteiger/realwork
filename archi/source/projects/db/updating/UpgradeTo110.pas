unit UpgradeTo110;

// ���������� ���������.

{ $Id: UpgradeTo110.pas,v 1.8 2015/02/10 08:04:16 fireton Exp $ }
// $Log: UpgradeTo110.pas,v $
// Revision 1.8  2015/02/10 08:04:16  fireton
// - ���������� ��������������
//
// Revision 1.7  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.6  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.5  2006/06/08 15:55:56  fireton
// - ���������� � �������� �� ������� User ID
//
// Revision 1.4.6.1  2006/06/08 09:26:58  fireton
// - ������� User ID �� Longword
//
// Revision 1.4  2004/12/02 15:55:23  step
// ���������� ����� ID � DICT_ID � �������� DT#* � LNK#* � ���� DWRD (ver. 111)
//
// Revision 1.3  2004/10/29 09:11:43  step
// bug fix
//
// Revision 1.2  2004/10/26 11:55:40  step
// bug fix
//
// Revision 1.1  2004/10/25 16:12:41  step
// ���������� ��������� (ver. 110)
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo110 = class(TDocBaseUpgrade)
 private
  f_StorageSize: Integer;
  f_StoragePercentDone: Integer;
  function StorageFile: string;
  procedure StorageCopyProgress(aState: Byte; aValue: Longint; const aMsg: string = '');
  procedure StorageUpdateProgress(aState: Byte; aValue: Longint; const aMsg: string = '');
  procedure Old2New;
  procedure Delta2Const;
 protected
  procedure ModifyBd; override;
 public
  class function PrevVersion: Integer; override; // 109
  class function Version: Integer; override;     // 110
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils,
 l3Types,
 l3Math,
 l3Interfaces,
 Dt_Const,

 m2COMLib,

 m3Const,
 m3StorageInterfaces,
 m3StorageTools,
 m3StgMgr,
 m3DB,
 m3DBInterfaces,

 m4DB,
 m4DBInterfaces;

{$INCLUDE nodt_const.inc} 


const
 STORAGE_FILE = 'bserv001';

class function TUpgradeTo110.PrevVersion: Integer;
begin
 Result := 109;
end;

procedure TUpgradeTo110.ModifyBd;
begin
 Old2New;
 Delta2Const;
end;

class function TUpgradeTo110.Version: Integer;
begin
 Result := 110;
end;

function TUpgradeTo110.StorageFile: string;
begin
 Result := f_DbReformer.FamilyTable(STORAGE_FILE);
end;

procedure TUpgradeTo110.StorageCopyProgress(aState: Byte; aValue: Integer; const aMsg: string);
var
 l_PercentDone: Integer;
begin
 case aState of
  piStart:
  begin
   f_StorageSize := aValue;
   f_StoragePercentDone := 0;
   f_DbReformer.Log('�������� ����������� ����������.');
  end;
  piCurrent:
   if f_StorageSize > 0 then
   begin
    l_PercentDone := l3MulDiv(aValue, 100, f_StorageSize);
    if l_PercentDone > f_StoragePercentDone then
    begin
     f_StoragePercentDone := l_PercentDone;
     f_DbReformer.Log('���� ����������� ����������. ��������� ' + IntToStr(f_StoragePercentDone) + ' %.');
    end;
   end;
  piEnd:
   f_DbReformer.Log('����������� ���������� ���������.');
 end;
end;

procedure TUpgradeTo110.Delta2Const;
var
 l_Db: Im4DB;
begin
 with f_DbReformer do
 begin
  Log('����������� �������� ���������.');
  l_Db := Tm4DB.Make(StorageFile,
                     //False,
                     Yield,
                     nil,
                     StorageUpdateProgress);
  try
   l_Db.Start({m3_saRead, }m3_saReadWrite);
   try
    l_Db.Update;
   finally
    l_Db.Finish;
   end;
  finally
   l_Db := nil;
  end;
 end; // with
end;

procedure TUpgradeTo110.Old2New;
var
 l_Db: Im3DB;
 l_DbOld: Im3DB;
begin
 with f_DbReformer do
 begin
  Log('����������� ���������� ���������.');
  l_Db := Tm3DB.Make(StorageFile,
                     //False,
                     Yield,
                     nil,
                     nil,
                     nil,
                     nil);
  try
   l_Db.Start(m3_saReadWrite{, m3_saRead});
   try
    l_DbOld := Tm3DB.Make(StorageFile,
                          //True,
                          Yield,
                          nil,
                          StorageCopyProgress,
                          nil,
                          nil);
    try
     // ������� �� ������� � �����
     l_DbOld.AllFiles.CopyTo(l_Db, m3_cmRewriteEmpty);
    finally
     l_DbOld := nil;
    end;
   finally
    l_Db.Finish;
   end;
  finally
   l_Db := nil;
  end;
 end; // with
end;

procedure TUpgradeTo110.StorageUpdateProgress(aState: Byte;
  aValue: Integer; const aMsg: string);
var
 l_PercentDone: Integer;
begin
 case aState of
  piStart:
  begin
   f_StorageSize := aValue;
   f_StoragePercentDone := 0;
   f_DbReformer.Log('�������� �������� ���������.');
  end;
  piCurrent:
   if f_StorageSize > 0 then
   begin
    l_PercentDone := l3MulDiv(aValue, 100, f_StorageSize);
    if l_PercentDone > f_StoragePercentDone then
    begin
     f_StoragePercentDone := l_PercentDone;
     f_DbReformer.Log('���� �������� ���������. ��������� ' + IntToStr(f_StoragePercentDone) + ' %.');
    end;
   end;
  piEnd:
   f_DbReformer.Log('�������� ��������� ���������.');
 end;
end;

end.

