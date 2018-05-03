program InposTest;

uses
  Vcl.Forms,
  main in 'main.pas' {Form1},
  InposTypes in 'InposTypes.pas',
  InposExt in 'InposExt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
