unit Admin3Res;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/archi/source/projects/Admin3/Admin3Res.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> archi$Admin3::Admin3::Admin3
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Admin3\arAdminDefine.inc}

interface

uses
  F1LikeRes,
  Classes {a},
  vcmInterfaces {a},
  vcmExternalInterfaces {a}
  ;

type
TAdmin3Res = {final} class(TF1LikeRes)
protected
   procedure RegisterFormSetFactories; override;
   procedure Loaded; override;

end;//TAdmin3Res
TvcmApplicationRef = TAdmin3Res;
 {* ������ �� ���������� ��� DesignTime ���������� }


implementation

uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  evExtFormat
  ;

// start class TAdmin3Res

procedure TAdmin3Res.RegisterFormSetFactories;
begin
 inherited;
end;

procedure TAdmin3Res.Loaded;
begin
 inherited;
end;

end.