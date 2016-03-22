unit ddDocumentAtom;

// Модуль: "w:\common\components\rtl\Garant\dd\ddDocumentAtom.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddDocumentAtom" MUID: (4FACE0E4032F)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddCustomDestination
 , k2Interfaces
 , ddTypes
 , l3ProtoObject
;

type
 _ddDocAtomWithAssign_Parent_ = Tl3ProtoDataContainer;
 {$Include w:\common\components\rtl\Garant\dd\ddDocAtomWithAssign.imp.pas}
 TddDocumentAtom = class(_ddDocAtomWithAssign_)
  private
   f_Closed: Boolean;
    {* Поле для свойства Closed }
   f_Stored: Boolean;
    {* Поле для свойства Stored }
  protected
   f_Destination: TddCustomDestination;
  protected
   procedure pm_SetClosed(aValue: Boolean);
   function pm_GetEmpty: Boolean;
   procedure pm_SetStored(aValue: Boolean); virtual;
   procedure DoClose; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetEmpty: Boolean; override;
  public
   procedure Clear; virtual;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); virtual; abstract;
   function JoinWith(P: TObject;
    aCorrectSegment: Boolean = False): Integer; virtual;
   function HasSoftEnter: Boolean; virtual;
   function IsTable: Boolean; virtual;
   function IsTextPara: Boolean; virtual;
   function IsPicture: Boolean; virtual;
   function IsBreak: Boolean; virtual;
   function IsRow: Boolean; virtual;
   function GetLastPara: TddDocumentAtom; virtual;
   function CanWrite: Boolean; virtual;
    {* Проверяет возможность записи объекта. Например, если у картинки нет размеров ширины и высоты, то она не записывается. }
   constructor Create(aDetination: TddCustomDestination); reintroduce; virtual;
  public
   property Closed: Boolean
    read f_Closed
    write pm_SetClosed;
   property Empty: Boolean
    read pm_GetEmpty;
   property Stored: Boolean
    read f_Stored
    write pm_SetStored;
 end;//TddDocumentAtom

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\dd\ddDocAtomWithAssign.imp.pas}

procedure TddDocumentAtom.pm_SetClosed(aValue: Boolean);
//#UC START# *5192108D0091_4FACE0E4032Fset_var*
//#UC END# *5192108D0091_4FACE0E4032Fset_var*
begin
//#UC START# *5192108D0091_4FACE0E4032Fset_impl*
 f_Closed := aValue;
 if f_Closed then
  DoClose;
//#UC END# *5192108D0091_4FACE0E4032Fset_impl*
end;//TddDocumentAtom.pm_SetClosed

function TddDocumentAtom.pm_GetEmpty: Boolean;
//#UC START# *525D1B9B0218_4FACE0E4032Fget_var*
//#UC END# *525D1B9B0218_4FACE0E4032Fget_var*
begin
//#UC START# *525D1B9B0218_4FACE0E4032Fget_impl*
 Result := GetEmpty;
//#UC END# *525D1B9B0218_4FACE0E4032Fget_impl*
end;//TddDocumentAtom.pm_GetEmpty

procedure TddDocumentAtom.pm_SetStored(aValue: Boolean);
//#UC START# *55BB6C6903D5_4FACE0E4032Fset_var*
//#UC END# *55BB6C6903D5_4FACE0E4032Fset_var*
begin
//#UC START# *55BB6C6903D5_4FACE0E4032Fset_impl*
 f_Stored := aValue;
//#UC END# *55BB6C6903D5_4FACE0E4032Fset_impl*
end;//TddDocumentAtom.pm_SetStored

procedure TddDocumentAtom.Clear;
//#UC START# *518A48F500CF_4FACE0E4032F_var*
//#UC END# *518A48F500CF_4FACE0E4032F_var*
begin
//#UC START# *518A48F500CF_4FACE0E4032F_impl*
 f_Stored := True;
//#UC END# *518A48F500CF_4FACE0E4032F_impl*
end;//TddDocumentAtom.Clear

procedure TddDocumentAtom.DoClose;
//#UC START# *518A4950037A_4FACE0E4032F_var*
//#UC END# *518A4950037A_4FACE0E4032F_var*
begin
//#UC START# *518A4950037A_4FACE0E4032F_impl*
//#UC END# *518A4950037A_4FACE0E4032F_impl*
end;//TddDocumentAtom.DoClose

function TddDocumentAtom.JoinWith(P: TObject;
 aCorrectSegment: Boolean = False): Integer;
//#UC START# *51921142034B_4FACE0E4032F_var*
//#UC END# *51921142034B_4FACE0E4032F_var*
begin
//#UC START# *51921142034B_4FACE0E4032F_impl*
 Result := -1;
