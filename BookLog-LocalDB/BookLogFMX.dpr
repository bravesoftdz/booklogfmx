program BookLogFmx;

uses
  System.StartUpCopy,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form1},
  DataAccessModule in 'DataAccessModule.pas' {DataModule1: TDataModule},
  PhotoFrame in 'Frames\PhotoFrame.pas' {frPhoto: TFrame},
  WebBrowserFrame in 'Frames\WebBrowserFrame.pas' {frWebBrowser: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
