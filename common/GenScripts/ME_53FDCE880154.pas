unit m3CustomStream;

// ������: "w:\common\components\rtl\Garant\m3\m3CustomStream.pas"
// ���������: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , m3BaseStream
 , ActiveX
 , m3StorageInterfaces
;

type
 Tm3CustomStream = {abstract} class(Tm3BaseStream)
  private
   f_InnerStream: IStream;
    {* ���� ��� �������� InnerStream }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aStream: IStream;
    anAccess: Tm3StoreAccess); reintroduce;
   procedure Commit(aFlags: Integer;
    var theReturn: hResult); override;
  protected
   property InnerStream: IStream
    read f_InnerStream;
 end;//Tm3CustomStream

implementation

uses
 l3ImplUses
 , m3Exceptions
;

constructor Tm3CustomStream.Create(const aStream: IStream;
 anAccess: Tm3StoreAccess);
//#UC START# *5480895501A0_53FDCE880154_var*
//#UC END# *5480895501A0_53FDCE880154_var*
begin
//#UC START# *5480895501A0_53FDCE880154_impl*
 Em3NilStream.Check(AStream <> nil, '������ �����');
 Assert(AStream <> nil);
 inherited Create(anAccess);
 f_InnerStream := aStream;
//#UC END# *5480895501A0_53FDCE880154_impl*
end;//Tm3CustomStream.Create

procedure Tm3CustomStream.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_53FDCE880154_var*
//#UC END# *479731C50290_53FDCE880154_var*
begin
//#UC START# *479731C50290_53FDCE880154_impl*
 f_InnerStream := nil;
 inherited;
//#UC END# *479731C50290_53FDCE880154_impl*
end;//Tm3CustomStream.Cleanup

procedure Tm3CustomStream.Commit(aFlags: Integer;
 var theReturn: hResult);
//#UC START# *4FA280DB0288_53FDCE880154_var*
//#UC END# *4FA280DB0288_53FDCE880154_var*
begin
//#UC START# *4FA280DB0288_53FDCE880154_impl*
 if (f_InnerStream = nil) then
  theReturn := E_NOTIMPL
 else
  theReturn := f_InnerStream.Commit(aFlags); 
//#UC END# *4FA280DB0288_53FDCE880154_impl*
end;//Tm3CustomStream.Commit

procedure Tm3CustomStream.ClearFields;
begin
 f_InnerStream := nil;
 inherited;
end;//Tm3CustomStream.ClearFields

end.
