unit tfwStreamFactory;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwStreamFactory.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3BaseStream
;

type
 TtfwStreamFactory = {abstract} class(Tl3ProtoObject)
  private
   f_FileName: AnsiString;
  protected
   f_Stream: Tl3Stream;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   function FileName: AnsiString;
   function Stream: Tl3Stream; virtual; abstract;
   constructor Create(const aFileName: AnsiString); reintroduce;
   procedure CloseStream;
   function FileDateTime: TDateTime; virtual; abstract;
 end;//TtfwStreamFactory

implementation

uses
 l3ImplUses
 , SysUtils
;

function TtfwStreamFactory.FileName: AnsiString;
//#UC START# *52F4E6D60067_52F4E6AA02BB_var*
//#UC END# *52F4E6D60067_52F4E6AA02BB_var*
begin
//#UC START# *52F4E6D60067_52F4E6AA02BB_impl*
 Result := f_FileName;
//#UC END# *52F4E6D60067_52F4E6AA02BB_impl*
end;//TtfwStreamFactory.FileName

constructor TtfwStreamFactory.Create(const aFileName: AnsiString);
//#UC START# *52F4E94802D6_52F4E6AA02BB_var*
//#UC END# *52F4E94802D6_52F4E6AA02BB_var*
begin
//#UC START# *52F4E94802D6_52F4E6AA02BB_impl*
 inherited Create;
 f_FileName := aFileName;
//#UC END# *52F4E94802D6_52F4E6AA02BB_impl*
end;//TtfwStreamFactory.Create

procedure TtfwStreamFactory.CloseStream;
//#UC START# *52F4F68C01E0_52F4E6AA02BB_var*
//#UC END# *52F4F68C01E0_52F4E6AA02BB_var*
begin
//#UC START# *52F4F68C01E0_52F4E6AA02BB_impl*
 FreeAndNil(f_Stream);
//#UC END# *52F4F68C01E0_52F4E6AA02BB_impl*
end;//TtfwStreamFactory.CloseStream

procedure TtfwStreamFactory.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_52F4E6AA02BB_var*
//#UC END# *479731C50290_52F4E6AA02BB_var*
begin
//#UC START# *479731C50290_52F4E6AA02BB_impl*
 FreeAndNil(f_Stream);
 inherited;
//#UC END# *479731C50290_52F4E6AA02BB_impl*
end;//TtfwStreamFactory.Cleanup

end.
