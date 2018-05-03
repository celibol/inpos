unit InposExt;

interface

uses
	Windows, Messages, SysUtils, Classes, InposTypes;

Const
  DLLName = 'InposExt.dll';

Type
  TInposExt_Version = function: PAnsiChar; cdecl;
  Tinposext_ecr_state = function (timeout: uint32_t; var ecrState: InposEcrState): Integer; cdecl;
  Tinposext_initialize = function (const applicationNo: uint32_t; const ecrSerialNo: TBytes; const address: TBytes; const port: uint16_t; const timeout: uint32_t): Integer; cdecl;
  TInposext_close = procedure; cdecl;
  TInposext_close_all = procedure; cdecl;

  TInposext_Start_Sale = function(timeout: uint32_t): integer; cdecl;
  TInposext_end_sale = function (cashPayment: int32_t): Integer; // set cashPayment to 0 for credit card

  TInposext_add_sale_item = function (timeout: uint32_t; item: PInposEcrSaleItem; totals: PInposEcrSaleTotals): Integer; cdecl;
  Tinposext_add_multiple_sale_items = function (timeout: uint32_t; items: PInposEcrMultipleSaleItems; totals: PInposEcrSaleTotals): Integer; cdecl;
  Tinposext_section_data = function (const timeout: uint32_t; item: PInposEcrSaleItem): integer; cdecl;

  TInposExt = Class
  protected
    DLLHandle  : THandle;

    FInposExt_Version: TInposExt_Version;
    Finposext_ecr_state: Tinposext_ecr_state;
    Finposext_initialize: Tinposext_initialize;
    FInposExt_Close: TInposext_close;
    FInposExt_Close_All: TInposext_close_all;
    FInposext_Start_Sale: TInposext_Start_Sale;
    FInposext_end_sale: TInposext_end_sale;
    FInposext_add_sale_item: TInposext_add_sale_item;
    Finposext_add_multiple_sale_items: Tinposext_add_multiple_sale_items;
    FInposext_section_data: TInposext_section_data;

    procedure Reset;
    procedure LoadFuncs;
  public
    constructor Create;
    destructor Free;

    function Version: PAnsiChar;
    function EcrState(timeout: uint32_t; var ecrState: InposEcrState): Integer;

    procedure close;
    procedure closeAll;

    procedure startSale(timeout: uint32_t);
    Function endSale(cashPayment: uint32_t): Integer;

    Function addSaleItem(timeout: uint32_t; item: PInposEcrSaleItem; totals: PInposEcrSaleTotals): Integer;
    function addMultipleSaleItem(timeout: uint32_t; items: PInposEcrMultipleSaleItems; totals: PInposEcrSaleTotals): Integer;

    function initialize(applicationNo: uint32_t; ecrSerialNo: TBytes; address: TBytes; port: uint16_t; timeout: uint32_t): Integer;

    function sectionData(const timeout: uint32_t; item: PInposEcrSaleItem): integer;
  End;

implementation

{ TInposExt }

constructor TInposExt.Create;
begin
  DLLHandle:= INVALID_HANDLE_VALUE;

  Reset;

  LoadFuncs;
end;

destructor TInposExt.Free;
begin
  if DLLHandle <> INVALID_HANDLE_VALUE Then
    FreeLibrary(DLLHandle);
end;

procedure TInposExt.LoadFuncs;
Var
  C: Array[0..1024] Of WideChar;
