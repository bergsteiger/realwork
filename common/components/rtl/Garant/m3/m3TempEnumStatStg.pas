unit m3TempEnumStatStg;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3TempEnumStatStg.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::Storage::Tm3TempEnumStatStg
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  m3BaseEnumStatStg
  ;

type
//#UC START# *5485894C00CBci*
//#UC END# *5485894C00CBci*
//#UC START# *5485894C00CBcit*
//#UC END# *5485894C00CBcit*
 Tm3TempEnumStatStg = class(Tm3BaseEnumStatStg)
 private
 // private fields
   FStream : IStream;
   FItemsCount : Integer;
   FItemsIndex : Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aStream: IStream;
     aCount: Integer); reintroduce;
   class function Make(const aStream: IStream;
     aCount: Integer): IEnumStatStg; reintroduce;
     {* Сигнатура фабрики Tm3TempEnumStatStg.Make }
//#UC START# *5485894C00CBpubl*
         private


          _Status:                LongWord;


                function          InitProc00000001    (const ABitMask: LongWord;
                                                       const AStream: IStream
                                                      ): LongWord;

                procedure         DoneProc00000001    (
                                                      );


                function          InitProc00000002    (const ABitMask: LongWord;
                                                       const AItemsCount: LongInt
                                                      ): LongWord;

         protected


                procedure         Next                (const ACount: LongInt;
                                                       const ABuff: PStatStg;
                                                       const AResult: PLongInt;
                                                       var   AReturn: HRESULT
                                                      ); override;

                procedure         Skip                (const ACount: LongInt;
                                                       var   AReturn: HRESULT
                                                      ); override;


                procedure         Reset               (var   AReturn: HRESULT
                                                      ); override;


//#UC END# *5485894C00CBpubl*
 end;//Tm3TempEnumStatStg

implementation

uses
  m2AddPrc,
  m2COMLib,
  m2MemLib,
  ComObj
  ;

// start class Tm3TempEnumStatStg

constructor Tm3TempEnumStatStg.Create(const aStream: IStream;
  aCount: Integer);
//#UC START# *54858CC10221_5485894C00CB_var*
//#UC END# *54858CC10221_5485894C00CB_var*
begin
//#UC START# *54858CC10221_5485894C00CB_impl*
 FItemsCount := 0;
 FItemsIndex := 0;
 inherited Create;
 m2InitOperation(_Status, InitProc00000001($00000001,aStream));
 m2InitOperation(_Status, InitProc00000002($00000002,aCount));
//#UC END# *54858CC10221_5485894C00CB_impl*
end;//Tm3TempEnumStatStg.Create

class function Tm3TempEnumStatStg.Make(const aStream: IStream;
  aCount: Integer): IEnumStatStg;
var
 l_Inst : Tm3TempEnumStatStg;
begin
 l_Inst := Create(aStream, aCount);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure Tm3TempEnumStatStg.Cleanup;
//#UC START# *479731C50290_5485894C00CB_var*
//#UC END# *479731C50290_5485894C00CB_var*
begin
//#UC START# *479731C50290_5485894C00CB_impl*
 FItemsCount := 0;
 FItemsIndex := 0;
 m2DoneOperation(_Status,$00000001, DoneProc00000001);
 inherited;
 _Status := 0;
//#UC END# *479731C50290_5485894C00CB_impl*
end;//Tm3TempEnumStatStg.Cleanup

procedure Tm3TempEnumStatStg.ClearFields;
 {-}
begin
 FStream := nil;
 inherited;
end;//Tm3TempEnumStatStg.ClearFields

//#UC START# *5485894C00CBimpl*

 function    Tm3TempEnumStatStg.InitProc00000001(const ABitMask: LongWord;
                                                 const AStream: IStream
                                                ): LongWord;
 begin

  with Self do
   begin

    FStream:=AStream;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3TempEnumStatStg.DoneProc00000001(
                                                );
 begin

  with Self do
   begin

    FStream:=nil;

   end;

 end;

 function    Tm3TempEnumStatStg.InitProc00000002(const ABitMask: LongWord;
                                                 const AItemsCount: LongInt
                                                ): LongWord;
 begin

  with Self do
   begin

    FItemsCount:=AItemsCount;

   end;

  Result:=ABitMask;

 end;

 procedure   Tm3TempEnumStatStg.Next(const ACount: LongInt;
                                     const ABuff: PStatStg;
                                     const AResult: PLongInt;
                                     var   AReturn: HRESULT
                                    );

  procedure   __LoadBuff(const AStream: IStream;
                         const ABuff: Pointer;
                         const ASize: LongInt
                        );
  begin

   m2COMReadBuffer(AStream,ABuff^,ASize);

  end;

  procedure   __LoadWideBuff(const AStream: IStream;
                             var   ABuff: PWideChar
                            );
  var
        LSize:                    LongInt;
  begin

   __LoadBuff(AStream,@LSize,SizeOf(LSize));

   m2MEMCoTaskAlloc(Pointer(ABuff),LSize+SizeOf(WideChar));
    try

     __LoadBuff(AStream,ABuff,LSize);
     PWideChar(LongInt(ABuff)+LSize)^:=WideChar($0000);

    except

     m2MEMCoTaskFree(Pointer(ABuff));

     raise;

    end;

  end;

 var
        LBuff:                    PStatStg;
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     LBuff:=ABuff;

     while ((FItemsIndex < FItemsCount) and (AResult^ < ACount)) do
      begin

       with LBuff^ do
        begin

         __LoadWideBuff(FStream,pwcsName);

         __LoadBuff(FStream,@dwType,SizeOf(dwType));
         __LoadBuff(FStream,@cbSize,SizeOf(cbSize));

         __LoadBuff(FStream,@grfStateBits,SizeOf(grfStateBits));

        end;

       Inc(LongInt(LBuff),SizeOf(LBuff^));

       Inc(FItemsIndex);
       Inc(AResult^);

      end;

    end;

 end;

 procedure   Tm3TempEnumStatStg.Skip(const ACount: LongInt;
                                     var   AReturn: HRESULT
                                    );
 var
        LItemsCount:              LongInt;
        LItemsIndex:              LongInt;
        LStatStgPtr:              PStatStg;
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     LItemsCount:=ACount;
     LItemsIndex:=FItemsIndex+LItemsCount;

     if (LItemsIndex > FItemsCount)
      then
       begin

        AReturn := S_FALSE;

       end
      else
       begin

        m2MEMAlloc(Pointer(LStatStgPtr),LItemsCount*SizeOf(LStatStgPtr^));
         try

          OleCheck(COMNext(LItemsCount,LStatStgPtr,nil));

         finally

          m2MEMFree(Pointer(LStatStgPtr));

         end;

       end;

    end;

 end;

 procedure   Tm3TempEnumStatStg.Reset(var   AReturn: HRESULT
                                     );
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     if (FItemsCount <> 0)
      then
       begin

        m2COMSetPosition(0,FStream);

        FItemsIndex:=0;

       end;

    end;

 end;

//#UC END# *5485894C00CBimpl*

end.