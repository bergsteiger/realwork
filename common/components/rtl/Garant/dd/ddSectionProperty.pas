unit ddSectionProperty;

// Модуль: "w:\common\components\rtl\Garant\dd\ddSectionProperty.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddSectionProperty" MUID: (51DBBE7802D5)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentProperty
 , RTFtypes
 , ddPropertyObject
;

type
 TddSectState = (
  dd_ssNone
  , dd_ssStart
  , dd_ssFinish
 );//TddSectState

 TddSectionProperty = class(TddDocumentProperty)
  private
   f_ColumnCount: Integer;
   f_ColsSpace: Integer;
   f_EndHere: Boolean;
   f_Landscape: Boolean;
   f_LineBetween: Boolean;
   f_Unlocked: Boolean;
   f_pgnFormat: TPGN;
   f_SBK: TSBK;
   f_SectionState: TddSectState;
  public
   constructor Create; override;
    {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
   procedure Clear; override;
   procedure AssignFrom(anOther: TddPropertyObject); override;
  public
   property ColumnCount: Integer
    read f_ColumnCount
    write f_ColumnCount;
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
   property SectionState: TddSectState
    read f_SectionState
    write f_SectionState;
 end;//TddSectionProperty

implementation

uses
 l3ImplUses
;

constructor TddSectionProperty.Create;
 {* конструктор объекта. Возвращает объект, со счетчиком ссылок равным 1. }
//#UC START# *47914F960008_51DBBE7802D5_var*
//#UC END# *47914F960008_51DBBE7802D5_var*
begin
//#UC START# *47914F960008_51DBBE7802D5_impl*
 inherited Create;
 Clear;
 f_SectionState := dd_ssNone;
//#UC END# *47914F960008_51DBBE7802D5_impl*
end;//TddSectionProperty.Create

procedure TddSectionProperty.Clear;
//#UC START# *518A13330058_51DBBE7802D5_var*
//#UC END# *518A13330058_51DBBE7802D5_var*
begin
//#UC START# *518A13330058_51DBBE7802D5_impl*
 inherited;
 f_ColumnCount := 0;                  { number of column }
 ColsSpace:= 720;    { пространство между колонками }
 LineBetween:= False;  { линия между колонками }
 SBK:= sbkPg;                    { section break type  }
 pgnFormat:= pgDec;              { how the page number is formatted      }
 EndHere:= False; { конечные сноски в конце секции }
 Unlocked:= True; { раздел открыт для форм }
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
  f_ColumnCount := TddSectionProperty(anOther).f_ColumnCount;
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
