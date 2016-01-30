unit ddSectionProperty;

// ������: "w:\common\components\rtl\Garant\dd\ddSectionProperty.pas"
// ���������: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentProperty
 , RTFtypes
 , ddPropertyObject
;

type
 TddSectionProperty = class(TddDocumentProperty)
  private
   f_cCols: Integer;
    {* ���� ��� �������� cCols }
   f_ColsSpace: Integer;
    {* ���� ��� �������� ColsSpace }
   f_EndHere: Boolean;
    {* ���� ��� �������� EndHere }
   f_Landscape: Boolean;
    {* ���� ��� �������� Landscape }
   f_LineBetween: Boolean;
    {* ���� ��� �������� LineBetween }
   f_Unlocked: Boolean;
    {* ���� ��� �������� Unlocked }
   f_pgnFormat: TPGN;
    {* ���� ��� �������� pgnFormat }
   f_SBK: TSBK;
    {* ���� ��� �������� SBK }
  public
   constructor Create; override;
    {* ����������� �������. ���������� ������, �� ��������� ������ ������ 1. }
   procedure Clear; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
  public
   property cCols: Integer
    read f_cCols
    write f_cCols;
   property ColsSpace: Integer
    read f_ColsSpace
    write f_ColsSpace;
   property EndHere: Boolean
    read f_EndHere
    write f_EndHere;
   property Landscape: Boolean
    read f_Landscape
    write f_Landscape;
   property LineBetween: Boolean
    read f_LineBetween
    write f_LineBetween;
   property Unlocked: Boolean
    read f_Unlocked
    write f_Unlocked;
   property pgnFormat: TPGN
    read f_pgnFormat
    write f_pgnFormat;
   property SBK: TSBK
    read f_SBK
    write f_SBK;
 end;//TddSectionProperty

implementation

uses
 l3ImplUses
;

constructor TddSectionProperty.Create;
 {* ����������� �������. ���������� ������, �� ��������� ������ ������ 1. }
//#UC START# *47914F960008_51DBBE7802D5_var*
//#UC END# *47914F960008_51DBBE7802D5_var*
begin
//#UC START# *47914F960008_51DBBE7802D5_impl*
 inherited Create;
 Clear;
//#UC END# *47914F960008_51DBBE7802D5_impl*
end;//TddSectionProperty.Create

procedure TddSectionProperty.Clear;
//#UC START# *518A13330058_51DBBE7802D5_var*
//#UC END# *518A13330058_51DBBE7802D5_var*
begin
//#UC START# *518A13330058_51DBBE7802D5_impl*
 inherited;
 cCols:= 1;                  { number of column }
 ColsSpace:= 720;    { ������������ ����� ��������� }
 LineBetween:= False;  { ����� ����� ��������� }
 SBK:= sbkPg;                    { section break type  }
 pgnFormat:= pgDec;              { how the page number is formatted      }
 EndHere:= False; { �������� ������ � ����� ������ }
 Unlocked:= True; { ������ ������ ��� ���� }
 Landscape:= False;
//#UC END# *518A13330058_51DBBE7802D5_impl*
end;//TddSectionProperty.Clear

procedure TddSectionProperty.AssignFrom(anOther: TddPropertyObject);
//#UC START# *5301DFE6002C_51DBBE7802D5_var*
//#UC END# *5301DFE6002C_51DBBE7802D5_var*
begin
//#UC START# *5301DFE6002C_51DBBE7802D5_impl*
 if (anOther Is TddSectionProperty) then
 begin
  cCols:= TddSectionProperty(anOther).cCols;
  ColsSpace:= TddSectionProperty(anOther).ColsSpace;
  EndHere:= TddSectionProperty(anOther).EndHere;
  Landscape:= TddSectionProperty(anOther).Landscape;
  LineBetween:= TddSectionProperty(anOther).LineBetween;
  pgnFormat:= TddSectionProperty(anOther).pgnFormat;
  SBK:= TddSectionProperty(anOther).SBK;
  Unlocked:= TddSectionProperty(anOther).Unlocked;
 end else
  inherited AssignFrom(anOther);
//#UC END# *5301DFE6002C_51DBBE7802D5_impl*
end;//TddSectionProperty.AssignFrom

end.
