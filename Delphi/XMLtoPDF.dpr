program XMLtoPDF;

{$R *.dres}

uses
  Vcl.Forms,
  uXMLtoPDF in 'uXMLtoPDF.pas' {frmGerador},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'XML to PDF';
  Application.CreateForm(TfrmGerador, frmGerador);
  Application.Run;
end.
