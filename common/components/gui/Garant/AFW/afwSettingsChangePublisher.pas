unit afwSettingsChangePublisher;

// ������: "w:\common\components\gui\Garant\AFW\afwSettingsChangePublisher.pas"
// ���������: "SimpleClass"
// ������� ������: "TafwSettingsChangePublisher" MUID: (5242FE0C02ED)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwSettingsChangePublisherPrim
;

type
 TafwSettingsChangePublisher = class(TafwSettingsChangePublisherPrim)
  public
   class function Exists: Boolean;
   class function Instance: TafwSettingsChangePublisher;
    {* ����� ��������� ���������� ���������� TafwSettingsChangePublisher }
 end;//TafwSettingsChangePublisher

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TafwSettingsChangePublisher: TafwSettingsChangePublisher = nil;
 {* ��������� ���������� TafwSettingsChangePublisher }

procedure TafwSettingsChangePublisherFree;
 {* ����� ������������ ���������� ���������� TafwSettingsChangePublisher }
begin
 l3Free(g_TafwSettingsChangePublisher);
end;//TafwSettingsChangePublisherFree

class function TafwSettingsChangePublisher.Exists: Boolean;
begin
 Result := g_TafwSettingsChangePublisher <> nil;
end;//TafwSettingsChangePublisher.Exists

class function TafwSettingsChangePublisher.Instance: TafwSettingsChangePublisher;
 {* ����� ��������� ���������� ���������� TafwSettingsChangePublisher }
begin
 if (g_TafwSettingsChangePublisher = nil) then
 begin
  l3System.AddExitProc(TafwSettingsChangePublisherFree);
  g_TafwSettingsChangePublisher := Create;
 end;
 Result := g_TafwSettingsChangePublisher;
end;//TafwSettingsChangePublisher.Instance

end.
