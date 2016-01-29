unit afwLongProcessVisualizer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwLongProcessVisualizer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::Visual::TafwLongProcessVisualizer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  l3AsincMessageWindow,
  l3ProtoObject
  ;

type
 TafwLongProcessVisualizer = class(Tl3ProtoObject, IafwLongProcessVisualizer)
 private
 // private fields
   f_Wnd : Tl3AsincMessageWindow;
    {* ���������� ���� � ����������.}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
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
  SysUtils
  ;

// start class TafwLongProcessVisualizer

constructor TafwLongProcessVisualizer.Create(const aCaption: IafwCString;
  anAttachWnd: THandle = 0;
  anInitialTimeout: Cardinal = afw_lpwTimeout;
  anImageList: TafwCustomImageList = nil;
  anImageIndex: Integer = -1);
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
var
 l_Inst : TafwLongProcessVisualizer;
begin
 l_Inst := Create(aCaption, anAttachWnd, anInitialTimeout, anImageList, anImageIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TafwLongProcessVisualizer.Cleanup;
//#UC START# *479731C50290_47877AB8026C_var*
//#UC END# *479731C50290_47877AB8026C_var*
begin
//#UC START# *479731C50290_47877AB8026C_impl*
 FreeAndNil(f_Wnd);
 inherited;
//#UC END# *479731C50290_47877AB8026C_impl*
end;//TafwLongProcessVisualizer.Cleanup

end.