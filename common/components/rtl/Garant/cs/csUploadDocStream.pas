unit csUploadDocStream;

// Модуль: "w:\common\components\rtl\Garant\cs\csUploadDocStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsUploadDocStream" MUID: (57D2706902F8)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2SizedMemoryPool
 , l3MarshalledTypes
 , k2Base
;

type
 TcsUploadDocStream = class(TncsMessage)
  protected
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
   function pm_GetIsObjTopic: Boolean;
   procedure pm_SetIsObjTopic(aValue: Boolean);
   function pm_GetDocFamily: Integer;
   procedure pm_SetDocFamily(aValue: Integer);
   function pm_GetDocID: Integer;
   procedure pm_SetDocID(aValue: Integer);
   function pm_GetDocPart: Tm3DocPartSelector;
   procedure pm_SetDocPart(aValue: Tm3DocPartSelector);
   function pm_GetParseToDB: Boolean;
   procedure pm_SetParseToDB(aValue: Boolean);
   function pm_GetIsClassChanged: Boolean;
   procedure pm_SetIsClassChanged(aValue: Boolean);
   function pm_GetNeedSaveText: Boolean;
   procedure pm_SetNeedSaveText(aValue: Boolean);
   function pm_GetDocClass: TDocType;
   procedure pm_SetDocClass(aValue: TDocType);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
   property IsObjTopic: Boolean
    read pm_GetIsObjTopic
    write pm_SetIsObjTopic;
   property DocFamily: Integer
    read pm_GetDocFamily
    write pm_SetDocFamily;
   property DocID: Integer
    read pm_GetDocID
    write pm_SetDocID;
   property DocPart: Tm3DocPartSelector
    read pm_GetDocPart
    write pm_SetDocPart;
   property ParseToDB: Boolean
    read pm_GetParseToDB
    write pm_SetParseToDB;
   property IsClassChanged: Boolean
    read pm_GetIsClassChanged
    write pm_SetIsClassChanged;
   property NeedSaveText: Boolean
    read pm_GetNeedSaveText
    write pm_SetNeedSaveText;
   property DocClass: TDocType
    read pm_GetDocClass
    write pm_SetDocClass;
 end;//TcsUploadDocStream
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csUploadDocStream_Const
 //#UC START# *57D2706902F8impl_uses*
 //#UC END# *57D2706902F8impl_uses*
;

function TcsUploadDocStream.pm_GetData: Tk2RawData;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TcsUploadDocStream.pm_GetData

procedure TcsUploadDocStream.pm_SetData(aValue: Tk2RawData);
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetData

function TcsUploadDocStream.pm_GetIsObjTopic: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsObjTopic]);
end;//TcsUploadDocStream.pm_GetIsObjTopic

procedure TcsUploadDocStream.pm_SetIsObjTopic(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsObjTopic, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetIsObjTopic

function TcsUploadDocStream.pm_GetDocFamily: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocFamily]);
end;//TcsUploadDocStream.pm_GetDocFamily

procedure TcsUploadDocStream.pm_SetDocFamily(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocFamily, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetDocFamily

function TcsUploadDocStream.pm_GetDocID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocID]);
end;//TcsUploadDocStream.pm_GetDocID

procedure TcsUploadDocStream.pm_SetDocID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocID, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetDocID

function TcsUploadDocStream.pm_GetDocPart: Tm3DocPartSelector;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tm3DocPartSelector(TaggedData.IntA[k2_attrDocPart]);
end;//TcsUploadDocStream.pm_GetDocPart

procedure TcsUploadDocStream.pm_SetDocPart(aValue: Tm3DocPartSelector);
begin
 TaggedData.IntW[k2_attrDocPart, nil] := Ord(aValue);
end;//TcsUploadDocStream.pm_SetDocPart

function TcsUploadDocStream.pm_GetParseToDB: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrParseToDB]);
end;//TcsUploadDocStream.pm_GetParseToDB

procedure TcsUploadDocStream.pm_SetParseToDB(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrParseToDB, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetParseToDB

function TcsUploadDocStream.pm_GetIsClassChanged: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsClassChanged]);
end;//TcsUploadDocStream.pm_GetIsClassChanged

procedure TcsUploadDocStream.pm_SetIsClassChanged(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsClassChanged, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetIsClassChanged

function TcsUploadDocStream.pm_GetNeedSaveText: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedSaveText]);
end;//TcsUploadDocStream.pm_GetNeedSaveText

procedure TcsUploadDocStream.pm_SetNeedSaveText(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedSaveText, nil] := (aValue);
end;//TcsUploadDocStream.pm_SetNeedSaveText

function TcsUploadDocStream.pm_GetDocClass: TDocType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocType(TaggedData.IntA[k2_attrDocClass]);
end;//TcsUploadDocStream.pm_GetDocClass

procedure TcsUploadDocStream.pm_SetDocClass(aValue: TDocType);
begin
 TaggedData.IntW[k2_attrDocClass, nil] := Ord(aValue);
end;//TcsUploadDocStream.pm_SetDocClass

class function TcsUploadDocStream.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsUploadDocStream;
end;//TcsUploadDocStream.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