Begin
  FillChar(C, sizeof(C), 0);
  StrPCOpy(C, IncludeTrailingBackSlash(ExtractFilePath(ParamStr(0))) + DLLName);
  DLLHandle:= LoadLibrary(C);
  if DLLHandle = 0 then
    RaiseLastWin32Error;

  if DLLHandle <> INVALID_HANDLE_VALUE Then
  Begin
    FInposExt_Version:= GetProcAddress(DLLHandle, 'inposext_version');
    Finposext_ecr_state:= GetProcAddress(DLLHandle, 'inposext_ecr_state');

    Finposext_initialize:= GetProcAddress(DLLHandle, 'inposext_initialize');
    FInposext_close:= GetProcAddress(DLLHandle, 'inposext_close');
    FInposext_close_all:= GetProcAddress(DLLHandle, 'inposext_close_all');
    FInposext_Start_Sale:= GetProcAddress(DLLHandle, 'inposext_start_sale');
    FInposext_end_sale:= GetProcAddress(DLLHandle, 'inposext_end_sale');
    FInposext_add_sale_item:= GetProcAddress(DLLHandle, 'inposext_add_sale_item');
    Finposext_add_multiple_sale_items:= GetProcAddress(DLLHandle, 'inposext_add_multiple_sale_items');
    FInposext_section_data:= GetProcAddress(DLLHandle, 'inposext_section_data');
  End;
end;

procedure TInposExt.Reset;
begin
  FInposExt_Version:= nil;
  Finposext_ecr_state:= nil;
  Finposext_initialize:= nil;
  FInposExt_Close:= nil;
  FInposExt_Close_All:= nil;
  FInposext_Start_Sale:= nil;
  FInposext_end_sale:= nil;
  FInposext_add_sale_item:= nil;
  Finposext_add_multiple_sale_items:= nil;
end;

function TInposExt.EcrState(timeout: uint32_t; var ecrState: InposEcrState): Integer;
begin
  Result:= -1;

  if Assigned(Finposext_ecr_state) then
    Result:= Finposext_ecr_state(timeout, ecrState);
end;

function TInposExt.Version: PAnsiChar;
Var
  V: WideString;
begin
  Result:= 0;

  if Assigned(FInposExt_Version) then
    Result:= FInposExt_Version;

  V:= Result;
end;

procedure TInposExt.close;
begin
  if Assigned(FInposExt_Close) then
    FInposExt_Close;
end;

procedure TInposExt.closeAll;
begin
  if Assigned(FInposExt_Close_All) then
    FInposExt_Close_All;
end;

function TInposExt.initialize(applicationNo: uint32_t; ecrSerialNo, address: TBytes; port: uint16_t; timeout: uint32_t): Integer;
begin
  Result:= -1;

  if Assigned(Finposext_initialize) then
    Result:= Finposext_initialize(applicationNo, ecrSerialNo, address, port, timeout);
end;

function TInposExt.sectionData(const timeout: uint32_t; item: PInposEcrSaleItem): integer;
begin
  Result:= -1;

  if Assigned(FInposext_section_data) then
    Result:= FInposext_section_data(timeout, item);
end;

procedure TInposExt.startSale(timeout: uint32_t);
begin
  if Assigned(FInposext_Start_Sale) then
    FInposext_Start_Sale(timeout);
end;

function TInposExt.endSale(cashPayment: uint32_t): Integer;
begin
  Result:= -1;

  if Assigned(FInposext_end_sale) then
    Result:= FInposext_end_sale(cashPayment);
end;

function TInposExt.addMultipleSaleItem(timeout: uint32_t; items: PInposEcrMultipleSaleItems; totals: PInposEcrSaleTotals): Integer;
begin
  Result:= -1;

  if Assigned(Finposext_add_multiple_sale_items) then
    Result:= Finposext_add_multiple_sale_items(timeout, items, totals);
end;

function TInposExt.addSaleItem(timeout: uint32_t; item: PInposEcrSaleItem; totals: PInposEcrSaleTotals): Integer;
Var
  I: Integer;
  ECRS: InposEcrState;
begin
  Result:= -1;

  I:= EcrState(7000, ECRS);
  if (ECRS in [InposEcrSale, InposEcrSale, InposEcrMainMenu]) then
  Begin
    if Assigned(FInposext_add_sale_item) then
      Result:= FInposext_add_sale_item(timeout, item, totals);
  End;
end;

end.