//#UC END# *51921142034B_4FACE0E4032F_impl*
end;//TddDocumentAtom.JoinWith

function TddDocumentAtom.HasSoftEnter: Boolean;
//#UC START# *52662EA90016_4FACE0E4032F_var*
//#UC END# *52662EA90016_4FACE0E4032F_var*
begin
//#UC START# *52662EA90016_4FACE0E4032F_impl*
 Result := False;
//#UC END# *52662EA90016_4FACE0E4032F_impl*
end;//TddDocumentAtom.HasSoftEnter

function TddDocumentAtom.IsTable: Boolean;
//#UC START# *5268D575002D_4FACE0E4032F_var*
//#UC END# *5268D575002D_4FACE0E4032F_var*
begin
//#UC START# *5268D575002D_4FACE0E4032F_impl*
 Result := False;
//#UC END# *5268D575002D_4FACE0E4032F_impl*
end;//TddDocumentAtom.IsTable

function TddDocumentAtom.IsTextPara: Boolean;
//#UC START# *5268D5950076_4FACE0E4032F_var*
//#UC END# *5268D5950076_4FACE0E4032F_var*
begin
//#UC START# *5268D5950076_4FACE0E4032F_impl*
 Result := False;
//#UC END# *5268D5950076_4FACE0E4032F_impl*
end;//TddDocumentAtom.IsTextPara

function TddDocumentAtom.IsPicture: Boolean;
//#UC START# *5268D62B022C_4FACE0E4032F_var*
//#UC END# *5268D62B022C_4FACE0E4032F_var*
begin
//#UC START# *5268D62B022C_4FACE0E4032F_impl*
 Result := False;
//#UC END# *5268D62B022C_4FACE0E4032F_impl*
end;//TddDocumentAtom.IsPicture

function TddDocumentAtom.IsBreak: Boolean;
//#UC START# *5268D65201D6_4FACE0E4032F_var*
//#UC END# *5268D65201D6_4FACE0E4032F_var*
begin
//#UC START# *5268D65201D6_4FACE0E4032F_impl*
 Result := False;
//#UC END# *5268D65201D6_4FACE0E4032F_impl*
end;//TddDocumentAtom.IsBreak

function TddDocumentAtom.IsRow: Boolean;
//#UC START# *5268D6C802E0_4FACE0E4032F_var*
//#UC END# *5268D6C802E0_4FACE0E4032F_var*
begin
//#UC START# *5268D6C802E0_4FACE0E4032F_impl*
 Result := False;
//#UC END# *5268D6C802E0_4FACE0E4032F_impl*
end;//TddDocumentAtom.IsRow

function TddDocumentAtom.GetLastPara: TddDocumentAtom;
//#UC START# *5268DBC503E2_4FACE0E4032F_var*
//#UC END# *5268DBC503E2_4FACE0E4032F_var*
begin
//#UC START# *5268DBC503E2_4FACE0E4032F_impl*
 Result := nil;
//#UC END# *5268DBC503E2_4FACE0E4032F_impl*
end;//TddDocumentAtom.GetLastPara

function TddDocumentAtom.CanWrite: Boolean;
 {* Проверяет возможность записи объекта. Например, если у картинки нет размеров ширины и высоты, то она не записывается. }
//#UC START# *55D71C0C0164_4FACE0E4032F_var*
//#UC END# *55D71C0C0164_4FACE0E4032F_var*
begin
//#UC START# *55D71C0C0164_4FACE0E4032F_impl*
 Result := True;
//#UC END# *55D71C0C0164_4FACE0E4032F_impl*
end;//TddDocumentAtom.CanWrite

constructor TddDocumentAtom.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_4FACE0E4032F_var*
//#UC END# *51E91BA80051_4FACE0E4032F_var*
begin
//#UC START# *51E91BA80051_4FACE0E4032F_impl*
 inherited Create;
 f_Destination := aDetination;
 f_Stored := True;
//#UC END# *51E91BA80051_4FACE0E4032F_impl*
end;//TddDocumentAtom.Create

procedure TddDocumentAtom.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FACE0E4032F_var*
//#UC END# *479731C50290_4FACE0E4032F_var*
begin
//#UC START# *479731C50290_4FACE0E4032F_impl*
 f_Destination := nil;
 f_Stored := True;
 inherited;
//#UC END# *479731C50290_4FACE0E4032F_impl*
end;//TddDocumentAtom.Cleanup

function TddDocumentAtom.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_4FACE0E4032F_var*
//#UC END# *4A54E03B009A_4FACE0E4032F_var*
begin
//#UC START# *4A54E03B009A_4FACE0E4032F_impl*
 Result := false;
//#UC END# *4A54E03B009A_4FACE0E4032F_impl*
end;//TddDocumentAtom.GetEmpty

end.
