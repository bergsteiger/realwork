unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;


procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
{********* Security *********}
procedure SetSecurity(APDFDoc:TgtPDFDocument; AOwnerPass, AUserPass, AConfirmPass, AConfrimUserPass:string;Alevel: Integer;
  AEnabled, APrint,AModify,ACopy,AAnnotation,AFormfill,AAccessibilty,ADocumentassembly,AHighresolutionprinting: Boolean);

//const

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

procedure SetSecurity(APDFDoc:TgtPDFDocument; AOwnerPass, AUserPass, AConfirmPass, AConfrimUserPass:string;Alevel: Integer;
  AEnabled, APrint,AModify,ACopy,AAnnotation,AFormfill,AAccessibilty,ADocumentassembly,AHighresolutionprinting: Boolean);
begin
  if APDFDoc.IsLoaded then
  begin
    with APDFDoc.Encryption do
    begin
      Enabled := AEnabled;

      if Alevel = 0 then
        Level := el40bit
      else
        Level := el128bit;

      if AOwnerPass = AConfirmPass then
        OwnerPassword := AOwnerPass;
      if AUserPass = AConfrimUserPass then
        UserPassword := AUserPass;

      UserPermissions :=[];

      if  APrint then
        UserPermissions := UserPermissions + [AllowPrint];
      If  AModify then
        UserPermissions := UserPermissions + [AllowModify];
      If  ACopy then
        UserPermissions := UserPermissions + [AllowCopy];
      If  AAnnotation then
        UserPermissions := UserPermissions + [AllowAnnotation];
      If  AFormfill then
        UserPermissions := UserPermissions + [AllowFormFill];
      If  AAccessibilty then
        UserPermissions := UserPermissions + [AllowAccessibility];
      If  ADocumentassembly then
        UserPermissions := UserPermissions + [AllowDocAssembly];
      If  AHighresolutionprinting then
        UserPermissions := UserPermissions + [AllowHighResPrint];
   end;
  end;
end;

end.



