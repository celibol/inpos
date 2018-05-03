unit main;

interface

{.$DEFINE MULTIPLEITEM}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    appNo: TcxTextEdit;
    serNo: TcxTextEdit;
    port: TcxTextEdit;
    ipAddr: TcxTextEdit;
    uD: TdxMemData;
    uDS: TDataSource;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    uDCINSI: TStringField;
    uDFIYATI: TFloatField;
    uDMIKTARI: TFloatField;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1CINSI: TcxGridDBColumn;
    cxGrid1DBTableView1FIYATI: TcxGridDBColumn;
    cxGrid1DBTableView1MIKTARI: TcxGridDBColumn;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    uDTUTARI: TFloatField;
    cxGrid1DBTableView1TUTARI: TcxGridDBColumn;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure uDSDataChange(Sender: TObject; Field: TField);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Math, InposExt, InposTypes;

procedure TForm1.Button1Click(Sender: TObject);
Var
  Inp: TInposExt;
  V: PAnsiChar;
  ECRS: InposEcrState;
begin
  Inp:= TInposExt.Create;

  // V:= Inp.Version;
  // ShowMessage(String(V));

  ShowMessage(IntToSTr(Inp.EcrState(7000, EcrS)));

  FreeAndNil(Inp);
end;

procedure TForm1.Button2Click(Sender: TObject);
Var
  Inp: TInposExt;

  res,
  appID,
  prt: Integer;

  SNC,
  IPAC: TBytes;
begin
  Inp:= TInposExt.Create;

  appID:= 1;
  prt:= 59000;

  if appNo.Text <> '' then
    appID:= StrToInt(appNo.Text);

  if port.Text <> '' then
    prt:= StrToInt(port.Text);

  SNC:= TEncoding.UTF8.GetBytes(serNo.Text + #0);
  IPAC:= TEncoding.UTF8.GetBytes(ipAddr.Text + #0);

  res:= Inp.initialize(appID, SNC, IPAC, prt, 7000);

  if res <> InposNoError then
    ShowMessage('Ýnit Hata Kodu: ' + IntToStr(res))
  else
    ShowMessage('Init Tamam');

  FreeAndNil(Inp);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  uD.Active:= False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  uD.Active:= True;
  uD.First;
  while not uD.Eof do
  BEgin
    uD.Edit;
    uDSDataChange(uDS, uDMIKTARI);
    uD.Post;

    uD.Next;
  End;

  uD.First;
end;

procedure TForm1.uDSDataChange(Sender: TObject; Field: TField);
begin
  if Assigned(Field) then
  Begin
    uDS.OnDataChange:= nil;

    uDTUTARI.AsFloat:= uDMIKTARI.AsFloat * uDFIYATI.AsFloat;

    uDS.OnDataChange:= uDSDataChange;
  End;
end;

procedure TForm1.Button3Click(Sender: TObject);
Var
  Itm: TInposEcrMultipleSaleItems;
  I, X, Stt: Integer;
  S: String;
  B: TBytes;
  Inp: TInposExt;
  ST: TInposEcrSaleTotals;
  T: Real;
begin
  uD.DisableControls;

  FillChar(Itm, sizeof(Itm), 0);
  Itm.count:= uD.RecordCount;
  I:= 0;

  T:= 0;
  uD.First;

{$IFNDEF MULTIPLEITEM}
  Button2Click(Button2);
  Inp:= TInposExt.Create;
  Inp.startSale(7000);
{$ENDIF}

  while not UD.Eof do
  Begin
    T:= T + uDTUTARI.AsFloat;

    FillChar(Itm.items[I], sizeof(Itm.items[I]), 0);

    // Itm.items[I].multiplier:= 1000;

    Itm.items[I].munit:= 2;
    Itm.items[I].discountRate:= 0;
    Itm.items[I].discountAmount:= 0;

    Itm.items[I].section:= I + 1;

    Itm.items[I].unitPrice:= Trunc(uDFIYATI.AsFloat * 100);
    Itm.items[I].multiplier:= Trunc(uDMIKTARI.AsFloat * 1000);

    if length(uDCINSI.AsString) > 52 then
      S:= Copy(uDCINSI.AsString, 1, 52)
    else
      S:= uDCINSI.AsString;

    S:= S + #0;

    B:= TEncoding.UTF8.GetBytes(S);

    for X := 0 to Length(B) do
      Itm.items[I].name[X]:= B[X];

    itm.items[I].section:= 1;
    itm.items[I].munit:= 4;
    itm.items[I].discountRate:= 0;
    itm.items[I].discountAmount:= 19;

{$IFNDEF MULTIPLEITEM}
    FillChar(ST, sizeof(ST), 0);
    Stt:= Inp.addSaleItem(7000, @Itm.Items[I], @ST);
{$ENDIF}

    I:= I + 1;
    if I > 8 then
      break;

    UD.Next;
  End;
{$IFNDEF MULTIPLEITEM}
  Stt:= Inp.endSale(Trunc(T));
  Inp.Free;
{$ELSE}

  Button2Click(Button2);

  FillChar(ST, sizeof(ST), 0);
{
  ST.totalAmount:= Trunc(T);
  ST.totalVat:= 0;
  ST.amountToPay:= ST.totalAmount;
  ST.cashPaymentAmount:= ST.totalAmount;
  ST.creditCardPaymentAmount:= 0;
  ST.itemCount:= I;
}
  Inp:= TInposExt.Create;

  Inp.startSale(7000);

  I:= Inp.addMultipleSaleItem(7000, @Itm, @ST);

  if I = InposNoError then
    I:= Inp.endSale(0);

  FreeAndNil(Inp);

  if I <> InposNoError then
    ShowMessage('Satýþ Hata Kodu: ' + IntToStr(I))
  else
    ShowMessage('Satýþ Tamam');
{$ENDIF}

  uD.First;
  uD.EnableControls;
end;

procedure TForm1.Button4Click(Sender: TObject);
Var
  Inp: TInposExt;
  P: PInposEcrSaleItem;
  X, I: Integer;
begin
  // Button2Click(Button2);

  Inp:= TInposExt.Create;

  new(P);
  for I:= 1 to 8 do
  Begin
    FillChar(P^, sizeof(P), 0);
    P^.section:= I;
    P^.munit:= I;
    X:= Inp.sectionData(7000, P);
  End;

  dispose(P);

  Inp.Free;

end;

end.
