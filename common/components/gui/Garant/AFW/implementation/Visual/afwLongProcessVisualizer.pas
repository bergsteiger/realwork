unit afwLongProcessVisualizer;

// ������: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwLongProcessVisualizer.pas"
// ���������: "SimpleClass"
// ������� ������: "TafwLongProcessVisualizer" MUID: (47877AB8026C)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , l3AsincMessageWindow
;

type
 TafwLongProcessVisualizer = class(Tl3ProtoObject, IafwLongProcessVisualizer)
  private
   f_Wnd: Tl3AsincMessageWindow;
    {* ���������� ���� � ����������. }
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(const aCaption: IafwCString;
    anAttachWnd: THandle = 0;
    anInitialTimeout: Cardinal = afw_lpwTimeout;
    anImageList: TafwCustomImageList = nil;
    anImageIndex: Integer = -1); reintroduce;
    {* ������� ��������� ������. }
   class function Make(const aCaption: IafwCString;
    anAttachWnd: THandle = 0;
    anInitialTimeout: Cardinal = afw_lpwTimeout;
    anImageList: TafwCustomImageList = nil;
    anImageIndex: Integer = -1): IafwLongProcessVisualizer; reintroduce;
    {* ������� ��������� ������ � ���� ���������� IafwLongProcessVisualizer. }
 end;//TafwLongProcessVisualizer

implementation

uses
 l3ImplUses
 , SysUtils
 //#UC START# *47877AB8026Cimpl_uses*
 //#UC END# *47877AB8026Cimpl_uses*
;

constructor TafwLongProcessVisualizer.Create(const aCaption: IafwCString;
 anAttachWnd: THandle = 0;
 anInitialTimeout: Cardinal = afw_lpwTimeout;
 anImageList: TafwCustomImageList = nil;
 anImageIndex: Integer = -1);
 {* ������� ��������� ������. }
//#UC START# *4787FEFF02E5_47877AB8026C_var*
//#UC END# *4787FEFF02E5_47877AB8026C_var*
begin
//#UC START# *4787FEFF02E5_47877AB8026C_impl*
 inherited Create;
 f_Wnd := Tl3AsincMessageWindow.Create(aCaption, anImageList, anImageIndex,
                                       anAttachWnd, anInitialTimeout);
//#UC END# *4787FEFF02E5_47877AB8026C_impl*
end;//TafwLongProcessVisualizer.Create

class function TafwLongProcessVisualizer.Make(const aCaption: IafwCString;
 anAttachWnd: THandle = 0;
 anInitialTimeout: Cardinal = afw_lpwTimeout;
 anImageList: TafwCustomImageList = nil;
 anImageIndex: Integer = -1): IafwLongProcessVisualizer;
 {* ������� ��������� ������ � ���� ���������� IafwLongProcessVisualizer. }
var
 l_Inst : TafwLongProcessVisualizer;
begin
 l_Inst := Create(aCaption, anAttachWnd, anInitialTimeout, anImageList, anImageIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwLongProcessVisualizer.Make

procedure TafwLongProcessVisualizer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_47877AB8026C_var*
//#UC END# *479731C50290_47877AB8026C_var*
begin
//#UC START# *479731C50290_47877AB8026C_impl*
 FreeAndNil(f_Wnd);
 inherited;
//#UC END# *479731C50290_47877AB8026C_impl*
end;//TafwLongProcessVisualizer.Cleanup

end.
