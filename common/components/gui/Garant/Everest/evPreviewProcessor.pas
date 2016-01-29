unit evPreviewProcessor;

// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: evPreviewProcessor
// Начат: 01.12.2005 06:21

{$Include evDefine.inc}

interface

uses
  l3Interfaces,
  l3Variant,
  k2Interfaces,
  evNotifiedProcessor,
  nevTools,
  k2Base
  ;

type
 TevPreviewProcessor = class(TevNotifiedProcessor)
    protected
    // internal methods
      procedure ChildAdded(aList    : Tl3Variant;
                           aProp    : Tk2ArrayProperty;
                           aChild   : Tl3Variant;
                           anIndex        : Integer;
                           const anOpPack : InevOp);
        override;
        {-}
    public
    // public methods
      constructor Create(const aHolder: InevObjectHolder);
      class function Make(const aHolder: InevObjectHolder): InevProcessor;
 end;//TevPreviewProcessor

implementation

uses
  l3Types,
  k2Tags,
  SysUtils,

  ParaList_Const
  ;

// start class TevPreviewProcessor

constructor TevPreviewProcessor.Create(const aHolder: InevObjectHolder);
begin
 inherited Create;
 LinkDocument(aHolder);
end;

class function TevPreviewProcessor.Make(const aHolder: InevObjectHolder): InevProcessor;
var
 l_P : TevPreviewProcessor;
begin
 l_P := Create(aHolder);
 try
  Result := l_P;
 finally
  FreeAndNil(l_P);
 end;//try..finally
end;

procedure TevPreviewProcessor.ChildAdded(aList    : Tl3Variant;
                                         aProp    : Tk2ArrayProperty;
                                         aChild   : Tl3Variant;
                                         anIndex        : Integer;
                                         const anOpPack : InevOp);
  //override;
  {-}
begin
 inherited;
 if (anOpPack <> nil) AND anOpPack.InIOProcess AND
    aList.IsKindOf(k2_typParaList) then
  NotifyCompleted(aList, aChild);
  //ParaOp(aList, aChild, l3_opInsert);
end;

end.